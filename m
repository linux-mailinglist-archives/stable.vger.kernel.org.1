Return-Path: <stable+bounces-18394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4984828D
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB19028209A
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB77495D6;
	Sat,  3 Feb 2024 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pnu/aIxR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE671BC3E;
	Sat,  3 Feb 2024 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933766; cv=none; b=nDV5geCpBPqE2IVAKssKX0R2fqGShrwJBjRYD9ZDpJmasoyTNojKf7w9wlEL2J+nDsNL7h6g3nkdDhgxA5YkII9JWqmHMzt12HrN3qrkVIbDQN+mswFWILKdZ+RV06itg4f1XIUuulnekJY5hvxksCUJyoTPNNeSLBpPqthKaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933766; c=relaxed/simple;
	bh=pnGPrnr8GxTsRJjl9DN/Q6PiD9O+wARmFePDXoiKTts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyd9ahvvdp9pUm3vi4fkfW4qgni6m9hNFfrPaQ+zkF0lZzDtcyBTY+mZjiAwX/bmJa5llGXYnb3OlOMcxG9OYzr9zZjsCe2lTiRFaAHxvgBrJq9sAeInz7b9Wy9weWz7XqoRbyLVLMn3QVsAVzzSZ2XoPh6T3KmBlXKo0sDKd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pnu/aIxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F9C433C7;
	Sat,  3 Feb 2024 04:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933766;
	bh=pnGPrnr8GxTsRJjl9DN/Q6PiD9O+wARmFePDXoiKTts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pnu/aIxRgIvFdka3j1DxJ67UG+txIpndOeDshLvJHsDOX+Obzm3l47MBoffPbBQmM
	 sTxokCtQVN++zbHIMzVbn5CIrhwt5YlEQSpI0wFI0Lh2DdR6xPl/TD80OpzTofPRNc
	 hXH5F270zc7KomOv+fyBto21KiczDalyBqDHoHeA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 067/353] libbpf: Fix potential uninitialized tail padding with LIBBPF_OPTS_RESET
Date: Fri,  2 Feb 2024 20:03:05 -0800
Message-ID: <20240203035405.931314450@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 7f7c43693c1b46652cfafb7af67ba31726d6ec4e ]

Martin reported that there is a libbpf complaining of non-zero-value tail
padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modified
to have a 4-byte tail padding. This only happens to clang compiler.
The commend line is: ./test_progs -t tc_netkit_multi_links
Martin and I did some investigation and found this indeed the case and
the following are the investigation details.

Clang:
  clang version 18.0.0
  <I tried clang15/16/17 and they all have similar results>

tools/lib/bpf/libbpf_common.h:
  #define LIBBPF_OPTS_RESET(NAME, ...)                                      \
        do {                                                                \
                memset(&NAME, 0, sizeof(NAME));                             \
                NAME = (typeof(NAME)) {                                     \
                        .sz = sizeof(NAME),                                 \
                        __VA_ARGS__                                         \
                };                                                          \
        } while (0)

  #endif

tools/lib/bpf/libbpf.h:
  struct bpf_netkit_opts {
        /* size of this struct, for forward/backward compatibility */
        size_t sz;
        __u32 flags;
        __u32 relative_fd;
        __u32 relative_id;
        __u64 expected_revision;
        size_t :0;
  };
  #define bpf_netkit_opts__last_field expected_revision
In the above struct bpf_netkit_opts, there is no tail padding.

prog_tests/tc_netkit.c:
  static void serial_test_tc_netkit_multi_links_target(int mode, int target)
  {
        ...
        LIBBPF_OPTS(bpf_netkit_opts, optl);
        ...
        LIBBPF_OPTS_RESET(optl,
                .flags = BPF_F_BEFORE,
                .relative_fd = bpf_program__fd(skel->progs.tc1),
        );
        ...
  }

Let us make the following source change, note that we have a 4-byte
tailing padding now.
#  diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
#  index 6cd9c501624f..0dd83910ae9a 100644
#  --- a/tools/lib/bpf/libbpf.h
#  +++ b/tools/lib/bpf/libbpf.h
#  @@ -803,13 +803,13 @@ bpf_program__attach_tcx(const struct bpf_program *prog, int ifindex,
#   struct bpf_netkit_opts {
#        /* size of this struct, for forward/backward compatibility */
#        size_t sz;
#  -       __u32 flags;
#        __u32 relative_fd;
#        __u32 relative_id;
#        __u64 expected_revision;
#  +       __u32 flags;
#        size_t :0;
#   };
#  -#define bpf_netkit_opts__last_field expected_revision
#  +#define bpf_netkit_opts__last_field flags

The clang 18 generated asm code looks like below:
    ;       LIBBPF_OPTS_RESET(optl,
    55e3: 48 8d 7d 98                   leaq    -0x68(%rbp), %rdi
    55e7: 31 f6                         xorl    %esi, %esi
    55e9: ba 20 00 00 00                movl    $0x20, %edx
    55ee: e8 00 00 00 00                callq   0x55f3 <serial_test_tc_netkit_multi_links_target+0x18d3>
    55f3: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rbp)
    55fe: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
    5605: 48 8b 78 18                   movq    0x18(%rax), %rdi
    5609: e8 00 00 00 00                callq   0x560e <serial_test_tc_netkit_multi_links_target+0x18ee>
    560e: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
    5614: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
    561e: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp)
    5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
    5633: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
    563a: 48 89 45 98                   movq    %rax, -0x68(%rbp)
    563e: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
    5645: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
    5649: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
    5650: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
    5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
    ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);

At -O0 level, the clang compiler creates an intermediate copy.
We have below to store 'flags' with 4-byte store and leave another 4 byte
in the same 8-byte-aligned storage undefined,
    5629: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
