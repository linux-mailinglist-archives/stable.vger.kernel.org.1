Return-Path: <stable+bounces-225028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCJ4BHAfs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2501278BCC
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14E64301A7BD
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1AA29E11D;
	Thu, 12 Mar 2026 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HbspHXLp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8B1F9F70;
	Thu, 12 Mar 2026 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346667; cv=none; b=c5kT8fjhopB9kzCFS/g9s4sfIBsiL/BDtSj3OTK7tXRJqeCSLw29OkeZtTpYwey8lHoDKokelI1q4iEduuClVfFkFAnr7mtb9LDagdU/5FbzZRp27KKuFA4dFjejI7UcjbH2vNCnTSIyqnTmmxj05+IcCdWkv/J0jnUpCiGMbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346667; c=relaxed/simple;
	bh=GeU7oAVMc5LIRzaHT8PDJWCavul8yqiimnWelDQzbWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHcy2XlyDQCF9RGNqIPaFj7QHPpJ2vdk0qsqBVW+5HCRXdPS4ALHRguMqME5/eB37deObjEJv6SSTg7Ipkq8D9xic4DWbDZpUMUBk6H79Wd16ISABBs09czYyT3kfhYLGHAsqWHuxBiTo4FhYns7JMxWcS/DiNXLT1ee4Wqbw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HbspHXLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E7AC4CEF7;
	Thu, 12 Mar 2026 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346667;
	bh=GeU7oAVMc5LIRzaHT8PDJWCavul8yqiimnWelDQzbWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbspHXLp7bGeeiat5llkjT0KKUmXZeTnHr5HneCd9CKfU9jvVGrYIVZyJD6WU75yA
	 1SBbdequ97ZYzohKebFD/mNS87ehs/1cfZFfJn0RKRdts3L3aUk3doFHGEcG/7EYiG
	 i8ETcdhN/eCJxKKrhfvH7Lc9dtzZLv31A3oaqCzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeongjun Park <aha310510@gmail.com>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 095/265] drm/exynos: vidi: fix to avoid directly dereferencing user pointer
Date: Thu, 12 Mar 2026 21:08:02 +0100
Message-ID: <20260312201021.660593507@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225028-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,samsung.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: A2501278BCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit d4c98c077c7fb2dfdece7d605e694b5ea2665085 ]

In vidi_connection_ioctl(), vidi->edid(user pointer) is directly
dereferenced in the kernel.

This allows arbitrary kernel memory access from the user space, so instead
of directly accessing the user pointer in the kernel, we should modify it
to copy edid to kernel memory using copy_from_user() and use it.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 6de0cced6c9d2..007fd8dad3559 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -246,13 +246,27 @@ int vidi_connection_ioctl(struct drm_device *drm_dev, void *data,
 
 	if (vidi->connection) {
 		const struct drm_edid *drm_edid;
-		const struct edid *raw_edid;
+		const void __user *edid_userptr = u64_to_user_ptr(vidi->edid);
+		void *edid_buf;
+		struct edid hdr;
 		size_t size;
 
-		raw_edid = (const struct edid *)(unsigned long)vidi->edid;
-		size = (raw_edid->extensions + 1) * EDID_LENGTH;
+		if (copy_from_user(&hdr, edid_userptr, sizeof(hdr)))
+			return -EFAULT;
 
-		drm_edid = drm_edid_alloc(raw_edid, size);
+		size = (hdr.extensions + 1) * EDID_LENGTH;
+
+		edid_buf = kmalloc(size, GFP_KERNEL);
+		if (!edid_buf)
+			return -ENOMEM;
+
+		if (copy_from_user(edid_buf, edid_userptr, size)) {
+			kfree(edid_buf);
+			return -EFAULT;
+		}
+
+		drm_edid = drm_edid_alloc(edid_buf, size);
+		kfree(edid_buf);
 		if (!drm_edid)
 			return -ENOMEM;
 
-- 
2.51.0




