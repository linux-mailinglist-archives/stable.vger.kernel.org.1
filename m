Return-Path: <stable+bounces-210130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4CD38CC0
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 06:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B24F3301E6F3
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 05:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8C31C576;
	Sat, 17 Jan 2026 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlqBntoy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75534500964
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768629254; cv=none; b=TFAXCKey9Zol9LAsw4IpRbIYbJAZ4Kt87MnpMqP0D29J9KKfonUKU8kAZviFfAiRJ/OSFOUjC6M8Wd5Sqblimpf0BIeksoewvEgr4k0ZEukABPMvV6AFMQaJUSCk7k+rFty1fhCW1GchMPzgcOGBxdhMrxLzV5gT14S8iuNI4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768629254; c=relaxed/simple;
	bh=X28oz4Hqu8C9OrNAoigAJocOtIUCqP9c5jKWoshxS8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bU1h3Pt/eP0RY+M/jA8NHF6Xn1ONY00Cxd8BgK+34h+4bi7yKoXEgPbrYNCSdxKxoT+8jtO8TdK/o+fbJjxHi9oScOaEU2UOwMRkcqa1pd/1S1LV4nuc+J7UcL9fs15vWFngn2RU4PGu08ByWopR72Ixbd9SZ6Io5pdIPVKzHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlqBntoy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a2ea96930cso16627695ad.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 21:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768629253; x=1769234053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3Y2YH3nM767IcqTvERX11GvwkdtC120hdoDxqBZKew=;
        b=DlqBntoyK6tr01t6J5k5EKAx63R3U6KSu6cnlJXbei8pZ0uA07dZ5+6g8JPOAzcGd0
         3lHaHgZYmB5asVcgpv1NdCtM71lWNG0B2G5aLSoF5qJPol5tmpx+4cm4IwHlAoacReR8
         zncid74kAczGft7YjdumX2MdVq1H6A5Jra7Ulw9DdGXDneOwfCvrLszm3h5nPFce0Bzx
         X2Euc6Qzd+gwiqySnaPfJnvrppIIYA8vMpd8fDpeH712cstl3VEI4OKoYfKSoxToTtzI
         yve9IrFKnDOQFt0Hl01pzQUCBaSSy/Mq7YaWAt7qy/YzxTPcb6JlehJcDEz9B5p36Dg/
         j7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768629253; x=1769234053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3Y2YH3nM767IcqTvERX11GvwkdtC120hdoDxqBZKew=;
        b=tEwNyS6dR+zG4gHU8P4Y0WNEshfGbEph3Hk6t6dKhiBtmYZsh8UN/9GF+8MqgYXbKd
         UKFvxaoaldwASCizv2+8+MaUxYw+c7kedIwQDIkspxadLUAQ+sBZKP1nV0CP4CR8G7xh
         evXyczyQhXc4EtM197gU8tzE9145lXxG/9SzNkcQz+o5sjM1rhQuzLBHR4ha9mCrcvYT
         nDzZQLenp3EVcw5jMo5ETHNUzBv6CvX9J4RIn6qgq5bc61U4Gti0GpM8UlmxOdXe9VRk
         xaIhmn7Qn62MBQH4C/a7g0V3QhJPpY/c5x+HYsx1tW1Fe9iu8UAY/fTsaAKBIdcZwNAS
         SnoA==
X-Gm-Message-State: AOJu0YwPykPDU1i+VJ4TsBywEpNoLRSLky1NbwcVgzU8bDPi1IXRvorX
	Ad9P2ibmDF1fjH8J+Gniv2YCbe7SbA8nl25uAC6alnrgTuulaSPtKhEW
X-Gm-Gg: AY/fxX6FlZBIyK4OxSmi8Dkjchk8nF3ZjTLPeRbH/O6u4NMFqBN+BT3NkFZY9yBNY1W
	9TWzwU9H9mJaY9jTNQQbtUpEeVjvl6RwRxC1n4DsHW/FgTGgN45BP7+13T4eKj5gRo/FTyJyOyk
	M10cPPeIv1PUlkbLWYFTDb/tmsxxiN539X5ssnocQ3ImwhwLj6WL5ylTf5V/Q282wsxKpboANHu
	Xn3SrKtSvzhyxAUrb6XOlCa3Eb8O6oNciVwEfRsbEBvjWuh060dre3xIzf8+3ML9i+Tkd9T4NOE
	ZDZ3V5IpSS9pRwQ9cIPa8kdFl6T1VuT0MFAMjYkAsNYBtZXl1dfRtzCPJpC5nULtGNJCW2IoVuA
	crgpeNUdBy0ASDPR7+5mt5WaJfs3D5AUHdxBmNjos/O9VnxALN5iUg1Q5pXlZoXA7K6VKOq9eeW
	IS5VjnOXC6dWSc8K+hq/AuA8jFKTjtNtGAIFInYe+maLPD9bUkqZkl3tDEAfyQRqXxSIOGrCCJ7
	y4RKqMW206pLsnUW4iljG0Z09TU0czuqg3lRbVzQJX+J4EVHT+YULjZgg==
X-Received: by 2002:a17:903:2ad0:b0:2a0:d63c:7853 with SMTP id d9443c01a7336-2a717539304mr48150415ad.16.1768629252675;
        Fri, 16 Jan 2026 21:54:12 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd523sm36763495ad.62.2026.01.16.21.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 21:54:12 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: geoffreyhe2@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: fix reference count leak in sysc_init_stdout_path()
Date: Sat, 17 Jan 2026 05:54:07 +0000
Message-Id: <20260117055407.415600-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_node_by_path() returns a device_node with refcount incremented.
When of_get_property() is called to get the stdout-path property, the
reference to the "/chosen" node stored in np is either leaked if the
property lookup fails, or overwritten when np is reassigned to the uart
node path without releasing the "/chosen" reference first.

Add of_node_put(np) after of_get_property() to properly release the
"/chosen" node reference before either going to the error path or
acquiring a new reference for the uart path.

Fixes: 3bb37c8e6e6a ("bus: ti-sysc: Handle stdout-path for debug console")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/bus/ti-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 610354ce7f8f0..091cdad2f2cc6 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -696,6 +696,7 @@ static void sysc_init_stdout_path(struct sysc *ddata)
 		goto err;
 
 	uart = of_get_property(np, "stdout-path", NULL);
+	of_node_put(np);
 	if (!uart)
 		goto err;
 
-- 
2.34.1


