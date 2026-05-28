Return-Path: <stable+bounces-256160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH7wOHOqGGoomAgAu9opvQ
	(envelope-from <stable+bounces-256160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:49:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE65F9A20
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB93E3246DE9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCC2139C9;
	Thu, 28 May 2026 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xEbs15MB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9933F8B2;
	Thu, 28 May 2026 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000924; cv=none; b=KN6vliP9BEqDlgB3SaIR7j/j3xMsQqXDCqREzIu0gufavqxpCvQgt65l24tBtq7YZtaIzweRb7UVZPx51NYL7yOl/+aD+VCvWix3x7ycodrT81RSfw51r1GQlAqJzK0XVDSW8RQ6N2cmBdm9/FV17dKbUAn1iYiXmB4Mtkt3aHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000924; c=relaxed/simple;
	bh=wR5azgdBW4DhNM56mc/BEQehfJrARyWqa92SJAjXVJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4CAwiDg6c/eZsUMLNymsd/BAIppoLDPI4Dz4POFWuIUeHqOWoFagmPGxkEiXy1RUGBVyre4QM3jEVcNpiviTk1nMEYNtaaCaYvQWSnoACZ0IPwpPfHXQ/SmGKwTQP0U8y/7S+aC5Ne2c5PBCohMiKeCuEGGuGdH0bniyiR+1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xEbs15MB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2A41F000E9;
	Thu, 28 May 2026 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000923;
	bh=Jb06hym5/5XVxZBDMbgkheKA0gXCx38TiLoSGLFfDRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xEbs15MBSdwtLEz+X+pU8ngkdoy4aL5hnLTJupUSnbkbut4pgNZMeIt+Md5kLm/ID
	 RAwLogWe3soGAe5gwaJ5wFNgQNkQV/XgJz+gh2J0MBmu7xzsZjr+q7TRlx45gUHrhL
	 Naxrd5yDzzxsgz8o/slYbdKL5kjGF7MyzTJhkE18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Maar <lukas.maar@tugraz.at>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 218/272] accel/qaic: Add overflow check to remap_pfn_range during mmap
Date: Thu, 28 May 2026 21:49:52 +0200
Message-ID: <20260528194635.311915067@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256160-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,tugraz.at:email,intel.com:email]
X-Rspamd-Queue-Id: 5CDE65F9A20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>

[ Upstream commit aa16b2bc0f02709919e2435f531406531e5bcc69 ]

The call to remap_pfn_range in qaic_gem_object_mmap is susceptible to
(re)mapping beyond the VMA if the BO is too large. This can cause use
after free issues when munmap() unmaps only the VMA region and not the
additional mappings. To prevent this, check the remaining size of the
VMA before remapping and truncate the remapped length if sg->length is
too large.

Reported-by: Lukas Maar <lukas.maar@tugraz.at>
Fixes: ff13be830333 ("accel/qaic: Add datapath")
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
[jhugo: fix braces from checkpatch --strict]
Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Link: https://patch.msgid.link/20260430193858.1178641-1-zachary.mckevitt@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/qaic/qaic_data.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 265eeb4e156fc..aa89571b37f0e 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -605,8 +605,11 @@ static const struct vm_operations_struct drm_vm_ops = {
 static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct qaic_bo *bo = to_qaic_bo(obj);
+	unsigned long remap_start;
 	unsigned long offset = 0;
+	unsigned long remap_end;
 	struct scatterlist *sg;
+	unsigned long length;
 	int ret = 0;
 
 	if (obj->import_attach)
@@ -614,11 +617,27 @@ static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struc
 
 	for (sg = bo->sgt->sgl; sg; sg = sg_next(sg)) {
 		if (sg_page(sg)) {
+			/* if sg is too large for the VMA, so truncate it to fit */
+			if (check_add_overflow(vma->vm_start, offset, &remap_start))
+				return -EINVAL;
+			if (check_add_overflow(remap_start, sg->length, &remap_end))
+				return -EINVAL;
+
+			if (remap_end > vma->vm_end) {
+				if (check_sub_overflow(vma->vm_end, remap_start, &length))
+					return -EINVAL;
+			} else {
+				length = sg->length;
+			}
+
+			if (length == 0)
+				goto out;
+
 			ret = remap_pfn_range(vma, vma->vm_start + offset, page_to_pfn(sg_page(sg)),
-					      sg->length, vma->vm_page_prot);
+					      length, vma->vm_page_prot);
 			if (ret)
 				goto out;
-			offset += sg->length;
+			offset += length;
 		}
 	}
 
-- 
2.53.0




