Return-Path: <stable+bounces-42919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30688B903E
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D401F220F7
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E31635AC;
	Wed,  1 May 2024 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZurD+k44"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEC161B6A
	for <stable@vger.kernel.org>; Wed,  1 May 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593010; cv=none; b=t4IgC0Z8K0fuxwd2cUV+J55EyDrG3dWDT4C59tRYSARuRJFP4NtpLFMo+Wlbku4tYrBVQMd8zS3tluDCz/WZqBHVzFmabFi5dVeT3v812iB4WO2RxFgyFuRjXkR39sXWGJ1Qs7TJV5qa1JdCRGVlSNiPhquHxj6Je20qJSekNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593010; c=relaxed/simple;
	bh=tKZ004RtdKJETP5n98R09dwUPz/Qdort2kmKS/z51/E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uOhIO2upEFirW51Ut9TVUUjd1uZobPkfkwZ/QUM8grZp8iOKCK9hX1cHnLxeKEM7ZuBww8TRBT4TYU+Jj+X5S/bs3atKyQRHnlVVyb1hM/J8z7I57LpsW13cf3UPcNHm5qiycnnw4NixAYWnxX/MJLxhRmOg8GQws+eR+BJR9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZurD+k44; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36c5d918d41so7188225ab.3
        for <stable@vger.kernel.org>; Wed, 01 May 2024 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714593007; x=1715197807; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pAKhUrQEae8Czl59Jfk/xPJriJIZ5vgV75ekQy0VfM=;
        b=ZurD+k446KGipY2uvT7sIEplcql2sDkibHPT5zozEDy3LTABixc3MnZqKsyWwWxsaI
         I/iZepB/U8bXTu9Gp1fmif6tA+PfxDhl0hcur1RUYhoRMgSZXhOeRSia+yRuVQkvLmeE
         3k5SjhlBIfbqLHqaBKU34K4/3KgoSlYXVCChYfpI+PRL37GiIhvgfqKpCmqF0vCVm5dt
         /sWBLCZPgoUU+9lqVjZ3qd+uXZgPvIP41gnRoP/pZeNOpjmSjO/DAMp8WCwF4NEObflZ
         k1YBuqqIr3pxzcG+af6wLb8itgnAAZpEyFF6ZB1W3SWHZ/8goyQQhzyAerhXab1hZw57
         PBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593007; x=1715197807;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1pAKhUrQEae8Czl59Jfk/xPJriJIZ5vgV75ekQy0VfM=;
        b=G3biis8ltkgJUtuyCyJWXNclWo9mU8d4nYCbhdTiSJUbgv6OM0XznPX0Csg9Ivk1UI
         q4KNV65TIt44b1zHW/o2oOJvzTUJC6KmLaX/ijucBwFX5v32/NcBuacFrvHOZ44qPigf
         hCQuL6XRyJXNCCMdZJZuruslXa/YZSzzccvvjd4mAhike1f/8WwS762G99hHWHFGfLXh
         +KEYqql5cGguSDo2xVHQhMCXCm3WUraJc2xeJ+lcXVT7aQESkPzFjtjUcMIAu5MnR31M
         EQL3cyYmruEgvDawwVEUicWka7+PTJF5hPv9HSDUrwKEaBpX+2STGGsCF9V18PSNtA/F
         ZXsw==
X-Gm-Message-State: AOJu0YxGfuRXkuy6x3vY2UPbdZ+uEKbZ9R2EoFL1JdPlaaC/JYg5f4NI
	5+hKv8kdZEKfz2VcNznvcCVLvZeOqsdZfLyTTsNYADtCDl2YXm3MT08DZuijYXPuOT0+/jl+bOD
	W
X-Google-Smtp-Source: AGHT+IFN+9QLAEqgkE2DcuwRghKpNwGnKvIHmr1MyP1ryIfK5wvSTKb5d8Eqz/u1k9ZR7wdjYp+8DQ==
X-Received: by 2002:a05:6e02:1e0c:b0:36c:501e:d8da with SMTP id g12-20020a056e021e0c00b0036c501ed8damr4877360ila.5.1714593007342;
        Wed, 01 May 2024 12:50:07 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id k10-20020ad4420a000000b0069b69c5f077sm42534qvp.102.2024.05.01.12.50.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 12:50:06 -0700 (PDT)
Message-ID: <c655924f-7c16-46af-8d1f-e201f82328ad@linaro.org>
Date: Wed, 1 May 2024 14:50:05 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Alex Elder <elder@linaro.org>
Subject: Old commit back-port
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This commit landed in Linux v5.16, and should have been back-ported
to stable branches:
   0ac10b291bee8 arm64: dts: qcom: Fix 'interrupt-map' parent address cells

It has three hunks, and the commit can be cherry-picked directly
into the 5.15.y and 5.10.y stable branches.  The first hunk fixes
a problem first introduced in Linux v5.2, so that hunk (only) should
be back-ported to v5.4.y.

Signed-off-by: Alex Elder <elder@linaro.org>

Is there anything further I need to do?  If you'd prefer I send
patches, I can do that also (just ask).  Thanks.

					-Alex


Rob's original fix in Linus' tree:
   0ac10b291bee8 arm64: dts: qcom: Fix 'interrupt-map' parent address cells
This first landed in v5.16.

The commit that introduced the problem in the first hunk:
   b84dfd175c098 arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
This first landed in v5.2, so back-port to v5.4.y, v5.10.y, v5.15.y.

The commit that introduced the problem in the second hunk:
   5c538e09cb19b arm64: dts: qcom: sdm845: Add first PCIe controller and PHY
This first landed in v5.7, so back-port to v5.10.y, v5.15.y

The commit that introduced the problem in the third hunk:
   42ad231338c14 arm64: dts: qcom: sdm845: Add second PCIe PHY and 
controller
This first landed in v5.7 also



