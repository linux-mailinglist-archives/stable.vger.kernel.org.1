Return-Path: <stable+bounces-103785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F393A9EF9E6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83466172B32
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0922540E;
	Thu, 12 Dec 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLHl8UqX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC6222D59;
	Thu, 12 Dec 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025596; cv=none; b=EVfpHPhl3VxgzHomL3QPmfhGSZ5+JuKFLsAR9A4VJ0jYdm7iCxCHAHW/O5RvD1HG5ZH/RZLzSLGni9qd3RSpMl1NpfQYAYjLxrPGdggWPoUCPBIgtM6RB8TaSTPXnAio+t3gj0zwI0CeJkYmW/ArQDRaWgsP/ixDKWUNACQyADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025596; c=relaxed/simple;
	bh=Ew1sN5LkXfnbz8GgFu6XE/ZUsCfGakG1oEWvPJ9Th0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+fXkmihrwVg65QySuwCYr6sHtPD2o+0fxN8+Sej4VglEkEA3YJ+EKd7atWFR8o1PEgfvVyKVJ/lL11Va73bNFkmf/iPa4BUW9JQ+/PrKAzZbjb3nQpjfjtQNxrfJByn/s3RwapfwOFV3oPV3lo9omLgK8+oFZftaaqbrR6KQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLHl8UqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C622C4CECE;
	Thu, 12 Dec 2024 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025596;
	bh=Ew1sN5LkXfnbz8GgFu6XE/ZUsCfGakG1oEWvPJ9Th0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLHl8UqXbqAledjWLY+mK7Q6ChD6RCN6b7aQPxClg+Qhr6C0CEKYJwyfVoY7D3mpu
	 vBWn8Gq7p9xqy4uUUHmfy07kUxub8x61xM5YdCtWD5O4D9ABGw588eWiHq9/9oNInY
	 YTw8PZfigQp9te54BMebVRZykK2QJ64jxOZuIS+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Ruowen Qin <ruqin@redhat.com>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 223/321] ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()
Date: Thu, 12 Dec 2024 16:02:21 +0100
Message-ID: <20241212144238.787128702@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinghao Jia <jinghao7@illinois.edu>

[ Upstream commit 146b6f1112eb30a19776d6c323c994e9d67790db ]

Under certain kernel configurations when building with Clang/LLVM, the
compiler does not generate a return or jump as the terminator
instruction for ip_vs_protocol_init(), triggering the following objtool
warning during build time:

  vmlinux.o: warning: objtool: ip_vs_protocol_init() falls through to next function __initstub__kmod_ip_vs_rr__935_123_ip_vs_rr_init6()

At runtime, this either causes an oops when trying to load the ipvs
module or a boot-time panic if ipvs is built-in. This same issue has
been reported by the Intel kernel test robot previously.

Digging deeper into both LLVM and the kernel code reveals this to be a
undefined behavior problem. ip_vs_protocol_init() uses a on-stack buffer
of 64 chars to store the registered protocol names and leaves it
uninitialized after definition. The function calls strnlen() when
concatenating protocol names into the buffer. With CONFIG_FORTIFY_SOURCE
strnlen() performs an extra step to check whether the last byte of the
input char buffer is a null character (commit 3009f891bb9f ("fortify:
Allow strlen() and strnlen() to pass compile-time known lengths")).
This, together with possibly other configurations, cause the following
IR to be generated:

  define hidden i32 @ip_vs_protocol_init() local_unnamed_addr #5 section ".init.text" align 16 !kcfi_type !29 {
    %1 = alloca [64 x i8], align 16
    ...

  14:                                               ; preds = %11
    %15 = getelementptr inbounds i8, ptr %1, i64 63
    %16 = load i8, ptr %15, align 1
    %17 = tail call i1 @llvm.is.constant.i8(i8 %16)
    %18 = icmp eq i8 %16, 0
    %19 = select i1 %17, i1 %18, i1 false
    br i1 %19, label %20, label %23

  20:                                               ; preds = %14
    %21 = call i64 @strlen(ptr noundef nonnull dereferenceable(1) %1) #23
    ...

  23:                                               ; preds = %14, %11, %20
    %24 = call i64 @strnlen(ptr noundef nonnull dereferenceable(1) %1, i64 noundef 64) #24
    ...
  }

The above code calculates the address of the last char in the buffer
(value %15) and then loads from it (value %16). Because the buffer is
never initialized, the LLVM GVN pass marks value %16 as undefined:

  %13 = getelementptr inbounds i8, ptr %1, i64 63
  br i1 undef, label %14, label %17

This gives later passes (SCCP, in particular) more DCE opportunities by
propagating the undef value further, and eventually removes everything
after the load on the uninitialized stack location:

  define hidden i32 @ip_vs_protocol_init() local_unnamed_addr #0 section ".init.text" align 16 !kcfi_type !11 {
    %1 = alloca [64 x i8], align 16
    ...

  12:                                               ; preds = %11
    %13 = getelementptr inbounds i8, ptr %1, i64 63
    unreachable
  }

In this way, the generated native code will just fall through to the
next function, as LLVM does not generate any code for the unreachable IR
instruction and leaves the function without a terminator.

Zero the on-stack buffer to avoid this possible UB.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402100205.PWXIz1ZK-lkp@intel.com/
Co-developed-by: Ruowen Qin <ruqin@redhat.com>
Signed-off-by: Ruowen Qin <ruqin@redhat.com>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_proto.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_proto.c b/net/netfilter/ipvs/ip_vs_proto.c
index f100da4ba3bc3..a9fd1d3fc2cbf 100644
--- a/net/netfilter/ipvs/ip_vs_proto.c
+++ b/net/netfilter/ipvs/ip_vs_proto.c
@@ -340,7 +340,7 @@ void __net_exit ip_vs_protocol_net_cleanup(struct netns_ipvs *ipvs)
 
 int __init ip_vs_protocol_init(void)
 {
-	char protocols[64];
+	char protocols[64] = { 0 };
 #define REGISTER_PROTOCOL(p)			\
 	do {					\
 		register_ip_vs_protocol(p);	\
@@ -348,8 +348,6 @@ int __init ip_vs_protocol_init(void)
 		strcat(protocols, (p)->name);	\
 	} while (0)
 
-	protocols[0] = '\0';
-	protocols[2] = '\0';
 #ifdef CONFIG_IP_VS_PROTO_TCP
 	REGISTER_PROTOCOL(&ip_vs_protocol_tcp);
 #endif
-- 
2.43.0




