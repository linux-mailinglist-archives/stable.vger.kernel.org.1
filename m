Return-Path: <stable+bounces-110095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12660A18A20
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 03:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22993ABF8A
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 02:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5114F117;
	Wed, 22 Jan 2025 02:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzN9LHPr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624914B965;
	Wed, 22 Jan 2025 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513518; cv=none; b=Tb0vzWgANsR46F2+zBHrL4Ud8+ujNBojmLSLcYsePi96gvv0IN1qSDlQas68RIcAdrtbOuCbWvlWC0KNFbZqHEky1ytBxnjj2/cJUrnHo7Kdihdxbz4KY118MQO1TOZcRED4ANYolygkYKuC0D63V5VkdW846xehq20v0mxEbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513518; c=relaxed/simple;
	bh=HwneXwoCCptZ/zm0ZXEJWjR2tukJvOHDJ7S3Zhp1QHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cM7JQ7kuZp6t6YkBObzl8n2lp7xda7gyKP1KvHolU61XbQprqihAnzFOyRSnicN4BXOAVLKXTh20gmmi87C5OV28NsNoRghENesv5eWOGrEfmCd8NqBzay0tqHKrOxzoEQYdWrtTmqDIT6ww8uJUG0He5LpcG5BniQxvAJuUZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzN9LHPr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216426b0865so109436865ad.0;
        Tue, 21 Jan 2025 18:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737513516; x=1738118316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAhufiiGR7CriB+sy9/Z2V1HuRIBYKtABJeAY4r3KAw=;
        b=SzN9LHPrmQIf1VgoazqkaC2FSSsX/n+wL7USe42ramjeYvB2kKtqgGVmcsPQsOuuZr
         Mv8o3c+CDSogXh4j2q8ARV6USFlZ4LVTDUvclBzHNdvgscmRsNUGfZMIYjHzkNBL6f5m
         0CjGYaqiDBC0T5rdxA0j0HvGS0tdEab4YfDGWna94mUQuS+k1woP1+pkEVf7lVFkYajp
         P3nuQyBHk37FZ9ikjCxQNIadSRsmzSgIVRXbziXwl4tsRWHFIShx/a79W7dZyc8W3EyE
         C6ifLKaDTNkJX96mghAxuK3IJRwDk0UkrcWg8b+JWVk01n0YEP8vEmcqW/uKYqLPd9iW
         tCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737513516; x=1738118316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAhufiiGR7CriB+sy9/Z2V1HuRIBYKtABJeAY4r3KAw=;
        b=Q2F+mydINda1ldMfl0fIpzoPcriLrk/PzP/f29C8/+7Gt4r2vMtFQVkyZ530EDYDAD
         4hpO1AFkhqcNOJ989mrWPTOnkEvCmRpCwvjvojBJypELvpyR/C1JuJhs4hUKohoT/LTC
         qHZ2vu3cGKHcZ21jwiu766SPpJSxhls6Lu/W9L4L1ouUKyKRtxqCFLoHftW3lnEgZY60
         MZjUaGsIFsRv6uep8CigzXd7JLvWca10HtU/7JVoki1PEZkjh1DO50vRHUENFkIZh+AD
         U6WhnI+ad9aKo/KC+ht+hd0J8+w6gcGXD+TRhgqPIcMiFvd6z2tzAfjitQYNnZNHO/wz
         BxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAJsr39J0VAPzS/LaCLKoQESVuLqAUOQpLXLz491XhxjTC6Y677tCQ1MaNR8E5/0NeijAJWi6k@vger.kernel.org, AJvYcCWT8hI/GJFZRY23h/F27vgycQH1qbIO68wyIZKyolJvpg/065xEq0oNKgzho02j5I9eJ2KvyHGSNuoGTHQ=@vger.kernel.org, AJvYcCXtACey6j/HJiPinpKLLPO+8dfWoNNKz907DaF+0WxgOF774VBuAonh2qWgLEKjlCG3nujo0hF9@vger.kernel.org
X-Gm-Message-State: AOJu0YycYUHkgEoeb9SxwAoo70kozFCknRNOVsPZWg3LC2tpRAB+BM8G
	ZVnnNXXZDusfVdX36EpEOZk11rrlviugVSdIwu978Ybp2hNLCA4fC7m+sdkR
X-Gm-Gg: ASbGncv0fqjJVhkb+PSZKQ4u1t7MviLbdhJOa3lME/k6/7PnBFlwknYpfIEOTJMAj3s
	Yh1ZMTVaRGdjofpqWLH7LKYV1Jpg5Fqdphl1RbXJnf3y0HANVY6K7YRAiq71lnrU1Urjxd1S1BI
	ngOztJmGXLu68SGMSc+OeSB9eX6SpQRaYF+CDDVstKBQ7krF8ODlTHSMPovb8pRQ0dqrlYw7EuL
	0RJfsdBB5xqcYthd7Jv5W3hxW2q7nucvL/oAx4+xYw2qCc4G1lhxGJOMeli2b+0ZrKx/aEIuR+e
	n+RCp/M=
X-Google-Smtp-Source: AGHT+IHGPn147w3/rFjBtnjkpJY0nXFT4US9f3eEW4jMrB4pyDjS/mNOVUrl/OB6Y0LRpxSSrvXWkA==
X-Received: by 2002:a17:903:2291:b0:208:d856:dbb7 with SMTP id d9443c01a7336-21c355b7732mr272468795ad.39.1737513515967;
        Tue, 21 Jan 2025 18:38:35 -0800 (PST)
Received: from localhost.localdomain ([124.127.236.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac658sm83909695ad.127.2025.01.21.18.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 18:38:35 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	horms@kernel.org,
	kuba@kernel.org,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] atm/fore200e: Fix possible data race in fore200e_open()
Date: Wed, 22 Jan 2025 02:37:45 +0000
Message-Id: <20250122023745.584995-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect access to fore200e->available_cell_rate with rate_mtx lock to
prevent potential data race.

In this case, since the update depends on a prior read, a data race
could lead to a wrong fore200e.available_cell_rate value.

The field fore200e.available_cell_rate is generally protected by the lock
fore200e.rate_mtx when accessed. In all other read and write cases, this
field is consistently protected by the lock, except for this case and
during initialization.

This potential bug was detected by our experimental static analysis tool,
which analyzes locking APIs and paired functions to identify data races
and atomicity violations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* Added a description of the data race hazard in fore200e_open(), as
suggested by Jakub Kicinski and Simon Horman.
---
 drivers/atm/fore200e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 4fea1149e003..f62e38571440 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1374,7 +1374,9 @@ fore200e_open(struct atm_vcc *vcc)
 
 	vcc->dev_data = NULL;
 
+	mutex_lock(&fore200e->rate_mtx);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
+	mutex_unlock(&fore200e->rate_mtx);
 
 	kfree(fore200e_vcc);
 	return -EINVAL;
-- 
2.25.1


