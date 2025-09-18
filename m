Return-Path: <stable+bounces-173414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E0B35CBC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4957C5070
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D62BE643;
	Tue, 26 Aug 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MOnm/Eo5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756E283FDF;
	Tue, 26 Aug 2025 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208187; cv=none; b=R3r/eCwuGDvl/SOGcp9v1PiVmrcdbiB1GrECiiMA4Di+fYbJDtImk1CzXIf4083M3ak6E36cfNafSJjaEMg0uNns6Ba2H/jnr8O6GYs1XrczZZcCeFVhrDkqjnmLO14/XlCxoFQy0wcCzf2emODXzJZv8tRg1hw0zTD2d6DgDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208187; c=relaxed/simple;
	bh=GSbEfIrlHBbsi6pzffCCFll7cttbx0o00tH6efnZiFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbqW4We1QQKsEg83RvJksP8WeUM8IwGn4wK+f8mkEpSSvu0GLjQZVO03Jbm6kzrE0jnS/mAyQD2Q/bjsaeE7Pn9HO27tDWXYurokxnhiG+NEMtjktWJMtXcsOh+63yqgwT6oE3iWpS/wzPMCQiaWqJLu3f0ss2ZunmVGw7pU+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MOnm/Eo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EFAC4CEF1;
	Tue, 26 Aug 2025 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208187;
	bh=GSbEfIrlHBbsi6pzffCCFll7cttbx0o00tH6efnZiFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOnm/Eo5jnNd/ptOS0wCb1Mr59Q8UEJVpKS2la+9V3S+bdxyiQy44IUVlCRIhqCal
	 dahGVLqK7vQy+acvnkoge8pYaJEcRDeqfAal6zqgumDGkWzOxayq+QjBcpP7Zzy55E
	 sLg9Nyu0F4HbO6KycoLnpnvilzxrHRrYrfpJF/yw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Subject: [PATCH 6.12 015/322] bus: mhi: host: Detect events pointing to unexpected TREs
Date: Tue, 26 Aug 2025 13:07:10 +0200
Message-ID: <20250826110915.619812196@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -602,7 +602,7 @@ static int parse_xfer_event(struct mhi_c
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
 		struct mhi_ring_element *local_rp, *ev_tre;
-		void *dev_rp;
+		void *dev_rp, *next_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
@@ -621,6 +621,16 @@ static int parse_xfer_event(struct mhi_c
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



