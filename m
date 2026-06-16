Return-Path: <stable+bounces-265591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S7PMItuMMWqSmQUAu9opvQ
	(envelope-from <stable+bounces-265591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:50:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58769386E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=c2Q6dXlP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265591-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265591-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F11E31B1681
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E81F3A5E91;
	Tue, 16 Jun 2026 17:46:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2023C3C1E;
	Tue, 16 Jun 2026 17:46:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631973; cv=none; b=UAM/yv3LF1kps/imk7G/0wXQmVdS7w/jBwaSr7GW5cK5bMWsmHHOul+M8jCYL3/NlueM1xeBZgdTdVhB7IkQWj7EcHL9Lur+ENqGUOH01da7FRK7BUFeMsBBwPbvlRAVXoVTSGfM2YzceTlbcgaBuR6HSPhghYy+3d439YSdsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631973; c=relaxed/simple;
	bh=9kL45s4tnzJno8DbPEgJuhBKTEcmAIl+JvkoYDMEAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtCZKCCetZTNGFFsDEyKon03vtTgm7HCdsbdpU+a2z6xHIQssaiIdw/1IHjm0DxOJ0xGaf4gmgkcFUefOXk0TobDKA6n272TVePS+OlUS0PaMHAfFZlOdQrw7hITRRZoKgcPLd2rcxLq0PsexZb74Bwj+rPOzfkgd5XcGR4jPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c2Q6dXlP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CE61F000E9;
	Tue, 16 Jun 2026 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631972;
	bh=eKbIhFCRrW5SyIke5JUsMHGAWf/mcLAQLIiI7kC0haE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c2Q6dXlPO5Pqi4PN87B4OEpkyUX2GpG0RANge2ZKgc+vq4t2tzKgkJmb8OsVgiueG
	 HhXlKbv+guxYQ1Mj26SXNvmNJbvrhxz/MwFr9q4bsajv9Bph6Y1N8xjdwee4Mw+JXZ
	 FRaN9VYSFvtAigO5zf7RUo7Lxonv/66WlpuVCw9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 322/522] drm/amdgpu: restart the CS if some parts of the VM are still invalidated
Date: Tue, 16 Jun 2026 20:27:49 +0530
Message-ID: <20260616145140.914850334@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:christian.koenig@amd.com,m:vitaly.prosyak@amd.com,m:alexander.deucher@amd.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265591-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF58769386E

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 40396ffdf6120e2380706c59e1a84d7e765a37b6 upstream.

Make sure that we only submit work with full up to date VM page tables.

Backport to 7.1 and older.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 59720bfd8c6dbebeb8d5a7ab64241b007efd9213)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1227,6 +1227,7 @@ static int amdgpu_cs_submit(struct amdgp
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct amdgpu_job *leader = p->gang_leader;
+	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	unsigned int i;
 	uint64_t seq;
@@ -1268,7 +1269,8 @@ static int amdgpu_cs_submit(struct amdgp
 		r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
 		e->range = NULL;
 	}
-	if (r) {
+
+	if (r || !list_empty(&vm->invalidated)) {
 		r = -EAGAIN;
 		mutex_unlock(&p->adev->notifier_lock);
 		return r;



