Return-Path: <stable+bounces-250318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENYsGjPmDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:49:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C4592843
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8211F30EBC96
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC532B123;
	Wed, 20 May 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rNDY3dE6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AD221F2F;
	Wed, 20 May 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295099; cv=none; b=egG25T6oTzXTPv6F9i1/OUy9tdUmPWhxVSIrMESJCKQ6AsG1H6gU4IsxqQ2bAHwbowiOuFTtIG15xtQCwdJGTMLIJeUIlH/8OSPHNV2tH7beXKLLAsdI+xEGSnDofIRS0DDF87fbX71/9Dv/sObLYyNojvyf5R+phV8f2FAiGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295099; c=relaxed/simple;
	bh=OQoi4+dW/57XcbHkAzuqf932CzvXVBEzecNX+jhLKws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaBEE+tzAWjknvJrRgcorkSvmZ37S/5Wx1Utn0ep62egbzi2OXLC4w5I9+wMAykUVkQTdDCC4TP4s0oUVgWwZBZ5MJfV35pYXpEY3Hl7AjfrrLx5AD14KA/JmEB0U63GHNf2vZ43iRQgdv9YMWp7zQeMQXnisWUZhmqW9pSEHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rNDY3dE6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9481F1F00893;
	Wed, 20 May 2026 16:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295098;
	bh=cZLZwtuIt2gXdTtH7fAcwFdpu9gVltg/yd4ge5twYQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rNDY3dE61jBx+L0r0LrKtNqeCxyft+lLTqWuwHWOjWUk9+4BmrvbpSgU3tvDpXs/A
	 Uyh0bjDGenFs3MoWYu8yyoXfgbUytpDArIjkojY0di9uC509hSW2GkTD7u9ZvT4+Yb
	 xX4x4BU/c1ex62nphAShGaKXxUjteYb9v6asRZY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0289/1146] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
Date: Wed, 20 May 2026 18:08:59 +0200
Message-ID: <20260520162154.757578122@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250318-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,alibaba.com:email,amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 173C4592843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

[ Upstream commit f5c262b544975e067ea265fc7403aefbbea8563e ]

Add riscv_iommu_iodir_iotinval() to perform required TLB and context cache
invalidations after updating DDT or PDT entries, as mandated by the RISC-V
IOMMU specification (Section 6.3.1 and 6.3.2).

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/riscv/iommu.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index fa2ebfd2f912e..aadfbc181138f 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -996,7 +996,67 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 }
 
 #define RISCV_IOMMU_FSC_BARE 0
+/*
+ * This function sends IOTINVAL commands as required by the RISC-V
+ * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
+ * after modifying DDT or PDT entries
+ */
+static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
+				       bool inval_pdt, unsigned long iohgatp,
+				       struct riscv_iommu_dc *dc,
+				       struct riscv_iommu_pc *pc)
+{
+	struct riscv_iommu_command cmd;
+
+	riscv_iommu_cmd_inval_vma(&cmd);
 
+	if (FIELD_GET(RISCV_IOMMU_DC_IOHGATP_MODE, iohgatp) ==
+	    RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+		if (inval_pdt) {
+			/*
+			 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
+			 * PSCID=PC.PSCID
+			 */
+			riscv_iommu_cmd_inval_set_pscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
+		} else {
+			if (!FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) &&
+			    FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) !=
+			    RISCV_IOMMU_DC_FSC_MODE_BARE) {
+				/*
+				 * DC.tc.PDTV == 0 && DC.fsc.MODE != Bare
+				 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
+				 * PSCID=DC.ta.PSCID
+				 */
+				riscv_iommu_cmd_inval_set_pscid(&cmd,
+					FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, dc->ta));
+			}
+			/* else: IOTINVAL.VMA with GV=AV=PSCV=0 */
+		}
+	} else {
+		riscv_iommu_cmd_inval_set_gscid(&cmd,
+			FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
+
+		if (inval_pdt) {
+			/*
+			 * IOTINVAL.VMA with GV=1, AV=0, and PSCV=1, and
+			 * GSCID=DC.iohgatp.GSCID, PSCID=PC.PSCID
+			 */
+			riscv_iommu_cmd_inval_set_pscid(&cmd,
+				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
+		}
+		/*
+		 * else: IOTINVAL.VMA with GV=1,AV=PSCV=0,and
+		 * GSCID=DC.iohgatp.GSCID
+		 *
+		 * IOTINVAL.GVMA with GV=1,AV=0,and
+		 * GSCID=DC.iohgatp.GSCID
+		 * TODO: For now, the Second-Stage feature have not yet been merged,
+		 * also issue IOTINVAL.GVMA once second-stage support is merged.
+		 */
+	}
+	riscv_iommu_cmd_send(iommu, &cmd);
+}
 /*
  * Update IODIR for the device.
  *
@@ -1031,6 +1091,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
 		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
 		riscv_iommu_cmd_send(iommu, &cmd);
+		/*
+		 * For now, the SVA and PASID features have not yet been merged, the
+		 * default configuration is inval_pdt=false and pc=NULL.
+		 */
+		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
 		sync_required = true;
 	}
 
@@ -1056,6 +1121,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
 		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
 		riscv_iommu_cmd_send(iommu, &cmd);
+		/*
+		 * For now, the SVA and PASID features have not yet been merged, the
+		 * default configuration is inval_pdt=false and pc=NULL.
+		 */
+		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
 	}
 
 	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
-- 
2.53.0




