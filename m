Return-Path: <stable+bounces-167099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1D3B21E2F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560473ABB6A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC202DF3F8;
	Tue, 12 Aug 2025 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JYH5YnHQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CE2737F2
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979713; cv=none; b=LYe4s77seyLAdJ5mBSw3CAEHbLaIT19TTTqULWX6bWGaqooA1Ar/TibZTIJ697DPWiMFo7j5UI88YeWtMmCZeuj69qH1aRbRK1O0HlhJkbU/d77UuSkD6GTOw3xScfbBqVGJejCyiTFLbRGGuGtFq5NPM8hhEKWNYai9o39A7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979713; c=relaxed/simple;
	bh=j9SeDoRL/zhcDIxNSS4UctRBSHg1RCzqAgMYHl9qkqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=njwDV6V/+d9id1/ySuK8GeUxesJrX61StAJZ0w/GWp0jX01waez3JUc+mp4PMtU2mJhONIha6OiogNZs4/JlbaU8kgsJUVJcnGLH1YXbZIn/8ai/rg1CJtPaQ8IQf9LvDAHGf6DgITkLXcB/MtaAIhiebi78VIPowZJuW70T59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JYH5YnHQ; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so4623082fac.0
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 23:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754979711; x=1755584511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCHLE6MOqroEiy+1R8X845jTZo3rM4OTlMeoN6yXvZg=;
        b=jZ1TFPn8gmKwoaQBardlqIe51SEBv7DTjuQih3R877dC/pGdoDP97YbLISGyjITwi1
         c3L8iLxwzVbu/ESN+7ftGBlMP/1yQvG0Lb4AecrhiyL8mmi16Y6ovvI50/tX4pha+lcl
         EGJZpcDSecq9PYtVXX8R21VuMHoYaRcao1MKNYFlhBDiYaW+i6j/rCc2lyPvrkd4UOfP
         u05caaZFD+t5hrle89GDfslg0vAcg9Mj4iBQMEXzd8W5m58TcJzbLrj+DllolvOcDw/v
         ACrcLH9r/bLigJSPIHoQZ0ItO0NCijRjEkCrxTZktfhinduNNClPm024pIgdnPxvRQzw
         hqog==
X-Gm-Message-State: AOJu0YwVRAo0dtp4kjyNXYmKf3FoT3bf/qoNyJTPpYLO6Lcx/6cB82gy
	lSE9RDhLmWHR58t4tCAlMxjG1yt471NHZ0egG5EbDKpjavAwbOfLru9jMPrtcIG/i44lFmHar2l
	x1WiFvKJ9na8weLorlVvghxQPkX1FXErhpPIJZmTIAX/tn16zdrPZ9lZXvpUxFSuXoJjvCL72eN
	3XgPktQ02g8Nu9kiwr20I2uyiLCvCIZsN50BJLxJFlLNeCR1u/6AEK0qf1HIGTCD7ixydL2sYhx
	zStYK/b+S+VS70NCw==
X-Gm-Gg: ASbGnctp07eo/qkMYh+wvfJrdztfLDYtastJdV/2yukDHH2zb/a1IytY8aef34c1fN8
	IvzX35nJTtyNfpk0p/Cp5xNdIoWdTSb0FIn1WANm7eYs7wbQjy2JiRA3KQk8iNIKuEWHgBosOpJ
	p7dIZ2nnWkS/B+eY0n/lWxYpZ3Cd/rNj9+IO7BZUAZhw8LdQnrnuIgPOlKQr2vX0+zwrB6ng+Tf
	Y7MtjeiQIFvTlIK9MMJ8MMx38IOo0N+jQzoCsdEt8KXfB+18v5F2K5dBJdWf5Kfs19H0V0feZzk
	fVScult8ljBdrqZ3dTpOle+1vjCQEl90mXDq6VUvCEBJQBBglvtK8r3QsmWbuDpJIAfL/oTbGOW
	uN4hGArixRM9GzmDmvEDTxKAUsDPk2FxAuxQBdEyFAIoP7i6Yz3AAY/Vkb7gEwCFrtJDbnanxJx
	oT9/mjZA==
