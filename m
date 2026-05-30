Return-Path: <stable+bounces-258715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO84H9EqG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6106119B9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C192300F271
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33FE3ACA4D;
	Sat, 30 May 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXX0+f7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EA3AB285;
	Sat, 30 May 2026 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165295; cv=none; b=LDUbfg7SyMzmoFou1SxK+Xah0hQWAIq/6R8nkiF4WOHmf+Uvv2GFlisAYhot/0B9avY4Cb+eTaAMs0dJIqQ+Ir2VTQq4EBGmdwyJhvNXjUbJB3b0VYTNiNldupB/MFEERnBigbn9acLsJiEzYhFfZLcsKbweOX3i+wXmPn1jXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165295; c=relaxed/simple;
	bh=PtdGHaankBqI/NpH4gC/i4ch/ZNQlkYtVll/u1mXnnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arpRVpqZYAg9T6rrdEAFUjZjyDGU+cIV8NPZYuZo4ApNVUdOzOzQ1WwMPvGLanl0XDiqzUnJC7UgI43IAumihQXjHA0V0obJeZPjJ4g4qGJ90ZBKX0uJmzX+xrZzv3i4fU58gfS3rAyN5frEGdshTOEAj77EaYhy+BClm4eocaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXX0+f7T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEA51F00893;
	Sat, 30 May 2026 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165293;
	bh=MZepzH3fWlqNLqJoNWG1A0k+A+SsdqA0z/kORB2pDRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MXX0+f7TtwOjSUn4YBk1OXsGNnFnSk7+AudJLfbSTC6vOceWsucLrFnpssx7UFz44
	 FEpClN7wBdUpscjEMgmgNbTsGhaJyzyTfHrMsQtRRmDo2lk4Bb2w0GUKdGG+UMYba2
	 CkPyeEyZkvjLsO3luaa7iF7Hh99PTGZdThqeab20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 016/589] drm/vc4: Fix memory leak of BO array in hang state
Date: Sat, 30 May 2026 17:58:17 +0200
Message-ID: <20260530160225.008743069@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258715-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,igalia.com:email]
X-Rspamd-Queue-Id: 7E6106119B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 drivers/gpu/drm/vc4/vc4_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index b641252939d87..788f64154119b 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -60,6 +60,7 @@ vc4_free_hang_state(struct drm_device *dev, struct vc4_hang_state *state)
 	for (i = 0; i < state->user_state.bo_count; i++)
 		drm_gem_object_put(state->bo[i]);
 
+	kfree(state->bo);
 	kfree(state);
 }
 
-- 
2.53.0




