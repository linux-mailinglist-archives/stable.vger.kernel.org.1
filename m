Return-Path: <stable+bounces-90094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F76C9BE358
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F491C2250A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECF61DC1AF;
	Wed,  6 Nov 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVe+svP7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C851DB534;
	Wed,  6 Nov 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887158; cv=none; b=NqX27Dd2qGIJRTjkSns++19xwLIeM7SvlgeTvLAGYSdlyBj0Kprv7IUseuXt0/v9E5Bep/Ca9RyJ00i3auW4nIkfHJtHHtVoWGFTUV8opLzr6XgTJ+7/PC4fA8Xl2ilFqXPSodbilD5PMN4SW/e0BDXQqTeBzpWUnLtWiM3czHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887158; c=relaxed/simple;
	bh=E5GOAEhRD9j+u1CXK0RooAUO8b6h1E/vhZjKiq9wXqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ayUSNUOXsKlraq0ilEDhBmur0uheyvG/02HzCQoh11vPj2ZieVFrNojUowumHdYQrznNaMpkVV5I6c5o9ggDpsmiznC4Ta3cU0lh36gBlX370Q6IJwvJMdGjVlCemsLBHG9Vxbf1/3YlOZIw5/iwrZ20ebIF6ecasaiK5NUtTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVe+svP7; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7ee386ce3dfso524686a12.1;
        Wed, 06 Nov 2024 01:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730887156; x=1731491956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YanI8iRaFnbYDLIbwSAL7fPqo0KzjFa50XedZ+8YIHE=;
        b=CVe+svP7LWpomvfC0RiqXyLiaNSquLYsvn28fI0+MWctGGA+dzWfZi0rJJ54jmJ8na
         o+y+RuUYO6OkTwo08aJkD7g/F5BfP4b5R+SoO8TS1OiXO+b2t8qJRm5PALl3JtlR3fmW
         LKqrA2/otUfOi037a8e0Akz7DhBW4aZVir3+yu9PxUJDu79b+mU/SUTsrMCuj0H+dWSb
         ezPj3iYdNBhUs/AtYT3vNCPqMcV8tJfMULaboELS7jpgoETVR6pCcFcC6LvR0qnmSroP
         Fg8h7dS9PlZCTRzSfCcLMx0Ps94qjz88+jdp+m/kEh6UbnDO5zA97DnNFMhylWdVDcf0
         Dhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730887156; x=1731491956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YanI8iRaFnbYDLIbwSAL7fPqo0KzjFa50XedZ+8YIHE=;
        b=uI+JH+QeoDL2ewSpv6rQ4da76T8eWPBJXU8MwmRaVSvALs4opmi9kUMzGxo+O+g7Nl
         qNXpgy9LSIt2YMand3TPV8E97YWOrH0GUrD6rmoP9Y5VlqUQc4de8zkGZQQ2yRztDuoJ
         pd+2fs4njDSPKVyeiwYXYA9WIo9quCbP7cbY5Q+hQqWPp6RMvaHh3v0VoE1WvAw+XA5s
         xpoLTkHj6wAtbf3zwA/MVrWaHQw0J2ucu4IRAXNDHxqMs0JoZBeqvited7Gr7S006j5q
         RlV3iNbKH3iYlfx50L+SQfADJY5EKHI/gnxh745i9tIclG9NYyKFuoW6gL1vQjn8qa43
         2hfg==
X-Forwarded-Encrypted: i=1; AJvYcCU4y03Mrt26a3XmXOrqoWBxYdT9r1cd3enki7IioZP3uYapXXFwpfHU9GzwkYwA3YQhpUs3i/ZM@vger.kernel.org, AJvYcCVNZpZSOMf1eQ4X9k92XIozFpDHOEv90Jb5Ag1r9neqmAAImg/4ztqFSVMdTNo5eHIdyEnsk1KbMknLWMQ=@vger.kernel.org, AJvYcCWtpz6RLUkMIyeR13TxR5wjvkSwlU599dl+qsNHhL3nvFj4C7IS9HiwpshxfBxeP2Fsnbb68m46Sk61/c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uX2giLrFeAwkAbecqFinl5DnAcTF3W1SuHXFLPE/50Afv89p
	//v06VZsHVjwhEjHf7Q6b3O13LjWeMLRjj3pKkEt06F7yQrSrBH5
X-Google-Smtp-Source: AGHT+IGjHbCdL9n1T25NiYqOv/Egm/PtLSzYQLrz+c1DLzL/71S3yO0qnkuzyroDHsVMSMplfp6p6A==
X-Received: by 2002:a17:902:f54d:b0:20c:76a1:604b with SMTP id d9443c01a7336-2116c88c016mr32877155ad.12.1730887156274;
        Wed, 06 Nov 2024 01:59:16 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057087dasm92697005ad.85.2024.11.06.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:59:15 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: fix a possible null pointer dereference
Date: Wed,  6 Nov 2024 17:59:06 +0800
Message-Id: <20241106095906.15247-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tegra_crtc_reset(), new memory is allocated with kzalloc(), but
no check is performed. Before calling __drm_atomic_helper_crtc_reset,
state should be checked to prevent possible null pointer dereference.

Fixes: b7e0b04ae450 ("drm/tegra: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index be61c9d1a4f0..1ed30853bd9e 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1388,7 +1388,10 @@ static void tegra_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		tegra_crtc_atomic_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (state)
+		 __drm_atomic_helper_crtc_reset(crtc, &state->base);
+	else
+		 __drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 static struct drm_crtc_state *
-- 
2.34.1


