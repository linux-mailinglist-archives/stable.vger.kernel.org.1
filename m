Return-Path: <stable+bounces-191394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C8DC13152
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5CA4620C2
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6059529E101;
	Tue, 28 Oct 2025 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkbX2dtG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430B2727FD
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631776; cv=none; b=SA9wQmPnRt2GYo54OjrrqAvekj6mosXbOLR9gKgRNhv2VXzOBYUpFGxV0GGMVIMBPJ+EFmGtFS81e+Dm6ER9LgZC4GqqOPOkYCiIJg7oW5PAalgaxbDlItMAS933rcrnHMFGu903zHmRR5P2l0B4fscWaR9CR0MVkIrM87+m9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631776; c=relaxed/simple;
	bh=7tSMPskPiKe/boXjgCXM8U4kjX9Rmu5BHSaKJRhAyrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIr+nj2MtSeYHsMQ58F+UkSOonFHDvcWQs1lkN/XR0emf5HWAcBvy9zJVxESU7yemBRLPixImtQ1PNXzVQDH2Dh7k6NWslvobBvouVnOtl+Ho8IgWr54PXNzEl0RUCsaXV+pKty6ra1UUt7erV8/Q0Z0lLVL1Ms08nlmDqS9GJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkbX2dtG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782e93932ffso4131838b3a.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761631773; x=1762236573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxCaZgetgi7vR+cOn85gSzckFRkwOHE6DdvavzMKaQo=;
        b=AkbX2dtGxl2sf8gLRLDSn9oK2vmeAPa5gOcC9fkdtCnAc9M6SbNxG6Ge+owznUttaO
         UIYwqFtYzC5KfR6G0Sd586Onq42NCaQ8snrmhAYM71/VIvQevgZWHXOXkDzjZtiaBJSx
         JosbzoBwpm5wNeoeAnCNbWm1EE9m/tNnQTyx5vGphjoXKVKIL473QGayIGrjWMYJoqaR
         2K5sKMWHA3l7SrBD9sISKAB38fVPgXVU0DIKS7uVLSUSO7thDbqQpHRMSvE/x7zYH446
         BturuGNxStPJczjlQDpotYbWjZpP4RcurcNux864a9gFR0OH/CoF2Lruk/KSACi54QAn
         BqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761631773; x=1762236573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxCaZgetgi7vR+cOn85gSzckFRkwOHE6DdvavzMKaQo=;
        b=I1cSkD8Njj1hprfQb0EEiScKUmsL4SIuBiyCYG4PJMBe2z0JK9NEz53LgGKJVG1lUk
         xRY63ya5Lw2YqoOWA1uczxp7A3NPqnF0tCS9RTBTDW85iGV9fhb2U+kK6WWRZSO7APXA
         bSW31yS8MCp3ZjrfqQlDYOM917QE9kORsT4fu9YAxjiSn2iNq2dgfG15oSaThok0HetD
         KXyr6CjNO/SioLr9vvDH25udKvBDjGkJcQRLpSw8pN3aEVbelG3hRDhlGN/kVQ/LeruC
         0cRf9s0YTV76KLnkuos7KR+iOY2KhqTY2nQbgHEjT18WGfd5Tr+5mMX+SydNAfXmzH8Q
         toWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuXA9cFvsWKhLJUpKxvspMIgCFEXGsLgRGidSWuV3kphMZhqdHSLWAosITLU4JA02W1T5UZ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XgG4/yYRBn2g5JA0LoXRmofmyWG8oOVB6BTlkMo3EbI16JAN
	VB9HCgYWIfwhF9L11RtaINkZHymkUlbxxgWlseFdzwWjP96nd0mStB8I
X-Gm-Gg: ASbGncvf3l5XPshJz/hrgpILK6J9OmPnS2aY5L96Dy5apFSDRky8wgjLKQtGGWpjJYq
	8tio6zfL9M4tjbZJOhM5UjVGd3hqCgwSjVYGCei9OEWynpSQD25J7PWOmgEWkf5QGGwuauuD+Jm
	OcgLUGhD66ebpBrg7b8d/cxDcDooBXzxkGOvg/40lo79RplDMpd6/Jq/wbEQbiSD2vchZMIoIFA
	0JzQIZxTcjoEtGSc8hO40Nqzr8fmc5u+OzFEdFl9yFfW0cnoabrKLItjnZ+Nup45YcZVuwebFHp
	/0lczNumCV9zJwV3IduV5pNmd6cx1GMcvKC+0H7LuYawNRNe9hiPuzR0j0WniJKWaSRJyGBcGht
	ExfXC6UhHgFFWGw2R4gEM/h1WAzz1XmeGEone9hzIsreOFiDrTaH+/IS2mX1+q26wpLM1mFCeEM
	Sr7FO4ZfTz6iG+t5m5Ha/6Qg==
X-Google-Smtp-Source: AGHT+IH1+F3wRNfLwu/JVjiQE8TzFdjDfCqQgZpgSMYvuq3FzyuWy/Ro1wdBKzwG6QcCND8qtflldg==
X-Received: by 2002:a05:6a20:158a:b0:341:c255:7148 with SMTP id adf61e73a8af0-344d345618bmr3246377637.28.1761631773211;
        Mon, 27 Oct 2025 23:09:33 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm9382533a12.6.2025.10.27.23.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:09:32 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
	Philippe Cornu <philippe.cornu@st.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/of: Fix device node reference leak in drm_of_panel_bridge_remove
Date: Tue, 28 Oct 2025 14:09:18 +0800
Message-Id: <20251028060918.65688-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_graph_get_remote_node() returns a device node
with its reference count incremented. The caller is responsible for
releasing this reference when the node is no longer needed.

Add of_node_put(remote) to fix the reference leak.

Found via static analysis.

Fixes: c70087e8f16f ("drm/drm_of: add drm_of_panel_bridge_remove function")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 include/drm/drm_of.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 7f0256dae3f1..5940b1cd542b 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -171,6 +171,7 @@ static inline int drm_of_panel_bridge_remove(const struct device_node *np,
 		return -ENODEV;
 
 	bridge = of_drm_find_bridge(remote);
+	of_node_put(remote);
 	drm_panel_bridge_remove(bridge);
 
 	return 0;
-- 
2.39.5 (Apple Git-154)


