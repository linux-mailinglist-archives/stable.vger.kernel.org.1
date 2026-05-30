Return-Path: <stable+bounces-257130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPdzDrsWG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C0C60EA2E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DAB930BAD0A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34883403F3;
	Sat, 30 May 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9J8Yxak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C43242BE;
	Sat, 30 May 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159910; cv=none; b=SKMHniHNwWzpFDrhpVJJNaDeQYqyZ4+GZTIev/xsDFAue5GakbvG+IAHN3x1FOu8lfpJdXFtnehko+gYxDoCfsoZgvRoesO2dXN9f+Nex6GxYD4OH/tl2TLQydDimZnl/VqRKS6ztvi7DObqERM0hUo7wXhVD8HRWk0eFlYjsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159910; c=relaxed/simple;
	bh=8pbHkHOqkdtj6absZuMTN06E0t4RdaC5W9Qw1S0Xnno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIGMoy2Rs7JPgnBYHDIHIE1aVDJ91cI7VLO9P+nvJEkbM9opXDbi7IvxJdQx+Rut/y3NZjVaUc4TT/icwtJn9DVhnyLDHs6teRbA41P7kptEej6RYAbbZxXUcYG/dFfOYRxc1SQ2FEdspFCZ46Yuj0/77+050xYFS/i3H7zUTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9J8Yxak; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5761F00893;
	Sat, 30 May 2026 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780159909;
	bh=FxbTfB0E7s5Ll5EbkD5BBeMOo38TBlO9ZMWyN7RO7PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9J8YxakeMZdfwKyB7CxqvEi4XIcHJ5k8/N/v8FcsROFzPBw2kVdoDyqSRYUvBVSp
	 5vw+cj/h/mId2k1qrctedJXXbVauVruxBETS4OFgJTotLa+6fGrwPqBD7yIxa3X6QI
	 emJylZhV6GZJbd+KFdYzDlkOIUKCZNJ0lGPgboQ8=
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
	stable <stable@kernel.org>
Subject: [PATCH 6.1 164/969] drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
Date: Sat, 30 May 2026 17:54:48 +0200
Message-ID: <20260530160305.049682509@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257130-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A3C0C60EA2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 2fc87d37be1b730a149b035f9375fdb8cc5333a5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -668,7 +668,7 @@ nouveau_gem_pushbuf_reloc_apply(struct n
 		}
 		nvbo = (void *)(unsigned long)bo[r->reloc_bo_index].user_priv;
 
-		if (unlikely(r->reloc_bo_offset + 4 >
+		if (unlikely((u64)r->reloc_bo_offset + 4 >
 			     nvbo->bo.base.size)) {
 			NV_PRINTK(err, cli, "reloc outside of bo\n");
 			ret = -EINVAL;



