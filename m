Return-Path: <stable+bounces-136861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21DA9EFB8
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA34E3B50ED
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3E263F45;
	Mon, 28 Apr 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bDO2w4ZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2391FDA8A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841243; cv=none; b=MVLGuZ4E6jGbG0zMMu3LjPZChmMR0gMG+bQs/m0hETJ+2b27tKa81TvTIjmUtoHLz46z1e43HBMJ/DEQ1JRr5kJ/FRWDmfYG3ub23a8crOjGNv1U+ROj1az/CTLuA+KzzEH4q75PF05HLry+IoXCooy0tAarF2juj7OcaSxDgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841243; c=relaxed/simple;
	bh=2pvbIR5CaEbzYS+MzUu6DFG5r12BaG8Qcw/eqnK3i60=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DWEARozaCdRFwfLRaXUJgBLvkTdwckmMFpAI9qnfiij2KcSrfDHPm52CZKz8kUW4RAd6yNrVRucyFDk3Q4z88zQwlXFZriCymWwXx1G8jjINrnNpSqsEG2FU4fHc8fwgQ4hPoF65eTKhHqW2ui7Vcw8KqV2315E+qMbqnk8dZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDO2w4ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA124C4CEE9;
	Mon, 28 Apr 2025 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841243;
	bh=2pvbIR5CaEbzYS+MzUu6DFG5r12BaG8Qcw/eqnK3i60=;
	h=Subject:To:Cc:From:Date:From;
	b=bDO2w4ZCmlQBNHO6NTONkEwcu/7/Ot0R7TjIms3CLxxSrl6YzhThMBbBgBj+RTdaX
	 rBnEH0/P6qV+z+1mSb5FsgP1OjLMJ50LbhqPCqnsrnk5YyaMIenq82hOOWVY1cAV8i
	 6+2ot07V4tANxSGGz5b7EfY71bQyWgI/Qj11XiuM=
Subject: FAILED: patch "[PATCH] xen-netfront: handle NULL returned by" failed to apply to 5.10-stable tree
To: sdl@nppct.ru,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:54:00 +0200
Message-ID: <2025042800-convene-bless-ce4b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cc3628dcd851ddd8d418bf0c897024b4621ddc92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042800-convene-bless-ce4b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc3628dcd851ddd8d418bf0c897024b4621ddc92 Mon Sep 17 00:00:00 2001
From: Alexey Nepomnyashih <sdl@nppct.ru>
Date: Thu, 17 Apr 2025 12:21:17 +0000
Subject: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()

The function xdp_convert_buff_to_frame() may return NULL if it fails
to correctly convert the XDP buffer into an XDP frame due to memory
constraints, internal errors, or invalid data. Failing to check for NULL
may lead to a NULL pointer dereference if the result is used later in
processing, potentially causing crashes, data corruption, or undefined
behavior.

On XDP redirect failure, the associated page must be released explicitly
if it was previously retained via get_page(). Failing to do so may result
in a memory leak, as the pages reference count is not decremented.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
Link: https://patch.msgid.link/20250417122118.1009824-1-sdl@nppct.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index fc52d5c4c69b..5091e1fa4a0d 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -985,20 +985,27 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_TX:
-		get_page(pdata);
 		xdpf = xdp_convert_buff_to_frame(xdp);
-		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
-		if (unlikely(!err))
-			xdp_return_frame_rx_napi(xdpf);
-		else if (unlikely(err < 0))
+		if (unlikely(!xdpf)) {
 			trace_xdp_exception(queue->info->netdev, prog, act);
+			break;
+		}
+		get_page(pdata);
+		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
+		if (unlikely(err <= 0)) {
+			if (err < 0)
+				trace_xdp_exception(queue->info->netdev, prog, act);
+			xdp_return_frame_rx_napi(xdpf);
+		}
 		break;
 	case XDP_REDIRECT:
 		get_page(pdata);
 		err = xdp_do_redirect(queue->info->netdev, xdp, prog);
 		*need_xdp_flush = true;
-		if (unlikely(err))
+		if (unlikely(err)) {
 			trace_xdp_exception(queue->info->netdev, prog, act);
+			xdp_return_buff(xdp);
+		}
 		break;
 	case XDP_PASS:
 	case XDP_DROP:


