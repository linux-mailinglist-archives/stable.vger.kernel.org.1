Return-Path: <stable+bounces-174592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FEB36440
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61068E15B4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4386926FDBF;
	Tue, 26 Aug 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e+dV7DN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251C23D7DD;
	Tue, 26 Aug 2025 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214801; cv=none; b=hdhPprj0Sqbp+ulFSLogiBzXnNZenkpQQ4jKBTV3HL8rapdKZe6CQqrY98EmdXtihlBRzawjIuz7u8dnH3BjSsKSaAOZPeOfec8UGUPfjsyLoa9FA+7BDzU19cLEwy3QAZYpDtqqKU0yacKh0kD6Ogv8vechkXTwBH7oZoY3fJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214801; c=relaxed/simple;
	bh=P1cLPx0ctWdtXg4/ijhYjsD0riHmKk0RRWZvL/vUqAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6JcWFK4FWjeotJ6AyZFdEvPdpp1zgvHqjrOUB0VBntufIpIgofXOrI9utN9s0fj+yn9uJvhIxjlj6f4fNoSaSie0Xf3iOaGtrUYD0NGIjLrk0C8lWJFDRLGWoIcFgvr8SYDxEStVOAw3lV/M8+Iho51es+r95dl+XDY7DQMmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e+dV7DN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E38C4CEF1;
	Tue, 26 Aug 2025 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214800;
	bh=P1cLPx0ctWdtXg4/ijhYjsD0riHmKk0RRWZvL/vUqAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+dV7DN2KZTU58E5cWpHW9zpd1mmXWO/RV096bl25j/M770z+h25JwCX8ym5hFPhP
	 F78w7Oq6Ug4gPxupDw5D7S9/heKK+7W2T/fpI7VQXa0jyODQvsbi3Wn32UJAdFkfLQ
	 /y8TYF3GgkciRmCVFn9bsnct1TJ+snrNPBsE4H8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Subject: [PATCH 6.1 274/482] bus: mhi: host: Detect events pointing to unexpected TREs
Date: Tue, 26 Aug 2025 13:08:47 +0200
Message-ID: <20250826110937.543348726@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Youssef Samir <quic_yabdulra@quicinc.com>

commit 5bd398e20f0833ae8a1267d4f343591a2dd20185 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/host/main.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -603,7 +603,7 @@ static int parse_xfer_event(struct mhi_c
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
 		struct mhi_ring_element *local_rp, *ev_tre;
-		void *dev_rp;
+		void *dev_rp, *next_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
@@ -622,6 +622,16 @@ static int parse_xfer_event(struct mhi_c
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



