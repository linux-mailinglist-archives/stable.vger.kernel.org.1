Return-Path: <stable+bounces-127336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768F6A77D01
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F26188BD66
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6B204696;
	Tue,  1 Apr 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7yfZrBB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876A4501A;
	Tue,  1 Apr 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515914; cv=none; b=fwPryB/Y76hJ1vrzsuNnx1+wJ12aNNnaOwrLR4XcaLWGS2M6UIwrECuLjJOz2aZikSjkUmRpZ9KPBzSMwj8/+3K1FmBAThWFjT4Io9doWfnrnsiJthH8gLGUxuPsIzMy1VToGmgeA24QkHvDavYrfnI/7/z/bXy8jloSnfEI/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515914; c=relaxed/simple;
	bh=Ik9ndR1ZOthTt3RPFJbayzRDoWqFGAwHZ4LyIzPoYyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NBhlg1iyrII4+++qTg9RuE73Dk2wA9fpECEoT4bLb7VdH0IissczzIaJW+xzAP2VSx4W+x6ZrgzczCWBocyQQ/YOuICFf9Cwm5XU93ATNOVzYqo44dyDMF4BoK058Dw7zlWTswLBR0gCEvAvCWD2Hn7DkDPMDvL9j5J61ljgJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7yfZrBB; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-224341bbc1dso93898085ad.3;
        Tue, 01 Apr 2025 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743515912; x=1744120712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gvs23NKWJWpxifCmG2JMMd+dceGohlJ1NYBE+YufBB0=;
        b=K7yfZrBBp8X10Vr+cBlTDZfQF+XKB2OsZlrCLko6NBkPoAVn2yfVMBg6UVexnZhp0T
         RsykDtyepGNgHsVUTpo93WkFGuwA7E8dEMUlLaDbCQBHxEqO8sonQVCJFrukml8ul0W7
         fUyOw+JcYN1wwji+oiIIkY8dsQcPzoPvIycNU9vsde0BhHC1LdVmYcJMj/Hn1OYOczMT
         +7wIEuaJvRA7DXm9shnX+4tvWuya5GOX5m8tWXSBSMGoi/GoGtn54y2cT6w24LiCRwd4
         Ae4Ser3VTkgIHoioNhi9f4dkgS9lYZFSbqOR3k68MSZYXPKCzv7wKlj4nAM3kc14em1C
         2Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515912; x=1744120712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvs23NKWJWpxifCmG2JMMd+dceGohlJ1NYBE+YufBB0=;
        b=JPb/QszxwP+OC000xhOxSJfQogZsCiCTaXbB1+nifKl/8lr4y9Z9ruBEkI3JGMsa2d
         JvYWqeb9pALzOXyFSrtm/e77khwNkm5Bv3hLQZ1Ec8bOndIwqwWY3kk8oh3BxkKm065e
         W36/wknor2nFUPw6RI7KGu44i7x+GwkK0PHTDZx6grN8Rcp1bPKuDu4rLQSKGBCVLf29
         GqIl3u55srB0hnt+5HptwGKjgZPrn/5/aT1R7CIqwnuiKgWaK89y/uhS0fQ0wRMLo/Dj
         Ljdx1b1XDVi3nv2sI7LvtefbA4lbEhaEOZG+deuotcA3OpaBHDaG+6V477fLKhG4YDrb
         RONg==
X-Forwarded-Encrypted: i=1; AJvYcCU7quvZ+eaMRXxRcmcIDBb7H3OvLCnWepePX5eMMbm/YPnC5M/D/fFbx2z9fpg6E27mHWCRqTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJX61zPZzfV8EJuan2m1MBj1iRLkFCPVG8FpntqEth6WMvcJm1
	bNhH9Tu+b0kX7ta07XOca9z/b1Annu1jOW6gafK59D1ZEiQpRwcH
X-Gm-Gg: ASbGncuMQ/VeVDWGguXt3KeOFKkDSyHIX9AE0XqRzuhco76iYi921CXNBt5V42eaRoI
	g4uSQLrgXYlpgG0tKBIz3eI2cEihLvCOMr/h89nZfqVYk2fiqZzH/vUr91WfBnb9uTldVcGpA48
	omEk8jNQwtzBe21du1nOYuaXzP50dyKI4+D60nTYmvsGOEWp4KL64TCxu+YlgZnQJhSXWZJJMJ0
	9sWFKGxnBvyDqZUC7ARCf3CCxSHtxUJ1ZEcwHylc5OAdwygCpwucqwdmKVOXuy7muJp7d6mOf+p
	ThKBfliSL6/PfnuyRTLBT2YOmwS0lIkD1lAjQ5Cl9aGw53l6M19i0YMlu4OXEx+eiuWLQGHBp1m
	X5BJv0w==
X-Google-Smtp-Source: AGHT+IFe5huXyqUWJr2X0qS753K3KbtPpTRYhcHoKF9r1UMNQ7vm5c8wsTWP9penkOThrq06D6mW9Q==
X-Received: by 2002:a05:6a00:ac3:b0:736:5544:7ad7 with SMTP id d2e1a72fcca58-739803c0672mr15923478b3a.14.1743515912195;
        Tue, 01 Apr 2025 06:58:32 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e1d922sm8923850b3a.37.2025.04.01.06.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:58:31 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] misc: tps6594-pfsm: Add NULL check in tps6594_pfsm_probe()
Date: Tue,  1 Apr 2025 21:58:25 +0800
Message-Id: <20250401135825.28694-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
tps6594_pfsm_probe() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Cc: stable@vger.kernel.org # 6.5+
Fixes: a0df3ef087f8 ("misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add Cc stable line.

 drivers/misc/tps6594-pfsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 0a24ce44cc37..0d9dad20b6ae 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -281,6 +281,8 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
 	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
 					    tps->chip_id, tps->reg);
+	if (!pfsm->miscdev.name)
+		return -ENOMEM;
 	pfsm->miscdev.fops = &tps6594_pfsm_fops;
 	pfsm->miscdev.parent = dev->parent;
 	pfsm->chip_id = tps->chip_id;
-- 
2.34.1


