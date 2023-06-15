Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6607073122D
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbjFOIbP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbjFOIbO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 04:31:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115D2125
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 01:31:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666779dcc8aso1150230b3a.0
        for <stable@vger.kernel.org>; Thu, 15 Jun 2023 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686817872; x=1689409872;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOfkaXQP6a7nMtHjmGTQ1+3gj3u/SpYCxsuLpI5jIaw=;
        b=Vjsw28UiMORstu9Iijie+tfJdodD3F2n0zWat8i0pgSkAsdqyoXoH24FiwBNDe7hnJ
         tS8ps+ah/YhB+pJN27EVp45zQGEpg7VcJERm7DQ84tJ9yevzjaHvZpVlclgqgi6YpTGW
         GQtbzSo9W8sjaxJMTpiqlVkv5nEaqsRZkCFM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686817872; x=1689409872;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOfkaXQP6a7nMtHjmGTQ1+3gj3u/SpYCxsuLpI5jIaw=;
        b=lJzyHu+0U+/PGrhuB7XeZabjQh9Q2z8s0qfG+/1iMKU0YDN8Cc+13YDyHo7utuMW7u
         uxLPM6RP/8PrjFLewlzFB8lfR8kXbb69/6DFzEcPy2oo1m81NlZXDB5OhcUOXs3Pk6VQ
         OGNY1tVJH3cHxOTGYUdg03u1hltZLp/oV3oreEjzTGpxEPPPyzVp58stzt1OAW/AvQOt
         kcp0PSPk23/W5MitmD0dd9LRMPnzZC5m4YBFUDnLABjR09mJOtYaAtAXOk/ID9+eLhjY
         L3mv2MmwGNstqB/i6V8tlTfywfYBLDWHUJxLupNeWVv2owqJum5kY4/FRkjrCcDAHGaN
         mdJw==
X-Gm-Message-State: AC+VfDwEUdnHPHsWnJZgFu1P2vVwl8f1o86KhNPpoP+p2VqfWaX3gRJD
        gjF7s8YHWn7dh2Tjwihlwjfz1Q==
X-Google-Smtp-Source: ACHHUZ4xn00dBpWSTtbmhD3x07GHx04y6VFhJ8vK+cODUrnmszzOTdlbTRHlpqLDzcSJ5REQvDFmQA==
X-Received: by 2002:a05:6a20:2451:b0:107:35ed:28b5 with SMTP id t17-20020a056a20245100b0010735ed28b5mr4998905pzc.2.1686817872260;
        Thu, 15 Jun 2023 01:31:12 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u9-20020aa78489000000b006589cf6d88bsm11912402pfn.145.2023.06.15.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:31:11 -0700 (PDT)
From:   Ranjan Kumar <ranjan.kumar@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        stable@vger.kernel.org
Subject: [PATCH] mpt3sas: Perform additional retries if Doorbell read returns 0
Date:   Thu, 15 Jun 2023 14:00:10 +0530
Message-Id: <20230615083010.45837-1-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000019f31205fe26e45e"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--00000000000019f31205fe26e45e
Content-Transfer-Encoding: 8bit

Doorbell and Host diagnostic registers could return 0 even
after 3 retries and that leads to occasional resets of the
controllers, hence increased the retry count to thirty.

'Fixes: b899202901a8 ("mpt3sas: Add separate function for aero doorbell reads ")'
Cc: stable@vger.kernel.org

Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 50 ++++++++++++++++-------------
 drivers/scsi/mpt3sas/mpt3sas_base.h |  4 ++-
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 53f5492579cb..44e7ccb6f780 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -201,20 +201,20 @@ module_param_call(mpt3sas_fwfault_debug, _scsih_set_fwfault_debug,
  * while reading the system interface register.
  */
 static inline u32
-_base_readl_aero(const volatile void __iomem *addr)
+_base_readl_aero(const volatile void __iomem *addr, u8 retry_count)
 {
 	u32 i = 0, ret_val;
 
 	do {
 		ret_val = readl(addr);
 		i++;
-	} while (ret_val == 0 && i < 3);
+	} while (ret_val == 0 && i < retry_count);
 
 	return ret_val;
 }
 
 static inline u32
