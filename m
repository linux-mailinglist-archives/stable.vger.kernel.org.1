Return-Path: <stable+bounces-98928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A673B9E654A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 05:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82131169E7B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 04:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA719415E;
	Fri,  6 Dec 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrVBQud/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153F193081
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458133; cv=none; b=K5vPsF325iARyRbSyQvsd2KU/F8i4lTVtmxEloypsT4vX5KRdQsG79kmdE+uOhMFLgWS8NXfOIrjwKiOsDsVQkovwNDuKv7wkeYxn0Zh6kSS5Fa9SngMip0Z3UY1MTM3eH776XzmfzJSl6xKIGTs1EMxTT3f1mfmZAGNzk1TXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458133; c=relaxed/simple;
	bh=mfEM/DG4PNsmSscMrTtijAKM7ewta8wLDkEBOoOqr1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSDe9HIQRIgPdHq9xvZRNwbgHTDwhS19cBIJd0s4RB47kR2dMhiUDBpdJUc/ki6STFaheKUWNcEKoqTP/QT9X6PMPeTB9agSHo7OAvb/ydEAMvO6E3/USUz1tWbpRry3F9ZChhAfU3Xihx+ozGZZfvAj+B4DGacD1K6pnfu5t9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrVBQud/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7259b9147a1so265646b3a.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 20:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733458131; x=1734062931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pycc29BcH8MRwie8Do3jeg7dOfWDOOE59oanfpjCi0o=;
        b=ZrVBQud/OGxzB/B/f18babgbVCORCrWMXfrTAA5dku3BxdfA3gludd3umcMX2hYrXM
         lObEWPSn0Ejcs1XdC+Z7ou9zrityUFjbTGQC2VSrnFYDaQT/0Pmn3wANh5qoRbsSnxK8
         aDsdIf0SXer1f3UFi0jfj913y5GtdbeDJQbxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458131; x=1734062931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pycc29BcH8MRwie8Do3jeg7dOfWDOOE59oanfpjCi0o=;
        b=AK2WlEyCQcLWcIoKUWi1nI4qACFyxR98EpSGcVkOESPda1gof9s0ODXruAeugZKl7S
         HGHS4Z7H1edfpsC45clU+uF5lWUPfA57xmN3BpVvok1E7wQySvntImtykFHs4vbjzFx/
         QnbVGpop/gRxmZTZulUBuDVuvDWMDi8MUBxwBcqEXcrXT3Nd9g/5B/i3ur+tCX/ljzai
         ouob01G+XY5xo0mHwyd0pFDI3owSyOUcaFe1Oe36dlhDOf24G6ioBP384jdb5iIdPuze
         LsjpB+pFvUUuuqLRiPlOlb/SF5Onv6qzIbgzKYLHaeYTqKaOoRqKxOrNkVhXcbz45oza
         KsBQ==
X-Gm-Message-State: AOJu0Yw3cnNBvpjLw3+sYUSTSNJZ11OdoZHwiIUUqXN72x1CC9CbveFQ
	oMl6favkM1pjempUP4w4cHJPPSMIqT0aE48JtuL5sfqceu7w0p2FS7NBaWQr6BxUD196ZZo3jxU
	d7JvwlF9nZs6npk13ZOx6VLQTf9pu+Nuo2VxRDVv5BUrHfayUG2Fm871CVm5leIA6t3bPE4w8mQ
	wbTIbw7rxqbVHAJwWOLeqfY26rDnSdqpCNVHM1ILU6/C2huHivH4y29CxjiQ==
X-Gm-Gg: ASbGncskXGf03zRDpgJqPZENxnmKTmSV7zMk8Re8vXopYk6A0/t91PP53Gxu9nOsXx3
	aDOaDtm06HIYVkApa4o57cYGMubKBAPlkn2duGSmcx+Kf6iL6i56tjPE8UL7J121pSkLNv9S/Jq
	ffsXKGZRi1n/uZTRJP0+i2ojSq1Jki+0/+hbizTcb4wuk/F8YPtQiKdDWSf6FGEQ7nVd6R7Oz7y
	DONXAJV7xYOrLPtsVbg08biRQ/B1XBDHKSB6ILQ052GAO4AHSxowu8MjByLus732hwZJqaocGXg
	4E2Bk/7FrStEpJQW0w==
X-Google-Smtp-Source: AGHT+IHxgK0uBuqS9VxoHyUeS6mBM9E7ub6R77truPmNtH3VetfzIrO8WGEyYuJM9Zme/SwKoAuxfA==
X-Received: by 2002:a17:902:c402:b0:215:a3fd:61f9 with SMTP id d9443c01a7336-21614dce2fdmr7340275ad.15.1733458130805;
        Thu, 05 Dec 2024 20:08:50 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f26ff2sm19920525ad.227.2024.12.05.20.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:08:50 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.6] btrfs: don't BUG_ON on ENOMEM from btrfs_lookuip_extent_info() in walk_down_proc()
Date: Fri,  6 Dec 2024 04:08:46 +0000
Message-Id: <20241206040846.4013310-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit a580fb2c3479d993556e1c31b237c9e5be4944a3 ]

We handle errors here properly, ENOMEM isn't fatal, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0d97c8ee6..f53c4d52b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5213,7 +5213,6 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       eb->start, level, 1,
 					       &wc->refs[level],
 					       &wc->flags[level]);
-		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
 		if (unlikely(wc->refs[level] == 0)) {
-- 
2.19.0


