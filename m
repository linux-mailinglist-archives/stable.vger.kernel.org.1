Return-Path: <stable+bounces-238961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PZNB4Aw5mmWtAEAu9opvQ
	(envelope-from <stable+bounces-238961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6442C6FD
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4434D30A5A42
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEE93EDAAF;
	Mon, 20 Apr 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulq90t4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11703EDAA1;
	Mon, 20 Apr 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691515; cv=none; b=Op73b8vwmJoGjXvuwZm3fyn0R9vJnU98nx+WfLcARNhVYgg28QInFC9ZGyeiRMaM7K/DvTXYDyLoqRXZGBW5iJ3Q6UMXCk6A1FbKyw8aHZGorsEq7k499R9Ki2nSVuvN2QW21aSqcYQFHiZHKmsncyyqEjchmg7RMBMVSS/aa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691515; c=relaxed/simple;
	bh=aAa37wjp9jNLis7FJ8hKBQTsPEvjboH9hfzGfhPVlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECOxUsNDj8TeckMTbmK5qaCZ7ydwOaTJVb1a9PNnAEQTgd7Yj0q4JknB7ApB856o4jiylYKE8K49MnVrzPy7d1eGVVnUqKoBPJFJp8KDdhagDc5oMFI64zl7Pv77N2WUujgq7H6FSRb16F2+SiRs8clVra7NzyShnUpxWkxEkw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulq90t4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF26C2BCB4;
	Mon, 20 Apr 2026 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691515;
	bh=aAa37wjp9jNLis7FJ8hKBQTsPEvjboH9hfzGfhPVlc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulq90t4p8TP055U5GKAZcSdiFezZTxdarUke4u/glSMjPHt8Sg2pcxiUgVOzsxNhd
	 lPdrXttVwX2Srx8gJgqR/rxNAxUGPqyPq/azmT0c5HgCJ5v86118ZPqzagIvB5xuNn
	 IgFTvE46sIicscAoKcNqnhfz6XVA9ErzlpLLoQL+qrsMk3AFQhl1/Tuze8EwK8smNu
	 Bb6IK81B9KmQLnEypZfjoLB12wz7/4zK81gl9i6I6qFETMf5inOu0MP7faugU1mNN0
	 AzjF/qOC6wJifWuvtLQvKGxSrt+xL/MSzEHmPdvxFP1XCp3oucnEnPuZ5ovhSaM1zT
	 VYZuFWvUiHf5w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Melissa Wen <mwen@igalia.com>,
	Sasha Levin <sashal@kernel.org>,
	mripard@kernel.org,
	dave.stevenson@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	eric@anholt.net,
	bbrezillon@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock
Date: Mon, 20 Apr 2026 09:17:49 -0400
Message-ID: <20260420132314.1023554-75-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[igalia.com,kernel.org,raspberrypi.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,anholt.net,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238961-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 88C6442C6FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/gpu/drm/vc4/vc4_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 4aaa587be3a5e..a1efda9c39f92 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -738,12 +738,15 @@ static int vc4_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 		return -EINVAL;
 	}
 
+	mutex_lock(&bo->madv_lock);
 	if (bo->madv != VC4_MADV_WILLNEED) {
 		DRM_DEBUG("mmapping of %s BO not allowed\n",
 			  bo->madv == VC4_MADV_DONTNEED ?
 			  "purgeable" : "purged");
+		mutex_unlock(&bo->madv_lock);
 		return -EINVAL;
 	}
+	mutex_unlock(&bo->madv_lock);
 
 	return drm_gem_dma_mmap(&bo->base, vma);
 }
-- 
2.53.0


