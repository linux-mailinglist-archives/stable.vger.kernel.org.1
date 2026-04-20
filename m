Return-Path: <stable+bounces-239157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEeJOZE55mlutgEAu9opvQ
	(envelope-from <stable+bounces-239157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:34:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E342D34C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D36CC3045B5A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1648AE3D;
	Mon, 20 Apr 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9ZYsJAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C093A962B;
	Mon, 20 Apr 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691920; cv=none; b=Hfdt2vvyR0ZdrDXWfnOKiXGUygcFVcwoyZ1SwYhQB8Ctgtm6zJVINDH8GKN3adhLnN5Ykz9zkY3WDFQxaroNd5xWt4Mnym8ifZoCHRWG/X+bZ5eiw4VG4sCUIe6UX2tY11/u8cqaopm1HpulHcd1sU2OYR7hNIuMdPcdtag7KtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691920; c=relaxed/simple;
	bh=qT0ZL0B6ToWjqqbmFHN33yOuett6m6mzNfjQbbXVzMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqH0Ip093GSNiE1HaU7fmGokY9uMuc0aoi7gyzA1lIIaEFmircRxLp6hjHkzZFtQOgWROHglhb13hB2eW1u9g2vWVI/i4LzIKNE9O1tC0JJP/1CiJIVkDrEPLCnyKie/zFR73vwhi4XWQ4cg/9uzU6BFfYSh5UuqHw0FYhyYu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9ZYsJAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BCEC2BCC7;
	Mon, 20 Apr 2026 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691920;
	bh=qT0ZL0B6ToWjqqbmFHN33yOuett6m6mzNfjQbbXVzMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9ZYsJAWTlRcI/THiFLrPfUW2ztphMUDHkxuS/FWh5y8qzzfRd2Y5t/1X3tpKEoNe
	 8jWTe3hjzhjcYCcONUlyZzxxTFwpjvE6Ts9GUc15hIwtNH7tqI404QgoNhpMLE1qbf
	 6D6Lt1w6ohnc0MEHkCju/hd7DeHvcjYyfB41ppLnZTksx8AY9+RMHt9cztXru4Rgy6
	 g0iJ9yiyFxOojF0KPxpVVfjqHMbNqE5/LNKdWJv3GYjvuuQB0uHgwZG4f/4Ye1o4Xc
	 TACOG8kYw2Ykq2oe74Rr8nBb2zcvmtKThpr5XVmNgipOZBCwri/MGyQwIWg9liSJaS
	 ZAN0AKAtUQ4xA==
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] drm/vc4: Fix memory leak of BO array in hang state
Date: Mon, 20 Apr 2026 09:21:03 -0400
Message-ID: <20260420132314.1023554-269-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[igalia.com,kernel.org,raspberrypi.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,anholt.net,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-239157-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: A24E342D34C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit f4dfd6847b3e5d24e336bca6057485116d17aea4 ]

The hang state's BO array is allocated separately with kzalloc() in
vc4_save_hang_state() but never freed in vc4_free_hang_state(). Add the
missing kfree() for the BO array before freeing the hang state struct.

Fixes: 214613656b51 ("drm/vc4: Add an interface for capturing the GPU state after a hang.")
Reviewed-by: Melissa Wen <mwen@igalia.com>
Link: https://patch.msgid.link/20260330-vc4-misc-fixes-v1-2-92defc940a29@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/gpu/drm/vc4/vc4_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 255e5817618e3..6238630e46793 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -61,6 +61,7 @@ vc4_free_hang_state(struct drm_device *dev, struct vc4_hang_state *state)
 	for (i = 0; i < state->user_state.bo_count; i++)
 		drm_gem_object_put(state->bo[i]);
 
+	kfree(state->bo);
 	kfree(state);
 }
 
-- 
2.53.0


