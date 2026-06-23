Return-Path: <stable+bounces-267884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /F8JCLs3Omq84AcAu9opvQ
	(envelope-from <stable+bounces-267884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:37:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426A6B4E6F
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:37:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chromium.org header.s=google header.b=i5ZhMF2o;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267884-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267884-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=chromium.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6C66301AC9B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C13C65F0;
	Tue, 23 Jun 2026 07:37:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6F75801
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 07:37:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200236; cv=none; b=OcwtVC+fPnimiiavqaVjtcCCjxT+NkvIFM8N/QljeLYrJW1/6yqqnP8wp1MJou3IE9TNdhHccI1Nq/1ljEGICuLtSRAafmOFB2phnGPFXZDEB1zOE9SvlaG8kZUregvVcowyHeP9Jesp5f1AYX3FJy1qKtcm0OfxMR3nA2Hh91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200236; c=relaxed/simple;
	bh=1HxkBmcCDSZ30VdkIOv1oH2E/czZ6I76edgF9YsrWO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+pbUGnCX36brrJHlq7GjhTKm/epCcBkEs7XwwKYECWkfhI7ZxpxKlmQn3CNom6aqz/R2AAI22q6VrLe13UmFBy7WTcnE6Tam/dCS0+KbdMaOEVmpbsrY8xSqLdNDzMEAwfkEPbZwOY05SmDAY1TMpa2Ah4ebg0ZC9spgBLHmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i5ZhMF2o; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84231305a80so3299794b3a.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782200233; x=1782805033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWlSMHsACJK0E3abjyK7dgy5EMAkt0OYlO+2FYWhCzk=;
        b=i5ZhMF2ogtZg6zzAFcQaX8fWB4O4++s6sVn8dBSnponRMqFQGbGRTVzp1q4UQg5WEz
         PRHpmeW+LCCWDK+QSxrAiISWQBWkXNj+3ru4IPqK+aAucoFrX2nLtLPjKjc0jmnxTOho
         p2o2MBX24m0s8jJ+SbNp1ZD4sbrv3vLCBd3lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200233; x=1782805033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWlSMHsACJK0E3abjyK7dgy5EMAkt0OYlO+2FYWhCzk=;
        b=Fpr/RwXq4ivNXGkMYDSLecEK/G/2lYklMod4MH7VyM7Y6t065txQm4LgPpj2EGNFJQ
         tHu5lRgb0IvPcTnc+lnWYKFiYxvRs64nTwNF7LSs8C+6bjpfEn9rzwfI/RzcHVhFbH4Y
         Ncd+fbInNhLhXglmHkut57eHZSOx7awBfDemflIN3RZzbWWW/iRGM7YTrGM77RjVkSPK
         WEiyl6mDJpVyLLG40N2FNfSJBghT8RWq+hgjTSYLO/ywqxJUEOSpalguFwbJrPnIzSIz
         U7nzOClwR26PBzer9Zn5Wb5S9TkpkJYKggn3EaX3sjA9CjbBWqmdzcWp2M8YWGS8OhcH
         pDOw==
X-Forwarded-Encrypted: i=1; AFNElJ/yqytlpViz7vc1RLdlud37Qglecfa69N2+9/z0zeFngsnOp9X+XakKYfRfWy84aUqp62eDV4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvErS4JIDvwhhG6laaMUsLrWlADvrgY4S3p/1SUnIpoxWGDis
	SPqKi+J7HDjMJH5ClQ8nK5kPnHRUwQ4IQUhKCivNggoPWipKaXeQn7haf2nTbd414g==
X-Gm-Gg: AfdE7ckqTpTF8ZCxTkMVCbbxAzWo5evteOG8RR218QZVPRy1F33OxhjC2whlq1wyHi8
	7TQjatvEeGFUw6hqUDbuflmTSfqVq9pff6//XPgY1hhEylcSvI5ELPDWrUp6TJXFKCLFRjb5pMx
	D0wvIBEl6mrtr0tvbFhWZVT/Epu4ZG9ROCtADi36MRE/zrX109V3YQrqAyZ3kU9iPe5LyOZW4k7
	Jig6TGAWLXdQN0cFS32me9ZHz+WkUcOMZabWoveryUwsq2vjbkbxOcOCqVLiHHS4kKerYQbEaFn
	kL12zhhoBgvgRgMRr2zJTJBoVvvQC6f8HouNmwFd63QUQHTJ3U6Ck1IYmfh7VImn5uP6zQhem9E
	icuEERHKjRSNdTy4kzVorfnvYv4MckEICRjU5MgdyqFEmyZx3u4fyZavBcbRMfRhfHRCvYy+Q0c
	Nsuhw8TSwTJ3iwfieocSs/7gI0EI9fHZ11pGU1FIFsIDiVrQkU7We/8l3xhcqvLv9UajQeM4QEv
	FA=
X-Received: by 2002:a05:6a00:3cc4:b0:842:46a6:e2db with SMTP id d2e1a72fcca58-84597044cf1mr1705096b3a.19.1782200233543;
        Tue, 23 Jun 2026 00:37:13 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:1287:5d13:b2d6:c6ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3212sm9961227b3a.55.2026.06.23.00.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:37:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/drm_mode: drop property ref-counter outside of deadlock retry loop
Date: Tue, 23 Jun 2026 16:36:24 +0900
Message-ID: <20260623073648.836363-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267884-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:senozhatsky@chromium.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,chromium.org:dkim,chromium.org:email,chromium.org:mid,chromium.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5426A6B4E6F

set_property_legacy() increments property ref-counter before
DRM_MODESET_LOCK_ALL_BEGIN()'s modeset_lock_retry label.
However the ref-counter decrement is misplaced - it's performed
before DRM_MODESET_LOCK_ALL_END() checks for -EDEADLK and jumps
to modeset_lock_retry label, creating ref-counter underflow.

Fixes: 9bcaa3fe58ab ("drm: Replace drm_modeset_lock/unlock_all with DRM_MODESET_LOCK_ALL_* helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/gpu/drm/drm_mode_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 21fc9deda437..11f0044f4782 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -549,8 +549,8 @@ static int set_property_legacy(struct drm_mode_object *obj,
 						  prop, prop_value);
 		break;
 	}
-	drm_property_change_valid_put(prop, ref);
 	DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
+	drm_property_change_valid_put(prop, ref);
 
 	return ret;
 }
-- 
2.55.0.rc0.786.g65d90a0328-goog


