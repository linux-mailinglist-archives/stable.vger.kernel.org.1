Return-Path: <stable+bounces-172001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA7B2F938
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D190168240D
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4053218C9;
	Thu, 21 Aug 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqWPBenr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986C3218BA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780516; cv=none; b=tWIEn+esWbI/T62HjFRuuSqqDYeD45IqmVCMjsJhL8Z1tQKOqYfnsZdljZBYXxL7izLsEJsptBhfZgyj1fPQrW6YO0bWw1MydqOV3vt96h34FMr5Xvy3LzKpKNdmBt0HXA6N1ItRCdar63J2xbqZa0VreVjvq6Mca/2q9VO3bXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780516; c=relaxed/simple;
	bh=n7WiKYf9HBVcBwcXkH7FbASg5QlshMdcyhVWxTzi5bg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZeRJN18IdHLUitm2FKGWm14OGJ2TH3n1yX4V7Xezr9PM9nfaO6SkK7xrn/HscQcNJb1Z8Sjn9cxhD0SeXWuZfhM8KuStRRJODa83N4hUyqXlf8+NsGgGyv+2cV0rievr+zoJzyi1WYoH45EQ0P6kQJL38xMyi9ZIYhsdhq9U28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aqWPBenr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A88C4CEED;
	Thu, 21 Aug 2025 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780515;
	bh=n7WiKYf9HBVcBwcXkH7FbASg5QlshMdcyhVWxTzi5bg=;
	h=Subject:To:Cc:From:Date:From;
	b=aqWPBenrRjyuJJY/zx/TMNnp+Bqm7wZYlOeIymLDq+vkuVKcssDBKlfj9+0THxDzb
	 7B7GtFIGF4HB8n6qbsByRGWEwtyVSGGgwWqTmoyEK+jpOU0QSQ3PCkIvzI/yJeEhQ+
	 ig5Wqhq91RrNuqjybHpO4a8kpY0kM+HxdX1GAsHE=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Detect events pointing to unexpected TREs" failed to apply to 5.15-stable tree
To: quic_yabdulra@quicinc.com,jeff.hugo@oss.qualcomm.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:48:32 +0200
Message-ID: <2025082132-hurricane-stank-2ae5@gregkh>
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
git cherry-pick -x 5bd398e20f0833ae8a1267d4f343591a2dd20185
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082132-hurricane-stank-2ae5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5bd398e20f0833ae8a1267d4f343591a2dd20185 Mon Sep 17 00:00:00 2001
From: Youssef Samir <quic_yabdulra@quicinc.com>
Date: Mon, 14 Jul 2025 18:30:39 +0200
Subject: [PATCH] bus: mhi: host: Detect events pointing to unexpected TREs

When a remote device sends a completion event to the host, it contains a
pointer to the consumed TRE. The host uses this pointer to process all of
the TREs between it and the host's local copy of the ring's read pointer.
This works when processing completion for chained transactions, but can
lead to nasty results if the device sends an event for a single-element
transaction with a read pointer that is multiple elements ahead of the
host's read pointer.

For instance, if the host accesses an event ring while the device is
updating it, the pointer inside of the event might still point to an old
TRE. If the host uses the channel's xfer_cb() to directly free the buffer
pointed to by the TRE, the buffer will be double-freed.

This behavior was observed on an ep that used upstream EP stack without
'commit 6f18d174b73d ("bus: mhi: ep: Update read pointer only after buffer
is written")'. Where the device updated the events ring pointer before
updating the event contents, so it left a window where the host was able to
access the stale data the event pointed to, before the device had the
chance to update them. The usual pattern was that the host received an
event pointing to a TRE that is not immediately after the last processed
one, so it got treated as if it was a chained transaction, processing all
of the TREs in between the two read pointers.

This commit aims to harden the host by ensuring transactions where the
event points to a TRE that isn't local_rp + 1 are chained.

Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
[mani: added stable tag and reworded commit message]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250714163039.3438985-1-quic_yabdulra@quicinc.com

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 3041ee6747e3..52bef663e182 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -602,7 +602,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
 		struct mhi_ring_element *local_rp, *ev_tre;
-		void *dev_rp;
+		void *dev_rp, *next_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
@@ -621,6 +621,16 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 		result.dir = mhi_chan->dir;
 
 		local_rp = tre_ring->rp;
+
+		next_rp = local_rp + 1;
+		if (next_rp >= tre_ring->base + tre_ring->len)
+			next_rp = tre_ring->base;
+		if (dev_rp != next_rp && !MHI_TRE_DATA_GET_CHAIN(local_rp)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points to an unexpected TRE\n");
+			break;
+		}
+
 		while (local_rp != dev_rp) {
 			buf_info = buf_ring->rp;
 			/* If it's the last TRE, get length from the event */


