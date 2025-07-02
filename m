Return-Path: <stable+bounces-159223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2853AF11E0
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D424A307F
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2340825487B;
	Wed,  2 Jul 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox/Qtwpp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A224BBFD
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452115; cv=none; b=khsN99ACk4llZbWDr9XDXDPREAqSeN2WFYHceJdD9ZGsTMp+OdxmfS7eK6gyzmMRCTYiLScXp/TxA8mTAyu867QutxVj6gOWTWeL/XQjZT1ia8FqeZhGQzyYi4mrjeVYQx8/c8J5jlikFyOb3DlZqnl2pHc4bUvTmSU//Nohf+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452115; c=relaxed/simple;
	bh=+QVotqdwA70sgRW5ax4MbfUA9kJCetvcQw3WKt8aCrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueMgEHdCSAPxnjXRjp7+xUdxKV3iPNQtDxatgIfW2+FwL68jUBP200pqnrPv26li/FHntW3rVNX5Yw8jfDozl4PIkYX/XaG/YXTTTyruKomsijaduNT05KWBElN8WdITMaVX0WjivDynlgYbVxYMP2TvIJ02uMyfozu8lmumVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox/Qtwpp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453426170b6so40199675e9.1
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751452112; x=1752056912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPNz/NmzAd54ABa83+86c4tijpK5324PryNPOQHPrzE=;
        b=Ox/Qtwppzpc0E1dLevFw5Kabewil+a6MdfjaElHKXXX6qs/8FMZH1r5nae9YIjmpJ2
         6T5lN1PTUO2WblxyXdjKBEUi1mXtlbbwXCB2JUb0gPli2eKYEeWiBss3Wvg6r54ePdCY
         uV9xPcOClU0ucXmgBVMWD6sEg0ElpQ7tjBbe9TP7BWNDdS0E5zjx2qy+MNiIuaGM9Ucc
         37s5vjq57fpNq9xg8gtB3VwDx2XAhccgIaZ569eYPrJ0rKvS0V2PvPGKAOb0v9sHPTlw
         LeDCLfZVayZF70o1qUeN5+9aKxQbc6dWvX0cPcepAt3s6LvSjqvQPLIXrUZtMF7U4sll
         i5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452112; x=1752056912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPNz/NmzAd54ABa83+86c4tijpK5324PryNPOQHPrzE=;
        b=hanwL1nyEW/Swp7h5FILsQRSwYRC2FoCnxpCrQWcqBY3jkWSKcfdfOfP2AauNccldT
         lBZTQNvbClkuTE9tJGBpw9hWN232NBrzGx50iDIErrgfDLd/qShDhxHrFkcqTnY4e3NO
         xwvPClkEyBFoBOQwBFJAi1mtEtAa95T5M4SbUvkJYpHkF5kZm2fbkd3pHirHyWLoFNNm
         bzunHz9QLMAKMHBwsMJVK5J9auP2JmPxW1Gy9NOwFPBUo5/9WZ//Ab+nr748FyKLDu7+
         rWMyLYCk5lxplR4CwO/F7zHDg6qgkkuiSocCL6VltyWz6TRAsl1B5dN+PCFMzW+3x18o
         Ul/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtqxz4S+a/RvRPws5BDB07YvoU//k7kMl43WdP4HxEY45E840DNOFkX+ZhPfdGgjL0jVK3XOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8E/ga78/ZhWhIhixh/HfrpZVA8ah7NlyANSlm3N5PYeHm9T8F
	WpaJUPrFHIBUUBlMAdGRcn5jz08J6Mfi3Jaq/KQ97dWk0VCMCqEkRApx
X-Gm-Gg: ASbGncvlLfSk0+5SmmyL7l81VAMmnvM38eumYf9zheOo9+WA0tYFeWj6ujyC9AzY4+k
	MJFXCYhMk7mqYE6VmnJ1Y/pxE2Qhp3mINqSheogUFwHL0uRNZ6ls0EUKCXT46tFW6YwaQhotmQZ
	6wYZpGwsdH0DcjwH9LNVB03p2afmCF1H12HSppXssL8xeYz983e/3ewKGTW+BLWAUvPP+J8Z2ua
	L3KUJsDOKu+GSTHVdYL+VmJiqIY1N6V6puHKYQqNyG/sqIiN1YPloj0/k1Ydp3zxF/ZNM6Q7Qs6
	nVvB82mvBjOpakSsGekNMGsLuoN/Tn5V+/C12fznMDUZczyz8ih+u/S3qKqMTrkLHNiIvbv2mwz
	MY4qNS/a+B9k=
X-Google-Smtp-Source: AGHT+IGxVQ3NCI4DhE6Gvgaj9+IPimfTEDulKkK/vpBGfx2lFv8OGYl5F9/Lsj0d41241QHQoR26Xg==
X-Received: by 2002:a05:600c:a10a:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-454a3c61a24mr13649665e9.15.1751452112296;
        Wed, 02 Jul 2025 03:28:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm224443185e9.20.2025.07.02.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:28:31 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: gregkh@linuxfoundation.org
Cc: mathieu.tortuyaux@gmail.com,
	mtortuyaux@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y v2 0/3] r8169: add support for RTL8125D
Date: Wed,  2 Jul 2025 12:28:04 +0200
Message-ID: <20250702102807.29282-1-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025070224-plethora-thread-8ef2@gregkh>
References: <2025070224-plethora-thread-8ef2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Tortuyaux <mtortuyaux@microsoft.com>

Hi,

> You did not sign off on any of these patches that you forwarded on :(

Thanks for the feedback, this is now done. I am sorry about that.

Have a great day,

Mathieu (@tormath1)

Heiner Kallweit (3):
  r8169: add support for RTL8125D
  net: phy: realtek: merge the drivers for internal NBase-T PHY's
  net: phy: realtek: add RTL8125D-internal PHY

 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++---
 .../net/ethernet/realtek/r8169_phy_config.c   | 10 ++++
 drivers/net/phy/realtek.c                     | 54 +++++++++++++++----
 4 files changed, 71 insertions(+), 17 deletions(-)

-- 
2.49.0


