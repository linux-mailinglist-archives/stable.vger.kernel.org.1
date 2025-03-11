Return-Path: <stable+bounces-123161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD4A5BA82
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C433A5E9B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 08:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97882224226;
	Tue, 11 Mar 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU3iRlm2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1352222C9
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680610; cv=none; b=CZebJKAc/AJqGMU+pPKiCATn8jwW6uDadWmWFrcUS5cPN9vGVKM0a0wmHOJ6HEYQpP+vFRkWZDs1+NrQ42sBMdniuIq0vDiMWz+ud8yKmj8c3ZCMjXxi6CZ5+N/DH2MM5Ccdri6rvk2fhfNpGAk90TljktnV1XTCEDxeQfhkx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680610; c=relaxed/simple;
	bh=tsqkyZE3LddBBXuHc5mfVK18DwXWho3aEpGJHcCNMPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgFLYL6tNzeHnZH11hmvXZM4voR0RTwQjHsOb82+crGM3eUqHMQl5W2nLywmZFXL4aW/raXNrjuM2zW+g/07mwIDzO7EoZTGf3QkEhzp5jkb+9WTsjkd4P/BZYKmShYdGYbLYsYQJvjFu7jvOzQpEO4ctX16eIDgBkbIxuQcD6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU3iRlm2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2243803b776so88368085ad.0
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680608; x=1742285408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enPNLG544XWvC17NxEgHsU0GcVw/OG88mo3GkL0GZx0=;
        b=XU3iRlm2fu6DqyoI7RDtjQl2hNQG1f+qwoTzdEEnEy4iDBis7xclnm645h7VBVr4bI
         WFv/p5lkTauqY2w+6WC3wrv1jSrtzsYE8E//GNx6q59xdpWT+5Q3QmRzSqZq/YpxMpUr
         fNQ3Aa921KMlFZaFufv+9fMI0v6BI8mlkAK336SbDNKPR5ukfk+bPy2giWeNVECfeqW6
         Z35QYzj2MqjUpo4BhI1cDqV5W/dsP2UOS67bfrFiEHf4tvLSfOI2WznpgwBxyh0yQ0CT
         EpAHWSrRZj7GJJKm7yM+ISuP4dbpYadOVbg/5obDODAk9T//nkLyROAvs23bl1KxAsku
         juYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680608; x=1742285408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enPNLG544XWvC17NxEgHsU0GcVw/OG88mo3GkL0GZx0=;
        b=Wl/GVqSFp9kyZOmwuVChr3pHmd80oZ0bsmj99sQGrUau23+Y0dW05zLK9mIeFTUeBr
         1yjJrptGjQgxpbweA0l8b6egiz7PG38bt/QIWkEh14J7xJDYlQjEfC8T/LFZomE6WbE0
         edbdFs/vXUZCY4ygghk8dlThLDhYhOBuerGKOvCzPeV+QZp9+SSSbrSRAxZBX3A70BTF
         2erEB8l4rzBbAbkbIpxbZ34oFdUE8HYBiIcxwVeGzeF/72f3VCXvC/sHKKqrRe2ZMbtw
         o568HkPZJTCtsWW3aVWQQ/iDoR+IkA9wqD81N9BbUtqtcussAfdugoB2KxJgL1y+53wN
         FOqg==
X-Gm-Message-State: AOJu0Yx5n2XGlR8b5f+FWoKp1cga4RB4xCGdlbzlfvdl+XWE5bLsjhFp
	IsaQsgNEbyWWy1IsnpuRBOIXrYq0wKGlpIdFRDKoRPqORDRVwwNmEhZARGwx
X-Gm-Gg: ASbGncvHGH0xyIwWINu+KSVmGeQ32h8cRtwXf5pb2NFfnC1tt7bRP+gznMjrIONvS4I
	pS294rK221U//tlqrRdANIe4p0fvZjmcYV2udERc7D1XgJIJI5nnLuewRVK2Rs+t1u5BN+NcyML
	8nhH+fp/e3J+Tj5G6ot+VHIlw9XQAbps8LP/yvarXALkac0soJpkJL3H9gDTKAfMeN5fK0Ke1I/
	4isG4K98k/FGNEkvE58a0bOBWy6SdpA+c1Y0s2nRqMyYRM5NDnSSDpxzrlolAi7+zQkITY5nuHj
	zq9A6VHr6zSopxP9zUebRQdd/8tr2RGrXObKzOlzYeOHVcsMI018pVeKUbfaZBXwbNvrylqw+D5
	AEfVBWqDCWEDHhePTjcs=
X-Google-Smtp-Source: AGHT+IFu2N0QHnUkqvNXNyKBHW2uaWse5GwPX01gzi/w9B0VPmxIC/5Ki3kjwWwBFS6kEPK3Kus8RQ==
X-Received: by 2002:a05:6a00:1817:b0:736:3c2b:c38e with SMTP id d2e1a72fcca58-736aa9f1fefmr23312614b3a.13.1741680607751;
        Tue, 11 Mar 2025 01:10:07 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-736aa133828sm8191037b3a.1.2025.03.11.01.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:10:07 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	zenmchen@gmail.com
Subject: [PATCH 6.6.y 2/2] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Tue, 11 Mar 2025 16:10:01 +0800
Message-ID: <20250311081001.1394-3-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311081001.1394-1-zenmchen@gmail.com>
References: <20250311081001.1394-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9c1df813e08832c3836c254bc8a2f83ff22dbc06 ]

The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
going down, clear this bit to prevent waking up host unexpectedly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241111063835.15454-1-pkshih@realtek.com
[ Zenm: minor fix to make it apply on 6.6.y ]
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 658ab61e3..1edbe202a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2482,6 +2482,8 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 
+	rtw89_pci_power_wake(rtwdev, false);
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);
-- 
2.48.1


