Return-Path: <stable+bounces-243688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDNyMlys+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:25:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F34BF590
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57DF53083967
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93893DE459;
	Mon,  4 May 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q0FWi4T6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4413D9DBB;
	Mon,  4 May 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904522; cv=none; b=kayaV8VJF3xtf2nvsVQcV5/1TsBjRPoz2eQYDdkVOGPhQ3dYHZs+wNrGHcPDQBnQx8BVI2g/BnEmK0k+lQQZagP+49UDRdcwWthKM4AAKGfX9uZ43ItLUEi2bMDbtULISBu2MmjcfUbrtFCVeqqwFMUFNRwG7/ya5aCMYvN3EDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904522; c=relaxed/simple;
	bh=0+7xVen8kDQj+uVCHKqDlYR6q9x6OybTIIItX+tWXOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRqM1NMF0/biqrxlALLZeg/95bcxePVTnnXyZHPQzPIhDXGrnpESKRsKgNKn6FsrfG/OYv0duFswzYNi+h6scCNs7r8+KCA2zaN5cr+78pfVdXpQU7sl5fCH5WceOg1q2UaAsGKJJyc2Om4BaYho1mkmV408c0W6xD4u4nP/qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q0FWi4T6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AB3C2BCF4;
	Mon,  4 May 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904522;
	bh=0+7xVen8kDQj+uVCHKqDlYR6q9x6OybTIIItX+tWXOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0FWi4T6zcpegEbKJUtWc+Gyr3EbVeMLNbtuuvlGRbvbbwyW4PZpckRs+EODcsCpO
	 H+1f7fAGrc2TAnzTRwahWaQWuVQ4Il9AwBQFE01SjxfCI3r++dUUhtTHDtL3kZiKYt
	 5JP+OdKrg443005CNWHnUsT5dWU/Zh805wFpy4JM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Levinsky <ben.levinsky@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.12 064/215] remoteproc: xlnx: Only access buffer information if IPI is buffered
Date: Mon,  4 May 2026 15:51:23 +0200
Message-ID: <20260504135132.509562376@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 644F34BF590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243688-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

6.12-stable review patch.  If anyone has any objections, please let me know.

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



