Return-Path: <stable+bounces-191579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EFC18C79
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA9A1895A81
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739B274FE8;
	Wed, 29 Oct 2025 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLPvLioi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68832F7465
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724169; cv=none; b=sn+0huYlBdCpKMOwok7H/Sa2LTQDeLCLEspZVIw/GV6C2J1tGchMVa00Ljs9sQYbRi56cDry0w40MlwYfX3I08232A9ONTiqFNgdOSZJD/+qCmhgtLXiUbtXihHS02k+5LAcR3wKy1AN4FvYyU0rXVGiA6ywk2lZCCLOX1UkyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724169; c=relaxed/simple;
	bh=1GaD607Sv/bHk2ImqjRGCbXa2CMQD2Ts9MTofIV/RBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpE5sOmK3sBBHo0mOPAi0rkCAU626k3t5AePyrCy5HMU4k6WJFyQ8qdQyjWujjox41zhgf/qYx34qVnM+XEc/qo+cTqHOklPr9h0yi/BaDvggDKVtQCVUmclT3/tU3macOK3H5OV9hZHfNIC1lzusr/Qitx3Owq4n6urUf6jMYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLPvLioi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-793021f348fso6170227b3a.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 00:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724167; x=1762328967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RLA/DGKm3EXMzePk9BvP8NDtl/YaS8WddbAf4crKqY=;
        b=VLPvLioib32raB3ikPJFEP9NE1vwcEQy41fV4lNGkxox2BPyjHqJT20fgnjuNtR/7o
         BC/tuEWTgcv8OQ1+vsYOo+P6W4BAqRHTN/div523QeUt3HqAWuFrgPLaHhyT5x8rTWMx
         lofi6/wANJpHGGPo0UOrWbfB5Z5AcFlD9R/+FDSud2U/ufopmpzLK9gvxw90b0Hck8+L
         N8fQb2i9dSBh9OP7arnV9JnwXrNNp8L9/FU8nwRISzoD+xHTTlZECvibX1k1bqU3Gx56
         A/M9QOG6y9My93X1SEC8e44bjmpbq36z3L3Z2yMqBRdow7sac5Ton8vmXt0oWgx90evi
         6oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724167; x=1762328967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RLA/DGKm3EXMzePk9BvP8NDtl/YaS8WddbAf4crKqY=;
        b=KgiQO41nhrDh0CxgXAzIw5nbeMFLLV0uVHL3HWaxj3capR7tG1dfwKuVG8hp/aUE8O
         kpNeOKx1/MGnWwL7731kiPuQ47tFwNYlEpGWRd/cYiCyM/BgE6H3mfqG+BJ7DOUdW2aI
         +1aK/Pm2iqj5D5P/gfsS8lXjH/dDkXuRj1QEXTm5BQr7dfFs/iMijfVlyuXuU8cC5l5o
         JwPjAV6KuppAfYDFFhiOl53uoUeWhFbw3a9mpyWTfK1LzLCdCIAuS55pzyY2LCX7lvH4
         S5Nh7GsidmBQnYNRpQYZmvX/Cv89KYPP+7btoxKRZH8VV6DKePCvwaQMfsLOJvhtNRvQ
         6YGw==
X-Forwarded-Encrypted: i=1; AJvYcCUKGoFBZA/GiuMtx06igW5zLGqjbxFTpV0FRQxS2GbS8ZNzOqNpYGAop8PiaH3Qiasjq533uuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysh0iDIvSzTBhS2FzXgDAkj/8Mojd6So6+JvVNjSkN1v0OPWKP
	ESbzgOIID5KRcQAU8auYwKmzqzeynze48F9igRVIlItSxlZAEqz4IfnRGSffXd5kY3k+GQ==
X-Gm-Gg: ASbGncsenUD/MpeUbzwORmgcpLMif6sPpKbGZBnEoIu7klLwRfJGs09buk6ePA+nFF0
	SWEDNrg6wefmzlFAcJitGMAWS6/Z9FVGtNZltThloJTNAYX3qiIfrPVEuhCIxnXLCL7gheg5fSk
	wuuKkvwkOsjpqrEh48xPaYz1yF1oU9g2qO/vfaq3uvEhNC8omRi+RIB0Xql0fyUxWJa5XoUWNiI
	azG6SflcEH9v8SwdVlZQxUsdBcyV6igKpPa5Z1AeO8YtnRUDZ/k53RKprNS5bBO9XrGkIAVkADO
	i5RvKISJyvnluMbiG8YxjDJwHqz2WkuT/98HEYS7TdOTNpDaMgfHeN7xl4pFP72lH60IWN/0WCT
	lEb5+ny1A8Kv7t+9H0C/QQ+orcgMVamIPCozXLkjZfINFHjTJu4ixrrk9VqEO1WiJYuWp8wuh0L
	wpNqQfox88GWpRzUV/kKl+Kw==
X-Google-Smtp-Source: AGHT+IEjGFYHvTA0394tCrKBxDkPiihw2m2Mpe1BSWvzEwpLa5iv/ijoEfCshocB13qZhqbfk34Zvg==
X-Received: by 2002:a05:6a00:4907:b0:7a4:f552:b524 with SMTP id d2e1a72fcca58-7a4f552b7d3mr1920900b3a.28.1761724166997;
        Wed, 29 Oct 2025 00:49:26 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41404dddcsm14151864b3a.38.2025.10.29.00.49.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:49:26 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/sun4i: Fix device node reference leak in sun4i_tcon_of_get_id_from_port
Date: Wed, 29 Oct 2025 15:49:10 +0800
Message-Id: <20251029074911.19265-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a device node reference leak where the remote endpoint node obtained
by of_graph_get_remote_endpoint() was not being properly released.

Add of_node_put() calls after of_property_read_u32() to fix this.

Fixes: e8d5bbf7f4c4 ("drm/sun4i: tcon: get TCON ID and matching engine with remote endpoint ID")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 960e83c8291d..9214769a2857 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -970,6 +970,7 @@ static int sun4i_tcon_of_get_id_from_port(struct device_node *port)
 			continue;
 
 		ret = of_property_read_u32(remote, "reg", &reg);
+		of_node_put(remote);
 		if (ret)
 			continue;
 
-- 
2.39.5 (Apple Git-154)


