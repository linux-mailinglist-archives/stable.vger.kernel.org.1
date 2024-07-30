Return-Path: <stable+bounces-64524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF7941E39
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5441F24AA3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A191A76C6;
	Tue, 30 Jul 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+7h2U26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152141A76B6;
	Tue, 30 Jul 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360408; cv=none; b=qQ3H7QjHfpuJ721x8T+4jD1JhwGuvOwgcu8npXGH0Q4nC6xcWo7St2gC/kR56eH2iKLBHSIlaCtyWZdwjcT7MTuJQtKU8sIWxQZoDNm4ylAkLnHkBuU0My3h3AC9hYzgf64gQjN48f07NJDJw1MlVyg3m3mp/pNFm3rC6mY/x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360408; c=relaxed/simple;
	bh=lCV1i6R/mZLrHPOR5Vxaubq2EFiQZ3r+raUzxoweR0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La5MZvLV3cP40tvjEcGiBNr/M4GSQ1aDc7kpATBD7wuArzaJS3RiTO3/STuxN96GZLi/s8BPBbK4EGLt3B/DOUwDfSATvEbqAaos8RDpf9QAoXsDJKd5J7wS6O9aS8WwzbFveUsAv6B0zT9uI07QFRIGpgSWVQPj1z+pJrYU7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+7h2U26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEDEC32782;
	Tue, 30 Jul 2024 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360408;
	bh=lCV1i6R/mZLrHPOR5Vxaubq2EFiQZ3r+raUzxoweR0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+7h2U26S+PzVsOCxLNe27Xn+CwbMkpGllaoEZiWo5IJvLAJiqMuRIwJiESc4fQrp
	 CHt3f0AwFgwVE8n8Lcwfs31v3gk5co+XScX4/LvgafnUIbJ8CuBRM2R6FIWPAj8z9J
	 myQoestAi31lRLI/K/2oxnxE4HTgiKE3o5CiyzV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Quinn Tran <qutran@marvell.com>,
	Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.10 688/809] scsi: qla2xxx: Fix flash read failure
Date: Tue, 30 Jul 2024 17:49:24 +0200
Message-ID: <20240730151752.087119036@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 29e222085d8907ccff18ecd931bdd4c6b1f11b92 upstream.

Link up failure is observed as a result of flash read failure.  Current
code does not check flash read return code where it relies on FW checksum
to detect the problem.

