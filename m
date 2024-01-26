Return-Path: <stable+bounces-15885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6383D968
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 12:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38A3B2DCD8
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC214280;
	Fri, 26 Jan 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaxRzeNr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C814273
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267700; cv=none; b=iFWANr1U2zVedBEiP9CUT6HMZsCOBbaJzTWs7RqbJ2vFn0SkSugYB7zmAtp8zo8sWdEACHGRZHSiIpN7rVh28qNfNjov3qjcMjeRNj3V3avAFMsp4u4mk6UtkTHe3rMA2GXAQ+Fa4772jH3tYKgIHx8qVzk/I26g2W4YhGawGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267700; c=relaxed/simple;
	bh=h1EU6NmqUFj2EvkMVNy0hjRZlnhlBhK46W5pi0y1Pp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfDk5w/ty3o6IMGD20S0eZsf3XoowatcE07HCs0fVsODeBWccuhGOCqC7erOVDvyU9lqEz6kw6IcOncjaNDdHJ2i2dCPa49n7ZJsBAv7Xb4Ot6VuQV0wHBhTgdU8QVdPXi6CIR4htdedl4bBHKNkwd4JMekHarn5xJp5MGzKc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DaxRzeNr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso165272a12.3
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706267697; x=1706872497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1ZZmYqo3r/SFCPLD0R0hGRGIRyXYIsP1uGinEyaK58=;
        b=DaxRzeNrWeUY7YNsMi0c95lWDjvUTMbrprpH8UZpOdRNcdeZ6Lq4LbFKUDUaQYewLc
         eTQlSYA7/Q3mFtG1epfjIhro58SqVC/DiUOHm+NFCQoRFkzTyY7wraE9BSuENmuFIDTu
         yMGv5ekAnqaUT6g44hs8VozNHguSCN1ImFrhslM1a5l4sIVeoLvLRtvZ7WI17a9jeBDI
         bbXbvXv3fuCsrvZKPRr0BFX2G9VBhrSRHsFYwrx20XfKeL/op03vlPGF2rLJGTpGhGPW
         tc5fl0Py8AZz1RLWAhg91t6pBVD2TXbs++DMNDscw0ofZ+OdQIznJjkdRFYytJs4gh5R
         8bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706267697; x=1706872497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1ZZmYqo3r/SFCPLD0R0hGRGIRyXYIsP1uGinEyaK58=;
        b=sdgzT9YvHtlxmO0d+jbLFTMvBM5Wce53TuHV0fZZ/FXgoo/uHlpxZ+rR0rjDM9UMNV
         CQLrBvcuIOHPcK+QAUswdzVGA53S+SCIEoQware/VHCwtCIAiU0X3LuOdyTF1Ae/GyU4
         UGkHG/y2IUsVH3hsBdtByJ0+PbErlb6ARdz8Lmi1s1uMMG4EuXwXY2EU/gAKFrIkbMp1
         u0GP1NzKbCePzL/zzZD9uc5MBco4uSlErVbbexYfs3TlWGrhrYyUcEAX3jmwv8otuSdY
         2JJkMrearoYQe/0rsixSBxUIBmABjoA7DnG2yBvLLT209SCCEQgBtwxlXWv7Y9GzeoSL
         hjuw==
X-Gm-Message-State: AOJu0YxVG2o/CyM8cltUcmE6Tzwr3bNW6TG6l9bM0UO09p1cOgh2Tjjw
	h5cJO4ISVU79iKoUwLCzoeP1plfqSNXn7qJrvOMrenhOfYOFef5pq5ufcffdPq8=
X-Google-Smtp-Source: AGHT+IEfV55Jc3OHGjYJDygk2acvMz0sszcIACRuw4I6C7+yV3g9xfsU70RpckrTODZ4cxkUWVu3+g==
X-Received: by 2002:a05:6402:c9a:b0:55a:44cd:9c59 with SMTP id cm26-20020a0564020c9a00b0055a44cd9c59mr461447edb.30.1706267697145;
        Fri, 26 Jan 2024 03:14:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0055d1f27f47dsm488523edw.28.2024.01.26.03.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 03:14:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lubomir Rintel <lkundrak@v3.sk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Qing Xu <qingx@marvell.com>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] arm: marvell: Fix maxium->maxim typo in brownstone dts
Date: Fri, 26 Jan 2024 12:14:54 +0100
Message-Id: <170626764360.50413.9381526885560837347.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125-brownstone-typo-fix-v2-1-45bc48a0c81c@skole.hr>
References: <20240125-brownstone-typo-fix-v2-1-45bc48a0c81c@skole.hr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 19:39:32 +0100, Duje Mihanović wrote:
> Fix an obvious spelling error in the PMIC compatible in the MMP2
> Brownstone DTS file.
> 
> Without this, the PMIC would never probe.
> 
> 

Corrected commit msg, took Andrew tag (thanks!).

Applied, thanks!

[1/1] arm: marvell: Fix maxium->maxim typo in brownstone dts
      https://git.kernel.org/krzk/linux-dt/c/b589f7aaf96330236a6d6a4057880550b066b581

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

