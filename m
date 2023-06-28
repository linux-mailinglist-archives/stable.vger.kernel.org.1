Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D8740AC2
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 10:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjF1IKu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjF1IGP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 04:06:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C72D78
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:05:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5038724b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1687939535; x=1690531535;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWPeCBlAMxrecskxb6L/1ppNB2UXaMy93rWZ7sSyrpg=;
        b=h67LkxmDzD+D9QpLATILZ9JiggJS2mkbwltcFYmYsLJdABkPcpwp1QxPsoGiEYsmTw
         eLIC4WqUFgzeBQaxJqq/CKOcVGxxlkCHo88wkvH00hU9OQOYlyU2UvyIcJ7cf5WgHnC/
         0swrlCVapjdCiUEKX8efreK3vUsVlAqwvPCzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939535; x=1690531535;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWPeCBlAMxrecskxb6L/1ppNB2UXaMy93rWZ7sSyrpg=;
        b=VcIWOZAKmMEPneASIBu0oWOPsw9wvXp5rwNfEdZbv08Dm7fevNZco83Q1z4tK38XP7
         9vZaKn8KYLGOF5oL6/WjzkmJxD6ttQ0WVJZFCM0wUonrGTJADwbF6JD8yKNN6DeOMXhk
         sdgswnGHSJj9wPPElqe/4Z2TfYnx5P6aqS2LrpM8wono8DeJV78NhDGgS0wvc4ft8Jcm
         Ldd5R9dfdSfLa13bB5ijG9yRWAHKKKG36o/NmkG0SQIHaU6UaNBEexh3y52t5rBlo2eT
         5sg0H6bJ/owdIDvdmIEGYU25jtYr3neFmhepFDRdzgCXxDe83xRTD14uDFpgZP0N59bv
         kvUg==
X-Gm-Message-State: AC+VfDw1OyPGcnPTYKYCYYN69Jxwyh+RfrPDD135zzwL9qIRXC2swhuH
        RwgsBgFV0ODsVVagdjJN4Ra4CSxAo2uo3hHw9S4=
X-Google-Smtp-Source: ACHHUZ56lGmQzd+sH/aXCG8IYx1ePUiRRuXskOWQAznv3zfVKnmeqmlO4k530y6Fn9w9HKKEvagVlQ==
X-Received: by 2002:a17:90a:7522:b0:25d:e321:c4e8 with SMTP id q31-20020a17090a752200b0025de321c4e8mr33103155pjk.41.1687935961128;
        Wed, 28 Jun 2023 00:06:01 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b0024e4f169931sm8964361pjb.2.2023.06.28.00.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 00:06:00 -0700 (PDT)
From:   Ranjan Kumar <ranjan.kumar@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] mpt3sas: Perform additional retries if Doorbell read returns 0
Date:   Wed, 28 Jun 2023 12:35:10 +0530
Message-Id: <20230628070511.27774-2-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628070511.27774-1-ranjan.kumar@broadcom.com>
References: <20230628070511.27774-1-ranjan.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006f393c05ff2c0c3f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--0000000000006f393c05ff2c0c3f
Content-Transfer-Encoding: 8bit

Doorbell and Host diagnostic registers could return 0 even
after 3 retries and that leads to occasional resets of the
controllers, hence increased the retry count to thirty.

Fixes: b899202901a8 ("mpt3sas: Add separate function for aero doorbell reads ")
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


--0000000000006f393c05ff2c0c3f
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOv/cC3Cld4qn0magTdTUVjFGARTTIgk
VRgCh11eB3xCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYy
ODA4MDUzNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQClvcCbFFoELi1zTjqBKgB9Y042u+m4DFJ0ZSWA5eGo99jNhWo4
trdmohGMpzP2Jq9Ieneqho80Qw/9lLnB/fj4dFIxBo8vB337JKavnKTRS8r+KdZH7KmcXkROOYVa
q7gnez7DeImFJv6K+Fyd8ZQgeSt61iuUhD0opdwyLxJ1ma4IAdsJt7nBzfH7/WcgY0Ot37UKngj9
L5df5jv/BwV5bJO3GBGFKUM5ODNgF0cHQUkvl7VG6gHN+tqvN9E6UJ5gRvNUxEShGlkdmGF9K5zE
rxiTr3uOptgWKqfG3si86DLS77eWU6ye8/6e0u/rMgbHCgw8rcf3mNVCiidoJpGe
--0000000000006f393c05ff2c0c3f--