-_base_readl(const volatile void __iomem *addr)
+_base_readl(const volatile void __iomem *addr, u8 retry_count)
 {
 	return readl(addr);
 }
@@ -940,7 +940,7 @@ mpt3sas_halt_firmware(struct MPT3SAS_ADAPTER *ioc)
 
 	dump_stack();
 
-	doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+	doorbell = ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY);
 	if ((doorbell & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_FAULT) {
 		mpt3sas_print_fault_code(ioc, doorbell &
 		    MPI2_DOORBELL_DATA_MASK);
@@ -1617,10 +1617,10 @@ mpt3sas_base_mask_interrupts(struct MPT3SAS_ADAPTER *ioc)
 	u32 him_register;
 
 	ioc->mask_interrupts = 1;
-	him_register = ioc->base_readl(&ioc->chip->HostInterruptMask);
+	him_register = ioc->base_readl(&ioc->chip->HostInterruptMask, READL_RETRY_COUNT_OF_THREE);
 	him_register |= MPI2_HIM_DIM + MPI2_HIM_RIM + MPI2_HIM_RESET_IRQ_MASK;
 	writel(him_register, &ioc->chip->HostInterruptMask);
-	ioc->base_readl(&ioc->chip->HostInterruptMask);
+	ioc->base_readl(&ioc->chip->HostInterruptMask, READL_RETRY_COUNT_OF_THREE);
 }
 
 /**
@@ -1634,7 +1634,7 @@ mpt3sas_base_unmask_interrupts(struct MPT3SAS_ADAPTER *ioc)
 {
 	u32 him_register;
 
-	him_register = ioc->base_readl(&ioc->chip->HostInterruptMask);
+	him_register = ioc->base_readl(&ioc->chip->HostInterruptMask, READL_RETRY_COUNT_OF_THREE);
 	him_register &= ~MPI2_HIM_RIM;
 	writel(him_register, &ioc->chip->HostInterruptMask);
 	ioc->mask_interrupts = 0;
@@ -6686,7 +6686,7 @@ mpt3sas_base_get_iocstate(struct MPT3SAS_ADAPTER *ioc, int cooked)
 {
 	u32 s, sc;
 
-	s = ioc->base_readl(&ioc->chip->Doorbell);
+	s = ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY);
 	sc = s & MPI2_IOC_STATE_MASK;
 	return cooked ? sc : s;
 }
@@ -6760,7 +6760,8 @@ _base_wait_for_doorbell_int(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	count = 0;
 	cntdn = 1000 * timeout;
 	do {
-		int_status = ioc->base_readl(&ioc->chip->HostInterruptStatus);
+		int_status = ioc->base_readl(&ioc->chip->HostInterruptStatus,
+							READL_RETRY_COUNT_OF_THREE);
 		if (int_status & MPI2_HIS_IOC2SYS_DB_STATUS) {
 			dhsprintk(ioc,
 				  ioc_info(ioc, "%s: successful count(%d), timeout(%d)\n",
@@ -6786,7 +6787,8 @@ _base_spin_on_doorbell_int(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	count = 0;
 	cntdn = 2000 * timeout;
 	do {
-		int_status = ioc->base_readl(&ioc->chip->HostInterruptStatus);
+		int_status = ioc->base_readl(&ioc->chip->HostInterruptStatus,
+							READL_RETRY_COUNT_OF_THREE);
 		if (int_status & MPI2_HIS_IOC2SYS_DB_STATUS) {
 			dhsprintk(ioc,
 				  ioc_info(ioc, "%s: successful count(%d), timeout(%d)\n",
@@ -6824,14 +6826,16 @@ _base_wait_for_doorbell_ack(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	count = 0;
 	cntdn = 1000 * timeout;
 	do {
-		int_status = ioc->base_readl(&ioc->chip->HostInterruptStatus);
+		int_status = ioc->base_readl(&ioc->chip->HostInterruptStatus,
+							READL_RETRY_COUNT_OF_THREE);
 		if (!(int_status & MPI2_HIS_SYS2IOC_DB_STATUS)) {
 			dhsprintk(ioc,
 				  ioc_info(ioc, "%s: successful count(%d), timeout(%d)\n",
 					   __func__, count, timeout));
 			return 0;
 		} else if (int_status & MPI2_HIS_IOC2SYS_DB_STATUS) {
-			doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+			doorbell = ioc->base_readl(&ioc->chip->Doorbell,
+							READL_RETRY_COUNT_OF_THIRTY);
 			if ((doorbell & MPI2_IOC_STATE_MASK) ==
 			    MPI2_IOC_STATE_FAULT) {
 				mpt3sas_print_fault_code(ioc, doorbell);
@@ -6871,7 +6875,7 @@ _base_wait_for_doorbell_not_used(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	count = 0;
 	cntdn = 1000 * timeout;
 	do {
-		doorbell_reg = ioc->base_readl(&ioc->chip->Doorbell);
+		doorbell_reg = ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY);
 		if (!(doorbell_reg & MPI2_DOORBELL_USED)) {
 			dhsprintk(ioc,
 				  ioc_info(ioc, "%s: successful count(%d), timeout(%d)\n",
@@ -7019,13 +7023,13 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	__le32 *mfp;
 
 	/* make sure doorbell is not in use */
-	if ((ioc->base_readl(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
+	if ((ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY) & MPI2_DOORBELL_USED)) {
 		ioc_err(ioc, "doorbell is in use (line=%d)\n", __LINE__);
 		return -EFAULT;
 	}
 
 	/* clear pending doorbell interrupts from previous state changes */
-	if (ioc->base_readl(&ioc->chip->HostInterruptStatus) &
+	if (ioc->base_readl(&ioc->chip->HostInterruptStatus, READL_RETRY_COUNT_OF_THREE) &
 	    MPI2_HIS_IOC2SYS_DB_STATUS)
 		writel(0, &ioc->chip->HostInterruptStatus);
 
@@ -7068,7 +7072,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	}
 
 	/* read the first two 16-bits, it gives the total length of the reply */
-	reply[0] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[0] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 	if ((_base_wait_for_doorbell_int(ioc, 5))) {
@@ -7076,7 +7080,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 			__LINE__);
 		return -EFAULT;
 	}
-	reply[1] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[1] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 
@@ -7087,10 +7091,10 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 			return -EFAULT;
 		}
 		if (i >=  reply_bytes/2) /* overflow case */
-			ioc->base_readl(&ioc->chip->Doorbell);
+			ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY);
 		else
 			reply[i] = le16_to_cpu(
-			    ioc->base_readl(&ioc->chip->Doorbell)
+			    ioc->base_readl(&ioc->chip->Doorbell, READL_RETRY_COUNT_OF_THIRTY)
 			    & MPI2_DOORBELL_DATA_MASK);
 		writel(0, &ioc->chip->HostInterruptStatus);
 	}
