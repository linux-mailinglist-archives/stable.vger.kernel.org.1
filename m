Return-Path: <stable+bounces-51817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 443329071C3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D171F2811D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051E1448D4;
	Thu, 13 Jun 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zMS7rO03"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC001292FF;
	Thu, 13 Jun 2024 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282401; cv=none; b=KyCLYPXn8NUDUL/r6AasS+aPyj7NUc1Fazu9Y1oj8m4WNG1cowuwo9zm19I8ZZ5/O05tcMAIZjQeCKkUG852JMwtBKcwBw+J1s6gpp/0VfRE5k+N/zKNpCXokr66tef3tmZJO7mj6HNuzOTK0zQj08Bfjqi4aX/UGTV1vnlSbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282401; c=relaxed/simple;
	bh=zUg6w2eqiiQRixl8QKvoQk188tX3Ge7V87oqO1+pHhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fva1D6Tev4imVEZBYTpOEZm8n0EPRJ2TuoZX1WEKo7u0CgBLL2LuiRb4k14j2v0exKcq1MuSfJqy7//f5k75AuHc1h8KFi2DZU/bIPWcRzwJew9tiZbg78aArsHmeNW3ASi9cTxGT0zMYteZ069tmQwN7M+Q1npSBl1IBxOsFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zMS7rO03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7955C2BBFC;
	Thu, 13 Jun 2024 12:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282401;
	bh=zUg6w2eqiiQRixl8QKvoQk188tX3Ge7V87oqO1+pHhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zMS7rO03NM5yiLCZGkwjO0KqeeK9czWmQ6AsKZpeAHQkDxdKuXzGozoiScHDaaLI7
	 fuq/cEDkbTEyQVwj+kXUqSBWjXbgJQFIeGGHpe5FqpFzPYFFklRwD6ozAq25p5JdsU
	 ThI/blHDRi80KYxMa5DtspHTIRB9iswiKukB1Qb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 265/402] scsi: qla2xxx: Replace all non-returning strlcpy() with strscpy()
Date: Thu, 13 Jun 2024 13:33:42 +0200
Message-ID: <20240613113312.487573651@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Azeem Shaikh <azeemshaikh38@gmail.com>

[ Upstream commit 37f1663c91934f664fb850306708094a324c227c ]

strlcpy() reads the entire source buffer first.  This read may exceed the
destination size limit.  This is both inefficient and can lead to linear
read overflows if a source string is not NUL-terminated [1].  In an effort
to remove strlcpy() completely [2], replace strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Link: https://lore.kernel.org/r/20230516025404.2843867-1-azeemshaikh38@gmail.com
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: c3408c4ae041 ("scsi: qla2xxx: Avoid possible run-time warning with long model_num")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c |  8 ++++----
 drivers/scsi/qla2xxx/qla_mr.c   | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 585df40e95bb0..531e0ea87202e 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5145,7 +5145,7 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES)
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 	} else {
@@ -5153,14 +5153,14 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES) {
-			strlcpy(ha->model_number,
+			strscpy(ha->model_number,
 				qla2x00_model_name[index * 2],
 				sizeof(ha->model_number));
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 		} else {
-			strlcpy(ha->model_number, def,
+			strscpy(ha->model_number, def,
 				sizeof(ha->model_number));
 		}
 	}
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index f726eb8449c5e..083f94e43fba0 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -691,7 +691,7 @@ qlafx00_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 	struct qla_hw_data *ha = vha->hw;
 
 	if (pci_is_pcie(ha->pdev))
-		strlcpy(str, "PCIe iSA", str_len);
+		strscpy(str, "PCIe iSA", str_len);
 	return str;
 }
 
@@ -1850,21 +1850,21 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 			phost_info = &preg_hsi->hsi;
 			memset(preg_hsi, 0, sizeof(struct register_host_info));
 			phost_info->os_type = OS_TYPE_LINUX;
-			strlcpy(phost_info->sysname, p_sysid->sysname,
+			strscpy(phost_info->sysname, p_sysid->sysname,
 				sizeof(phost_info->sysname));
-			strlcpy(phost_info->nodename, p_sysid->nodename,
+			strscpy(phost_info->nodename, p_sysid->nodename,
 				sizeof(phost_info->nodename));
 			if (!strcmp(phost_info->nodename, "(none)"))
 				ha->mr.host_info_resend = true;
-			strlcpy(phost_info->release, p_sysid->release,
+			strscpy(phost_info->release, p_sysid->release,
 				sizeof(phost_info->release));
-			strlcpy(phost_info->version, p_sysid->version,
+			strscpy(phost_info->version, p_sysid->version,
 				sizeof(phost_info->version));
-			strlcpy(phost_info->machine, p_sysid->machine,
+			strscpy(phost_info->machine, p_sysid->machine,
 				sizeof(phost_info->machine));
-			strlcpy(phost_info->domainname, p_sysid->domainname,
+			strscpy(phost_info->domainname, p_sysid->domainname,
 				sizeof(phost_info->domainname));
-			strlcpy(phost_info->hostdriver, QLA2XXX_VERSION,
+			strscpy(phost_info->hostdriver, QLA2XXX_VERSION,
 				sizeof(phost_info->hostdriver));
 			preg_hsi->utc = (uint64_t)ktime_get_real_seconds();
 			ql_dbg(ql_dbg_init, vha, 0x0149,
@@ -1909,9 +1909,9 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 	if (fx_type == FXDISC_GET_CONFIG_INFO) {
 		struct config_info_data *pinfo =
 		    (struct config_info_data *) fdisc->u.fxiocb.rsp_addr;
-		strlcpy(vha->hw->model_number, pinfo->model_num,
+		strscpy(vha->hw->model_number, pinfo->model_num,
 			ARRAY_SIZE(vha->hw->model_number));
-		strlcpy(vha->hw->model_desc, pinfo->model_description,
+		strscpy(vha->hw->model_desc, pinfo->model_description,
 			ARRAY_SIZE(vha->hw->model_desc));
 		memcpy(&vha->hw->mr.symbolic_name, pinfo->symbolic_name,
 		    sizeof(vha->hw->mr.symbolic_name));
-- 
2.43.0




