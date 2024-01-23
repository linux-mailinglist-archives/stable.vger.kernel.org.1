Return-Path: <stable+bounces-15505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93956838D9E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3463DB21D45
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B15D8E7;
	Tue, 23 Jan 2024 11:40:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648F5D755
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010047; cv=none; b=qThTkwbfXCHger5ENLGQUj8evR8/P/AizhcuUSaXYieXwuYAOlL+nivolPzIDbjPiFnxBYUHG+gWtlfUgCvyT3pAybwGVeqjeHGMLAHUuXtdfPcFLTrUjIml4ESlhX74rH7YL6WzfA8EaQ8fUztJ7kYlIPEKHAWJnwYvZd82Duo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010047; c=relaxed/simple;
	bh=1xlsO42Sv49UYC2FsbXKbaKfgSPOJfTr9mtfJZytU+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oqghx0fhtmwXCp9DiYqus8bX34pn/zyJjn/2xeeWoNMinxmA4NTjjtly5zwEzJdb2qFrPJISraNrzNFo7bg2BsEYfleTyI/s5aOGuXFVvKSjt2uLaLM1m5Ib79xdDT8ldBYlODSYN6jPEUY4+BqW9jHUW3PFywdDMdwNtbpqS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd67e9d6ceso2683681b6e.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010045; x=1706614845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs7b96pUhLUlWK/njbc6LkFPrK5r0FYyDa2xtvOmctw=;
        b=Msh1BPklXbYu9oHfSZ2o+hk8AgXGO61iDKV+RTOr7KN4RGZs7ON82vP5dIlRuAsn+C
         7AeAfgqjK7kVPttp7etYsglsaSoQG+bSgRJhZqddZAMkZu48R61xlnOu/SoPLU1xrg5G
         kCBhvzbPvV5OrCLUi077TjunTJcPFDseLU6R90Vf719NNjnkMbOmlmIcoU0KWuLoF6w0
         lTmYZxR5gDI2LerkBocA+qZAPQpBoOPGz/Z69B3ak6H3mLUJEop1qxo0mrKoxFER+1cH
         ZZMnR600CZKjnXDkFPqrKw5GpbNiJgFX+CeDX5a65aUsNix5Xv/cYvHxrgFrULcoQfuS
         7+zw==
X-Gm-Message-State: AOJu0YwvY2zH4kW42f0YbHo/+fefjxhgACRFs0JQd+5sXaZYXNYwN2qh
	qT1neTPkdkzVItMGovEYYlNVYoFVH9oyJfGUGHkMKDR25ODOnuZJ
X-Google-Smtp-Source: AGHT+IEaHo+gWCeiceQBV/gbv4mobHfSQM5usU54mZFnSKM2l6szNpQlUpF4zkWMHzU8DeEBpmtEcw==
X-Received: by 2002:a05:6870:1684:b0:210:c8d1:b83f with SMTP id j4-20020a056870168400b00210c8d1b83fmr1431160oae.92.1706010044912;
        Tue, 23 Jan 2024 03:40:44 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id p15-20020a63c14f000000b005cfb6e7b0c7sm7543359pgi.39.2024.01.23.03.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:40:44 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 1/5] ksmbd: set v2 lease version on lease upgrade
Date: Tue, 23 Jan 2024 20:40:27 +0900
Message-Id: <20240123114031.199004-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114031.199004-1-linkinjeon@kernel.org>
References: <20240123114031.199004-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit bb05367a66a9990d2c561282f5620bb1dbe40c28 ]

If file opened with v2 lease is upgraded with v1 lease, smb server
should response v2 lease create context to client.
This patch fix smb2.lease.v2_epoch2 test failure.

This test case assumes the following scenario:
 1. smb2 create with v2 lease(R, LEASE1 key)
 2. smb server return smb2 create response with v2 lease context(R,
LEASE1 key, epoch + 1)
 3. smb2 create with v1 lease(RH, LEASE1 key)
 4. smb server return smb2 create response with v2 lease context(RH,
LEASE1 key, epoch + 2)

i.e. If same client(same lease key) try to open a file that is being
opened with v2 lease with v1 lease, smb server should return v2 lease.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index e0eb7cb2a525..c58ff61cf7fd 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1036,6 +1036,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
 	lease2->epoch = lease1->epoch++;
+	lease2->version = lease1->version;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
-- 
2.25.1


