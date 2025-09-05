Return-Path: <stable+bounces-177905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15421B46690
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 00:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53BDA44A5E
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC228724D;
	Fri,  5 Sep 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="coBs6dh7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88086283C9D
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110934; cv=none; b=T/p1wkSlIthfzAsZjM1wbTcA7AguqMzq/BQ++ZWntmp/LqPPy9ZQnE75ZxYKZjGTzsH9GpcExSfVAN/z2c63fgjKgC3s4mR4dPjAoguX8n4o8eH0e8dHsu/XmTY7cxM2dGFHZXA1IVUF8aRHhRTSJLtpXhccGQuq0hWEXs7Sh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110934; c=relaxed/simple;
	bh=CLtBTRODHOtRfKtljROOY9At9iB558qJn+zs0E4D0mc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BE0yaE0FlnHS/9UwFHntNCrezbAg/B5B1W+f6DBCfSeHujLD0K4rfJX+E3laoR+fH0TNdot3TSk++7Y/MB6f7j+zGz60vjX8gAcLZ0e41aw9pjshwTbQAUB73G9qjbkkBjDLClSgFHnA2Xhktt6MPaQTIX3pQy1eKee0HwXTTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=coBs6dh7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77251d7cca6so2212685b3a.3
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110932; x=1757715732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYJbNr/FzY1+zoA5tKpao01rUyzDVS9XAIWE0H2pjng=;
        b=coBs6dh7266sH809ep8IUCA9DQjOonHOS4bH2hQ53K3IasIQSf1eucUEQr54iFk0o2
         06lChXDb1G6Sp/IS4x8TFwd5ub8Z2WJizyJ2+lh+vES/h7PHbikqIgsb0mV9hmT2kaJu
         kf64i3kJZHM0QI/ZRrRfqxKW7Ut9Mxud8W/qjXD5uuHBZcvaDjf/0YoeT8Jz+D6A7spK
         rTSkaDJNbevXuWZ3IC4mxJskbZfkhE/VVU1WDQv1sSssHMFkfPhTjeu86I5dGKxkJMU+
         Bu5DvpUj1Bkg3NtZuBV0ljNTv3bEGkqkD0ZNPMUK42UW0eZ5Fd7YV/zjyRMV1UmaWX1O
         JSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110932; x=1757715732;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYJbNr/FzY1+zoA5tKpao01rUyzDVS9XAIWE0H2pjng=;
        b=vsCr1g61mXDPywkVaLX0QdN35PEclNq9fBnfIV56Vh3/Wpm+E/vAcFZXFh4/6Zx5iT
         HloYsyCtJc5sEz23Y1KjtXcGBomlI+jMxRDEGARmbs7bWoh9jZa4fFh3L4lI6iG2gYxR
         dZzVRFvZUJN06QipdWoGPqk/ofKIfxJzUNMs2IsjtQVcoiI6RcbBhn0W019KtZ6DsTcM
         19jMJWmzk4I88Tre4PnnuK98NnD/W3VdLcWIKaN//8QfOZ29aL+QpRlQGalkZ7Jww8yB
         17O1xG7ItjPRvoYukJFEpLmRzeNxMPTWd3i2/hNgnBOMzzmLizMAh0rqLuLIhqq146Hd
         L+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXoh8lJBJB3hOfppQk0ThGlczWRkDwhCH43KOoMJYiY6MZWsM/OArp/aEyXFbQGUZCDd1iEjaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq03LbVjQ7MysQ6CKmURxron5q261VglzpfFd5WMepx/LeVjOB
	HOhxLy7oEipkoXZm1LEyHt6WZf2ce95pLtkU7Qhe+ijQITeZVryQy2QLUM3pDTF46Jg=
X-Gm-Gg: ASbGnctPxDXgmC3xkk0EIi034fbGFNLL8SpNXaEko0HTbz0xSWlHU9lj4aaBjg6xtTi
	svSdAWDSDKTo9e59izVg8i/oklAdqs9Yfu7bgGeGh/0b5/5XESUhSr2MT/9Z9N5s4C2FAqETlKz
	oPESiTtLwmgCdYoq4SrUhxrhrsiIssxhzbvE9ookFFCJYdNXfMUAMXuh0QvKpFjCmzlM5KqAl4b
	TNbYo+hrDdcB3Eq7oYXdJfSN+o8vX7jj3u++O/jMYqV1Qp+MsdKWjt9x0SnzAiGp/1pAvnQDnp9
	08MLt0iOpZfo3T3YU0R2S++EQohmF7tvS5Jl6n1TJrnq0wA/TOyjIG+1zxM1AYVkfFh0pyWY6O0
	44lk5Ix+z8OFk0p23z0qO3W2YqJMIeRarKGeppUGWAg==
X-Google-Smtp-Source: AGHT+IGaXEwoc7ILB2arBg0Y16+KGjCnlIvUXKnnyBv3PESilhG49cI++fLCWMv8Z7e3a6gXIMXVhw==
X-Received: by 2002:a05:6a00:17a8:b0:772:5165:3f68 with SMTP id d2e1a72fcca58-7742de615c8mr302181b3a.27.1757110931832;
        Fri, 05 Sep 2025 15:22:11 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77274171cf4sm11008985b3a.76.2025.09.05.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-omap@vger.kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Matthias Michel <matthias.michel@siemens.com>, stable@vger.kernel.org
In-Reply-To: <20250717152708.487891-1-alexander.sverdlin@siemens.com>
References: <20250717152708.487891-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH] ARM: AM33xx: Implement TI advisory 1.0.36 (EMU0/EMU1
 pins state on reset)
Message-Id: <175711093087.666031.2909646610138285182.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Thu, 17 Jul 2025 17:27:03 +0200, A. Sverdlin wrote:
> There is an issue possible where TI AM33xx SoCs do not boot properly after
> a reset if EMU0/EMU1 pins were used as GPIO and have been driving low level
> actively prior to reset [1].
> 
> "Advisory 1.0.36 EMU0 and EMU1: Terminals Must be Pulled High Before
> ICEPick Samples
> 
> [...]

Applied, thanks!

[1/1] ARM: AM33xx: Implement TI advisory 1.0.36 (EMU0/EMU1 pins state on reset)
      commit: 8a6506e1ba0d2b831729808d958aae77604f12f9

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


