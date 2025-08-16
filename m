Return-Path: <stable+bounces-169837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0727B289B6
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 03:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CCF5C21F0
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FE185955;
	Sat, 16 Aug 2025 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZs93FV9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF72B2DA
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309174; cv=none; b=H3nOdffS9wXlf/Y3jy4GR1U7AW7BinstOMh3A19EX5329Gt1Y4TO5hEJ5kNe4K1tOiFuOZpnrs9WtwAkZ/VuCuX9z+UEoZkqhvltrM54MU/H0u2Yso4NnArXEKpq6OLXc45CCpmxGhmeY1j7/bg3tH2oDGfG09BgoC36p8EehK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309174; c=relaxed/simple;
	bh=IZG/KJfVeBj/miM0tdGc0qY88Z24bIrYIekeNXgCW6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNKbJUbrFw/BzSGPViDGn6ovV9IABzkTD0jVkuSO0ZXeEaRNSa9k84knFISV2JV8poPdZKXIZcLznc7p7rjJ/6ls4ZGXoiTTyFT5PsNUp9wiIA3VWLcvL5UFmF8RB2ApSvAj9n2QY/jVU4oTlOgOpRcsK2Ullhgxtwf0B1Cz2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZs93FV9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so2082787b3a.3
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755309172; x=1755913972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLKG6jNvVUsekFiiFHIYl022cHqokzDGITdYQJ2LTYk=;
        b=HZs93FV9Es02smp0WldUe5YBDE/kTBaDhExQhPotvtIwbrHgiSbhVtt6mmFVtK3GpH
         P2u03PoSSn6ULVbXagQ6pB9bwCh0j/B2dVKnttx7uqFo1UaLeLW6SLcEFTNpeeylziYw
         jwvjPRnodC3hDeq0az134SdQCovyRv/YC0iBzfH4zrDcRvDStrvF6DjnGuFVa519rrWp
         nvFHmFzb4hM1pi8aLHP8f8D+fgrkdCbh2kygz6LpedeZcXn6VKQHu7sXiWTCs/Pmj5KT
         bdG1NaZA+y4xALuiPQwSsakF5hns0pzo/VD+qyrEXrOVS+jjwCu0H/eHhQx7hOPBdKPL
         liJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755309172; x=1755913972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLKG6jNvVUsekFiiFHIYl022cHqokzDGITdYQJ2LTYk=;
        b=Dm+J0ANbmSTr472Y9Xfc1lZon19dAjCPg1T7g5U16IjibLk7jkcDy2DKfSq5IN2EXG
         fWJebh+uK5Lj3Nj3k/W64JwJ1whO4nUP9hPwOCPAP9LWVgjPXlwqGE6w/fc0xiSHxnED
         UL2QWNhtOuLxup9spJ690xOL5TeaAq0b1qZ6uVlp+ng/O1LgsITNooL3yttjXJlKcUMK
         UlBBziMkaoST3cQfxguuVyRO1Z1NtmVAf71RByQCaznXCpw+VfY+NEjsKQ98F4rW0Brh
         G9Qa0tHqZxya7BFdS/bveyipua+h36e2RsyEVePwrIUckyjHDdBMTRhTR7BpXgb0RPl7
         PMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE8nZfgP5cYH2tuMsrBfeweTlrnuuf6gEGXoiG66PqgeL2//Gw9N6KA0+kK41Z3gDeIM5BOAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQfq6O08DkRLOBdKesAzDOg3K8SfZ66Rr8sXLZTC++ZpvRXtc
	SFaUPUjexUPl63g1yevmRI03waRNvgUqUHAUJF4/yvs7lMXO1MCLLOQU
X-Gm-Gg: ASbGncu+Fwqm5zN174x0cZgrMa72ZtzpRvsA9IQW7N/KVHRI99RXVELXMp4eVIpsXHK
	dccjRhrGDToQZEhO8zVLSDyLz5kzGRuu5oNYsL5xCejUv15Ep0r2W37o2K8lubMtXKV/jqG3qzx
	JnUtB9DQ8lvulUN9Nwz7ubq6SA6/O2pAT3qSK3Kt2li+NcKMAu5vOyWQcduwsf2rm2u4ZT8seOp
	QPdS3YnojDLLoFXf4euHnZV2myMSXzph8wF8yK4I4RtjO92as9n8Ru1SQm2aa7i/VnJHbJw5j/I
	JAWahvT7ICr4LbsIPWtp2fEmWSYiwv7Gh8i+q9qgKZD0eOLI36MG+bUsCMnwN/mHpsEmP0fbtBo
	+Q98x9EVsnfhgtAnH
X-Google-Smtp-Source: AGHT+IF9A2Kqr68he/7eryBtdSIV/oxea5NzcQp/EEPSEaGXhlmWWl1RqA4Rfv6eTN56d7YYgkaoMQ==
X-Received: by 2002:a05:6a00:238c:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-76e446fcdcbmr6372130b3a.7.1755309172232;
        Fri, 15 Aug 2025 18:52:52 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45293ddbsm2076609b3a.49.2025.08.15.18.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 18:52:51 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix damos_commit_filter not changing allow
Date: Sat, 16 Aug 2025 10:51:16 +0900
Message-ID: <20250816015116.194589-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current damos_commit_filter() not persist allow value of filter. As a
result, changing allow value of filter and commit doesn't change
allow value.

Add the missing allow value update, so commit filter now persist changing
allow value well.

Fixes: fe6d7fdd6249 ("mm/damon/core: add damos_filter->allow field")
Cc: stable@vger.kernel.org # 6.14.x
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]:
- Fix wrong fixes section commit
- Add cc section for backporting

[1] https://lore.kernel.org/damon/20250815094059.133769-1-ekffu200098@gmail.com/

---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 19c8f01fc81a..cb41fddca78c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -900,6 +900,7 @@ static void damos_commit_filter(
 {
 	dst->type = src->type;
 	dst->matching = src->matching;
+	dst->allow = src->allow;
 	damos_commit_filter_arg(dst, src);
 }
 
-- 
2.43.0


