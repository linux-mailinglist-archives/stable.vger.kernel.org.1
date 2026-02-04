Return-Path: <stable+bounces-214313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQSMwNwg2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:12:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67FEA017
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EB323028D5C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23252D8798;
	Wed,  4 Feb 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+s9jMJt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664D0261B91;
	Wed,  4 Feb 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219273; cv=none; b=dr16xyw+FEpTct7y3ZwqNQGqUCybGzB3yljPN7zQW3uJ0MdlIfCFwf6kFxQE0e7F1nbNPjoHZEKMpLrS5KTvH9US1aAtcDOYK0hjHgleYVxRT5aeMODdISUdPlJ1Oy7Vp0uE5mDwDySutzmclTM5zZ0WnYRlJfZSgILS2SZ/7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219273; c=relaxed/simple;
	bh=kTExvl6hHateJwtCP60uemLKzhn4QikAzDvqJdt+jL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8C4+RZkSLivnsMc/+7cuhO/ZbL7iJw5kl5l77aNJq9mKoOBpSGKZy6JOJ+2xl+ArAqExdOurY+tPCpYA7gNlnubP9Uo/sUb2vl8AD7892G0pv1aJn4dl6Ox38lk/x08e5Etd5YLTJU5SOjJHi7vLu5dNWBQEPAUF8pWcw7XQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+s9jMJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A284DC19423;
	Wed,  4 Feb 2026 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219273;
	bh=kTExvl6hHateJwtCP60uemLKzhn4QikAzDvqJdt+jL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+s9jMJtrQmFpWh7d0drZxj9DUzlbZlRrRUs4lV/24IiPp7Po+XyMX1Fb0ClF5hbf
	 ka8pmtUAVteOBSROXFJ1FBZsl/y8iHABKySVNM3enYTGmvlo7bPqzeC/54FTn0Q+fd
	 5UYUyXGp2jTSB9EY5olz6jgthJv7wpX2mGGLMOSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Ogness <john.ogness@linutronix.de>,
	Daniel Palmer <daniel@thingy.jp>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.18 118/122] Revert "drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)"
Date: Wed,  4 Feb 2026 15:41:40 +0100
Message-ID: <20260204143856.096799670@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214313-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,thingy.jp:email,linutronix.de:email]
X-Rspamd-Queue-Id: DE67FEA017
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Ogness <john.ogness@linutronix.de>

commit 6c65db809796717f0a96cf22f80405dbc1a31a4b upstream.

This reverts commit 604826acb3f53c6648a7ee99a3914ead680ab7fb.

Apparently there is more to supporting atomic modesetting than
providing atomic_(check|commit) callbacks. Before this revert:

WARNING: [] drivers/gpu/drm/drm_plane.c:389 at .__drm_universal_plane_init+0x13c/0x794 [drm], CPU#1: modprobe/1790
BUG: Kernel NULL pointer dereference on read at 0x00000000
.drm_atomic_get_plane_state+0xd4/0x210 [drm] (unreliable)
.drm_client_modeset_commit_atomic+0xf8/0x338 [drm]
.drm_client_modeset_commit_locked+0x80/0x260 [drm]
.drm_client_modeset_commit+0x40/0x7c [drm]
.__drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0xfc/0x108 [drm_kms_helper]
.drm_fb_helper_set_par+0x8c/0xb8 [drm_kms_helper]
.fbcon_init+0x31c/0x618
[...]
.__drm_fb_helper_initial_config_and_unlock+0x474/0x7f4 [drm_kms_helper]
.drm_fbdev_client_hotplug+0xb0/0x120 [drm_client_lib]
.drm_client_register+0x88/0xe4 [drm]
.drm_fbdev_client_setup+0x12c/0x19b4 [drm_client_lib]
.drm_client_setup+0x15c/0x18c [drm_client_lib]
.nouveau_drm_probe+0x19c/0x268 [nouveau]

Fixes: 604826acb3f5 ("drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)")
Reported-by: John Ogness <john.ogness@linutronix.de>
Closes: https://lore.kernel.org/lkml/87ldhf1prw.fsf@jogness.linutronix.de
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Tested-by: Daniel Palmer <daniel@thingy.jp>
Link: https://patch.msgid.link/20260130113230.2311221-1-john.ogness@linutronix.de
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -351,8 +351,6 @@ nouveau_user_framebuffer_create(struct d
 
 static const struct drm_mode_config_funcs nouveau_mode_config_funcs = {
 	.fb_create = nouveau_user_framebuffer_create,
-	.atomic_commit = drm_atomic_helper_commit,
-	.atomic_check = drm_atomic_helper_check,
 };
 
 