@@ -7949,14 +7953,15 @@ _base_diag_reset(struct MPT3SAS_ADAPTER *ioc)
 			goto out;
 		}
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic,
+								READL_RETRY_COUNT_OF_THIRTY);
 		drsprintk(ioc,
 			  ioc_info(ioc, "wrote magic sequence: count(%d), host_diagnostic(0x%08x)\n",
 				   count, host_diagnostic));
 
 	} while ((host_diagnostic & MPI2_DIAG_DIAG_WRITE_ENABLE) == 0);
 
-	hcb_size = ioc->base_readl(&ioc->chip->HCBSize);
+	hcb_size = ioc->base_readl(&ioc->chip->HCBSize, READL_RETRY_COUNT_OF_THREE);
 
 	drsprintk(ioc, ioc_info(ioc, "diag reset: issued\n"));
 	writel(host_diagnostic | MPI2_DIAG_RESET_ADAPTER,
@@ -7969,7 +7974,8 @@ _base_diag_reset(struct MPT3SAS_ADAPTER *ioc)
 	for (count = 0; count < (300000000 /
 		MPI2_HARD_RESET_PCIE_SECOND_READ_DELAY_MICRO_SEC); count++) {
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic,
+								READL_RETRY_COUNT_OF_THIRTY);
 
 		if (host_diagnostic == 0xFFFFFFFF) {
 			ioc_info(ioc,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 05364aa15ecd..3b8ec4fd2d21 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -160,6 +160,8 @@
 
 #define IOC_OPERATIONAL_WAIT_COUNT	10
 
+#define READL_RETRY_COUNT_OF_THIRTY	30
+#define READL_RETRY_COUNT_OF_THREE	3
 /*
  * NVMe defines
  */
@@ -994,7 +996,7 @@ typedef void (*NVME_BUILD_PRP)(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 typedef void (*PUT_SMID_IO_FP_HIP) (struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u16 funcdep);
 typedef void (*PUT_SMID_DEFAULT) (struct MPT3SAS_ADAPTER *ioc, u16 smid);
-typedef u32 (*BASE_READ_REG) (const volatile void __iomem *addr);
+typedef u32 (*BASE_READ_REG) (const volatile void __iomem *addr, u8 retry_count);
 /*
  * To get high iops reply queue's msix index when high iops mode is enabled
  * else get the msix index of general reply queues.
-- 
2.31.1


--00000000000019f31205fe26e45e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
GK2Ee6ez7fr/FL1RWbOPVHJR+deNIorOjW7U5HVwnRYhM1OR4mAkrkqcN+3kwae0KmVO3SDKFd7h
Ok4L2e1ixyaRTo379Ur3iVTnagglDOliayMGRITBPe0CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU8WuEiYXvpeCaubgLCCFoyRBc
8QwwDQYJKoZIhvcNAQELBQADggEBAA5th3yz1fvJCBmK21x68IdDNFC0gmynT76I3fOgslLHc7ey
lC9VXLb+vJ863blS/WxEOwf0fvc0ks7qYWl8xisInHu5AX9glaooGhLImlzE0l9rDf0tcq2kkgc4
CXL9UGDEoqdxfRj3j9xn9fm9gpTBWSck6ufc/8RV1TLVjcZvrYkMqQwoVulGkr+HCnzaEFxBRmO/
nWsVitGa1sKS9usFXoW1bQXgJ9TtRdy8gka8b9SaKnh4TaiEKpdl8ztXhugWp7RpFGVu/ZZ8narx
0H1L9W/UIr3J/uYokdFr+hIrXOfOwJLB18bWOTCVWxTEo4zYC8qZ/h7UcS5aispm/rkxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxMV+PqteWF5WGw7jsw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEw8u74CEwX/OEG3cxxRhynQ+9OUEXuG
iPG6tRB2QBawMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYx
NTA4MzExMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCIZZXRkjhnDXxYrlBmtacRHpNV4xXzMy+Aeower464vsVPy3sH
AzHm/53XpsIsntcdk7J7f6L/If/JM+GoughF0CG0+wh55czL+epGKLoCiUKkIVLYLKbgFYtrJ+WX
iom9hLAtfZ2tZ9tPqFV2ViKeNr2phRiiyjCJ6n4wqXHBABJ4naNHjy07JYYaVMIxRBp41RxxeGGX
VFZwcXfUNe4S89fCxZF5Smah72YNukbsyNR/lp9QCRAtYhYs4oTZDAKEJBO1iPJNYzrFEa7MmKMH
eGnZUGswgAR9s9HM77p7QPor/W51lLPMTIzJZD2Is/PoOjGaRzXpHYLe3bS5CJlK
--00000000000019f31205fe26e45e--