and later we store 8-byte to the original zero'ed buffer
    5654: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565b: 48 89 45 b0                   movq    %rax, -0x50(%rbp)

This caused a problem as the 4-byte value at [%rbp-0x2dc, %rbp-0x2e0)
may be garbage.

gcc (gcc 11.4) does not have this issue as it does zeroing struct first before
doing assignments:
  ;       LIBBPF_OPTS_RESET(optl,
    50fd: 48 8d 85 40 fc ff ff          leaq    -0x3c0(%rbp), %rax
    5104: ba 20 00 00 00                movl    $0x20, %edx
    5109: be 00 00 00 00                movl    $0x0, %esi
    510e: 48 89 c7                      movq    %rax, %rdi
    5111: e8 00 00 00 00                callq   0x5116 <serial_test_tc_netkit_multi_links_target+0x1522>
    5116: 48 8b 45 f0                   movq    -0x10(%rbp), %rax
    511a: 48 8b 40 18                   movq    0x18(%rax), %rax
    511e: 48 89 c7                      movq    %rax, %rdi
    5121: e8 00 00 00 00                callq   0x5126 <serial_test_tc_netkit_multi_links_target+0x1532>
    5126: 48 c7 85 40 fc ff ff 00 00 00 00      movq    $0x0, -0x3c0(%rbp)
    5131: 48 c7 85 48 fc ff ff 00 00 00 00      movq    $0x0, -0x3b8(%rbp)
    513c: 48 c7 85 50 fc ff ff 00 00 00 00      movq    $0x0, -0x3b0(%rbp)
    5147: 48 c7 85 58 fc ff ff 00 00 00 00      movq    $0x0, -0x3a8(%rbp)
    5152: 48 c7 85 40 fc ff ff 20 00 00 00      movq    $0x20, -0x3c0(%rbp)
    515d: 89 85 48 fc ff ff             movl    %eax, -0x3b8(%rbp)
    5163: c7 85 58 fc ff ff 08 00 00 00 movl    $0x8, -0x3a8(%rbp)
  ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);

It is not clear how to resolve the compiler code generation as the compiler
generates correct code w.r.t. how to handle unnamed padding in C standard.
So this patch changed LIBBPF_OPTS_RESET macro to avoid uninitialized tail
padding. We already knows LIBBPF_OPTS macro works on both gcc and clang,
even with tail padding. So LIBBPF_OPTS_RESET is changed to be a
LIBBPF_OPTS followed by a memcpy(), thus avoiding uninitialized tail padding.

The below is asm code generated with this patch and with clang compiler:
    ;       LIBBPF_OPTS_RESET(optl,
    55e3: 48 8d bd 10 fd ff ff          leaq    -0x2f0(%rbp), %rdi
    55ea: 31 f6                         xorl    %esi, %esi
    55ec: ba 20 00 00 00                movl    $0x20, %edx
    55f1: e8 00 00 00 00                callq   0x55f6 <serial_test_tc_netkit_multi_links_target+0x18d6>
    55f6: 48 c7 85 10 fd ff ff 20 00 00 00      movq    $0x20, -0x2f0(%rbp)
    5601: 48 8b 85 68 ff ff ff          movq    -0x98(%rbp), %rax
    5608: 48 8b 78 18                   movq    0x18(%rax), %rdi
    560c: e8 00 00 00 00                callq   0x5611 <serial_test_tc_netkit_multi_links_target+0x18f1>
    5611: 89 85 18 fd ff ff             movl    %eax, -0x2e8(%rbp)
    5617: c7 85 1c fd ff ff 00 00 00 00 movl    $0x0, -0x2e4(%rbp)
    5621: 48 c7 85 20 fd ff ff 00 00 00 00      movq    $0x0, -0x2e0(%rbp)
    562c: c7 85 28 fd ff ff 08 00 00 00 movl    $0x8, -0x2d8(%rbp)
    5636: 48 8b 85 10 fd ff ff          movq    -0x2f0(%rbp), %rax
    563d: 48 89 45 98                   movq    %rax, -0x68(%rbp)
    5641: 48 8b 85 18 fd ff ff          movq    -0x2e8(%rbp), %rax
    5648: 48 89 45 a0                   movq    %rax, -0x60(%rbp)
    564c: 48 8b 85 20 fd ff ff          movq    -0x2e0(%rbp), %rax
    5653: 48 89 45 a8                   movq    %rax, -0x58(%rbp)
    5657: 48 8b 85 28 fd ff ff          movq    -0x2d8(%rbp), %rax
    565e: 48 89 45 b0                   movq    %rax, -0x50(%rbp)
    ;       link = bpf_program__attach_netkit(skel->progs.tc2, ifindex, &optl);

In the above code, a temporary buffer is zeroed and then has proper value assigned.
Finally, values in temporary buffer are copied to the original variable buffer,
hence tail padding is guaranteed to be 0.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/bpf/20231107201511.2548645-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/bpf/libbpf_common.h |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -79,11 +79,14 @@
  */
 #define LIBBPF_OPTS_RESET(NAME, ...)					    \
 	do {								    \
-		memset(&NAME, 0, sizeof(NAME));				    \
-		NAME = (typeof(NAME)) {					    \
-			.sz = sizeof(NAME),				    \
-			__VA_ARGS__					    \
-		};							    \
+		typeof(NAME) ___##NAME = ({ 				    \
+			memset(&___##NAME, 0, sizeof(NAME));		    \
+			(typeof(NAME)) {				    \
+				.sz = sizeof(NAME),			    \
+				__VA_ARGS__				    \
+			};						    \
+		});							    \
+		memcpy(&NAME, &___##NAME, sizeof(NAME));		    \
 	} while (0)
 
 #endif /* __LIBBPF_LIBBPF_COMMON_H */



