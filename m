Return-Path: <stable+bounces-15499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EDC838D94
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D4F1C22084
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45555D75A;
	Tue, 23 Jan 2024 11:39:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E165D755
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009980; cv=none; b=XAWizLUoMRJfHG00jVuKAl1SqQxqJ1PMmY0yfAW3o98lpV+rbJuwpY35T4Zc+MOOuKpyuNTIqciA1oXGooKYRbyDAoa1sw9Osk4FJgVaZy+p9TYNXFWNT4ceu5gVF8TjSH6ky53kP3/0c9d/RnNMb39bFk9vDx/zkplNiJI0Cyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009980; c=relaxed/simple;
	bh=p8fd5VnzCWqHmHdmmWQEAyzHMQf7ZPT2nkkED4AtQ8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+Q7Ss6lxiInfM6/QcES5ZvtX+GdF88aB152LL4RsTn27Wxy8spGL7CKZDcZODsqx9Dr9j9Y2DFH4WoUxwhpo2GutmMTrn1kBsdVHVHXo+vfB01+c9OqYjuUgsogd1fXnrUhX3shZNimPag4+0Pxt49DjxJoCYQlmW5kpFQpfgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dbcdbe13e1so1992540b3a.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009978; x=1706614778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA4+jiRoe9pxgGSnmKO6vx8nQZ/n83r0lFKxpv0M6XA=;
        b=psfN9VCacLP1qEHK3SIyyKdYXQE2eVeO6fNTxx5sdAEw6ds1XIvla3GXuh1DTnyTTl
         InAp5f+Ld3ewVbubZWXfU2N8E6M5GbgizrxexewrinTGZ+sPL79daxQ/BCr/2s4QZwpM
         NfODreJWEWqpvhthZTcJ4+ujcRNqPlMu6G6ygSJN/UaGqCW7K9GGJTEDnJRc2WU4B5C8
         uBruHQUjR2wJn5vQXCH8sWW1+TiIGyYjTdMiKdtAWoQKjgPIry7q9uVHpu/7XrptJMag
         tEAlPdplvIwIZRQdAJYeaxIgwShHBwjEVr0ZMT7ynUHJCLIqqbXb8dlkJlvEPn1BS4fN
         lmLQ==
X-Gm-Message-State: AOJu0Ywso35EE3qzIOovp748YSkTYcEpiYMyZYMnUuj8QYbWJFKl5yyA
	uHtrkg+dBXVjfZEQxLmA6LpM0XDXwkjSzyWLXILp2u1oVFQo92tzcsQZEj2Y
X-Google-Smtp-Source: AGHT+IGx1mf96aRPtxAxc5+gIqvbcyP6A3D2FKQ15XQeSlFVaMd0ziHquUZsMALqTzRW2izVEzY1Vg==
X-Received: by 2002:a05:6a00:1384:b0:6db:7102:f95 with SMTP id t4-20020a056a00138400b006db71020f95mr3276556pfg.47.1706009978576;
        Tue, 23 Jan 2024 03:39:38 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b005ce033f3b54sm10139779pgg.27.2024.01.23.03.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:39:38 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 1/5] ksmbd: set v2 lease version on lease upgrade
Date: Tue, 23 Jan 2024 20:38:50 +0900
Message-Id: <20240123113854.194887-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123113854.194887-1-linkinjeon@kernel.org>
References: <20240123113854.194887-1-linkinjeon@kernel.org>
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
index f1831e26adad..8adae5871e44 100644
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


