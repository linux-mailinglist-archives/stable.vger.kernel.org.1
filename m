Return-Path: <stable+bounces-243124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNilL72m+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:01:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEED4BE58E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C77CF3018BC9
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036B93DDDDF;
	Mon,  4 May 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbfKpYJD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34A2E2F0E;
	Mon,  4 May 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903079; cv=none; b=bfrmHxWuCUzk8jJZBNB/EniP/CR8ugLKhTny1COwQIedmM6wVC8ut58pVdvmiPNcA2/kUptVyrmAdAulX9dRExTSLUOLKfGBRa8L+RpGqpAluwoptst5PLoUekYuVnzOW9tl7sAwcLaSMYUEoLDkTKvfV+qWlWOWHI4PfK7/Pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903079; c=relaxed/simple;
	bh=J/0rrZDz2ExPEk4oQGgA/blCeSXaPAV8IfmU4v2mO1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsYf7BwlaAMA1dMrztyr5v+FwgYC2Q5c+QRcJtJEIgUXuuhXrCMRmeCbBKWd+WG+SmW3BwJBrpxBs8N3UV7I4zrwFwaspBBOvy2d5hjaq8YcKH6UhtucszV7k9viVb8JlDHDMINDQGWopQk6IuMNlZTBNOY/OH8GX1dlVsm82E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbfKpYJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119A2C2BCB8;
	Mon,  4 May 2026 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903079;
	bh=J/0rrZDz2ExPEk4oQGgA/blCeSXaPAV8IfmU4v2mO1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbfKpYJD1/neOYVBJRO5jZT8D/WTFR0nhVg1XL0mlKocWBkyLFjunDh6R7A4dj1XV
	 g5QEwX/D1xUk26grtc36qgBiIbJN6B2U8dkGxdnxx3gXKJdJ7H3A8M2/EzsaroPhJJ
	 ixmQAL5Lri64ZZqEPBR7s3C2a1OY+xjx2sT2Tzyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Levinsky <ben.levinsky@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 7.0 094/307] remoteproc: xlnx: Only access buffer information if IPI is buffered
Date: Mon,  4 May 2026 15:49:39 +0200
Message-ID: <20260504135146.349572166@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BEED4BE58E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243124-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Levinsky <ben.levinsky@amd.com>

commit 38dd6ccfdfbbe865569a52fe1ba9fa1478f672e6 upstream.

In the receive callback check if message is NULL to prevent
possibility of crash by NULL pointer dereferencing.

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Fixes: 5dfb28c257b7 ("remoteproc: xilinx: Add mailbox channels for rpmsg")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260303235127.2317955-3-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -232,17 +232,19 @@ static void zynqmp_r5_mb_rx_cb(struct mb
 
 	ipi = container_of(cl, struct mbox_info, mbox_cl);
 
-	/* copy data from ipi buffer to r5_core */
+	/* copy data from ipi buffer to r5_core if IPI is buffered. */
 	ipi_msg = (struct zynqmp_ipi_message *)msg;
-	buf_msg = (struct zynqmp_ipi_message *)ipi->rx_mc_buf;
-	len = ipi_msg->len;
-	if (len > IPI_BUF_LEN_MAX) {
-		dev_warn(cl->dev, "msg size exceeded than %d\n",
-			 IPI_BUF_LEN_MAX);
-		len = IPI_BUF_LEN_MAX;
+	if (ipi_msg) {
+		buf_msg = (struct zynqmp_ipi_message *)ipi->rx_mc_buf;
+		len = ipi_msg->len;
+		if (len > IPI_BUF_LEN_MAX) {
+			dev_warn(cl->dev, "msg size exceeded than %d\n",
+				 IPI_BUF_LEN_MAX);
+			len = IPI_BUF_LEN_MAX;
+		}
+		buf_msg->len = len;
+		memcpy(buf_msg->data, ipi_msg->data, len);
 	}
-	buf_msg->len = len;
-	memcpy(buf_msg->data, ipi_msg->data, len);
 
 	/* received and processed interrupt ack */
 	if (mbox_send_message(ipi->rx_chan, NULL) < 0)



