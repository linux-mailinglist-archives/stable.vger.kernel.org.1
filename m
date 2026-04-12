Return-Path: <stable+bounces-235819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGl9BWWW22n1DgkAu9opvQ
	(envelope-from <stable+bounces-235819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:56:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7123C3E3E0D
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36413011119
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2E037B03B;
	Sun, 12 Apr 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVcqOo8J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBC37756E
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998540; cv=none; b=SQiSkdrwdIG8IG8RSDSPKFXhFsI9Tqtgc3tGg1sGyhARAL/DKEXQg1NFR05R7u/ZaCuTdXhWGwvXgU5qHLtUEbA0xbaOpEYc/SNfFFCRlhHPU7/fUeTgCpUN71Uk36wruOtrZeFcKotPRXMoelH1DA72D0k98M6ZN7W28dj8ftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998540; c=relaxed/simple;
	bh=YdktwupOCGYDsXBTCp/6UncgNDvXr/nreRmag7N1hVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGRo11VKxbyirp7XOu9p2V8c+gATD45ONWo8wcenvRnBhUDb3/5OlhomwlO6GJjKPYCW5dEE4n6ImQtaENmnjqxpRTV2xmrMojmhg0TeWfnIEpTxKmNkzvKaToANOEJZksUOzQ6Vp4Gixlx0mOmqkpOW3bL9avJ+zfzEJhJxYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVcqOo8J; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so2061809a91.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 05:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775998538; x=1776603338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxOe3LAamwoRd6++BiNK2MTql5chiY2Vdpn2Z4OwuWg=;
        b=bVcqOo8Jvoe1L6QXbziWmAhyWrgPxr9lofUOovJZ14okenwZV2HnMHI9rE6IidT/sZ
         eIyfhxKw7LZeSDrTcD5lNQa2M+7ietcMLu8rk2kpe/dXz38lWuvRPb2rXwM6WSinCS3n
         X9Ghg8oBlW+WzX3cQVtcMrXs8d2oriYceTQk9LSuQCxLalN3bhMkUBLcjhLRaiyFt0wn
         5RVpeDyfZAbE2qrkvM1QfpHV0hUOyqaSQfz2xL0jg+fLY+K5I1azMpqLbgbK/EAzBIPT
         rQKsSMFXL2e5buL8JxZ3aBlNwftpypvdmB0r47tIZ++YjWxsHxTbc2IomQJdjLhD7n8z
         OA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775998538; x=1776603338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxOe3LAamwoRd6++BiNK2MTql5chiY2Vdpn2Z4OwuWg=;
        b=Fy83AIz8e9avS/Jz9spkYPjkOu0rsAPfB61xlkz9Cil/+gxuuBLj5d88jD9DG/5PCp
         UYW/NiBcP6T93PtU6bazW8pV08Q3AfORhyON3UWkuSYgLoEN6Oas0YqectFmXpBiGT3y
         2EycElT4ZcWn1AFDiiodrZDzpiyQfZGDhzQh0Bn3PCE7z3yMqq9ia94pAg41AJrzHpkX
         +48JgiwjATLDAbF5wSEIC9w3GEcWWTu8S0Ha3qf1AvMmpR09GpuJQTqyTkDNb01S0+nL
         r/+cIogg/n9aUkbJVpM6J5/c3pkab4MwCAdPoqrOJhK2FW6P2OT54w5sRdanVepnLSf3
         HoZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8N2pT2Il+sMa+/uRBolql/8hZPbLbsl8m9IEXkOtuIdOkWvVzxBUaJBzfuAdHy5FBznoP0BvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSosPWWuhjM2pmkopKWiTe6+AnUBldu+NNjiwnwUXFc1GP9eYX
	DoBAZmZb/OoG9Qni6qedyMfjQ7bPE2f+MRLIQJN0XMWVsjih4aMHw9We
X-Gm-Gg: AeBDieuLUb8tzqDtj+zO6hjPWGGmyBG1dUGWonMd4u+kDBYxtTHSECsiaoRBqMUf9xQ
	IpH5VeQNeqeDk4jhx/7WduNVWeyuL+8azVOfx5BkmtAzmeqCYeDB9RHTRdzjg8FrIeVVkdoaSJi
	BTz8T06w/zbDl96bs2K0jZuy67qgYAMzA+ImdMpPyqyoVomWuhibUnqhi8NEp1k3D9YG22pxQrL
	Za7d3ovh3mDvm8p7FyNBL9CEGg7SFho0vi2TaOmuYpr86sqLcFGZyiuEBIkGvCRscDijBAMG9M9
	vTFjQ6ROaudokkAXX3lKLrzrXuDdxaMvrOun0VDOPcI909Rr1MpeuBcpd2hFc/feQKVEmjUfS7t
	j8MUSEBV1eIGadHoO1wHMBjTntP/KjSWeXXjLaFJF5Jo5LAq0/wLORAnWnaso/+1tgC4hrxrodj
	M5peVNsH9R/AQeGA==
X-Received: by 2002:a17:90a:1089:b0:35f:b1ad:fdfc with SMTP id 98e67ed59e1d1-35fb1ae003fmr1164183a91.27.1775998538284;
        Sun, 12 Apr 2026 05:55:38 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb1ed394csm1481298a91.11.2026.04.12.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 05:55:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] clk: starfive: jh7110: fix memory leak in jh7110_reset_controller_register() error path
Date: Sun, 12 Apr 2026 20:54:50 +0800
Message-ID: <20260412125450.2509092-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235819-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7123C3E3E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

jh7110_reset_controller_register() allocates a jh71x0_reset_adev with
kzalloc() before calling auxiliary_device_init().

When auxiliary_device_init() returns an error, the function exits
without freeing rdev. Since the release callback is only expected to
handle cleanup after successful initialization, rdev should be freed
explicitly in this path.

Add the missing kfree(rdev) before returning from the
auxiliary_device_init() error path.

Fixes: edab7204afe5 ("clk: starfive: Add StarFive JH7110 system clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 52833d4241c5..55cd0ccbdb84 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -360,8 +360,10 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 	adev->id = adev_id;
 
 	ret = auxiliary_device_init(adev);
-	if (ret)
+	if (ret) {
+		kfree(rdev);
 		return ret;
+	}
 
 	ret = auxiliary_device_add(adev);
 	if (ret) {
-- 
2.43.0


