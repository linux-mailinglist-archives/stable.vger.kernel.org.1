Return-Path: <stable+bounces-1757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6027F8138
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D11C1C2163E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7451133CD1;
	Fri, 24 Nov 2023 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rg2SArnl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F2321AD;
	Fri, 24 Nov 2023 18:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ACFC433C8;
	Fri, 24 Nov 2023 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852200;
	bh=8OqGQl9eTafoqRnhkitWuLzcHomRgwkFOPTHa/Vemvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rg2SArnlaX+I6rFh+7YmmjOFDrMvA4S+agzWDqm+X3Mi2FACw7Rl11/AXBC4MrsZW
	 ZRhoCNzOBbw3LNGHQ7Cl54CdY1ULe6joQll5C8CqdMt6VcfCnM91ZiwF7Zo9NmUOam
	 y+cjaHEmC3+NNaNgF/FWsy/+AKqMU+J0Su8m3K3g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.1 260/372] i3c: master: svc: fix ibi may not return mandatory data byte
Date: Fri, 24 Nov 2023 17:50:47 +0000
Message-ID: <20231124172019.155198570@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Frank Li <Frank.Li@nxp.com>

commit c85e209b799f12d18a90ae6353b997b1bb1274a5 upstream.

MSTATUS[RXPEND] is only updated after the data transfer cycle started. This
creates an issue when the I3C clock is slow, and the CPU is running fast
enough that MSTATUS[RXPEND] may not be updated when the code reaches
checking point. As a result, mandatory data can be missed.

Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data is
already in FIFO. It also works without mandatory data.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc:  <stable@vger.kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20231023161658.3890811-4-Frank.Li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master/svc-i3c-master.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -325,6 +325,7 @@ static int svc_i3c_master_handle_ibi(str
 	struct i3c_ibi_slot *slot;
 	unsigned int count;
 	u32 mdatactrl;
+	int ret, val;
 	u8 *buf;
 
 	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
@@ -334,6 +335,13 @@ static int svc_i3c_master_handle_ibi(str
 	slot->len = 0;
 	buf = slot->data;
 
+	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
+	if (ret) {
+		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		return ret;
+	}
+
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);