Add check of flash read failure to detect the problem sooner.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/202406210815.rPDRDMBi-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20240710171057.35066-6-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |   63 ++++++++++++++++++-----
 drivers/scsi/qla2xxx/qla_sup.c  |  108 +++++++++++++++++++++++++++-------------
 2 files changed, 125 insertions(+), 46 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8218,15 +8218,21 @@ qla28xx_get_aux_images(
 	struct qla27xx_image_status pri_aux_image_status, sec_aux_image_status;
 	bool valid_pri_image = false, valid_sec_image = false;
 	bool active_pri_image = false, active_sec_image = false;
+	int rc;
 
 	if (!ha->flt_region_aux_img_status_pri) {
 		ql_dbg(ql_dbg_init, vha, 0x018a, "Primary aux image not addressed\n");
 		goto check_sec_image;
 	}
 
-	qla24xx_read_flash_data(vha, (uint32_t *)&pri_aux_image_status,
+	rc = qla24xx_read_flash_data(vha, (uint32_t *)&pri_aux_image_status,
 	    ha->flt_region_aux_img_status_pri,
 	    sizeof(pri_aux_image_status) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a1,
+		    "Unable to read Primary aux image(%x).\n", rc);
+		goto check_sec_image;
+	}
 	qla27xx_print_image(vha, "Primary aux image", &pri_aux_image_status);
 
 	if (qla28xx_check_aux_image_status_signature(&pri_aux_image_status)) {
@@ -8257,9 +8263,15 @@ check_sec_image:
 		goto check_valid_image;
 	}
 
-	qla24xx_read_flash_data(vha, (uint32_t *)&sec_aux_image_status,
+	rc = qla24xx_read_flash_data(vha, (uint32_t *)&sec_aux_image_status,
 	    ha->flt_region_aux_img_status_sec,
 	    sizeof(sec_aux_image_status) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a2,
+		    "Unable to read Secondary aux image(%x).\n", rc);
+		goto check_valid_image;
+	}
+
 	qla27xx_print_image(vha, "Secondary aux image", &sec_aux_image_status);
 
 	if (qla28xx_check_aux_image_status_signature(&sec_aux_image_status)) {
@@ -8317,6 +8329,7 @@ qla27xx_get_active_image(struct scsi_qla
 	struct qla27xx_image_status pri_image_status, sec_image_status;
 	bool valid_pri_image = false, valid_sec_image = false;
 	bool active_pri_image = false, active_sec_image = false;
+	int rc;
 
 	if (!ha->flt_region_img_status_pri) {
 		ql_dbg(ql_dbg_init, vha, 0x018a, "Primary image not addressed\n");
@@ -8358,8 +8371,14 @@ check_sec_image:
 		goto check_valid_image;
 	}
 
-	qla24xx_read_flash_data(vha, (uint32_t *)(&sec_image_status),
+	rc = qla24xx_read_flash_data(vha, (uint32_t *)(&sec_image_status),
 	    ha->flt_region_img_status_sec, sizeof(sec_image_status) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a3,
+		    "Unable to read Secondary image status(%x).\n", rc);
+		goto check_valid_image;
+	}
+
 	qla27xx_print_image(vha, "Secondary image", &sec_image_status);
 
 	if (qla27xx_check_image_status_signature(&sec_image_status)) {
@@ -8431,11 +8450,10 @@ qla24xx_load_risc_flash(scsi_qla_host_t
 	    "FW: Loading firmware from flash (%x).\n", faddr);
 
 	dcode = (uint32_t *)req->ring;
-	qla24xx_read_flash_data(vha, dcode, faddr, 8);
-	if (qla24xx_risc_firmware_invalid(dcode)) {
+	rval = qla24xx_read_flash_data(vha, dcode, faddr, 8);
+	if (rval || qla24xx_risc_firmware_invalid(dcode)) {
 		ql_log(ql_log_fatal, vha, 0x008c,
-		    "Unable to verify the integrity of flash firmware "
-		    "image.\n");
+		    "Unable to verify the integrity of flash firmware image (rval %x).\n", rval);
 		ql_log(ql_log_fatal, vha, 0x008d,
 		    "Firmware data: %08x %08x %08x %08x.\n",
 		    dcode[0], dcode[1], dcode[2], dcode[3]);
@@ -8449,7 +8467,12 @@ qla24xx_load_risc_flash(scsi_qla_host_t
 	for (j = 0; j < segments; j++) {
 		ql_dbg(ql_dbg_init, vha, 0x008d,
 		    "-> Loading segment %u...\n", j);
-		qla24xx_read_flash_data(vha, dcode, faddr, 10);
+		rval = qla24xx_read_flash_data(vha, dcode, faddr, 10);
+		if (rval) {
+			ql_log(ql_log_fatal, vha, 0x016a,
+			    "-> Unable to read segment addr + size .\n");
+			return QLA_FUNCTION_FAILED;
+		}
 		risc_addr = be32_to_cpu((__force __be32)dcode[2]);
 		risc_size = be32_to_cpu((__force __be32)dcode[3]);
 		if (!*srisc_addr) {
@@ -8465,7 +8488,13 @@ qla24xx_load_risc_flash(scsi_qla_host_t
 			ql_dbg(ql_dbg_init, vha, 0x008e,
 			    "-> Loading fragment %u: %#x <- %#x (%#lx dwords)...\n",
 			    fragment, risc_addr, faddr, dlen);
-			qla24xx_read_flash_data(vha, dcode, faddr, dlen);
+			rval = qla24xx_read_flash_data(vha, dcode, faddr, dlen);
+			if (rval) {
+				ql_log(ql_log_fatal, vha, 0x016b,
+				    "-> Unable to read fragment(faddr %#x dlen %#lx).\n",
+				    faddr, dlen);
+				return QLA_FUNCTION_FAILED;
+			}
 			for (i = 0; i < dlen; i++)
 				dcode[i] = swab32(dcode[i]);
 
@@ -8494,7 +8523,14 @@ qla24xx_load_risc_flash(scsi_qla_host_t
 		fwdt->length = 0;
 
 		dcode = (uint32_t *)req->ring;
-		qla24xx_read_flash_data(vha, dcode, faddr, 7);
+
+		rval = qla24xx_read_flash_data(vha, dcode, faddr, 7);
+		if (rval) {
+			ql_log(ql_log_fatal, vha, 0x016c,
+			    "-> Unable to read template size.\n");
+			goto failed;
+		}
+
 		risc_size = be32_to_cpu((__force __be32)dcode[2]);
 		ql_dbg(ql_dbg_init, vha, 0x0161,
 		    "-> fwdt%u template array at %#x (%#x dwords)\n",
@@ -8520,11 +8556,12 @@ qla24xx_load_risc_flash(scsi_qla_host_t
 		}
 
 		dcode = fwdt->template;
-		qla24xx_read_flash_data(vha, dcode, faddr, risc_size);
+		rval = qla24xx_read_flash_data(vha, dcode, faddr, risc_size);
 
-		if (!qla27xx_fwdt_template_valid(dcode)) {
+		if (rval || !qla27xx_fwdt_template_valid(dcode)) {
 			ql_log(ql_log_warn, vha, 0x0165,
-			    "-> fwdt%u failed template validate\n", j);
+			    "-> fwdt%u failed template validate (rval %x)\n",
+			    j, rval);
 			goto failed;
 		}
 
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -555,6 +555,7 @@ qla2xxx_find_flt_start(scsi_qla_host_t *
 	struct qla_flt_location *fltl = (void *)req->ring;
 	uint32_t *dcode = (uint32_t *)req->ring;
 	uint8_t *buf = (void *)req->ring, *bcode,  last_image;
+	int rc;
 
 	/*
 	 * FLT-location structure resides after the last PCI region.
@@ -584,14 +585,24 @@ qla2xxx_find_flt_start(scsi_qla_host_t *
 	pcihdr = 0;
 	do {
 		/* Verify PCI expansion ROM header. */
-		qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		rc = qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		if (rc) {
+			ql_log(ql_log_info, vha, 0x016d,
+			    "Unable to read PCI Expansion Rom Header (%x).\n", rc);
+			return QLA_FUNCTION_FAILED;
+		}
 		bcode = buf + (pcihdr % 4);
 		if (bcode[0x0] != 0x55 || bcode[0x1] != 0xaa)
 			goto end;
 
 		/* Locate PCI data structure. */
 		pcids = pcihdr + ((bcode[0x19] << 8) | bcode[0x18]);
-		qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		rc = qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		if (rc) {
+			ql_log(ql_log_info, vha, 0x0179,
+			    "Unable to read PCI Data Structure (%x).\n", rc);
+			return QLA_FUNCTION_FAILED;
+		}
 		bcode = buf + (pcihdr % 4);
 
 		/* Validate signature of PCI data structure. */
@@ -606,7 +617,12 @@ qla2xxx_find_flt_start(scsi_qla_host_t *
 	} while (!last_image);
 
 	/* Now verify FLT-location structure. */
-	qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, sizeof(*fltl) >> 2);
+	rc = qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, sizeof(*fltl) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x017a,
+		    "Unable to read FLT (%x).\n", rc);
+		return QLA_FUNCTION_FAILED;
+	}
 	if (memcmp(fltl->sig, "QFLT", 4))
 		goto end;
 
@@ -2605,13 +2621,18 @@ qla24xx_read_optrom_data(struct scsi_qla
     uint32_t offset, uint32_t length)
 {
 	struct qla_hw_data *ha = vha->hw;
+	int rc;
 
 	/* Suspend HBA. */
 	scsi_block_requests(vha->host);
 	set_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
 
 	/* Go with read. */
-	qla24xx_read_flash_data(vha, buf, offset >> 2, length >> 2);
+	rc = qla24xx_read_flash_data(vha, buf, offset >> 2, length >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a0,
+		    "Unable to perform optrom read(%x).\n", rc);
+	}
 
 	/* Resume HBA. */
 	clear_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
@@ -3412,7 +3433,7 @@ qla24xx_get_flash_version(scsi_qla_host_
 	struct active_regions active_regions = { };
 
 	if (IS_P3P_TYPE(ha))
-		return ret;
+		return QLA_SUCCESS;
 
 	if (!mbuf)
 		return QLA_FUNCTION_FAILED;
@@ -3432,20 +3453,31 @@ qla24xx_get_flash_version(scsi_qla_host_
 
 	do {
 		/* Verify PCI expansion ROM header. */
-		qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		ret = qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		if (ret) {
+			ql_log(ql_log_info, vha, 0x017d,
+			    "Unable to read PCI EXP Rom Header(%x).\n", ret);
+			return QLA_FUNCTION_FAILED;
+		}
+
 		bcode = mbuf + (pcihdr % 4);
 		if (memcmp(bcode, "\x55\xaa", 2)) {
 			/* No signature */
 			ql_log(ql_log_fatal, vha, 0x0059,
 			    "No matching ROM signature.\n");
-			ret = QLA_FUNCTION_FAILED;
-			break;
+			return QLA_FUNCTION_FAILED;
 		}
 
 		/* Locate PCI data structure. */
 		pcids = pcihdr + ((bcode[0x19] << 8) | bcode[0x18]);
 
-		qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		ret = qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		if (ret) {
+			ql_log(ql_log_info, vha, 0x018e,
+			    "Unable to read PCI Data Structure (%x).\n", ret);
+			return QLA_FUNCTION_FAILED;
+		}
+
 		bcode = mbuf + (pcihdr % 4);
 
 		/* Validate signature of PCI data structure. */
@@ -3454,8 +3486,7 @@ qla24xx_get_flash_version(scsi_qla_host_
 			ql_log(ql_log_fatal, vha, 0x005a,
 			    "PCI data struct not found pcir_adr=%x.\n", pcids);
 			ql_dump_buffer(ql_dbg_init, vha, 0x0059, dcode, 32);
-			ret = QLA_FUNCTION_FAILED;
-			break;
+			return QLA_FUNCTION_FAILED;
 		}
 
 		/* Read version */
@@ -3507,20 +3538,26 @@ qla24xx_get_flash_version(scsi_qla_host_
 			faddr = ha->flt_region_fw_sec;
 	}
 
-	qla24xx_read_flash_data(vha, dcode, faddr, 8);
-	if (qla24xx_risc_firmware_invalid(dcode)) {
-		ql_log(ql_log_warn, vha, 0x005f,
-		    "Unrecognized fw revision at %x.\n",
-		    ha->flt_region_fw * 4);
-		ql_dump_buffer(ql_dbg_init, vha, 0x005f, dcode, 32);
+	ret = qla24xx_read_flash_data(vha, dcode, faddr, 8);
+	if (ret) {
+		ql_log(ql_log_info, vha, 0x019e,
+		    "Unable to read FW version (%x).\n", ret);
+		return ret;
 	} else {
-		for (i = 0; i < 4; i++)
-			ha->fw_revision[i] =
+		if (qla24xx_risc_firmware_invalid(dcode)) {
+			ql_log(ql_log_warn, vha, 0x005f,
+			    "Unrecognized fw revision at %x.\n",
+			    ha->flt_region_fw * 4);
+			ql_dump_buffer(ql_dbg_init, vha, 0x005f, dcode, 32);
+		} else {
+			for (i = 0; i < 4; i++)
+				ha->fw_revision[i] =
 				be32_to_cpu((__force __be32)dcode[4+i]);
-		ql_dbg(ql_dbg_init, vha, 0x0060,
-		    "Firmware revision (flash) %u.%u.%u (%x).\n",
-		    ha->fw_revision[0], ha->fw_revision[1],
-		    ha->fw_revision[2], ha->fw_revision[3]);
+			ql_dbg(ql_dbg_init, vha, 0x0060,
+			    "Firmware revision (flash) %u.%u.%u (%x).\n",
+			    ha->fw_revision[0], ha->fw_revision[1],
+			    ha->fw_revision[2], ha->fw_revision[3]);
+		}
 	}
 
 	/* Check for golden firmware and get version if available */
@@ -3531,18 +3568,23 @@ qla24xx_get_flash_version(scsi_qla_host_
 
 	memset(ha->gold_fw_version, 0, sizeof(ha->gold_fw_version));
 	faddr = ha->flt_region_gold_fw;
-	qla24xx_read_flash_data(vha, dcode, ha->flt_region_gold_fw, 8);
-	if (qla24xx_risc_firmware_invalid(dcode)) {
-		ql_log(ql_log_warn, vha, 0x0056,
-		    "Unrecognized golden fw at %#x.\n", faddr);
-		ql_dump_buffer(ql_dbg_init, vha, 0x0056, dcode, 32);
+	ret = qla24xx_read_flash_data(vha, dcode, ha->flt_region_gold_fw, 8);
+	if (ret) {
+		ql_log(ql_log_info, vha, 0x019f,
+		    "Unable to read Gold FW version (%x).\n", ret);
 		return ret;
-	}
-
-	for (i = 0; i < 4; i++)
-		ha->gold_fw_version[i] =
-			be32_to_cpu((__force __be32)dcode[4+i]);
+	} else {
+		if (qla24xx_risc_firmware_invalid(dcode)) {
+			ql_log(ql_log_warn, vha, 0x0056,
+			    "Unrecognized golden fw at %#x.\n", faddr);
+			ql_dump_buffer(ql_dbg_init, vha, 0x0056, dcode, 32);
+			return QLA_FUNCTION_FAILED;
+		}
 
+		for (i = 0; i < 4; i++)
+			ha->gold_fw_version[i] =
+			   be32_to_cpu((__force __be32)dcode[4+i]);
+	}
 	return ret;
 }
 



