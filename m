Return-Path: <stable+bounces-251474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKWMKOfyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADEB5946E0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EF01304BD3D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FFE39B975;
	Wed, 20 May 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfP5VEAj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3037754D;
	Wed, 20 May 2026 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298076; cv=none; b=ODx3BYbywcXA4Uv4kTwQq8hVwdWgTSwa1wieJ+wLf9mrt9dRORNrl5T7TTw2txuLreXMt4ikEfRmc4Oc0pLX8G29kFVVGTqGqAsMwIhkVE+0op45ko/7mk9cuNhdHg58M3Tql9GF6dWht63zLc/dsiWTDPe3rt34bBDOZIB1WDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298076; c=relaxed/simple;
	bh=LE98jFH8+ICaKGEzqQ0fZ4TtVx6Qe9DhYn5NMhXNSis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxqGBifTvPYJIxVlBMhr5BY4JE5jmobNuHudw+OmUKl3c1B3kzmFjYwY3Z0eeDnv+c4YtVXgQ74ZVM2bj/5juaCZtzzXAkGFE1W9mDkPTY//hNBrtVWHCW9jVzhBRXHDYhA5ZU7xpjWGT/Vx286IdPqQGF+ArQBPX2VeSbFbtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfP5VEAj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB321F00893;
	Wed, 20 May 2026 17:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298075;
	bh=GZ+ObSHamVwxpV6air7yEHlaoTbH8fzE/fnjyWMTr3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sfP5VEAjpzk0rgomTVSP8iYdgwNxkSesvbjqOqXqlYA770AfvcNcKVG/WU7ol7P6e
	 4UbE1VISdZNXzveC4HGE0Ew4F0n1OxrE/TNpYZ6a7doI/KYRYeSOnMVa+jAebosTsX
	 +dS7IsZXqmwmps1lAhFF3oV6i3fwrXKQafujOfdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victoria Brekenfeld <victoria@system76.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 274/957] drm/msm: Fix VM_BIND UNMAP locking
Date: Wed, 20 May 2026 18:12:37 +0200
Message-ID: <20260520162140.484448708@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251474-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,patchwork.freedesktop.org:url,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,system76.com:email]
X-Rspamd-Queue-Id: 4ADEB5946E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robin.clark@oss.qualcomm.com>

[ Upstream commit 85042c2cd970a6b0e686329387096fe19989ae62 ]

Wrong argument meant that the objs involved in UNMAP ops were not always
getting locked.

Since _NO_SHARE objs share a common resv with the VM (which is always
locked) this would only show up with non-_NO_SHARE BOs.

Reported-by: Victoria Brekenfeld <victoria@system76.com>
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/94
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/713898/
Message-ID: <20260324220519.1221471-2-robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 44bcc2b291e47..9016ef978be5e 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1232,7 +1232,7 @@ vm_bind_job_lock_objects(struct msm_vm_bind_job *job, struct drm_exec *exec)
 			case MSM_VM_BIND_OP_UNMAP:
 				ret = drm_gpuvm_sm_unmap_exec_lock(job->vm, exec,
 							      op->iova,
-							      op->obj_offset);
+							      op->range);
 				break;
 			case MSM_VM_BIND_OP_MAP:
 			case MSM_VM_BIND_OP_MAP_NULL: {
-- 
2.53.0




