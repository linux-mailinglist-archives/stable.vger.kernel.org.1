Return-Path: <stable+bounces-230320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHvmLzLPw2nuuAQAu9opvQ
	(envelope-from <stable+bounces-230320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:04:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67726324673
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E48B53077606
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B343CF672;
	Wed, 25 Mar 2026 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rniPaj3J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1B3CF681
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439205; cv=none; b=NhTomA/XwMkChgihdqHT7rkTAJtsqi9ShG2zMm9b5x98VC4PLAkzTvDQokByWabZLuajNvUAb0qz9AqZQ5RuhPyK38dLY0+m+xGzWMRUZ1lhRKCDkngoz8vHQdi0I9sM1EtfHV+QCUXEVbxuay22ycWVP7eKsYfGWmNpVJ+WDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439205; c=relaxed/simple;
	bh=Ly6IC9Fz8h1DyU1e0Ndd9ZWVflSJrVz9ndtt9bADr1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWpEVtQNS9yg7SGdfXsTxCJhuaLBb+WnsE0Gur5ATbeWRSOMXL/rRWaJ1G1eojXrySyAR9iipUJyc8vLiInmr6rT/5SPbsc7VdTl/fcXp4ZNCJWECtAItFQvQgzS6EPeGYVfNJVPQVSloyxtfGH3z6K/ya6nNuqOGg8L/pWF/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rniPaj3J; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a9296b3926so18391235ad.1
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439202; x=1775044002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcgLnCA0f7wz6dPCqxCZz9kXuIVTeQJ0aRrxBcbCgTA=;
        b=rniPaj3Jh/JEuk/Y8dGCYQg9uEJAXwAZ1DsPAjWLSs1uGReTRm2fROX9b+I41LP5d7
         CK+BCg8rSWzv6hh93o6goyhg58eLFG1FaBF81PCsjBsTh1VuCt6oBoLcTx2oei5RHgvc
         VtW1GgIlVQ8MRwhUbGACH1wogXQB6XQULij5hGXZEkB9tuiskgXOkcTNSUAm99zsXwi4
         CDb5GS+BY9x/HGHZ7J7ye/g9xdxhtU5mD8zKOWQEEswydas+mWhDGq60Bh2Z9Wc1Uq3a
         zcjaK9TnP5g2fzxQtYQcPksfdly4BduKj6+qeYquyJx+TtgbpqJR/BEPgMDf1Xnw1Qqg
         edxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439202; x=1775044002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcgLnCA0f7wz6dPCqxCZz9kXuIVTeQJ0aRrxBcbCgTA=;
        b=YJ9zv8cdV9YZ6/M4l3eTqJvzeXjYbss3dZ1FlOuQYA/mkkmlEB7+wdEJpZ2wKRAqy/
         AlnVkiGBsg2cPjdn/2y984iOL0DIXKoiNE8gln2X7c3LQ2iBrtK2XvdQlnBZ2g8EaF2F
         Br07/aZ/2gDqIT+peMSOO8JYiGX9KdESjnUkxmrmy189cJpchrLjYyoJktNuVoEhfVmJ
         /3PbDHlTycvoMJC1onZOVp5QBDIwiIXBxfWDpll2ijxOER4LBGv4z/MgWjaDaqnQNt/3
         I1SjOBicl+FpJDTFo5MYZFsUNQGWs+GnbmAWf4EKPkstBJLUJIUFYKLcoMO/E5ap/9gs
         hxig==
X-Forwarded-Encrypted: i=1; AJvYcCWOwUZGXdqpyhCSVp9vXkmCZe0alyvphE/eJfaKd0vzpsyVPMzk1LAWKKcB38aJLt2dBeR0fNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3eLQi9t8lb/1KSwXnoGt1hcBjM9hMk36aYf2dQgqtYb1xOyl
	n5BbQohs41Q379aWYXbZeCcBx3zJoRSA32mwkZQkog/pfLErVC3AVBwm
X-Gm-Gg: ATEYQzwRL5WxwfBHVRu+B7QfeKaykzcHiSUvgECmI82bJeK8hr+v3WaPMHYq54+EB98
	pR3zltJymTQOt9p9i/d3RcbnXLNxdsUx4y7R9gpmUWJNHq356f2yLKKFgPHSD1vav31bj70Qcb0
	8+25NrCgYA82dtlBkMgGjK3fo12rfCdPZ0hjVSNTbgJWb+O43e6JlqVIZ3vDIiUa1v29DAyfFDZ
	faqlqmeej5GS4fPT6pNT8RTInYL4GpQLeGBxxVB567ITqY4Ol36W4dG1aG2bdIiMJBJ7/GGgV9F
	Vykvch+2PejfVxSpxvCJTmNx7/WL70D9V89Yq7UkRBwT2hUUv+YpYHOKFmMWV+YtwLf2cC7K7da
	Vgrg8yscWcpa3M5Ikkjr/ZPKXrVxz/KgTan4cp5lgHquQagZszfAhDjgsVoACDoeBvhQUWSAya7
	pliuxYRbPK9R6jah0ZlLInmYo=
X-Received: by 2002:a17:903:908:b0:2b0:669d:3a68 with SMTP id d9443c01a7336-2b0b0a15b81mr36980765ad.19.1774439202138;
        Wed, 25 Mar 2026 04:46:42 -0700 (PDT)
Received: from nixos ([240b:10:ff26:df00:661a:64b7:4163:997b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c36fsm234579835ad.61.2026.03.25.04.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:46:40 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: robin.clark@oss.qualcomm.com,
	lumag@kernel.org
Cc: abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	stable@vger.kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH] drm/msm/gem: fix error handling in msm_ioctl_gem_info_get_metadata()
Date: Wed, 25 Mar 2026 20:46:34 +0900
Message-ID: <20260325114635.383241-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-230320-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67726324673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

msm_ioctl_gem_info_get_metadata() always returns 0 regardless of
errors. When copy_to_user() fails or the user buffer is too small,
the error code stored in ret is ignored because the function
unconditionally returns 0. This causes userspace to believe the
ioctl succeeded when it did not.

Additionally, kmemdup() can return NULL on allocation failure, but
the return value is not checked. This leads to a NULL pointer
dereference in the subsequent copy_to_user() call.

Add the missing NULL check for kmemdup() and return ret instead of 0.

Note that the SET counterpart (msm_ioctl_gem_info_set_metadata)
correctly returns ret.

Fixes: 9902cb999e4e ("drm/msm/gem: Add metadata")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e5ab1e28851d..195f40e331e5 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -536,6 +536,11 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
 	len = msm_obj->metadata_size;
 	buf = kmemdup(msm_obj->metadata, len, GFP_KERNEL);
 
+	if (!buf) {
+		msm_gem_unlock(obj);
+		return -ENOMEM;
+	}
+
 	msm_gem_unlock(obj);
 
 	if (*metadata_size < len) {
@@ -548,7 +553,7 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
 
 	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
-- 
2.50.1


