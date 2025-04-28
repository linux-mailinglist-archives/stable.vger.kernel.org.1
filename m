Return-Path: <stable+bounces-136913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB84A9F668
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D941A84AA0
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC391AD3E1;
	Mon, 28 Apr 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1zlP3Kj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DD27A128
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859662; cv=none; b=dNvAGUH7GKQTM5KQgRVrLBoR1YuEH96RsxVIqUdJpJ8FhIUIN18kl9V75s3cGPT6bGbZMvURkEns903THDK6phzmRmrsh8wdktNS14I7qSq1abeVwz6BZwox3By04kZpXlnuxeQBaIywhSKmDiyqhUhicBBmVklVgVj4/CEm4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859662; c=relaxed/simple;
	bh=NnlL+m7/DwY4Mhl2ZKMrtcWD4S9GHB49TBHf+WLt0qA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bZKEezRNIGDqI/M8xqZXz6i95s0Cn1tMf7EmORV6uZwS1FAhXyKTg3cN8arUJe/UL230+d8cx8+gG+7sqs4uQp2cF8TBT8xRxfdAF+lShWrEstUeNx6uu84rmOz9diGZzmqgwao1nXqAvaoChWoa6WObMwwqs0gTthT7ePq/OfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zlP3Kj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89D9C4CEEC;
	Mon, 28 Apr 2025 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745859662;
	bh=NnlL+m7/DwY4Mhl2ZKMrtcWD4S9GHB49TBHf+WLt0qA=;
	h=Subject:To:Cc:From:Date:From;
	b=1zlP3Kj6cvKQGbvluPTV9ZECDf4UT94vaRxlotizpRcmZxGLcZM5YZ43jJLYtMNZQ
	 3DACuqxcwL911cLtTTEgbivygtrKpti3slX4ctS+gw1myg/v5cbQ1xWPDlnp+u+Mf+
	 RuKc6UeOIxNC9vBd+TjC/dlog83ivMMVFfWzO9pk=
Subject: FAILED: patch "[PATCH] xen-netfront: handle NULL returned by" failed to apply to 5.15-stable tree
To: sdl@nppct.ru,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 19:00:59 +0200
Message-ID: <2025042858-guacamole-ozone-ac80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x cc3628dcd851ddd8d418bf0c897024b4621ddc92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042858-guacamole-ozone-ac80@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


