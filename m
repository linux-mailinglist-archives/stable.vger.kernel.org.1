Return-Path: <stable+bounces-140896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54528AAAC98
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848BB3B500E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933FC3C4DA8;
	Mon,  5 May 2025 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU8BtU7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5118638AF27;
	Mon,  5 May 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486776; cv=none; b=u0kmybVbOq1zkQEYdH7MUaI3P4WNp5pTcGJDjFPbZPhSCSPy7cOksADZzWDBpT22K1Es+2yXvn0FYEJ6XUth0JryvT8+gcpqilRZEFZm3mQxEvDt/ixFsBK9OWNw2IS+EENaFssDUdWbp2VRTcM9Ji7YFeNzBnaVBHMtQFkFydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486776; c=relaxed/simple;
	bh=O93GOxNWz5ji8fvhIskxfUjI+ZUwtz78F4UhBJq70aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EOhMdAiNGRqCydVXbv+aGTtheIUz3MQ+GHXTLri44uVRXroq+TH4N6ThHGegYYulgEF7Qfr09CaMsnkGVxrVd9LAfEd2slLhNqJnwDxW9CDSSeKUcTvV2l51e590nlE8l5TCiRh58XeHJdfEZaKNug7B7rtEO2p1XL0H6Lk2mAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU8BtU7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D63C4CEF2;
	Mon,  5 May 2025 23:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486775;
	bh=O93GOxNWz5ji8fvhIskxfUjI+ZUwtz78F4UhBJq70aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PU8BtU7Ul6tVKtU7UN5LMjl1UuQtknznTlHjzmy//E8xvubmmG+gXx/2pWNHB7/Lp
	 yzaIE1xoaKVO1nE6TBwfnjUpbZMh8BSU1R4s9/2AaH/7+eon3ehFfrLkQ2PUnJaPu4
	 a1OKaUAh6Vahy0rj3AMwzB2WQqP8cTRkd92XfOV+5ZEuFefbP39U8zggUIx3dwaHRY
	 x8+Ed19k89YVmOWpu3E3cjiXz3gPWytr/8ryPHhSni1tn6CpS+NLI3TNn+iTE7U1gE
	 840oaRIzCYHxXGbXlX1Q8gnQyVJK/vkSwfoP3nCgrMveg61Qa0Yqm+Fx1FJg7AYzbH
	 PFgWfw+Jv+vwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Tee <justin.tee@broadcom.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 196/212] scsi: lpfc: Handle duplicate D_IDs in ndlp search-by D_ID routine
Date: Mon,  5 May 2025 19:06:08 -0400
Message-Id: <20250505230624.2692522-196-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

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
index 57be02f8d5c18..b04112c77fcd1 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5619,6 +5619,7 @@ static struct lpfc_nodelist *
 __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 {
 	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *np = NULL;
 	uint32_t data1;
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
@@ -5633,14 +5634,20 @@ __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
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


