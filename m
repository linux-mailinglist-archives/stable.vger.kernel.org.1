Return-Path: <stable+bounces-35551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB378894CB7
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 09:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD001F223AE
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF53BBC3;
	Tue,  2 Apr 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feOc3UGH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FB2BD1C;
	Tue,  2 Apr 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043394; cv=none; b=Qly2A858kZ98LARLN2h47sxIIyjAHqmzpvNJAWVEiX1Yh0BU6NpEqLKpA7FQgFG2nfETFsihifM5Vo4SsNw/7iY2jz4MOgSUb5UquORoBGUnMLRdMyA2FuskAOWlT5KEXrHQXIQL1fMELZXEFMuHeIfnnlCSEQvl0Y4NQWsjHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043394; c=relaxed/simple;
	bh=zox4SvndtX2IQYH7dF2si0RyU8QV/fnDqLEkZtb7Hc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTWIPzfGzgeeLAdX5vtED1p6GQqotq1BNqL0meG+kwx654ORs7zAarGefivGBBHlRR1kvQaCUNCP9TblMNlb4fNT0ATJU+NM1Iuv7RWeL14/LaBTWuiforDRkdqlHvoCQTC53/wi0EIEeRr7NMZcQrUOohDneP7PsdoxPsGM48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feOc3UGH; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3c3d404225dso2782281b6e.3;
        Tue, 02 Apr 2024 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712043391; x=1712648191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOSjhq4e8oxtj3qoYtkivIs58UqN+jVmwQhUZgEoH9Y=;
        b=feOc3UGHWsQXqqkSERZyjzl3dgDJRo9PK8jWuCfGROJaOsfJng6cDVu2xUhKqQxCUL
         XevMbXPTZhvRNLYQmNRAfBWW55Jz1M7JW7g9MemG5gRVLuB1wVrJnv1ZfQw+SJErD28K
         bp2qlsYQ34hNL2HsuckQxARZvGpyL8UWsdGGHc9WAbvgCUcrsQS5E2TboUJgLIvFKMx4
         2zYt2wEd7IThK0ZhittMT9v3w/vFaHRfnb5H5AvLX4VldSPZ5AJPIwuwyY15mmCBucSN
         p8bOCfzBPUtNmDizapHm9Pk2wP07g9ID5hZ2oDeBii0Yb36MREge0C65VT1sb+yUl43+
         26RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043391; x=1712648191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOSjhq4e8oxtj3qoYtkivIs58UqN+jVmwQhUZgEoH9Y=;
        b=iLe9nRQ3MDiSZTZg78JwUNkhczLTH8Bw59L4B8+eDdWleQh2HPm5MiT1h8bCYG8UV1
         ZGVSpSgduFGp/HKdEojqo3g/lhDkczzkM3KcusnouWRcDeJLn5zzJ2OS3ukCCS/IJxb2
         prAPGvPK9IS6ZrKkjN+m1iH3vBJz6rVFd49wpj1G2LvCksSROFJXDnk2dEpYtnXF6lHQ
         370D0iWllT8BHcXexg/4NCTBEjSq66KTVLZ7Er2iIYMb5vEAfju8r4RV8cQ8El8Nd79y
         gtQ9wLHoaFsKkmMFgdwSBTgO3bwPBisFKIRruGWFg1qV0pIx+Q9SA22avSFq3//f21Ew
         JolA==
X-Forwarded-Encrypted: i=1; AJvYcCXtrTuylhCoLVI2HnM4LLwIwXytqhsGneYCY2cR21pNYks6lPEnf6q1pBe0Kxi5SmkXgJ2qenMAXTf3IBQ7qvPCuutKRqZV
X-Gm-Message-State: AOJu0YzeZx3E1nhTeURolREXQM/0P99ENJ67D2Tl5hzt6pBMOO5bN5Dz
	CJc+ydnBd7rj4UilDy2K8s7TQnnoz+urlukPFTxVxlKlvoPYUuPLTgBLDOp6IvIJHube9dvOWw=
	=
X-Google-Smtp-Source: AGHT+IF3+j06WxIYHgTCU8OLKQ8y4EXT06Ty4po+TJM8RiHUA84r+T1QS9NlVpI+1c5fvZIN5ph7vw==
X-Received: by 2002:a05:6808:1246:b0:3c4:e208:b784 with SMTP id o6-20020a056808124600b003c4e208b784mr9342057oiv.27.1712043391580;
        Tue, 02 Apr 2024 00:36:31 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id ef1-20020a056808234100b003c3e07cc6a1sm2036927oib.46.2024.04.02.00.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:36:31 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: netdev@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] net: usb: qmi_wwan: add Lonsung U8300/U9300 product Update the net usb qmi_wwan driver to support Longsung U8300/U9300.
Date: Tue,  2 Apr 2024 00:36:27 -0700
Message-Id: <20240402073627.1753526-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling DTR on this modem was necessary to ensure stable operation.

ID 1c9e:9b05 OMEGA TECHNOLOGY (U8300)
ID 1c9e:9b3c OMEGA TECHNOLOGY (U9300)

U8300
 /: Bus
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=option, 480M (Debug)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 5, Class=Vendor Specific Class, Driver=, 480M (ADB)
        ID 1c9e:9b05 OMEGA TECHNOLOGY

U9300
 /: Bus
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=, 480M (ADB)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
        ID 1c9e:9b3c OMEGA TECHNOLOGY

Tested successfully using Modem Manager on U9300.
Tested successfully using qmicli on U9300.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/usb/qmi_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e2e181378f41..3dd8a2e24837 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1380,6 +1380,8 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
+	{QMI_QUIRK_SET_DTR(0x1c9e, 0x9b05, 4)},	/* Longsung U8300 */
+	{QMI_QUIRK_SET_DTR(0x1c9e, 0x9b3c, 4)},	/* Longsung U9300 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc000, 4)},	/* Olivetti Olicard 100 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc001, 4)},	/* Olivetti Olicard 120 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc002, 4)},	/* Olivetti Olicard 140 */
-- 
2.39.2


