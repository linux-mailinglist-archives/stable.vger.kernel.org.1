Return-Path: <stable+bounces-186897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F177BBE9FA8
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC803627397
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2773328E2;
	Fri, 17 Oct 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0E02xqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48F2F12BE;
	Fri, 17 Oct 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714539; cv=none; b=Z7yIo5na7f9iUFVmGlmNNkDGY3NA4L16U5m3RKhqNYvDEieUhmemn+XywbujLVkQfLOmTH0XWIGS3WqJBWQRmqGoJ+VpdF4w2RcGiugTUH+HrgG3Y/7w7ph7GXE3l4e9ZLguodXD2RBY/ol/7IQqK7mqiI18ckLbnom80Cxr/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714539; c=relaxed/simple;
	bh=FLJXIsite+0c06oEdq50STt+anIUFsPpFYlzHOta5S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzsmMJtKIlevU+i8atF83vrJ7iReuFtDRutaRXXIorvRbCDE5ub/U7OLJbDkKyM6O44bfLUzyObs3jCEZrv+FTddphIvki7QThM4X/ufRJ9owDFu7K+05kKwlUEIRIWfrUzy0vb3szA9xWrp0WfiSx7Qy/Lny73k+msDQ9Al54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0E02xqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE12FC4CEE7;
	Fri, 17 Oct 2025 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714539;
	bh=FLJXIsite+0c06oEdq50STt+anIUFsPpFYlzHOta5S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0E02xqL3Bjd9+VYplxqTY5i3oeQ5Cmfal6u5eoZ1i9k99sq5KBcfyYcBszlA19Jm
	 3Qt9k5i857gMWqnOd+chYc+xDh61QJiyCbC3GV60Y1M2ovmt2+a7kcnXxIXGkStq8L
	 g3WY4Im55Vh6v5sWi87G5s21bxr66WyzR91BP7LE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 6.12 181/277] PCI/AER: Support errors introduced by PCIe r6.0
Date: Fri, 17 Oct 2025 16:53:08 +0200
Message-ID: <20251017145153.735765504@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 6633875250b38b18b8638cf01e695de031c71f02 upstream.

PCIe r6.0 defined five additional errors in the Uncorrectable Error
Status, Mask and Severity Registers (PCIe r7.0 sec 7.8.4.2ff).

lspci has been supporting them since commit 144b0911cc0b ("ls-ecaps:
extend decode support for more fields for AER CE and UE status"):

  https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/commit/?id=144b0911cc0b

Amend the AER driver to recognize them as well, instead of logging them as
"Unknown Error Bit".

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/21f1875b18d4078c99353378f37dcd6b994f6d4e.1756301211.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pcie/aer.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -38,7 +38,7 @@
 #define AER_ERROR_SOURCES_MAX		128
 
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
-#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
+#define AER_MAX_TYPEOF_UNCOR_ERRS	32	/* as per PCI_ERR_UNCOR_STATUS*/
 
 struct aer_err_source {
 	u32 status;			/* PCI_ERR_ROOT_STATUS */
@@ -510,11 +510,11 @@ static const char *aer_uncorrectable_err
 	"AtomicOpBlocked",		/* Bit Position 24	*/
 	"TLPBlockedErr",		/* Bit Position 25	*/
 	"PoisonTLPBlocked",		/* Bit Position 26	*/
-	NULL,				/* Bit Position 27	*/
-	NULL,				/* Bit Position 28	*/
-	NULL,				/* Bit Position 29	*/
-	NULL,				/* Bit Position 30	*/
-	NULL,				/* Bit Position 31	*/
+	"DMWrReqBlocked",		/* Bit Position 27	*/
+	"IDECheck",			/* Bit Position 28	*/
+	"MisIDETLP",			/* Bit Position 29	*/
+	"PCRC_CHECK",			/* Bit Position 30	*/
+	"TLPXlatBlocked",		/* Bit Position 31	*/
 };
 
 static const char *aer_agent_string[] = {



