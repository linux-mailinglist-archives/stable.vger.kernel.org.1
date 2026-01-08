Return-Path: <stable+bounces-206394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C87D055D7
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 19:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 361AB30E605A
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07C2F8BF0;
	Thu,  8 Jan 2026 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BDIMng67"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C62F6560
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895330; cv=none; b=Rs/aCT/jOSBeIrEG7h/suQvZovxekKayZxqIdkdrwegsc5u/nn5RkNGlUEvsMygmST9DcetP/wuCDGvuKIeAazf00SKTA843ZG2rBQIVLhuEz1aDDiCRLKEFBeRCkdXE8WRshSBdoSmrB7ZEWe0qWiSCBUhHaA1HMP6bNfdj7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895330; c=relaxed/simple;
	bh=tgpjDr+PX4dmyNKbxxVa6k3si4+mMDRfvxNWc2c1oEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqXJRebqvqlJlaIZBtEoG667qDLIINtTxV7aoWd5JqBaFxngARagDFkU1DVtq4fnip8U7qlrwvu+XlB+gDzq+3T7dQVJ4AUDyjQPgNfBb4KUcc03yHp6YwlQok8CYbS/oNX8Q+kjYrwlSlT2laPetyvOC5KRo48qG15mUCg0FSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BDIMng67; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775895d69cso17530735e9.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767895327; x=1768500127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofstAZxnHRW0myvgwQHd5VmIucA9twRraLf9vJfmRbE=;
        b=BDIMng67zsrCVG4RFxUqHOPbNbgXrcJAf6rFzeTxxgpGbChxsBnwkDlLX5UiSON6Mw
         qOIcyMHBi90mFa16Hs/SbD2gI9S3btu46InQSbXNoShuWUxaA1Pbo0unte9f1FUtUSvO
         4Q8k34MkLXoyi5N+H8CwbRpN6sL6is2JaPHnpiZJ1l1muzKS0cAQDoj6AcIoDXjwptQC
         fuJbvsFHTLvbX178lAGM1rTc+vLsTi8P0jEShIfS+SSoaVAONQh1N5JUue+XHGhZndTZ
         CaMqujrxQm52d1W8ztZE+T3S9T75WVK7+j1Mz9Ey9CXZZ1lUSjByT6VrKdOohg8/Awx5
         cOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767895327; x=1768500127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofstAZxnHRW0myvgwQHd5VmIucA9twRraLf9vJfmRbE=;
        b=aDkZni0ElD7NJlrnYyzKHl/AJobhBJ11rO1xaYdvV27RLrh0zOSE6MjUVe3u0AmmhM
         4J0jQPu+QheDYIIiHPV8XKexJc93+HGCIGqNytjFQXqNr05hkxpjOKQXAOH2X/qINSV2
         N/+zjLXZFhzPNGI5JRPwTiorFY30NpCenK9Ewi1O5ZeIy+yhpnVavaCiWjCZp0NuFj6h
         Ri0Qky37mgt3CorFmJxMecgJX6CheoSzNL3JL7/F8i/E0KhcjGou4js80XqXDIor9ly8
         GI5aIPWxAN2Iv6YKriPRpA9YMte8Vn1mqZ3RaxE5mIQ9dn9maUsfRtXqRYrhqdw3dx0T
         fVFg==
X-Forwarded-Encrypted: i=1; AJvYcCXUmbs39LrMA1dFYBuohn+pBfmddWHL/Mg1Gv5KU6mU2rhMqALM6oc+5q+mQuTJc15CiDznlz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIfaatZI7B6rfjQ/mJNGtZk6dB0ezebFZSyQ2XKiG4dXnz4Vbu
	nMrXfXak3l/O8LPb7MAIL8tO2DOf5LyQptqWmjxCNTpEHRqvOoLvU7k/vhWCZOt0XNQ=
X-Gm-Gg: AY/fxX65LUYts9L99jOU2VIFhUWGJkhJIMc0lQFP++sdXwRtKwtApYb6b3vWnrf9lPs
	QNK460vRmNi7P3benqCePLgUg1DbbKMIAVRyHxaK+B9V0XZ2F+L9CsV4tYNfXe/dtZzv2NCinNr
	heDuA39y2XMebV7qrwQBqqFpPDy50Yzd7D1XSEp392wpawkmjATpKXio94k9YFM4QJXv5uu5uwd
	gSPEaArdOK1D5/tuaH/AIoEjGFjY79cJEPbwi4F252BQgyrk5lyMPxhYN1l59XD7Y99hSknBL3P
	oQIzIUaszPX9edzeuSNxPWQasFCb0Y/2/xpSQ1NqS0kgU7axNmtlR2bHMbLx0PyUW1WdeuEmRmd
	z24hr4dbtXAh2H70crurS4bzLbLSlxxJW8Oy0aqgiP7o05iviEVseBTLrYJlhl0EvdZhG3yHfgt
	jq5xqhZRUyyhnl
X-Google-Smtp-Source: AGHT+IHuJPs2pwNlk9eJ8NAkY60O93gd4KzJGgDlQPNgcPwE17tnxzmYkkPIJLWzyVbgAz7j3VGjLg==
X-Received: by 2002:a05:600c:1392:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-47d84b3b5f6mr81282245e9.22.1767895326008;
        Thu, 08 Jan 2026 10:02:06 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6f0e15sm159929665e9.10.2026.01.08.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:02:05 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: fix WQ_MEM_RECLAIM passed as max_active to alloc_workqueue()
Date: Thu,  8 Jan 2026 19:01:48 +0100
Message-ID: <20260108180148.423062-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Workqueue xe-ggtt-wq has been allocated using WQ_MEM_RECLAIM, but
the flag has been passed as 3rd parameter (max_active) instead
of 2nd (flags) creating the workqueue as per-cpu with max_active = 8
(the WQ_MEM_RECLAIM value).

So change this by set WQ_MEM_RECLAIM as the 2nd parameter with a
default max_active.

Fixes: 60df57e496e4 ("drm/xe: Mark GGTT work queue with WQ_MEM_RECLAIM")
Cc: stable@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/xe/xe_ggtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index ef481b334af4..793d7324a395 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -322,7 +322,7 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	else
 		ggtt->pt_ops = &xelp_pt_ops;
 
-	ggtt->wq = alloc_workqueue("xe-ggtt-wq", 0, WQ_MEM_RECLAIM);
+	ggtt->wq = alloc_workqueue("xe-ggtt-wq", WQ_MEM_RECLAIM, 0);
 	if (!ggtt->wq)
 		return -ENOMEM;
 
-- 
2.52.0


