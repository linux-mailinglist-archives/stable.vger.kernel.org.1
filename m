Return-Path: <stable+bounces-158966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E51AEE0B4
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C553BE2B8
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79AC28C03A;
	Mon, 30 Jun 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQR2JhBC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD828C01F
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293678; cv=none; b=lVnu8rCFDw/2q4/X28MO3c72mFS0B5Im65y0tLWKTTo+ofHyi7MBb/XafYcJJje4l6LqfJz4vY+v+nMNVZ7kryYMQBpI960Zi2DCNyHJ2ECkdHYdKfOrImXvBMvip/yDqVxLSbvas9xQ7EuW+OB/wssWuc2TyuLAjhIYXAIPNkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293678; c=relaxed/simple;
	bh=gly0PCtPwveidC+ER35+ivq+EkwIMB7MBb3W80XgfGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq7jcvOD3t1uXS4Bi/Nr2SlerX/I5YBOcvjACTNBiVzqviiAdgmZM81KdaRsPMmABSYfN5Xqr5qNgqc0IH5FVaMi7659hi8bz1mkuvkYXGK4vBhri3rhvyrGmUu836RDE/vQiW4//I73IcUplCXkfkJ37ySnGPXroDgnuxi2FjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQR2JhBC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a52874d593so1880332f8f.0
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751293675; x=1751898475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffzs1nNIZxsl2kAngtgFFQfwzAjvO6uElPlG6BLds0M=;
        b=LQR2JhBC+MPc2zr9A2I8s9yWqxraHOK/Dht7VHmXWD9wjI0RWw43ZYg1nzJ9aUgIIx
         KqdMV6z3fcCQLUaM8U40MP31G4Gbfl6+Mxfx7C6lrsIMkvXu8JZ97eUsDDtf6w+qg3l4
         2umU2E1H44IqYZlbe9GesVReek1yU24Bz+VP6X6+Heyrymlqy/wSPKaZjcrg7yKvB7Sr
         FbwnoGZvPuXL6yVSCNtywAe4t/KPymUkCMPYbS0BMCx3jhR6wCwUp5LAJ67HOTG/kyPf
         IXoUKiZNN+OaUI0rFnJrrC8GGGWdySlhFhnQd7LcMZ1Clmo4ymxWHDlaaMwD9c4VhAz3
         cswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293675; x=1751898475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffzs1nNIZxsl2kAngtgFFQfwzAjvO6uElPlG6BLds0M=;
        b=iQIOYP1nry2yiPkioLTCjPGkB/TFatzyryoxZN0wTG6tQHxs+Is+oy8qsdhKdUNB1G
         Obz0btVGbdpqlXv4QjqFey4prgNPUvULUpva127zCx+DUsV4JSa+0Vlf8O1hFmrlTtie
         Ks25NAyOpf9HQnV96R8I9oKppmCI2UJoiwLpMlH5n4gjgmsA9Yvftz0firubJR5LvLmm
         e766j2D3f2UpJ3qi14rfLFAdBMnqe0zId0NMJE3m8PJjvcg5Y6rOT65rOHv9GjrRDTdn
         K1opV4f+ViKLbP77WE74QFiKmsZKSizL2mhMnexSUHJmhfpWe1GJcYSQvWVfUP1QnFJ5
         GR8Q==
X-Gm-Message-State: AOJu0Yz/9EETwWQUKTqv90HxbjmcbSBCmRaos6rktOhfbVDe+eMu2kKS
	Z7ge3yrc6NG6cYNRz80gQsUlquzLCA82GrC/zkG1gBX19IyptDEUY4uo0U1w8/xV
X-Gm-Gg: ASbGncvtVGhMNNnXK1mvf5LqUvmBFIBTnmJZVLp+72ivsjvzQl+CBHIy3pWmCzgLCWi
	dh4xQyhg2uQl3r3Zln2pjG9+0i2PPWcqwtNIoU68PVjULWG1ahHar8DTillIJ+OnEWiYqenY5iy
	81OrSbQxfina4m/olhebbYLpCL42N+vVXgTjH1UlHof1SDlnd344BI5O+8jB/HRSgHGobvDFWqD
	hdLE6RISb1GzJQ07eH7cm4oEV7SlA/+0I9erPJ0/2Rh6yBWXkSAY+4jClOrMjCV7tltyy72fuaq
	roxkaQAI2X8ngMu/j9wNhQAfJkcnYDpofBiLZAfJD1ZBrwzN+Krjr+W+Xv34M6XcyzKwpztW90A
	BtOrQ7S8k+zc=
X-Google-Smtp-Source: AGHT+IGxwXbGsGN9wj1rkY4zZuMs25dU0GGheFS1GeV8VqvEPRN17TsRq8YlsMWYwWbKt77z/HRXIw==
X-Received: by 2002:a05:6000:25ca:b0:3a4:f744:e00e with SMTP id ffacd0b85a97d-3a8f4548f84mr11783461f8f.4.1751293674608;
        Mon, 30 Jun 2025 07:27:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm165871905e9.10.2025.06.30.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:27:54 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 6.12.y 3/3] net: phy: realtek: add RTL8125D-internal PHY
Date: Mon, 30 Jun 2025 16:27:16 +0200
Message-ID: <20250630142717.70619-4-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630142717.70619-1-mathieu.tortuyaux@gmail.com>
References: <20250630142717.70619-1-mathieu.tortuyaux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 8989bad541133c43550bff2b80edbe37b8fb9659 upstream.

The first boards show up with Realtek's RTL8125D. This MAC/PHY chip
comes with an integrated 2.5Gbps PHY with ID 0x001cc841. It's not
clear yet whether there's an external version of this PHY and how
Realtek calls it, therefore use the numeric id for now.

Link: https://lore.kernel.org/netdev/2ada65e1-5dfa-456c-9334-2bc51272e9da@gmail.com/T/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7d2924de-053b-44d2-a479-870dc3878170@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 830a0d337de5..8ce5705af69c 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1114,6 +1114,7 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 	case RTL_GENERIC_PHYID:
 	case RTL_8221B:
 	case RTL_8251B:
+	case 0x001cc841:
 		break;
 	default:
 		return false;
-- 
2.49.0


