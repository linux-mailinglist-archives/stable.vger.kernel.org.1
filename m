Return-Path: <stable+bounces-210132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1453D38CD4
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 07:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06B8303091B
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 06:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64232B990;
	Sat, 17 Jan 2026 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD0Fz8SA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA076025
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768630964; cv=none; b=pYUbnTxKeDIYo+IhV2QZ21Po1GJVypzuuCFg17LWeXRaeZ7ZchBeaUAcVa4uOCn4uki7OcEXf0mxkOX+//6AWu3xu9ov6Y7tzGIORBNvLwQuVJsDlIANGTVcDwiyaAK719k0achDEuBPtRGR74j+0zLZnJ4hPYTSbobirc/0ALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768630964; c=relaxed/simple;
	bh=3FMUpbSyvaBsSjWl7wNChTOpAPhfLU+5WdVXV+kFTVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRQXSo9PfL/82eOzFllBxgzuRrL4200DKxXzyB/vUvrx8K76pp0U7ZxOsxkc+DDisfE43ylzxM2H9YgTqtcnlWm/QrIbhlnicwmkxPbu3E4nYSb9+mWjC+nSJXVJpyRgoxZBoxapCn3/mpclJ6t+JcXra4V8PSR6GSLN54bPe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD0Fz8SA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1666331b3a.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 22:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768630962; x=1769235762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzgEeF9hpKbrY/SjLzdTBS2moZ5Wv1qjh67NLpQv99c=;
        b=nD0Fz8SACqM+KcdyuQfHhV7QKLkw6LTcvjsB1L3oUdhUauq7PgLpSkcBr02Nc8P1Wd
         slEo86vgmixhNwIy9PN2lDry+4erz75LM3tjEHerVRN/7O9KRfbpKmFkCCLcR5M7clFI
         77WlCaXYwFjVITYOVRNoJW9Sbh6dVjc6rYQFORB2EjzKASk7C8dDVn/5aqGqeslyC+UP
         gwoFAk5M0gHe9ddVB+mP8kGPOnASycs6menNKgGIP9OATL7COZmLmfYR/ynhEjXI0G7F
         XpQgoetW1Gu3oDsoaizZ1BFuCUkElPvWIRHnENZRqijCRhJBl4h6ADlOMk6GNyBliu0O
         AtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768630962; x=1769235762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzgEeF9hpKbrY/SjLzdTBS2moZ5Wv1qjh67NLpQv99c=;
        b=jtDvPt/LhPGxu7+H4qtEnYQ8dHKzJfTsRQw+utKQ1pfm47za4lGJc9gKPQVUSU8FUK
         T5ozuQgesee6o8CUo8O9lK4tG+bkE43jF0A+u7owqPa5Cn0bzx7A/eU0vz1YXA6Xtvt7
         MgbaGd7aHbSqa0jc8QU/ofZ1Yf4j16RWc4tzq/yrx0j6atsfNfXOQwwfo3qO4rViIsXr
         J1yDp6x2GkufZUzX53hSU/QaZ1W0mjsctmPCautrk9fg+4Jix/1/oqYo9vayXbZY6vdB
         To4s+H5kxqzE7QDyjAkIcoK1I4WlVl7iRAOnDi0GGV0iZVwCPJ87h2zyjs5CHDDm1wI9
         6X3g==
X-Forwarded-Encrypted: i=1; AJvYcCXhiN30D1mC14ItjXsknruXXC4ha+xRiqzxd3+PgbvM6Srtu2ZCwbOviE4av9IxCUQk6qskpVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVyRKA3JwJzzjty2UHNltk7ZjP3+o50qQLIhBd33c1qYE9jZ3
	6OWSQNthoYxbvA6cz/BscW8GEYs4EkyaYfMb6UsiPbg8e36S+/Z4G4IF
X-Gm-Gg: AY/fxX6QT8XLHgDpGPDn4laEZGZgiJC43/3osMzqkAqxQ1o4Rex3JYQDzXlsTieCdDd
	uhY0ZK2edyA2fcQgXjub26VLjwyIsdyn+IkNWV3VOsdxAwtGnVyqdpeRzG3BntNSUirrXktRvKs
	KVqjDWx4Dvls/pFYaGOsmuac69AdCc4B+COivwYew23jwr/3+ZcxDn0fTdwjpT1NgNtozgIOuWH
	TU7c9pfD/E/Dbt1j2GA1wVCRu68dp8VlZli4G8kjVOinaR+K6jH5dscQia1HkcTsFxOVnmNKmyf
	bcb9f7qlbYcoRmrnumewaPILB4KKVDjemAS6fYaRj+G6HcNQH8cQVh/hzeb+natmM8Nbu6VBelf
	H9cEf9M85auX69VOP2aijxyFSbFoWagXdcdO7WPT3i2lKy9rAsN4n/zWnmATMWVbao8a9lEMyig
	7ZqMBGJLYbHadW8YyqPCC6Y5/TQDTMQkcrr6U8xMc0GgzQRE4Dm3Ljj/P8x9czKVyDrTtdjWyrv
	OfAzVRDvAWWDiaHd+YqDADtPDX9FPOtYxDfLZcMpwFn3xNoubZDjIeSgw==
X-Received: by 2002:a05:6a20:12c9:b0:38d:e87c:48b3 with SMTP id adf61e73a8af0-38e00bbfd6cmr5718140637.2.1768630962577;
        Fri, 16 Jan 2026 22:22:42 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d82fsm3507131a12.19.2026.01.16.22.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 22:22:42 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: tony@atomide.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: fix reference count leak in sysc_init_static_data()
Date: Sat, 17 Jan 2026 06:22:35 +0000
Message-Id: <20260117062235.435174-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_node_by_path() returns a device_node with refcount incremented.
The reference to the "/ocp" node is acquired for a WARN_ONCE check but
is never released with of_node_put(), causing a reference count leak.

Add of_node_put(np) after the WARN_ONCE check to properly release the
"/ocp" node reference.

Fixes: 5f7259a578e9 ("bus: ti-sysc: Check for old incomplete dtb")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/bus/ti-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 610354ce7f8f0..fd631a9889c1e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3014,6 +3014,7 @@ static int sysc_init_static_data(struct sysc *ddata)
 		np = of_find_node_by_path("/ocp");
 		WARN_ONCE(np && of_device_is_compatible(np, "simple-bus"),
 			  "ti-sysc: Incomplete old dtb, please update\n");
+		of_node_put(np);
 		break;
 	default:
 		break;
-- 
2.34.1


