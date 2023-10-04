Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7C7B8886
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbjJDSRB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244222AbjJDSQs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:16:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7021AAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:16:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA7BC433C9;
        Wed,  4 Oct 2023 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443404;
        bh=h8cxgEOexgFsNKv4LlsYPtR19gUViUPbl8BBNL4jUeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APLXGkb1g5cqz76WDfXliVz5uocGGaaAl+vv68T87LrfDKu3/Y0p8q4DsMQ0UZaOb
         Ca/aDEKmyu5SM+V2LSERnhchmImhtR2X06X19IGIOJg/+S5kOro9qVN8VPeXHj4X9E
         Jf3E4kDI3p3k5myyu+pAD1dcQSi45jQCAwC9Omuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+97522333291430dd277f@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 144/259] bpf: Annotate bpf_long_memcpy with data_race
Date:   Wed,  4 Oct 2023 19:55:17 +0200
Message-ID: <20231004175223.911928435@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 6a86b5b5cd76d2734304a0173f5f01aa8aa2025e ]

syzbot reported a data race splat between two processes trying to
update the same BPF map value via syscall on different CPUs:

  BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update

  write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
   bpf_long_memcpy include/linux/bpf.h:428 [inline]
   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
   copy_map_value_long include/linux/bpf.h:464 [inline]
   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
   __sys_bpf+0x28a/0x780
   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
   bpf_long_memcpy include/linux/bpf.h:428 [inline]
   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
   copy_map_value_long include/linux/bpf.h:464 [inline]
   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
   __sys_bpf+0x28a/0x780
   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  value changed: 0x0000000000000000 -> 0xfffffff000002788

The bpf_long_memcpy is used with 8-byte aligned pointers, power-of-8 size
and forced to use long read/writes to try to atomically copy long counters.
It is best-effort only and no barriers are here since it _will_ race with
concurrent updates from BPF programs. The bpf_long_memcpy() is called from
bpf(2) syscall. Marco suggested that the best way to make this known to
KCSAN would be to use data_race() annotation.

Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/bpf/000000000000d87a7f06040c970c@google.com
Link: https://lore.kernel.org/bpf/57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b3d3aa8437dce..1ed2ec035e779 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -301,7 +301,7 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 
 	size /= sizeof(long);
 	while (size--)
-		*ldst++ = *lsrc++;
+		data_race(*ldst++ = *lsrc++);
 }
 
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
-- 
2.40.1



