Return-Path: <stable+bounces-165037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F56B148CC
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 08:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5393B5574
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43B261393;
	Tue, 29 Jul 2025 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPNvzcDV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21240264618;
	Tue, 29 Jul 2025 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772306; cv=none; b=kHrpAM1pr6RuVG4PHg4Cj3u/AHeqpFNG8yKlFKeirZV2LUI0L2biOjeBzkpkhmwiNo1/z7xW4niozI02gHh3+kEFGLiZ3WU/iWuqYTdBy6VWMv8SyCMJn7jljmqGf8Rk/nn/JOkkBi2SM8tm+pDORqgQDCfZzlWIOw5OHs8hBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772306; c=relaxed/simple;
	bh=mlmMgEfh2bkKR9XTtXRjKPGqNjMsU/YKMZ/tXSM73n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGSdoIt1E/ihkWOBX/GTYdDY4e2by3opmTnVpvGBI+hmjYMpZqZXz7E8/uafq7pfE4e5hy4esUqr0x/63Id+SvRQCH/wroV/XLB7bNYqM8fjK+RsYAJi3m6SsjyvENNRnYsCVl0KuVTkk5ndbuId34sq1UJF1lCLVtbk6mBjtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPNvzcDV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747e41d5469so5690558b3a.3;
        Mon, 28 Jul 2025 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772304; x=1754377104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB5hbfGJeZWgdm24Ji9lctZ84pTJVwDogFiXOJHzb4k=;
        b=NPNvzcDVPUUDdq17oPKHeBXHjlqr7MWENGLNl4ZFy2/vJTLhW1gxA/dStHOZsymcxX
         m7CgeGv9zZUR85liIdJUnFQEWBRsjsLr7JluEHLuew0IzivpNx1J0nKwDiRrg3/00isn
         KL1kjgXT5nemTVQWnKj+SLfSoqYU3AwVIyprDeXtUYqvmAJq1IHiONyJG41jt10QJtaD
         4B8XfG2/8gzkX9aUnB9YTToDpTinUMubgoo+p8kJkpI8GfoY/UWIWMYxYKoBqIY7d12s
         z0IcgAC7a4b2MjpsXD5Dx1UQ7M3aab/WPfUQHePyoktL8WNX0+JZmQNctFMEamE8ba6z
         niBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772304; x=1754377104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB5hbfGJeZWgdm24Ji9lctZ84pTJVwDogFiXOJHzb4k=;
        b=IeI+gzfZamqQlGfEzpDebJ4ptTvEdU3iUJJJhcErR9Q4IXPLNwj3aNfPigL8qRATfa
         DRzXHYb96E8zfklNTOyfzz750qWwz8x9uTOQCnMA352rT81LhUVzTNzaBDdmd3A/bx4l
         CgFI2HyST/qhLivgywir8UyPRdU1NEa3UpQ5O0Q08HTTWpKUqLZHRXzN+bErPS9yxmI8
         v22qIdUYrtIb1D5yqTqqvFfCgGKONKyIFr5fuh03GIQLCfnWTzD95lCPjtUCqphBbO7p
         s6WcBQlogm7ywkSHxtEq98IVrUkrmuhQ1r2oqMSF+3Z0SEF5UlrTpLrnEbJpaiXOukmn
         YLEA==
X-Forwarded-Encrypted: i=1; AJvYcCViYKxltYJfMROeLw9r6V8thtPRvfvy4KFTqVTr8tBgFEvMxd2UGNzleLsqNmj+ztN+SftI02UphmZhhBI=@vger.kernel.org, AJvYcCXrOAyq1zvY9frJzeH/6Aa5ZETCmzh/lHOZmlL/d2/2uOucXah6HJYorLcsMyqG9n2am/Bzeatw@vger.kernel.org
X-Gm-Message-State: AOJu0YyOA9WQgsvGaFlPCK2x59aN/KVWIxOSmg7Zg9vqqQAqLwv8MBIH
	Z1kn/xWIVVH/UWDo6+ahFvcXBvUHsK1gLdEPJlczy0ohBqvSmcYvTr5E
X-Gm-Gg: ASbGncso58v7uA+LUbTnrGfQpNHktCwBosRTQA9dkS12XvQswdZ8E57iTcPBeS/BjLo
	crOjJya8Fj4UHAIA97miS9UDToCos5/dD6vyf335yRBtdqmcYvChyAwUS2DWaN1N8SNLrRxC5HW
	y6rV29p0r7aFViERB1QFdnui0alPfzTMgFncQfSJg/Sk33CXoGC1ISyaivrla5in96DxfoLCZG1
	YiqmsiyXxfYQxkh9Il9HxLx5uMLDPi46LoTNBBLJIK70quIV/Cux/tD1f5+psY+FAs/IV6pJ7cs
	vDJJTGfxWh7K4/2mOyuJwLM560oznb7BdFNXQNT1q6VN4kOeWRDikC9/MP2obIpEMZWolr3xaqd
	6e9G0dy6lqNzLZqIt92UGimgaBchQXQ==
X-Google-Smtp-Source: AGHT+IEp2B5xYEjinFzGyWbcr+vEjXOY8+csoNqhewQ/2XSCpFas8HrQzNZAG4+o+llAcRo/gNKzjQ==
X-Received: by 2002:a05:6a21:70c8:b0:21e:f2b5:30de with SMTP id adf61e73a8af0-23d700afbc9mr22847024637.12.1753772304372;
        Mon, 28 Jul 2025 23:58:24 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:c998:3a8e:c481:6cd7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b420df76dd8sm758066a12.19.2025.07.28.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:58:24 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	stable@vger.kernel.org
Subject: [PATCH V3 3/3] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
Date: Tue, 29 Jul 2025 14:58:06 +0800
Message-ID: <20250729065806.423902-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729065806.423902-1-victorshihgli@gmail.com>
References: <20250729065806.423902-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-pci-gli.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 436f0460222f..3a1de477e9af 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1782,6 +1782,9 @@ static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.43.0


