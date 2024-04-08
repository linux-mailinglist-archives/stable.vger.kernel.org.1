Return-Path: <stable+bounces-36317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBD889B869
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 09:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672DDB22172
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709E24B4A;
	Mon,  8 Apr 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUeU27Sm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D72554B
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561470; cv=none; b=snCHaxKkPZaEuzSysm7IJ/Ve+Te9eplh397v+3EHvuTeiWHuEKqEw8ObD4zErzdX829Iy7T2wuvIl4+g9/P+x8jzq+AR5g5GVIXV+82VoMmJpCB5SOMb7SFiYJnlwakGZ0dQC9Hu8exMMwRySrTNDaVi+sIaQJi7pLT+z6EzBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561470; c=relaxed/simple;
	bh=gvPPUa0vl7EbqiToeyDUXWTagIoF8MXRo9SBkPIbo3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrX57BoQ9JjOnZteTTkSCUb4HAEV5OcO6Db63ZjJqNBRGtDBbbEmn3QzuXUBB6eiwC1kJBZfRs5HDL3OM7zbtApnks3G+i14gN91whZuOB2sIb1ZpxGKVkQQ6x+fn10DjpshhBuYSy0PvOY/qgRr2bzaHvv+nZMGWdD15BtpXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUeU27Sm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso532904066b.3
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712561467; x=1713166267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=layzcbV9sKx4ytm9o4T1Bhv6Ti19VyFlFmhQB+yf+nU=;
        b=xUeU27SmhaEZOKpMh+0h5WXXSsMFsbJobUZtzI0wcnlC1H2D4qEucZwy1LUJjrDgJb
         ZwDGCDQZj1ErJMHkEyw7E3pKeyOksrW9RYc2sl7Uh03pFTqUUOv115nhWHfUnTUfuJeV
         kJrBKxBA7vrt3jBQ8No10F3M1iw7qSimtp0ZRPLBV/sjg3xnMaV/jc3Jku9UjPpOZKTa
         9jUQd4Nepb+qXL7Vac/Qzkyi01LuYA7TEn55Aavut0DALvul6Qa3Z7PnLbMwO2G2m7Xo
         YanWWuB8+6QPYYRNlVlI+VIfuS5wymbPvO2Nr+/LaXkLc4J8TQjV4zJfuTwKNzyjFe6R
         qgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561467; x=1713166267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=layzcbV9sKx4ytm9o4T1Bhv6Ti19VyFlFmhQB+yf+nU=;
        b=R6iwz871nwLf58ypMHCpcw/6XnO8RIMNZpHFdi9mTzHJT9BOTUKAIih3MSw9sMLh6/
         lbjBQuW77gVvPhp0ItkFp+urUaqWvdzgmfhLvmGlqaPu+b4otnjFxgMTt32G+oL3jd2H
         8WHIYJ4t9d3nEAp0RfSRqkZ073RyqoXnXUeWyetECDtzInWbq/KJiJN9zbrH9A1fGZfs
         cyHDvbBh94YjdIZ0/Z4csr/SXykR2Vwo35VQatqpsBvBpqOsKXIJt74vLnu7s7+bhvpy
         mipsSyTxtVxk/RidT1PNWCGAzEo+9f2+2+0S4Wa7Qs9T04I4ej+FN6DEr5NFtccvyHio
         xNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyviQLUktLvvTEtoj9WttsAvHaY+yPo43z0jA/cxuuL9F/1IFoAvvoQFy7NDZ62rABykwuefqRKsgnL+M/eJaC8kp0k/y4
X-Gm-Message-State: AOJu0YzFY7Vwlz5eyvSx9uw7i6ZwGjpBsHrgljF+oGtjsOlyUfa96vLD
	JZrgD3rWrKlJKTwfxJz0dXoEeAglF5ZrzWkVmXrULGsIqXXrmn48hWutPGnRfCU=
X-Google-Smtp-Source: AGHT+IFROZVhMl9yTG+kjy+p2ZQnYlsNW6lszZjXW/K8pEvc08uSmVIEaO9mys2gBbNnSzYgwzngtQ==
X-Received: by 2002:a17:906:f754:b0:a51:7a72:294d with SMTP id jp20-20020a170906f75400b00a517a72294dmr5206812ejb.2.1712561466991;
        Mon, 08 Apr 2024 00:31:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d3-20020a170906544300b00a4e48e52ecbsm4030508ejp.198.2024.04.08.00.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:31:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Alex Elder <elder@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Yang Xiwen <forbidden405@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache info, maintenance irq and GICH, GICV spaces
Date: Mon,  8 Apr 2024 09:31:03 +0200
Message-Id: <171256140981.12523.5652563259173425537.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 23:05:25 +0800, Yang Xiwen wrote:
> The patchset fixes some warnings reported by the kernel during boot.
> 
> The cache size info is from Processor_Datasheet_v2XX.pdf [1], Section
> 2.2.1 Master Processor.
> 
> The cache line size and the set-associative info are from Cortex-A53
> Documentation [2].
> 
> [...]

It's rc3 and almost one month after last ping/talk, so apparently these got
lost. I'll take them, but let me know if this should go via different tree.


Applied, thanks!

[1/3] arm64: dts: hi3798cv200: fix the size of GICR
      https://git.kernel.org/krzk/linux-dt/c/428a575dc9038846ad259466d5ba109858c0a023
[2/3] arm64: dts: hi3798cv200: add GICH, GICV register space and irq
      https://git.kernel.org/krzk/linux-dt/c/f00a6b9644a5668e25ad9ca5aff53b6de4b0aaf6
[3/3] arm64: dts: hi3798cv200: add cache info
      https://git.kernel.org/krzk/linux-dt/c/c7a3ad884d1dc1302dcc3295baa18917180b8bec

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

