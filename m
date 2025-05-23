Return-Path: <stable+bounces-146217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6654AC2935
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 20:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A284A7F9E
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968F22A1CD;
	Fri, 23 May 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy3lQNxD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9C2DCBF6;
	Fri, 23 May 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023246; cv=none; b=QM0Xm0BdOemV8/a1jHll0P+f8hQiXLxpN5Bllqz5GGnFcXTNi5T0INufymxJyOHuHdLI9sT417w/j0MdSjSallI/36lc68yCTsuIb0Z63Q4gDO1qO+RBypAMcXUJnn+oN9Y7Xp3IL+uaGz5eiZkGxBKiXx5L57C/LsgTB0HOwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023246; c=relaxed/simple;
	bh=QCpCSBDhQej3trndo9Ibzvgcf9+JjnB5ospzS8yGK9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgwX4G8rx2Ixv5e8cir/cR3PJV6/qgt8vlgcnXUnWlJo/wSSHuhdHhOyVCAxGdnqN77cuqDA6Lqey29BvR9Dtwdlrb5dv7TKKj84+EQMpwf68bUauwT8hk81WZMyGozbllVlBTsMbnmgnupOeOZCqtTqhw4VpFeLYyBQ0GzI/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy3lQNxD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54d6f933152so202228e87.1;
        Fri, 23 May 2025 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748023243; x=1748628043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0GAQf5NDAvpon6mZ8MBJ1SaeprvmNs6Ca8YavpQKvk=;
        b=Wy3lQNxD/f1tbc4U+OX6OrMcqg3EC2Sl3Hvj4m060j+VS6rMhZQvXckFG8+ghY48/4
         G/sVOVCU96t78FTBQXsbiLtKopRolJepOEyOPTJZcWu8UUp4u4zHSGeipQTO++ZukwKU
         3ttGsa3pEEunwt7q1nK2Zj1PxHzyZzv5fC0tdGfHPvj8VejnGFOcsVDHOBMWIAKu/9Gb
         xlxevSc7wzXUooS+2NldIncAClXh9zd2E+wxc432c48oIURcLxp2Q0HUmm7CsSYoRfj8
         DPYO6U0q1KHb2+kGb3JGZ1Du4IYZ0vmbePS/VpI386luNdH3z2hlvGHAymziO7UQ3kFs
         CNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748023243; x=1748628043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0GAQf5NDAvpon6mZ8MBJ1SaeprvmNs6Ca8YavpQKvk=;
        b=ukVjMfMh5YnB43UtKEerQEQs4DrLzBGQCQ4Zj3/Y7lsntnUnlCqmt2uNcEOeGDTDVi
         RePo4OR0jS1rRP/TrEtAjDW7KNLRPj0VJw75BcPvYflwckIJV+JAh8jBRNJhnzcSOHmF
         N9QuPKiv9deni7cG2K29/ZeYLPVqoSOFcINl7J34Pxxlw7a1EMmvDKAak97jynneKKTC
         g49SxPACyl8yS8pk73Hk8nV7NCvBNBrsTdPxSnmf+Yj0LA9zGSJkbcLYfGT6kQQabjZv
         u3mkYviifTd/rOUELEJS48e6apfypDbqIkALuUiX2iZ6RNw6MHnrKY916DIHR/pXtBVn
         Pv2w==
X-Forwarded-Encrypted: i=1; AJvYcCURCmfza93viapokrfGQA6yB4mxd3EQyhvmW2vcdXF6OkzhM2P6R+xxHU9Yr2sfsHTHgCaC4CYZ@vger.kernel.org, AJvYcCXHELe/QW4ReALkA8Nwuy8qssxmzyPOosmYbWcClhZ8fa+S/jqN95MPtqiouXcA3//XO8mLepUAnT6g3vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7weCNeJk/m8EnnfdhS8NGMp4VoUXJCQvs5NtVEUEt5aTdncI9
	1CwnvfqiVOs9rlLBs29WAS5qIeQaWGXVYPQLCe8MhjKpgwEgtuBETr6r
X-Gm-Gg: ASbGncszqRDMnjDyWz9HF6VFSsuBXqfkj0fAxNfz4HAxkjjFXvUBfQwLg02vt7NAaOW
	/1CYiWwpAZXQn4p2rJGLN37AJ4yS6D8d33wdE7fcG3wu4Pmxrc5gMCw34saK/RxHPVvzcB9KI8C
	k8ktCNt7v8EWtI7bekgk9ZGz0QGVWQS11Ca8Ug3RPP+KTd/nTOKtZRFi+mWq26IclJ5CORzSGhl
	FEYeMJf4bPFjwZvnbii5NaDCin8VSeqxHFP65jMWnnSAuU8MikJdrGPYehH3/khiIpvdMpM53MF
	CFTqNTLNIk2tWUxyBb3c9NNgRdXOWjeW3ItomGAeO33IDNjHvB1VbkFWeMox4o26t86g
X-Google-Smtp-Source: AGHT+IGFhbS3jl095+ZHhuX4XAw3gePGjRtWE+YRvcmbEVMpC3GVc3BQQFmzkYTUfPbpuvMeyFiiXA==
X-Received: by 2002:a05:6512:39c3:b0:54b:117c:1356 with SMTP id 2adb3069b0e04-5521cbafc09mr85664e87.56.1748023242940;
        Fri, 23 May 2025 11:00:42 -0700 (PDT)
Received: from localhost.localdomain ([176.33.69.152])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f3148csm3943316e87.66.2025.05.23.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:00:42 -0700 (PDT)
From: Alper Ak <alperyasinak1@gmail.com>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	alperyasinak1@gmail.com
Subject: [PATCH 6.6.y 0/1] pds_core: Prevent possible adminq overflow/stuck condition
Date: Fri, 23 May 2025 20:58:34 +0300
Message-ID: <20250523175835.3522650-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The breaking commit has been present since v6.4.

Although the fix is present in v6.15-rc4, v6.12.26 and v6.14.5
it is still missing in 6.6.y stable tree.

Brett Creeley (1):
  pds_core: Prevent possible adminq overflow/stuck condition

 drivers/net/ethernet/amd/pds_core/core.c | 5 +----
 drivers/net/ethernet/amd/pds_core/core.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

--
2.43.0


