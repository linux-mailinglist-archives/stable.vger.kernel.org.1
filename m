Return-Path: <stable+bounces-266423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jM8OF2GeMWqooQUAu9opvQ
	(envelope-from <stable+bounces-266423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:05:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AAF694B9B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:05:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=DsrB0ZT7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266423-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266423-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799A331B8900
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2347D92F;
	Tue, 16 Jun 2026 18:59:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20523EB0F5;
	Tue, 16 Jun 2026 18:59:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636346; cv=none; b=dO9z/s68bV5Qt8AVxU0Nem9pFQoGHNWQ9b7CCtIifzninFOFZNCgnFMhlfmoncGhs9ICQSSGVK89G9zykrfsGIADBdG7hmRX6zF7Co5OSQAGm9EALDNF9hjZ5LWrqoYWtsn/v/54XgyI2Q2IP6/9+DmqcSLDzHaEeDt1aRvoWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636346; c=relaxed/simple;
	bh=KyJeOS0nfXTp0iqLLDX6Kj45iLYjeOf8eFz3PPQP4T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjR4dM7ReNr5GmcRIG8d/z+loKsvHkF5CHmGNp9vMvwQBxeLAV3TU2hxxmkY8w80INY+dIzSUVzq0Ww0Nls9RfFCaFEMU2sI6v5eirsFCpypdZg8Gwoi8myaIikcfC7oAmtB10cin3f/2cFbJdLBsc5sdMJmrKpb5x4couioQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DsrB0ZT7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC81F000E9;
	Tue, 16 Jun 2026 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636345;
	bh=kDJTha8DsM3gr5RG8qGaYFvsWAdGr8VmrqJ/9NMtw9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DsrB0ZT7ulQxyRTt8PPDpMpfhlXC0rtQBpwUBuF3Ca7KJB83xVqH/+KZYdB86vI+/
	 pW23bn5a8rVdNUdZNGI2NQJT+u5pvRn2madgJFFAGY06m2UHW0rved3T1jM+TXswja
	 iCLoyZSJBIJZ0Flozfi4UJqVzWqda0F/pcCyoQp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable <stable@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 222/342] drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
Date: Tue, 16 Jun 2026 20:28:38 +0530
Message-ID: <20260616145058.541117504@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-266423-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:lyude@redhat.com,m:dakr@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:stable@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,ffwll.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9AAF694B9B

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -618,7 +618,7 @@ nouveau_gem_pushbuf_reloc_apply(struct n
 		}
 		nvbo = (void *)(unsigned long)bo[r->reloc_bo_index].user_priv;
 
-		if (unlikely(r->reloc_bo_offset + 4 >
+		if (unlikely((u64)r->reloc_bo_offset + 4 >
 			     nvbo->bo.mem.num_pages << PAGE_SHIFT)) {
 			NV_PRINTK(err, cli, "reloc outside of bo\n");
 			ret = -EINVAL;



