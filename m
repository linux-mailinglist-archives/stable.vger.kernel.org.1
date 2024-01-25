Return-Path: <stable+bounces-15747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3A783B5F6
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C2A2892D1
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7D538C;
	Thu, 25 Jan 2024 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYCYfJUL"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73921629
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141791; cv=none; b=q7n9sNXxl2C/ry7OFEtfPMJ7/bKVam9d4ODlZx+32FwgbhX+VIgej6MPUzwn+sOggNXGen639dp7psJu2bsj1XFzTVZOpOx/VGKQwUwY0AapAyEjuJmHY1woGGelKKfUfUMRvxN9EQDeyLldy8VfttQjPGeMjfshO99TJXcXFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141791; c=relaxed/simple;
	bh=uRZOntAHmAYDS6hg1/93ul9kNtQv3oUB1qfhqH7Nmgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0quFpq6XkUFRtfPJFOGEBTdJcIevx5kDynnYT/Ybg9vYX8CJy5d1QUVMoXwu2s4dTdHoNG3Upc8z5uDtRHpSKWk7Kk1ByRp78DFHAXL4q5jEsSBkTUhoHrCK4m+JXnOIhEWYRsR9YPxAMtyGiXmQtfBHqS5EBeGJHVQFGjZmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYCYfJUL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5100fd7f71dso1805982e87.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141787; x=1706746587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22Uxp0z18XsCNffuM2jczY+6IjeeRp93jGAFhQY6hEs=;
        b=UYCYfJULPDWejJvkbYtyNTwLl2J3/iBI5ml3pp3F4NU0nlMN5MYGlqZ8rEMIeztRvV
         zJIV+wYrxzM22GiYfJ4g9P8Roy15azs+vdY/uoojl3mEWeHp2aa8OfJVPJA3rqswFzyY
         v5xKtYo+B5K8RCKsKuJetekU9r1AR4Tu8vmUUzuOD6ykMxxzdaHBPkMopjZ9GhB2rehE
         O03m9achpuOs3IiJaZgOfN9wiJ9F0C8GxMGiMUn6aHo/Ku4WhUVLsLOLLM+/+8+p6UFz
         S0BkC+KufUKp2HCvbS7Hn/mg+SQgdz6v0HsMT5uQs4CwcQhSSQrVXENKsyuRI+pJYdsT
         Mzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141787; x=1706746587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22Uxp0z18XsCNffuM2jczY+6IjeeRp93jGAFhQY6hEs=;
        b=DJHZv8NAhaR1MGa1b4D37Aesuj508K6xNJFUweUpExOwaTG3DyZR4nsDxA74sBVaxz
         /12szks2aP0nOyKiO+k9O+ihmZcCsQ+YvcfZxykrde2F1OhEcMxIZelWSajGQnDtT7qH
         gA05Zv40kBFwlW4lj2aiS+jOb+xgm6s1GQdHGLMY2bOIHrhEj5GR3Dbxf3y7GdAtLXGW
         f5r4SMBiUUtNvllmLVgCNTtwUnoRPgxpYnA6E2oX1loc/B4fQmA8YuJ52XiDAGWb2BHc
         At0SE0Rl0NTZbLiqD/YAAAM16EXzHIYVBc/N4BdXMnbWe+dU6jVfbxsJOFyEL/R4D47e
         uIxg==
X-Gm-Message-State: AOJu0YxW6W6ZbuZ6azZvAlGlujLIbEDUMKe6N/y0b+B8PIvw6Q6mSSJK
	g8A2E2mnqYF3u1uEk/wgWmf/7NgO1NZnbevgwxqqABeWVRVxxGTXWiZFQFkZ
X-Google-Smtp-Source: AGHT+IHUNS5qpq6JTDTiAMdlV1ddMNDx0isFelawTJEgTvkZz9i8b8XpOR4uWzhZA+EwVFMBgl/rhA==
X-Received: by 2002:ac2:4341:0:b0:50f:1124:2c63 with SMTP id o1-20020ac24341000000b0050f11242c63mr30564lfl.101.1706141787308;
        Wed, 24 Jan 2024 16:16:27 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:26 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 07/17] bpf: print full verifier states on infinite loop detection
Date: Thu, 25 Jan 2024 02:15:44 +0200
Message-ID: <20240125001554.25287-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit b4d8239534fd ]

Additional logging in is_state_visited(): if infinite loop is detected
print full verifier state for both current and equivalent states.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231024000917.12153-8-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6658f6750715..e306a6fd8fbd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16548,6 +16548,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			    !iter_active_depths_differ(&sl->state, cur)) {
 				verbose_linfo(env, insn_idx, "; ");
 				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
+				verbose(env, "cur state:");
+				print_verifier_state(env, cur->frame[cur->curframe], true);
+				verbose(env, "old state:");
+				print_verifier_state(env, sl->state.frame[cur->curframe], true);
 				return -EINVAL;
 			}
 			/* if the verifier is processing a loop, avoid adding new state
-- 
2.43.0


