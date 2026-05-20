Return-Path: <stable+bounces-251472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM0POdb7DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-251472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D81595EA5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1CF235A569C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B13A3826;
	Wed, 20 May 2026 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZK3L5HkE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082D2701C4;
	Wed, 20 May 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298071; cv=none; b=oFOGT0oA+YELI5+z6OV9hNEy3YLSJWPhp/TEmJUAHV/5TFlzQ9HRrEfeWmDmBhb5jq4++cI3M/DTSp7a5vV+jvTLg6wqHh4/7021C0r7rulJaPebqGe+IsysFxsub+lke/v1qAAsWAM/j8yzL71fwwLiVcvKktkZ4yq+6bxhjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298071; c=relaxed/simple;
	bh=CFm/TOKs6kytgRs3RKuBYkj/or06/X2jFgtRIgqAPNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no7J+eH4gXjKTz9O4/bYprwDJLRutXh/3qQjCs346XVMPeSXy6QrwXfTkIGHff29hM3iS0UYccjJIYifaFSg0DPhFe7byEFAPPme08LOWuHh4X6TJFsjhA0FWrDH6Bqr2rUCvLbIRRqEiDZsvCQUnaCqnAlo91ecZUERuyOUzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZK3L5HkE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7371F000E9;
	Wed, 20 May 2026 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298070;
	bh=GabApUelk/qmvRuBqOx7HbDWOGrbMBg66azqSfF3sRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZK3L5HkEGqWu+b1lUoLdkaTFZSDDtCZ2C/+vs4L0HPantpFrqeKJjrBH//Ghbwx01
	 OelmHW5bN+Go+RWsTn7hzidSrgIvHU2h2iKdUirSRdkesksF28JflOtxZQmOuzd23M
	 SgXiN16UrM3Xn3RKgtU/NTHSlZVQAcdIJvLcljkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 272/957] drm/msm/vma: Avoid lock in VM_BIND fence signaling path
Date: Wed, 20 May 2026 18:12:35 +0200
Message-ID: <20260520162140.442249940@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251472-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,patchwork.freedesktop.org:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 58D81595EA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robin.clark@oss.qualcomm.com>

[ Upstream commit 8a7023b035355ef5bfa096bd323256fa8abbbc6a ]

Use msm_gem_unpin_active(), similar to what is used in the GEM_SUBMIT
path.  This avoids needing to hold the obj lock, and the end result is
the same.  (As with GEM_SUBMIT, we know the fence isn't signaled yet.)

Reported-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/712230/
Message-ID: <20260316184442.673558-1-robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem.c     | 3 +++
 drivers/gpu/drm/msm/msm_gem_vma.c | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 9f7fbe577abb1..8636a7f031d24 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -533,8 +533,11 @@ void msm_gem_unpin_locked(struct drm_gem_object *obj)
  */
 void msm_gem_unpin_active(struct drm_gem_object *obj)
 {
+	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
+	GEM_WARN_ON(!mutex_is_locked(&priv->lru.lock));
+
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
 	update_lru_active(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 89a95977f41ef..44bcc2b291e47 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -680,6 +680,7 @@ static struct dma_fence *
 msm_vma_job_run(struct drm_sched_job *_job)
 {
 	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
+	struct msm_drm_private *priv = job->vm->drm->dev_private;
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
 	struct drm_gem_object *obj;
 	int ret = vm->unusable ? -EINVAL : 0;
@@ -722,12 +723,14 @@ msm_vma_job_run(struct drm_sched_job *_job)
 	if (ret)
 		msm_gem_vm_unusable(job->vm);
 
+	mutex_lock(&priv->lru.lock);
+
 	job_foreach_bo (obj, job) {
-		msm_gem_lock(obj);
-		msm_gem_unpin_locked(obj);
-		msm_gem_unlock(obj);
+		msm_gem_unpin_active(obj);
 	}
 
+	mutex_unlock(&priv->lru.lock);
+
 	/* VM_BIND ops are synchronous, so no fence to wait on: */
 	return NULL;
 }
-- 
2.53.0




