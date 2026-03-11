Return-Path: <stable+bounces-224651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP8fDvkksWmvrQIAu9opvQ
	(envelope-from <stable+bounces-224651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:16:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89B25ECCF
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 09:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C00A30022C3
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B7133CE86;
	Wed, 11 Mar 2026 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LnccD2rk"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8C358378;
	Wed, 11 Mar 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217012; cv=none; b=lrLyVYLHmnkcRDj/yTnFSQ3q3gmbb8cwQEcVhFiHplwmJso6RtToddj7EhXdzZH9mipwDVcVIQSiMjTDm2H84KNxUWJynbMpvNPw3k7Tv0145X4RXcoqL1iFRzz/SimUimLwJ9eDLOHP0xqx7NwAx+RvrU53/uSaXnyMWgJK/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217012; c=relaxed/simple;
	bh=9a2EzuqWb7kdg6mxAd0NFRN9Sxh5g0P0fCSfFixANYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vBeqG2Ynd5V84vBKGzSKnNy+5dksyp/L1Tl12Vz1z10jbV/WP7+HGHEbxBXCLFx5d2k4Q6LVKWpwjI++MXVtQEtYELFiviMgDeeWy5G3sSt5y254a/NSfFZm/qiNAPxmfoHKIEcy2eiqhy/ToBAqB0qAeD7f4oFVImfOfJpXCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LnccD2rk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C78BD5A5;
	Wed, 11 Mar 2026 09:15:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773216940;
	bh=9a2EzuqWb7kdg6mxAd0NFRN9Sxh5g0P0fCSfFixANYE=;
	h=From:Subject:Date:To:Cc:From;
	b=LnccD2rkvrsNiDBD5vsrLPmEJi3UzWVTfPsF6Yz+szppllpXOdY7Rl7FvWVwUSXpp
	 goCmX++f6iew1djj8w6DyHr22i2perXtizTmWwekDlVgS0vaJ8iyiNmui3TgrjmqVs
	 VZhcjGTT9bqnDnOYvT0ooGdobEcr9dB7Qh7BqaWA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] drm/tidss: Two minor fixes
Date: Wed, 11 Mar 2026 10:16:27 +0200
Message-Id: <20260311-tidss-minor-fixes-v1-0-ee5e6e14a566@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsksWkC/x3LTQqAIBBA4avErBvwByO6SrQQHWsWaTgRQXT3p
 OXH4z0gVJkEpu6BShcLl9yg+w7C5vNKyLEZjDKDslrjyVEEd86lYuKbBINKo7PeWTMkaN9R6Q9
 tm5f3/QDl/wITYwAAAA==
X-Change-ID: 20260311-tidss-minor-fixes-c0f853a5326f
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Aradhya Bhatia <a-bhatia1@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=680;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=9a2EzuqWb7kdg6mxAd0NFRN9Sxh5g0P0fCSfFixANYE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpsSTr49kANPAJYQu/QED4C1mw5xdmIeMTwjMHe
 716HQ/+B2aJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCabEk6wAKCRD6PaqMvJYe
 9UfcD/4vLhrQTSnLoysY9jtzA609RVM5Avtv/A3HjNAhDFlqQKTlx55wXgfkm30QTs8v+k18zxd
 3h4tUQ9qQLuWLBshWpYxMBolPCefFddKqa8EZe+AUom7B55g7YdW4iDLcYz1FzvNt0l6e9e75ft
 7+Biw84Dx46NT4NQHulLeMxLIR7z6ojndzcz0Os2R0E2IlmfX5CVHOMfteRQUQZUqoqARxXBYCh
 SqcBmuEnlapH5AhmkdTkE4lXjJ/6zFd43XtKGeOQWGLP9OQSZ+UyRt/pRDju/sThW+Wm5/yVlOB
 LXpZnTCT3R+00dOZNlVJbcqTLgIajI7U24J6raU6z3lXUfPzSEUfojVNVJxcE+IVNPq5AzTcMdq
 jppednzJ+8orSnWG3y3bkSNimR9rOgxE54aF5gRooBXSjRpwHiA20rCewxRgQe7aqFekBYFFzUU
 CjuAV0SywJ/mGsQrPvrmxmzEJQvOGQr/mo+OIrRxgK8lXsDj4lq3snVA1bYGWXjLd3xwd6QFh6k
 63onMQ10kPQQUgLpIFK0yeiBo3gimQ4pIBRNviFOtsYTvP6G+O0+1agexgvAAvMj/+MaprYB8WU
 KGr+ZavKQqIuDDA83jqzJA6M+W6VEZOBPCC54SeNoOH1Xp6YUMBSvgciFpofIpj5i2UbPZJa7Mx
 cZyKbW2ksZ0eytw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Rspamd-Queue-Id: CE89B25ECCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[iki.fi,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org,redhat.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224651-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomi.valkeinen@ideasonboard.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:dkim,ideasonboard.com:email,ideasonboard.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Two minor fixes. One to drop an extra drm_mode_config_reset() call,
another to fix a "Missing drm_bridge_add() before attach" warning print.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      drm/tidss: Drop extra drm_mode_config_reset() call
      drm/tidss: Fix missing drm_bridge_attach() call

 drivers/gpu/drm/tidss/tidss_encoder.c | 2 ++
 drivers/gpu/drm/tidss/tidss_kms.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260311-tidss-minor-fixes-c0f853a5326f

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