X-Google-Smtp-Source: AGHT+IFcfuPp2l9qeHBJI14/B0kS96WjOYj7HWmR7HFJSKf4a5pzdYFcWOpigeY0kGUSeIZrzJ/StxpCcQvW
X-Received: by 2002:a05:6871:6718:b0:2e9:925b:206f with SMTP id 586e51a60fabf-30c94f3cf74mr1079594fac.17.1754979710670;
        Mon, 11 Aug 2025 23:21:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-30c5e5a8536sm443278fac.7.2025.08.11.23.21.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:21:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e6a5428a76so1550821485a.1
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754979708; x=1755584508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCHLE6MOqroEiy+1R8X845jTZo3rM4OTlMeoN6yXvZg=;
        b=JYH5YnHQbjvf+g2d+XFQbDxl2nbUFvOxWnBsmHvnGvFI1TWIWIWCVnG2DoR1dfbL2Z
         0J+p6X/inANSbCCX8XWudKGae6KIVgy+n500419nVsgyUyptzq/we3Mqo6sJbXT7sNda
         DskgSjig9wC/ajj7H8A/IMEN0qNYeiV9+qwo0=
X-Received: by 2002:a05:620a:bd6:b0:7e8:71b:96ac with SMTP id af79cd13be357-7e858daee46mr342623685a.11.1754979708400;
        Mon, 11 Aug 2025 23:21:48 -0700 (PDT)
X-Received: by 2002:a05:620a:bd6:b0:7e8:71b:96ac with SMTP id af79cd13be357-7e858daee46mr342619985a.11.1754979707824;
        Mon, 11 Aug 2025 23:21:47 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e826e22c13sm800422385a.50.2025.08.11.23.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:21:47 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	James Smart <jsmart2021@gmail.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] scsi: lpfc: Fix link down processing to address NULL pointer  dereference
Date: Mon, 11 Aug 2025 23:08:22 -0700
Message-Id: <20250812060822.149216-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 1854f53ccd88ad4e7568ddfafafffe71f1ceb0a6 ]

If an FC link down transition while PLOGIs are outstanding to fabric well
known addresses, outstanding ABTS requests may result in a NULL pointer
dereference. Driver unload requests may hang with repeated "2878" log
messages.

The Link down processing results in ABTS requests for outstanding ELS
requests. The Abort WQEs are sent for the ELSs before the driver had set
the link state to down. Thus the driver is sending the Abort with the
expectation that an ABTS will be sent on the wire. The Abort request is
stalled waiting for the link to come up. In some conditions the driver may
auto-complete the ELSs thus if the link does come up, the Abort completions
may reference an invalid structure.

Fix by ensuring that Abort set the flag to avoid link traffic if issued due
to conditions where the link failed.

Link: https://lore.kernel.org/r/20211020211417.88754-7-jsmart2021@gmail.com
Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index ff39c596f000..49931577da38 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -11432,10 +11432,12 @@ lpfc_sli_abort_iotag_issue(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	if (cmdiocb->iocb_flag & LPFC_IO_FOF)
 		abtsiocbp->iocb_flag |= LPFC_IO_FOF;
 
-	if (phba->link_state >= LPFC_LINK_UP)
-		iabt->ulpCommand = CMD_ABORT_XRI_CN;
-	else
+	if (phba->link_state < LPFC_LINK_UP ||
+	    (phba->sli_rev == LPFC_SLI_REV4 &&
+	     phba->sli4_hba.link_state.status == LPFC_FC_LA_TYPE_LINK_DOWN))
 		iabt->ulpCommand = CMD_CLOSE_XRI_CN;
+	else
+		iabt->ulpCommand = CMD_ABORT_XRI_CN;
 
 	abtsiocbp->iocb_cmpl = lpfc_sli_abort_els_cmpl;
 	abtsiocbp->vport = vport;
-- 
2.40.4


