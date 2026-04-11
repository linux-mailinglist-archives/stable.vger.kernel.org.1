Return-Path: <stable+bounces-235686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGRdLGfq2WlbvggAu9opvQ
	(envelope-from <stable+bounces-235686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:29:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE533DE899
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C387F304C4C6
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62076326951;
	Sat, 11 Apr 2026 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOVE2cS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0223EABC
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775888986; cv=none; b=bur1osxJfxxoXkUHi7n25Z/wMDhKthZLOA9AVpoB189JA2Qq7jtX0kPp5VJIDA7+fOpKFi6b9xjgpUtK6AjUZmmO3+jKFYVFi4ZLA+YSETOZkzvnPBO0CrkNroxgby+MRL4sZcmCG0XIIlnZ3jmKx5mAJN8YBH2cV8oKRQiBiZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775888986; c=relaxed/simple;
	bh=vynvh32GfD6OpN4AQhZiYo8DdPTfHFglJrxu259k4EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7u3U4C6pbe9uZDWK9yLOyIQMLazp/YPaIOD/GsDWox8OdznTl+4f8nRRATLTBbbCGurUX1cm6PIVe3UlBpzelIUDEkeHWDeVQSC+HyZgogLrL8AHpJHbEAzfOpsY4quZrVFWicubWl6sSyq/SgUTYhWkLRF1XdmQuOaLexA7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOVE2cS7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483487335c2so28923265e9.2
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 23:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775888982; x=1776493782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mp+f+a+GerC2oFr3qxw4PkE1viVQhwuT7MAD4+L/Nw=;
        b=UOVE2cS7tIg5+l64h9q+52t59ZHTIBDVOWFSmXJXxV/FlzglaUycaRAo62zULbJgnn
         dkX9wz4ALwPzDqW0mfV04xDGvy6ROxls3EOYzwY9Hc0VU0prnfdeMZQeEnQoU7Cls4Ry
         l61gc3dasKQs8ndPAbgt31KIVF8XpVvappxRJtLSP6+K758pX8yXlN9NqUEWNlEVn9mW
         t3TJoiq065O6Kyd1fsG5Mm+HgiJxAbem/4mur1/NysqUCqHsvcp1Ps+6iK3GS0bWn6T/
         q/U8bxmQ6hmA2mlZUqTjCvu8FvRqPXwwArG9E3IM2EfOexdotPcCyW3TOV7k8ZdV5a8U
         CDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775888982; x=1776493782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mp+f+a+GerC2oFr3qxw4PkE1viVQhwuT7MAD4+L/Nw=;
        b=C8wxqCCl+7xtbzyHwsQ24o9tRe6IP6+JCd+RhXZe7cVx6AR7xzK1KAcxw7HUdg5J7+
         3iPoCxZkQfqQtRjsLYSHOjd52kkUuWRzRma+XgqpYzVkP1QF2cghWcxs6YB5ArteJ2Lu
         fQOlOAB+hznVWWetYDCuA6zgyrB6DBTI7uqhgUQGq3oNuv9ZYPRHLv7K8yNA8tvElj7m
         bDVt7FxoOv/3p84aQv+XBI7KOQBH4uyni9xJDAZrKWGXq7uuXPlz1tjZ1Lo94+XFpnDr
         W6HgjG1rmbshsUD9Sr2J3vj7HoKUZyP+9YR1EYJVuvFY7sMyJMlBGomGx0lvyXwRQn5t
         r+wA==
X-Forwarded-Encrypted: i=1; AJvYcCVYqv4nEDDxlhqXM0Nj4lo27VmB2WdRUJ5RqEFeg7/oko7huM5gY9h6xyRgj7OfMDUIOwycMbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4wrcP9Ms97syE9D6Z1qzzTRr6PHBP3HcRUl0q/m/DUrof/qQ
	uv7I5xq1rJVLfzc/4rRSS8IXmN4VQ28KDMXB6GZNnBEko7xc4haH4fLS
X-Gm-Gg: AeBDiev0+cAVBml3gsImvsthd/NKnyRlZvfom1BADMzYXO+yyeKWVcbEtSVAcksOcUy
	ZqNz6X+lebulrtwKMCnHtVrgqkJ7ZP2w43VKmxRJQm4fe74AF5CbA4kemkJos5Q5LZkld9tAoIO
	rfVpjIKcCnf+fctzU99FyVUdglvOBFcON1HMJSyndKVYfNWvviytimHin0DcwLt7iIlHwpvH89N
	h49yyfX6lIpOkaed51FcmeQMpG9V8hb6TmR0U+TNon+EK1NdUuiwuRqvtVW4ph6PqGP7x7GK7A7
	8Yk5ElmoC4KoO6LPtHmVNekhuWnRBJoSXlPJ7dkZvuq2S2jQYKxg6cjnoKONnRbjwjukS8xNUQ9
	tVJ9xHPfo6p5E94RrDrwWr/bNekdJow+rRDbFgjMzz5cpyp+x8tjNF5ItJQcdiyDFFD8RUZHWkF
	CwRh/jfEm8McKrtpN50rWBk4GOh4DUPnbbZhcYrzUnidxGP7meVSwvPl6bAjYiknnu14De3XR4q
	3yzwEQ0NKZ/
X-Received: by 2002:a05:600c:45cf:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-488d67b8dddmr73834715e9.6.1775888982043;
        Fri, 10 Apr 2026 23:29:42 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888a97sm149666695e9.2.2026.04.10.23.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 23:29:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: dakr@kernel.org,
	lyude@redhat.com
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bskeggs@nvidia.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] drm/nouveau: fix nvkm_device leak on aperture removal failure
Date: Sat, 11 Apr 2026 07:29:38 +0100
Message-ID: <20260411062938.22925-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,nvidia.com,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235686-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[driver_pci.name:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FE533DE899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When aperture_remove_conflicting_pci_devices() fails during probe, the
error path returns directly without unwinding the nvkm_device that was
just allocated by nvkm_device_pci_new(). This leaks both the device
wrapper and the pci_enable_device() reference taken inside it.

Jump to the existing fail_nvkm label so nvkm_device_del() runs and
balances both. The leak was introduced when the intermediate
nvkm_device_del() between detection and aperture removal was dropped
in favor of creating the pci device once.

Fixes: c0bfe34330b5 ("drm/nouveau: create pci device once")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5d8475e4895e..517ff2c31dce 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -875,7 +875,7 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	/* Remove conflicting drivers (vesafb, efifb etc). */
 	ret = aperture_remove_conflicting_pci_devices(pdev, driver_pci.name);
 	if (ret)
-		return ret;
+		goto fail_nvkm;
 
 	pci_set_master(pdev);
 
-- 
2.53.0


