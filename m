Return-Path: <stable+bounces-235157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOueL/aq1mmOHAgAu9opvQ
	(envelope-from <stable+bounces-235157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA43C2DAB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3DC5318DE17
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1DA37F8AC;
	Wed,  8 Apr 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aEKvohMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1413176E4;
	Wed,  8 Apr 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674716; cv=none; b=Wq9kdvYBKTfGhgKdOcSYZivIlVcj/Q7P+6Dqrd0/g3uSnoGcm9r06HcinZT1RFACZlgcc6/JgxYga+7oMuwA4FugjFZo1CFpBi2gyXLgivyIN1a+Hli/1/AYY6NJvusO0TjTuGRd52L9L3Tyf2WW/tIMjtLjvdJq3zcMy/1p8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674716; c=relaxed/simple;
	bh=yo1PGd2l8RYgzPxKBKvn1aCl8ln5wqD884yBMYr5XU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2CdklmPK+tH6KzXe11E2KMfMFj6WCaVm/UHRJNbN9GSq8thNypEXYj72kTQ4Bie3bsWDIc3S5TVWXRM2OHZnSB/HZELqzaGc5bd7nHIyRh1NzexjbxEVPoPRzvPh5v58D2G7qAi8IlJpe2EvS7w7XS34hkwv1+vw2+yfPyX8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEKvohMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6185C19421;
	Wed,  8 Apr 2026 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674716;
	bh=yo1PGd2l8RYgzPxKBKvn1aCl8ln5wqD884yBMYr5XU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEKvohMiX/RzdA7Kn3PnrkGm/9yuGXGL/cwNdAT8+7mNlADAG5f1YO2f2/gdyxcp5
	 DSehrEOr0wN6FWhixczC2RxhVSkCYR8RabkVCZdwhv+jRI5gOhVA6LO0/Qzf0e5sYB
	 /JOsImFKrPYrS9o6S9vDynmqnme0mJwrYTG6+S5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.19 204/311] drm/amdgpu: validate doorbell_offset in user queue creation
Date: Wed,  8 Apr 2026 20:03:24 +0200
Message-ID: <20260408175947.026372427@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235157-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,amd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 21AA43C2DAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit a018d1819f158991b7308e4f74609c6c029b670c upstream.

amdgpu_userq_get_doorbell_index() passes the user-provided
doorbell_offset to amdgpu_doorbell_index_on_bar() without bounds
checking. An arbitrarily large doorbell_offset can cause the
calculated doorbell index to fall outside the allocated doorbell BO,
potentially corrupting kernel doorbell space.

Validate that doorbell_offset falls within the doorbell BO before
computing the BAR index, using u64 arithmetic to prevent overflow.

Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit de1ef4ffd70e1d15f0bf584fd22b1f28cbd5e2ec)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -550,6 +550,13 @@ amdgpu_userq_get_doorbell_index(struct a
 		goto unpin_bo;
 	}
 
+	/* Validate doorbell_offset is within the doorbell BO */
+	if ((u64)db_info->doorbell_offset * db_size + db_size >
+	    amdgpu_bo_size(db_obj->obj)) {
+		r = -EINVAL;
+		goto unpin_bo;
+	}
+
 	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
 					     db_info->doorbell_offset, db_size);
 	drm_dbg_driver(adev_to_drm(uq_mgr->adev),



