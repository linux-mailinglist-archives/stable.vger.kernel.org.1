Return-Path: <stable+bounces-257929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHlhKd4hG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:43:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B07610424
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3630F30FEAA1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A33546F6;
	Sat, 30 May 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p52ytLIq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6E32B11F;
	Sat, 30 May 2026 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162644; cv=none; b=cAxRnE3wbbvnz6/I0GtbZY4FQ6XAqjMx3u+yuVebbSHjeqT2gduJLumoos4cokdDEDp2kXZdwoRpP8ltV2RAkxcNwLw/Wz4FUL8P+XqA2VLKD3cEL5N68IFx+xTJBZE/poauHkFRgvMjXQf5iAo1tJKheoFq0JCh3Mqpq+pC7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162644; c=relaxed/simple;
	bh=MvbredatniRebKRFCq8yBio7uOoyy7M7abualZQg8/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7F66/KgkUrzGKEU4CrFYRJqxuIk7J8HP9B57VhADTc1AU637fEjZL3EqXKPGDlaA0ugBcDArkFkelIu8U4HxRNxIYLD5LhlO0T7s0b+eMJGLsoqdKE9JGlzLCRCOg8lVnppHKl5WnlerJavt2Ig+IGnsEIeKJ12CIWQ3lSteHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p52ytLIq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E121F00893;
	Sat, 30 May 2026 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162643;
	bh=6KgGrjkyCAlO+MEcj9nl8FL7NL7SMYJsjKsdutooIDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p52ytLIqo4jUkooGRr1EtBnNUG8jkgpK8T9HE3IfqyTuYgWYEaslpNX/9Y0RbpzQ8
	 ugNwBE2GqSdfBYckE+5zvORHPYAz7i+6T4ebdXND9uWUXEutioxWFT54JbC5gj69/7
	 YuYBWb2zEKvr4vwY78NqyqbDdTXvJVIuXh5z50TE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 022/776] drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock
Date: Sat, 30 May 2026 17:55:36 +0200
Message-ID: <20260530160240.837961841@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257929-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 40B07610424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 338c56050d8e892604da97f67bfa8cc4015a955f ]

The mmap callback reads bo->madv without holding madv_lock, racing with
concurrent DRM_IOCTL_VC4_GEM_MADVISE calls that modify the field under
the same lock. Add the missing locking to prevent the data race.

Fixes: b9f19259b84d ("drm/vc4: Add the DRM_IOCTL_VC4_GEM_MADVISE ioctl")
Reviewed-by: Melissa Wen <mwen@igalia.com>
Link: https://patch.msgid.link/20260330-vc4-misc-fixes-v1-4-92defc940a29@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index f642bd6e71ff4..4703f180cde60 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -713,12 +713,15 @@ static int vc4_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 		return -EINVAL;
 	}
 
+	mutex_lock(&bo->madv_lock);
 	if (bo->madv != VC4_MADV_WILLNEED) {
 		DRM_DEBUG("mmaping of %s BO not allowed\n",
 			  bo->madv == VC4_MADV_DONTNEED ?
 			  "purgeable" : "purged");
+		mutex_unlock(&bo->madv_lock);
 		return -EINVAL;
 	}
+	mutex_unlock(&bo->madv_lock);
 
 	return drm_gem_cma_mmap(obj, vma);
 }
-- 
2.53.0




