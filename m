Return-Path: <stable+bounces-121668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD1AA58E83
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 09:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B17188D0FC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D843C224247;
	Mon, 10 Mar 2025 08:47:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B3221F13;
	Mon, 10 Mar 2025 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596434; cv=none; b=b57tcbFzbr/9kQSe6/ToNz+NskRBkvtqfgf8DcNswfBOc9LvLsFEeLHKFTdOrS9M1yBKBLOZgzgh49mUJJF49RI/5qooRc+CVhp+pj4k9l13SXscodwS2RHs8SNwiYloHEvCzeE9RhvqQ6pSHVXrIBBss0OEXr2Lb9xgi8PC13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596434; c=relaxed/simple;
	bh=7eYxJiXXyvsA4PJuVaPR8SWKzbE9Klceg0t0r2NLctQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee6mnsyPROgYEsQmimM2as9a45cmDO44THkEBIT+Ll9UyCIA3M2JlfDe2kxua8SBMlTnMaHzop9fSfjtvuFnfE2QRueN9xynSwtXeDs6/34fO9cOA8RALzg3Q4A24BJBD6roy8UtToz+wZpCJO2IeNvdhfb9pB8fA/RGAwBJ8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso7681155e9.3;
        Mon, 10 Mar 2025 01:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596431; x=1742201231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KtY77mY4u59FBf462AarhG9KG7rTrsBhUE1IoAfDc0=;
        b=cr5Q6GLnho2+SlxvckGVxYy6SxVwKXXvrqfUtYX5akAD+ZMo+geVB43gxyevoA4jmg
         IC9/KtGYtBMYFCJ1Zq9nJYC0yBOyPWmTTpu92ZwwW0R/qbEMvmKrVgHfgjzuXJo8hpB9
         A9mIaDrIvTL9d/l7qJ1lcaapo5SIuqdcKi5hszU9SJOTdx2u4GOJs9cZyOQj6aaQZOaN
         WCFNqv1AM5A9V8Su7OGlCOtk1dmMhbKoMwnW5Z5sX1DXSo4DyArpquz9u+1ulkmKQLd7
         4VjNR6XJoE0rIlGGDngfnS1Y2Gi4wlrW2Rzdzl66vJI474OIdfJ+5xWZOJKOnLJCch2G
         +Xgw==
X-Forwarded-Encrypted: i=1; AJvYcCVbORXq9M9CIcmD0ybgoeCcXcYBXq3q666zSQDzN+Kw4+UrT0Ws8xao7gUb4j96c9Dw8ertsYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVauTn4xfgBoPPHYtQHNRQ6AlcklIzM5cWyyTzt6U6Ffe3ug8a
	0TBrZ2CzcDLvT0t3HqQjKie8TSbZTPqS9sSKVHROFPCCWRVc3yOu
X-Gm-Gg: ASbGnctckEnoI9kiyh83ceEyI32xtEnGL/pAl2mm+qfP2V/9Ce20Aj+pcZggpct3EZZ
	l0cBulp+zan9MXM+RNiO12kahGOFYBA2l171KuvoHSn4uzY+ldOEJc86wB2OOvaYh+9Lqg6lPac
	+FRC5J1vEgCi6n5MflsMdZiBqSNp16gn09Ux85vwkDiHeUKd2cJ089FSJO+smJeAGnFhNKihoiG
	huQ1fpVC/SOLEluwCZ/dtnzbVWB68I9PG7XuEHjSRyKLMCdpuNs8qxC1TQw7qkHz3Cu9X9nBsOr
	ceUbmwn0vyZQ6BPf11yQBAX6y5TEXU1XSmf1VJvgWCcKihyypGnctru10fDBqlkHKs3TJI1lpMb
	U1NkQ0V76BOcLrcGI2SiYqZompX76Y8RLIq1ihw==
X-Google-Smtp-Source: AGHT+IGLA3YDys0mrOMYJGrn/b+QddIi0nCx7Fb8mHhlLaz+GWXXXaiAbYgc13p1mplmr2Cyg3HGtg==
X-Received: by 2002:a05:600c:1c8f:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-43cfae151f4mr7605275e9.25.1741596431097;
        Mon, 10 Mar 2025 01:47:11 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7433100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f743:3100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm77093465e9.38.2025.03.10.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:47:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/1] mcb: fix a double free bug in chameleon_parse_gdd()
Date: Mon, 10 Mar 2025 09:46:57 +0100
Message-ID: <6201d09e2975ae5789879f79a6de4c38de9edd4a.1741596225.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741596225.git.jth@kernel.org>
References: <cover.1741596225.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

In chameleon_parse_gdd(), if mcb_device_register() fails, 'mdev'
would be released in mcb_device_register() via put_device().
Thus, goto 'err' label and free 'mdev' again causes a double free.
Just return if mcb_device_register() fails.

Fixes: 3764e82e5150 ("drivers: Introduce MEN Chameleon Bus")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 02a680c73979..bf0d7d58c8b0 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -96,7 +96,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	return 0;
 
-- 
2.43.0


