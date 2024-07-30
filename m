Return-Path: <stable+bounces-63116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26694176F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E74B20D6F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD453DAC11;
	Tue, 30 Jul 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tNN+LWhK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E7194C73;
	Tue, 30 Jul 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355717; cv=none; b=OQu5N9chKjx/78svv5J+lStZ4r9SUYAnCCGu3n2lPVA55OrhElFmHjBcxLWVU7mmGl0yy0H8x8QXsD4vmATWKFNnooUKcXOR48+EmFeDudseIu6m1EJGH1hvxnarNnn+vahZMw5WARAcxNZJkiIIUM9AixKfhSo/fvsinRklGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355717; c=relaxed/simple;
	bh=/4Jc3RPt85ynXGbLJfbjYfksohSL7Wtn3/zdLrjZtho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iF+aJWbNc1lrKcQf06HY47K6mh52nNzZlQh+fGb77pDwcIO7BvKjwcyZyAGE1wGsyeFACbE8uIEeX48FFZxku8O531kTsGKXlP3AlKDifG2lrFjnkXBt/WyNDOzQbUN18TR+xB3bk62LvaHjAKYqPu8rRFfeETtL3OMxYeMUHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tNN+LWhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A3C4AF0C;
	Tue, 30 Jul 2024 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355717;
	bh=/4Jc3RPt85ynXGbLJfbjYfksohSL7Wtn3/zdLrjZtho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNN+LWhKSMd/+8xtJ8mONISV1Y8+QgnsSL7kN5PGEmleKcTiqIcQ46rDSMvpu0idX
	 Fbe+2LYIp6u1NqzIHr/GzXpUBxjOvRHkwriaEmv1AuzjoT6vXaKBwcXEoVxV/TGCgf
	 /IxzYH7wqxUWGIsljVZtim5C7UmXFbShNhvdNIq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <kafai@fb.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 124/440] bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT
Date: Tue, 30 Jul 2024 17:45:57 +0200
Message-ID: <20240730151620.731036012@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tengda Wu <wutengda@huaweicloud.com>

[ Upstream commit f7866c35873377313ff94398f17d425b28b71de1 ]

When loading a EXT program without specifying `attr->attach_prog_fd`,
the `prog->aux->dst_prog` will be null. At this time, calling
resolve_prog_type() anywhere will result in a null pointer dereference.

Example stack trace:

[    8.107863] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
[    8.108262] Mem abort info:
[    8.108384]   ESR = 0x0000000096000004
[    8.108547]   EC = 0x25: DABT (current EL), IL = 32 bits
[    8.108722]   SET = 0, FnV = 0
[    8.108827]   EA = 0, S1PTW = 0
[    8.108939]   FSC = 0x04: level 0 translation fault
[    8.109102] Data abort info:
[    8.109203]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    8.109399]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    8.109614]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    8.109836] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101354000
[    8.110011] [0000000000000004] pgd=0000000000000000, p4d=0000000000000000
[    8.112624] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    8.112783] Modules linked in:
[    8.113120] CPU: 0 PID: 99 Comm: may_access_dire Not tainted 6.10.0-rc3-next-20240613-dirty #1
[    8.113230] Hardware name: linux,dummy-virt (DT)
[    8.113390] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.113429] pc : may_access_direct_pkt_data+0x24/0xa0
[    8.113746] lr : add_subprog_and_kfunc+0x634/0x8e8
[    8.113798] sp : ffff80008283b9f0
[    8.113813] x29: ffff80008283b9f0 x28: ffff800082795048 x27: 0000000000000001
[    8.113881] x26: ffff0000c0bb2600 x25: 0000000000000000 x24: 0000000000000000
[    8.113897] x23: ffff0000c1134000 x22: 000000000001864f x21: ffff0000c1138000
[    8.113912] x20: 0000000000000001 x19: ffff0000c12b8000 x18: ffffffffffffffff
[    8.113929] x17: 0000000000000000 x16: 0000000000000000 x15: 0720072007200720
[    8.113944] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
[    8.113958] x11: 0720072007200720 x10: 0000000000f9fca4 x9 : ffff80008021f4e4
[    8.113991] x8 : 0101010101010101 x7 : 746f72705f6d656d x6 : 000000001e0e0f5f
[    8.114006] x5 : 000000000001864f x4 : ffff0000c12b8000 x3 : 000000000000001c
[    8.114020] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
[    8.114126] Call trace:
[    8.114159]  may_access_direct_pkt_data+0x24/0xa0
[    8.114202]  bpf_check+0x3bc/0x28c0
[    8.114214]  bpf_prog_load+0x658/0xa58
[    8.114227]  __sys_bpf+0xc50/0x2250
[    8.114240]  __arm64_sys_bpf+0x28/0x40
[    8.114254]  invoke_syscall.constprop.0+0x54/0xf0
[    8.114273]  do_el0_svc+0x4c/0xd8
[    8.114289]  el0_svc+0x3c/0x140
[    8.114305]  el0t_64_sync_handler+0x134/0x150
[    8.114331]  el0t_64_sync+0x168/0x170
[    8.114477] Code: 7100707f 54000081 f9401c00 f9403800 (b9400403)
[    8.118672] ---[ end trace 0000000000000000 ]---

One way to fix it is by forcing `attach_prog_fd` non-empty when
bpf_prog_load(). But this will lead to `libbpf_probe_bpf_prog_type`
API broken which use verifier log to probe prog type and will log
nothing if we reject invalid EXT prog before bpf_check().

Another way is by adding null check in resolve_prog_type().

The issue was introduced by commit 4a9c7bbe2ed4 ("bpf: Resolve to
prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT") which wanted
to correct type resolution for BPF_PROG_TYPE_TRACING programs. Before
that, the type resolution of BPF_PROG_TYPE_EXT prog actually follows
the logic below:

  prog->aux->dst_prog ? prog->aux->dst_prog->type : prog->type;

It implies that when EXT program is not yet attached to `dst_prog`,
the prog type should be EXT itself. This code worked fine in the past.
So just keep using it.

Fix this by returning `prog->type` for BPF_PROG_TYPE_EXT if `dst_prog`
is not present in resolve_prog_type().

Fixes: 4a9c7bbe2ed4 ("bpf: Resolve to prog->aux->dst_prog->type only for BPF_PROG_TYPE_EXT")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/20240711145819.254178-2-wutengda@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f080ccf27d256..6a524c5462a6f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -645,7 +645,7 @@ static inline u32 type_flag(u32 type)
 /* only use after check_attach_btf_id() */
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
-	return prog->type == BPF_PROG_TYPE_EXT ?
+	return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
 		prog->aux->dst_prog->type : prog->type;
 }
 
-- 
2.43.0




