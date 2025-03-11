Return-Path: <stable+bounces-123159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A665A5BA80
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 09:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4D016E3F4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD252236E9;
	Tue, 11 Mar 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brXPd3xr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751991DE894
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680608; cv=none; b=G5HrHqkKPGDbBLTyPmvpVoupUBL6kkdoxyAtrXbnHnj1zKIFbcloYX18hrCKAS/QT9N3S9IJQcUerUTIWAn/PWK7DNfNF6SF3z83+laGr/ZDxlX5Nm/EydvrsnJ3YKW+RvtkwOVBS+CskItr5yf1PgiXZlJBeLcmQaeiB46cGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680608; c=relaxed/simple;
	bh=n5lmS4dNGdR+8PNLTkcWnTQWS1GYb50JQ39XlJGyGCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHkOnuBHyhwhIoUIgMaO8N94dF+N7wDyTJTDWD5CvljbyBKQDqpUgJiFyoIevLifn12WzvLEyMEnuikt6zSjsR5AaJRc9IsH+gAiBmBmmKq8krhJPv8RTtWYtJI/Q2aNQGhkv1NqcFKp9KaZS+EDQWYMkNWAg1/MR9Uw925EQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brXPd3xr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225477548e1so48223455ad.0
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 01:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680605; x=1742285405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzNKJisubxdQMe+7LzC3qhX2jQdiHQ9nWrcRZ3uxBj8=;
        b=brXPd3xrwLuEtfCUaG0xNvhOfBxHLASK4z8CYBjwm8+w+YfKR7noV2kL+oTxAITA6F
         8A9sFjoxecHlmjzgATYMPGWHnj28UtCUJ6zDYCLLFScy2KgUSPItZbNVeCzTG0wneLVx
         px4QBlN4A7Zc8rAT6/XSCn7feShMfv3EGVHQyNju+Xkd8H6x6EFBR9FOSwi0f0oK7232
         1qV6mvBwJcun+D1v2f8sS79kMM/01KdLkvSjktYkBjNN3/6DttaIOGNKwBTVfnGuOqup
         cJnNkUpN8q/siHG5pjZwVGqLWpw+0W/OmvffTTIKkL1Dt43qcCcj4mKEAkAYEG3Xa8x4
         gv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680605; x=1742285405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzNKJisubxdQMe+7LzC3qhX2jQdiHQ9nWrcRZ3uxBj8=;
        b=Bc3Y6LRFO9c+mH3ZDmw/S6Jls55I+/VCUX9q1lS8I+iFK1d17AtNRfYzHtDcajvf0Z
         ae8nQD908KTOaHj4yNgztGqqNOEdIgJNxnJJaOL2F6XLteHdddoHhLWcJPMEIXEK+GPi
         k8lWFLpGczOdfeaLJU8KEBRQ3sRQSwiCDUaQ67LhgRA60JCfePDzvXCi/7kococ8yCI+
         FWAHZ89X9VihfYvkaRejpP5RtCRBJlE0uPuGPkvPk1+d6yqzeZq4gRTrtc/D50pChRvn
         ip10uUIcd7jlqXUkvS0blruiMK6BHTYLZIVIHVDsNcuiARNJ+LzFtpA6k83UXowFh4s6
         OA6A==
X-Gm-Message-State: AOJu0YwNmKOwVnrnOt3xnm+/q/9jglZ6VeRvIR0I7dP5aBnngQ6DC/sZ
	E34hUYvY+rfQKlj3niC9kNc/wyKzeUg+h6S8OR7wUqSdPnKBqijbKiVU+iMp
X-Gm-Gg: ASbGncuMz+SccFoYfblVrZ2XNZ34sfGK1H3N+cj8yDOgxEF0yJF0UZ3EAy7rmIuF/ER
	lRA30OqafG9zA3Mr1CU++c6cUBp8boDeUvt+Qjgz9QsriMJReYCaSOAc0UkXMR39udbCEEtyWsk
	tMN+2Xt4MY/bG8X7Jtx6NSRG1eiQeTV1lcj0Yfq4qs2VNnlLDmPHPj/CXTizNjBBCkbyiB63/Vl
	a8jM/UYoYeZ9piXIxJMjxBCtwnffPq/X/9FbDmUimNQJCMujnrUu2V4YYmo9JrKXXmtMlk4N7iq
	eJoSNLmR9ZqtVvMQkjbHZcgN0Yoe0KkOKrciNRSBjSlJho05L/uc9rIrUdhcFapy9afXrFAf2uo
	EmdgeRxKTwktAlPHzhf4=
X-Google-Smtp-Source: AGHT+IFx+KYfxjj8/hU/9yGCYMMD3qIeIojLwDzhlVBiYz87k7y/IYqnq+QSDUWHq97SR4hLy1mytw==
X-Received: by 2002:a05:6a00:174b:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-736aaa1cfaamr24292557b3a.7.1741680605262;
        Tue, 11 Mar 2025 01:10:05 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-736aa133828sm8191037b3a.1.2025.03.11.01.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:10:04 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	zenmchen@gmail.com
Subject: [PATCH 6.6.y 0/2] wifi: rtw89: RTL8852BE: Fix the shutdown issue
Date: Tue, 11 Mar 2025 16:09:59 +0800
Message-ID: <20250311081001.1394-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses a shutdown issue reported in [1].

This problem has been fixed on kernel 6.12 and later, kernel 6.6 is 
the last kernel these upstream patches should go to because the Realtek 
RTL8852BE chip supported by kernel since v6.2 is the only chip known to 
have this problem.

[1] https://github.com/lwfinger/rtw89/issues/372

Zenm Chen (2):
  wifi: rtw89: pci: add pre_deinit to be called after probe complete
  wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit

 drivers/net/wireless/realtek/rtw89/core.c |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h |  6 ++++++
 drivers/net/wireless/realtek/rtw89/pci.c  | 10 ++++++++++
 3 files changed, 18 insertions(+)

-- 
2.48.1


