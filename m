Return-Path: <stable+bounces-163575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC48B0C3A5
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E992D7B466B
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940A29B79B;
	Mon, 21 Jul 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="ZQuTodb3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC82BE65B
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098573; cv=none; b=cmBlDO9GjNguOPPu/sDCQr9yYF2rMT+/i+9RRteo/qGSPrHH9F7tTxRZEb+heCnjPhuSzXujPv22tjyVbnZjXPkr4JSdqWLd38/74jNjtb8d5lD4+JZBMyqGT4f7348MeR8o/rp1fAjGhMze9idLdI1Dxoa9DplCRcqSo0AqPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098573; c=relaxed/simple;
	bh=lqI/PHLTX9DBjZMi6VlRLk3zEu+C3OA1KEpKeMH4aKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFaxJku95mFV4s6r3H1jcrJ/ANuvBnGXo0Qq2jj2MD6LrnVS7TirHWhf/IOtOaqxi3bdJM9XXXaLxmysNstHDuTSRz/HM6uTc4pErJs9i9HL/uOfVSVg6kAz2Xro7PP+6l0F7Qt5wnzGVnTXPn7fkgCWKV3mKVXDePbKiJ80EGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=ZQuTodb3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31d4886c50so587730a12.2
        for <stable@vger.kernel.org>; Mon, 21 Jul 2025 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753098570; x=1753703370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yvtLcNBOnl+JSIe0Q8HKwd4SNdxOK6d1iOjvb09Vgs=;
        b=ZQuTodb3g5RSoIbfHpU7NPq1eEUraRBlc0jI1UOMZ+TY8cMChyhI4++7OlOUT7sdei
         YPU39ZXUgFvZhW8QV+gnURjYD0woQ8nV4DPsMBEgHWyiMHUG3Fn5SJYfPjpeZSLdEY2+
         Efyqz+GxDVxDKcQ3It2lLL3d9bYqw4FMvW0e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098570; x=1753703370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yvtLcNBOnl+JSIe0Q8HKwd4SNdxOK6d1iOjvb09Vgs=;
        b=t0a8NWHkpi8np4yqTFDvexH3GtIfvP6ieH/f0lXoMMm+V3hp4Namxu4ksaOZzeRr3z
         C7u6kt16VdmtXQmE4oZD4mZkx3nBMpzw6EjLUh5+WCATsclHb5GsZRNEzAEaK9gfi/MB
         HnqBXOev3i24OVsPFCbU6U5NoIoolhXj9S3A/JsZYaEyg9nQEfOWy4Yrs3TSYgqyuh/2
         Tvy5bKFsh4i4TqKtwB6xiRMKwLg2OCQPymkuqmE7aJm3+ToMDGnvy15WAekOKvGPfYiR
         9xPVfqmZ1iiq95ERpvEdlZb1X3QelYo1b+kBO3WkmZKeaPZjNwDM86KwV/Gq2gmpOYdB
         KKKQ==
X-Gm-Message-State: AOJu0YzRY4sFSrM7mcr3SswCptJ9T34ZkRADRWNIhSQkXUcqxBlCamDx
	JU2vnPNPx5DxIq6NM8AKwJWJ8bJ/VXadGfdHRd09t+z4kT7r/V5i8EMj9h8gDY0JUq1I4VOS8XS
	spvW0BMo=
X-Gm-Gg: ASbGncuXzb9Pms5HUO7N5CepaqjsJ/sG6WhBOUuJJC94Yw3aISXCkJKofbYVk3onwhe
	jrHpqmOx7z3kMgVu8dAVUFvCanw6df5HwZFwi/CZcJ8nrMwHAt6fPeyiKoVXLuUh0PRBIpXOzIL
	TQI1qUEoHu8bS02c44kY0KqQz9Fd5q6LbgXzjz6DFtPBeCUts3IYL9Gh+lLV+HnAzYQjgMUKxTO
	sVtMQSzzkJ0S1W1buu2PCH2IbhS3B6P5kiV+PbjkNTEC7m9R7x4sVJxoHHRu+/VfVQ1yLG6q4e3
	ZLG+1VU65odyqOAuhHyx1drNLrGlo6jMzSclyUrevddkVK0TtiPwthAuju/RiWFVr+B1o7ICBbh
	bRXrRm2Ci2klZvjNAyqgKCGkLYeTm1heuMg==
X-Google-Smtp-Source: AGHT+IFYcfgmWfWxEzNAeoUEcLWyJPQ2AppgRhZoUROwsSu7hYiatnXhmvnlfQjq78ZNw37YwPFxtQ==
X-Received: by 2002:a05:6a00:3203:b0:739:b1df:2bf1 with SMTP id d2e1a72fcca58-756ea3c8d5emr8385244b3a.5.1753098570489;
        Mon, 21 Jul 2025 04:49:30 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d5d8sm5572140b3a.112.2025.07.21.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:49:30 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: Zheng Wang <zyytlz.wz@163.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 3/3] power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition
Date: Mon, 21 Jul 2025 17:18:46 +0530
Message-Id: <20250721114846.1360952-4-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721114846.1360952-1-skulkarni@mvista.com>
References: <20250721114846.1360952-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 47c29d69212911f50bdcdd0564b5999a559010d4 ]

In bq24190_probe, &bdi->input_current_limit_work is bound
with bq24190_input_current_limit_work. When external power
changed, it will call bq24190_charger_external_power_changed
 to start the work.

If we remove the module which will call bq24190_remove to make
cleanup, there may be a unfinished work. The possible
sequence is as follows:

CPU0                  CPUc1

                    |bq24190_input_current_limit_work
bq24190_remove      |
power_supply_unregister  |
device_unregister   |
power_supply_dev_release|
kfree(psy)          |
                    |
                    | power_supply_get_property_from_supplier
                    |   //use

Fix it by finishing the work before cleanup in the bq24190_remove

Fixes: 97774672573a ("power_supply: Initialize changed_work before calling device_add")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 drivers/power/supply/bq24190_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 0107b43ff554..34f570ccbe47 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1845,6 +1845,7 @@ static int bq24190_remove(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
+	cancel_delayed_work_sync(&bdi->input_current_limit_work);
 	error = pm_runtime_resume_and_get(bdi->dev);
 	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-- 
2.25.1


