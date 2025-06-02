Return-Path: <stable+bounces-149996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B78ACB5FE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C629E5D03
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5AC222590;
	Mon,  2 Jun 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijDIy5Sk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86711B81DC;
	Mon,  2 Jun 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875703; cv=none; b=sel0XDDw1uMkuYyh0FGIxECjvU7PQ0Mm4lW5FEeHIEkc4PYxG8ilMstKVLc/LHhErH4Uk48HobnjYqXbl8/pzq0oAl3TXZmyhw8wKFMzjfwAgORy6wGhnYskJCMos30xmqCD12oxdOTPaUex087+Nr6mGIHLdXh9CjY5ty+j45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875703; c=relaxed/simple;
	bh=O+RRWal4SboFvkYetKHvsz1doCWbu6a87TgoUcGigJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsYZZFsCIuWf4jqmFuB48oFN6hGHexs1IyIclZV5aaBQ/ypFA3TefVF2O9kWQ0U87nWVR0RechcIxF6A7vyIN0TPjCmeBWvd8J3LfpARP0CSH4OX2G5APeuxHhYFCXzc7/5u6pFiyHyytKjFWg5kuRZJEMAShMWfpVGbhN1i5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijDIy5Sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603C3C4CEEB;
	Mon,  2 Jun 2025 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875702;
	bh=O+RRWal4SboFvkYetKHvsz1doCWbu6a87TgoUcGigJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijDIy5SkzZiplNC1h6OauR8hammFSxd2dGsXB/ZhNPkAbXKsg18nnAg729c/PuM6R
	 uZkiZiNjWtC7JjdUXYx1CgR9PauVL3aIFl3VzvtG6Y4x86CeaolWB80CJPpzC1oQTS
	 Gz8Y6aUpXEJXrLTmP24VSXDpDo2TVKCTm0RvtBV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 217/270] scsi: lpfc: Handle duplicate D_IDs in ndlp search-by D_ID routine
Date: Mon,  2 Jun 2025 15:48:22 +0200
Message-ID: <20250602134316.056618929@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 56c3d809b7b450379162d0b8a70bbe71ab8db706 ]

After a port swap between separate fabrics, there may be multiple nodes in
the vport's fc_nodes list with the same fabric well known address.
Duplication is temporary and eventually resolves itself after dev_loss_tmo
expires, but nameserver queries may still occur before dev_loss_tmo.  This
possibly results in returning stale fabric ndlp objects.  Fix by adding an
nlp_state check to ensure the ndlp search routine returns the correct newer
allocated ndlp fabric object.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20250131000524.163662-5-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 3ff76ca147a5a..353c360b0c6ab 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5407,6 +5407,7 @@ static struct lpfc_nodelist *
 __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 {
 	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *np = NULL;
 	uint32_t data1;
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
@@ -5421,14 +5422,20 @@ __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1, ndlp->nlp_rpi,
 					 ndlp->active_rrqs_xri_bitmap);
-			return ndlp;
+
+			/* Check for new or potentially stale node */
+			if (ndlp->nlp_state != NLP_STE_UNUSED_NODE)
+				return ndlp;
+			np = ndlp;
 		}
 	}
 
-	/* FIND node did <did> NOT FOUND */
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
-			 "0932 FIND node did x%x NOT FOUND.\n", did);
-	return NULL;
+	if (!np)
+		/* FIND node did <did> NOT FOUND */
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
+				 "0932 FIND node did x%x NOT FOUND.\n", did);
+
+	return np;
 }
 
 struct lpfc_nodelist *
-- 
2.39.5




