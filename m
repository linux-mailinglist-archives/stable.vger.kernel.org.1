Return-Path: <stable+bounces-259862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vFsjBMkaH2rffwAAu9opvQ
	(envelope-from <stable+bounces-259862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:02:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4F630EA1
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:02:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=igalia.com header.s=20170329 header.b=Pay+AiA5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259862-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-259862-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=igalia.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 977A93019D9A
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281503FC5D3;
	Tue,  2 Jun 2026 17:50:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752F2F7EE8
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 17:50:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422629; cv=none; b=GXdobG+1NnAjcGyUuMkW8A2ZETUYwlXSYDIaksGjP2RpH9We0pltDlGQUqvDw5rbEIeG95hkUxATWtleMyioAeHnAt4hp0Rkj5Vufd+mMUGamqfoSC0FzT+eQMK4Cs/C6wWYc2CtVNN5F3fnqmHirl3PhWOgfI+UrbMZD+UBTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422629; c=relaxed/simple;
	bh=RRma3Zd6UFVlvFhfVDjOAZoDItATMSqZ9aSBrB0Hd+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihOGBfFTdzHcaUXai+r5rE6W1pqZWi8HDGP0ey0homTjFEwgm9LwkPVE8MIUP/qPAz7AghNLQ6RT91sVq5ibdWKEbR0y8fDVxhoe2HQd7slMhXK6sEprSq4nb6umZmjJrL07iKbluabvbR/pcVSiECgxfdJuz1RDkqd7fvfJZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Pay+AiA5; arc=none smtp.client-ip=213.97.179.56
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+TdZ6wgntN0ET3unbfiP01cv5Eyt2WdGwjMV+mmhb2I=; b=Pay+AiA54RkyryygCF/uScVvey
	c19qfmRVl8/SqwGpGfjeo2pkVWMjHceuBMmj8KX+McEURTxRdNxhPySLIyDnhvLtnexnRGhcHgB5u
	udxtzZU7mKw1a7LVaJvSXWuTAAu+isIGJ40feJ9H1AC+sHJb8aoic9QSOhZsDPOqsrp+d0EdarzPX
	E8uqLVOLlF4wgxZuA5KV5+SuXuGdtPGQhgtbKfSNxpgoj4rhm5GaH6euHQJhU5gr5Bb7mgVrnTDbV
	53MZ79FX7qJ8GfynNQP7IP8LZ9kZetlsMcpRnWKVjgf9+eZdfrGPKQaengGufQOMZNHA2Sudu2oJm
	4yx8551Q==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wUTFx-00BpDx-R2; Tue, 02 Jun 2026 19:50:26 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 02 Jun 2026 14:50:14 -0300
Subject: [PATCH v4 1/2] drm/v3d: Fix vaddr leak when indirect CSD has
 zeroed workgroups
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-v3d-fix-indirect-csd-v4-1-654309e32bc0@igalia.com>
References: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
In-Reply-To: <20260602-v3d-fix-indirect-csd-v4-0-654309e32bc0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=RRma3Zd6UFVlvFhfVDjOAZoDItATMSqZ9aSBrB0Hd+I=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHxfbRk0PvjifMuv1wQQqLWjRqPTWPQhy5v1DJ
 IBtbfGKcVCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCah8X2wAKCRA/8w6Kdoj6
 qhtlCACA2gziDkmzSn8DZ8lpOvl2s3GMMqpSRSi/zBsxF1WHd2Xkxpf7GM2XMf8WxUhosyiR2hG
 fnNkRBqcsbS2Ct4DfiQS/ie/k4+OLs+APgCMZKGOSbPgqKJECXZo6Q8HP7+JFUyKNV+HXRtKf8n
 FRytalSkYluKkXwUglkUaGmN41yGJFB6LjRicxCuBFOJ9uEVSLpHWicTgM14lRYAOoduZxRZ9Xd
 MZOffJyve4h3xB5zc1aD738KVMeA0rHwA22bprXfzzLRnPLQksJR70r1EQe14UQdFCET5kZWqPP
 /aSViaRgQPmokIv4TSrzxFqrrFqtRwAcJvNkV4bdiXbXuyU1
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259862-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mwen@igalia.com,m:itoral@igalia.com,m:jmcasanova@igalia.com,m:kernel-dev@igalia.com,m:dri-devel@lists.freedesktop.org,m:stable@vger.kernel.org,m:mcanal@igalia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[igalia.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00B4F630EA1

v3d_rewrite_csd_job_wg_counts_from_indirect() maps both the indirect
buffer and the workgroup buffer and is expected to release them before
returning. When any of the workgroup counts read from the buffer is zero,
the function bailed out early and skipped the cleanup, leaking the vaddr
mappings of both BOs.

Jump to the cleanup path instead of returning directly, so the mappings
are always dropped.

Cc: stable@vger.kernel.org
Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 94bf628dc91c..47f83936cd73 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -403,7 +403,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 	wg_counts = (uint32_t *)(bo->vaddr + indirect_csd->offset);
 
 	if (wg_counts[0] == 0 || wg_counts[1] == 0 || wg_counts[2] == 0)
-		return;
+		goto unmap_bo;
 
 	args->cfg[0] = wg_counts[0] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
 	args->cfg[1] = wg_counts[1] << V3D_CSD_CFG012_WG_COUNT_SHIFT;
@@ -428,6 +428,7 @@ v3d_rewrite_csd_job_wg_counts_from_indirect(struct v3d_cpu_job *job)
 		}
 	}
 
+unmap_bo:
 	v3d_put_bo_vaddr(indirect);
 	v3d_put_bo_vaddr(bo);
 }

-- 
2.54.0


