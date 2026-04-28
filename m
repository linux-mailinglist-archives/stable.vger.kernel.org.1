Return-Path: <stable+bounces-241512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIfwEUt68GnMTwEAu9opvQ
	(envelope-from <stable+bounces-241512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:13:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8BC4810D6
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96EE531126D0
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DA265629;
	Tue, 28 Apr 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE79cyOW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DE389471
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366966; cv=none; b=P+vHgs5GF885KRqs3mvkZwAGSUOuAeDOVBhrKETdKDfweV3VNkfrmVIjuaS8yRluYMAFG8ABCzpoA5XqJ26tZXDrgVL4bWT17HnDfqjJdvjowpyqVjJdMUt9lKZmuLTrsdapws52wPMaxWbKWnxnzRWz0VFXbLgpnUjX73voY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366966; c=relaxed/simple;
	bh=rR9IbszD2tDZROo4UNsyver5xL1kfbtpVdyrDg0qJNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHopfQMOJC5hQJHKsdijJ7+fOtbLjeH3FYhaL/Ina8NVdJH0yslk0prYu9sBlzoaAl2HKYa6xaxxPdUZKwe4Jwiv/n/BvOjRDd/GuP19VKEKWLsHq6fPV0CZ3xOcfnVrB9RhoRRAUNl+eNVx9x1CVo9av68wc3YyuoFbNnuuKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE79cyOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAAFC2BCF4;
	Tue, 28 Apr 2026 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777366965;
	bh=rR9IbszD2tDZROo4UNsyver5xL1kfbtpVdyrDg0qJNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AE79cyOWSRyWec/Xwn9mSXH8L2nPpt7OMymuksQ2lw6dF+RuyZ3M2bHxgBIVRaM8f
	 ICKDAdQlcMzpIMM1LipDzad99Vu/Eo5dKVyrM0j2+Pm0nTMdM403/DQj3ZmEIK+mw+
	 TTpT7fhFz+4ToraFK3TBu6d34cjkbdA2oTPvbtmHVFzTmlpJrNDyIkOLhNBAHWuXZ+
	 mISWZ/C9UrpzE863DRTOChAB2sey4jty/KgngbCUogk+kHE3AobX1CM7cxVFRRincm
	 PgWb6kQvbYV/+wZC3Z5KOYtbjbtmcf8eZ8ys4LXOfJNUOHNE/ZC/IUL+prJLzbLo+C
	 tcKzmT87HBvmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable <stable@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
Date: Tue, 28 Apr 2026 05:02:42 -0400
Message-ID: <20260428090242.2131744-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042712-extrovert-oblong-a615@gregkh>
References: <2026042712-extrovert-oblong-a615@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC8BC4810D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,redhat.com,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241512-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,suse.de:email,linuxfoundation.org:email,ffwll.ch:email]

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 2fc87d37be1b730a149b035f9375fdb8cc5333a5 ]

nouveau_gem_pushbuf_reloc_apply() validates each relocation with

    if (r->reloc_bo_offset + 4 > nvbo->bo.base.size)

but reloc_bo_offset is __u32 (uapi/drm/nouveau_drm.h) and the integer
literal 4 promotes to unsigned int, so the addition is performed in 32
bits and wraps before the comparison against the size_t bo size.

Cast to u64 so the addition happens in 64-bit arithmetic.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Reported-by: Anthropic
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Fixes: a1606a9596e5 ("drm/nouveau: new gem pushbuf interface, bump to 0.0.16")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Add Fixes: tag. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
[ Kept 5.10's `nvbo->bo.mem.num_pages << PAGE_SHIFT` instead of upstream's `nvbo->bo.base.size` accessor. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 567b43aa4a317..93c1afff5e90e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -618,7 +618,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 		}
 		nvbo = (void *)(unsigned long)bo[r->reloc_bo_index].user_priv;
 
-		if (unlikely(r->reloc_bo_offset + 4 >
+		if (unlikely((u64)r->reloc_bo_offset + 4 >
 			     nvbo->bo.mem.num_pages << PAGE_SHIFT)) {
 			NV_PRINTK(err, cli, "reloc outside of bo\n");
 			ret = -EINVAL;
-- 
2.53.0


