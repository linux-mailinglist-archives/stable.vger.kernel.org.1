Return-Path: <stable+bounces-248041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMJ2M19GB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-248041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:14:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0D552DCF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB34930C9B8A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5E8305674;
	Fri, 15 May 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpZV68ID"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8293FF1CD;
	Fri, 15 May 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860717; cv=none; b=F885ILX/WdVVsE7D+Q7VhBflA6nbrYK4RmhFE67yctz/21H1uYaxAQwpJMHK1Vx6KJz5+qDdOWhN5y/JI6/zJYPL7RHKYMwDLMNy1sZ67f7BliSSW2ov6VR/njgL55r9PwoMd3FdmAZ65UQWCeNbxqB4BXQc544kewMcY1r4Ysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860717; c=relaxed/simple;
	bh=KmqrmcLcTyvxzVbPBdg9JqqoULPXbqC3ItLwp/m4q9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic+WU0yaUGhvTWOm8kWD1vNmZYTcT6BHgy/9PqHE7Yn09JRQZOQcXe8waTwf+601EyNDzJdo90FTzktZr3CN72DurWs4ywTDel8jQAB2lnHL4+/RTR8tFMCFFzOOmUOkoGt1TBYabDr3RJ6zh7wOCVU06IvLhE1VjAx2OdIS9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpZV68ID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35220C2BCB3;
	Fri, 15 May 2026 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860717;
	bh=KmqrmcLcTyvxzVbPBdg9JqqoULPXbqC3ItLwp/m4q9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpZV68ID3Jyqq39GN2QT3MbBpnk6rBd7IHURCPCrrbVQeMKskA3uW9l3S6EyzAUBv
	 Dqh1Rd/Vs4GLm7V4IQWB/lcl5E3jmJBTB4EA1WQR2r1X1TRNgOsi4IHFQocJqF9jIG
	 0Cg4V/eOEjc72ZfwxPGLKEMVlgx16k2ulyBMbAAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Levinsky <ben.levinsky@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.6 051/474] remoteproc: xlnx: Only access buffer information if IPI is buffered
Date: Fri, 15 May 2026 17:42:40 +0200
Message-ID: <20260515154716.151342580@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 9FC0D552DCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248041-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linaro.org:email,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -179,17 +179,19 @@ static void zynqmp_r5_mb_rx_cb(struct mb
 
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



