Return-Path: <stable+bounces-272739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DQByBvjGTmpvTwIAu9opvQ
	(envelope-from <stable+bounces-272739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 23:54:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A773C72AACD
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 23:53:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Q35hGRKq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272739-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272739-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2250F301D4D3
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22F3F1ACC;
	Wed,  8 Jul 2026 21:53:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4389F3A6B81
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 21:53:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547637; cv=none; b=cu+gtAegtcxY3vIb6RPePK0m9tuHMDQyKsW+g2UXzIGGN+qRrIlpiwhraijL3lyZqUkPA7+svmeR0JD3x4dvvPuWqj26uD/H+EGHGbKj9als7UP/i7YnI/h/BOcEZGLKqTehfw1ZVBEPZGKvrVLHhZcbVq79BYmJ5GveW9OX8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547637; c=relaxed/simple;
	bh=6Ybfx0lFdICtzKlrOMUeIb8C42jMZMhMcXq2Ao+QSu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEnkUAhCL+ZywSo71x0Pu80FrBfMomDraHmNiZO6+CiPacQ2/Sc9kn2EAS9aCD4q0LaPVSowDo3/mRMZ5AL+1U8VgHXqVOXQ1SLJC07qncEgK3K5rhWmELfaLI1roLTKZ+CaxFhAfq05bsOmnBCL5EPSri8I1rnleUb3MGkTdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q35hGRKq; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4758bd3731bso182666f8f.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783547634; x=1784152434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IIMECz0v1f4LVIdLn0HTlLUSx/SJvMxrwrh19eAWfPY=;
        b=Q35hGRKqsmeseGbLCPSZpxptC2838DtDhPn6pMmBW+qfyIyiaj/LEKXWP+nIYF0g3b
         46CLh4n2zcgCqhA4gq1GtVVvaT4SffCtqWb3ERoOIc0D7baK4JPPt+tJ2tRBmsOUb8a8
         8c9N/+O3KSxZibGTXSfDoBcS4fTrtDTcEvVMO84BQ5F7JJ3uD+TkURGef9eyeAL9XlcP
         nh6sDNEw7+p333Gp7lLJgNlE0bod24lNXLMKgjvIZ2TCwsgnw/W4or7VYjfynb1y2Ghb
         QrYqOaYyeWgVsKu8oYHlH8Xidf+bMiTaWXGXbVAZralerx4Yk7szQLBbix9THgAWgVv5
         gfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547634; x=1784152434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IIMECz0v1f4LVIdLn0HTlLUSx/SJvMxrwrh19eAWfPY=;
        b=rXf1bKMuG3UW9qkRhy5lxiq+JFz94fkHeRr0yQApptSDGDpTm+WOIupmCPlB4nJKGE
         d9QbV7vUEsjaPjK4k3jAaH78bqzizrjAKoG0vI8kx/d1ST13SZClGmaKEgj73S001P6U
         VukwxperPa3sk2ygDz+wsGSf2Uz3LN6cj+hrOs3w5T9TCPKWXynCNVkvUdGw19GQ77Hh
         vhskBaxvex0SbnxlRKCfaJKkofXAhGQY66m0zd6AEISaJ4QXJB64QiGzYb7lXYtM0/eI
         kitRipyOpTz/MHmgIl+r3oJZeqA+NS01dJz2ytt+KNXbVDSK6xRlHp0Rg+BRCVRpH8vk
         7iNw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1ky83f4iDFTDpfmNK1TqM3P+MOwU0MchOdNUdFFx2XmlGjf7QgpagYTruniodEvMo+8nmDYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3B2Y65MqNTBpd2dxpG8ytXiZbkp2uOOXPy6BnH+pS/XpsiKci
	6AKuspoNIVDVFRUkaGDrb0YfBsyqkT+M6MDPGbfhle1EZXbK4NHT0k8z
X-Gm-Gg: AfdE7clbt7vL6iSJ9HF8Xq1sc4KRNy7aM+I+m1RL2r182lj0ZjG0L6eTt3hpCvWgQxU
	TFhdPDIORG1q6Jss51L75Nq1pWjxlM4oVOyDF19zX5U5s7MV9H8/L2bHX0VtbRCROvzmLXtKZQC
	FtHRXzyAM58H7Ov9RSQ2LdNrKJCPVX87sR5P3skiFLm/tnC0Zc6mHbWIkN6WRp0v7eCuq+fC51r
	1AfXs+6O5jlXPu4CeC8qYHv7/TMjRUih2yJ1GGSItjjhKdFTSNCcIU+jJrxfG9U0jtN8t3z1ir0
	jdwx2oPQybd8oHQWqSjINIcqKwbCy2vsL3ROU/5QQz6igOQz/ShgwVPX458rhVatLMlDPwNeaNd
	ev/5R83L/TaP7JBWW0fhVpFN3y5Vxzxg18KRLPTqkZBqS5LBvenH3I5Gw+3BsSX6UsXaIkoZB/R
	MkHjKyx8iHiozTrk5ZmQq+yA4wAYMnmBLtVZB63jQSuJiHLrrPHw==
X-Received: by 2002:a05:6000:4602:b0:47d:f6a5:1fd6 with SMTP id ffacd0b85a97d-47df7561c98mr84937f8f.26.1783547634411;
        Wed, 08 Jul 2026 14:53:54 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:7550:b182:7bdf:fbd0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm46622289f8f.15.2026.07.08.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:53:53 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/imx: ipuv3: account for active PREs in atomic check
Date: Wed,  8 Jul 2026 23:53:38 +0200
Message-ID: <20260708215338.147145-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272739-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:p.zabel@pengutronix.de,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:l.stach@pengutronix.de,m:dri-devel@lists.freedesktop.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:osama.abdelkader@gmail.com,m:stable@vger.kernel.org,m:osamaabdelkader@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,nxp.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A773C72AACD

ipu_planes_assign_pre() starts each atomic check with the number of
registered PRE blocks, but that value does not account for PREs that are
already used by planes outside the current atomic state.

This can happen when CRTCs are updated independently: the current commit
only adds planes from the affected CRTCs, while PREs used by other active
CRTCs are ignored. As a result, atomic check can approve more PRE users
than the hardware can provide.

Subtract already-active PRE users that are not part of the current atomic
state before assigning PREs to the planes in the commit.

Fixes: 00514e859335 ("drm/imx: use PRG/PRE when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index 67f2da7f2b65..d6806d1ae6e1 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -822,6 +822,19 @@ int ipu_planes_assign_pre(struct drm_device *dev,
 			return ret;
 	}
 
+	list_for_each_entry(plane, &dev->mode_config.plane_list, head) {
+		if (drm_atomic_get_new_plane_state(state, plane))
+			continue;
+
+		plane_state = plane->state;
+		if (!plane_state || !plane_state->crtc || !plane_state->fb)
+			continue;
+
+		ipu_state = to_ipu_plane_state(plane_state);
+		if (ipu_state->use_pre)
+			available_pres--;
+	}
+
 	/*
 	 * We are going over the planes in 2 passes: first we assign PREs to
 	 * planes with a tiling modifier, which need the PREs to resolve into
@@ -843,7 +856,7 @@ int ipu_planes_assign_pre(struct drm_device *dev,
 		    plane_state->fb->modifier == DRM_FORMAT_MOD_LINEAR)
 			continue;
 
-		if (!ipu_prg_present(ipu_plane->ipu) || !available_pres)
+		if (!ipu_prg_present(ipu_plane->ipu) || available_pres <= 0)
 			return -EINVAL;
 
 		if (!ipu_prg_format_supported(ipu_plane->ipu,
@@ -871,7 +884,7 @@ int ipu_planes_assign_pre(struct drm_device *dev,
 		/* make sure that modifier is initialized */
 		plane_state->fb->modifier = DRM_FORMAT_MOD_LINEAR;
 
-		if (ipu_prg_present(ipu_plane->ipu) && available_pres &&
+		if (ipu_prg_present(ipu_plane->ipu) && available_pres > 0 &&
 		    ipu_prg_format_supported(ipu_plane->ipu,
 					     plane_state->fb->format->format,
 					     plane_state->fb->modifier)) {
-- 
2.43.0


