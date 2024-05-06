Return-Path: <stable+bounces-43142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE38BD651
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5F82833B2
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953915B15C;
	Mon,  6 May 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XEeh5Eg5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70231591E8
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027902; cv=none; b=oYmPGSvYHA9p3MNoPABa0nar7aq8qHNP2LbKnfDiwnx2ILaAUw0QlgyBrIpvBbXw+mGJK5av4AzxCx6IAtgNTURwQp4OBaI+bXEuZ2sQScnAd4wnI9e11C/VkhwxUsIMzTR9FPQ0k3jlUdJbkdoAPXLudJ1zu3Xhf3iEKPgrhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027902; c=relaxed/simple;
	bh=TptIv7LNivSilzPK3Npqk+DAomcSxdjdDY86v472YqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oz87P3UG5Xo2aEyL855sRWhRXIJDce+Tkvcg/Rv1Eg87+hM6hDtSrwyi/3jVShnDwrpQYo853Vp5WKqxep4hm3vKjUOI38zNEb2tjsBI+73GdYqWU+4+VoWfBB8V+85Fy8CT2PXExEO4VOMEZSWyZTKz0olVlk2P8Hu8zzCx+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XEeh5Eg5; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f04ec1b501so881631a34.2
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715027900; x=1715632700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLrfr+kcgQbYNu0GJrr/6mqdAAot312Hynf8momx1K8=;
        b=XEeh5Eg5e0BvATtBxsu+ed1AcrKk6XoGHtELRi2N+g1+4iJq8LieHIrJ81DGYKzTBK
         z21nc2gFdbyXCpnt/3nlEWPTXjZ8bBGx6I+C1CSt5Z1wFS1kOr14izzJm5X92UvCpmfT
         0z/mRu9ClEb3GiqcHpmpBfyeRUiZWBmnogxHZ8Xn/PJGUG+7kqm9DY5dflVN0629ah3b
         cZQSqO66PrURMPYDZ30Of6wBh6R5Ano4mCG5lXAHNUyKIHd2qBtr7NUoYRDhkCiMNCFh
         X9HVGosXxxeswle79PlPh193REHqrWnoLV2O3xCfoZVgNzI6/gGA6edH67VYxkpoM2GP
         CDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027900; x=1715632700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLrfr+kcgQbYNu0GJrr/6mqdAAot312Hynf8momx1K8=;
        b=vTug8pipDLV1bIJvNxKKxssPlTo9LViVb1ORck2n2FFSApT6p+BZEUdziBBiID19Fh
         fsy+Br7vKvcJDBdNWwbM+r4lpXTsgdOE75qP6BMiKyewwYNvWUJYYQnRIkURH2ifO8uA
         CHk0aBlSFvqTKst1aCHumVRfpg9AWjWbTaMuHTRLdjeC8tH+xnnVWHyTn/BcDmemq2h4
         86i0S5HFilWUC0vNTPni4A4pgh2BWbTuhv8yGtigo9lQZqIug/dHxhyayLAlztH7xs1d
         fWgp2WVo1TKvKReIoc+ByuEx1Ztd99m8RoegsPVU5BPiuipMTTXRFwrbY3e+z+1NJKpG
         004g==
X-Gm-Message-State: AOJu0Yz9SNNQaAXfHwGOEXw7/nmhbwlk9iQ5gezRkTb9h4IMJxKkaYbV
	vxyIT5Hl7JAH+9pUn/mIvMCuN6ZGRqbhZ3HbsTCYGHzz7hR4bCMGNo/0HCLvCH8MGnt9NWWs66r
	gncM=
X-Google-Smtp-Source: AGHT+IH5mm8EUUtpa42ixv4qS7ZaXq+l5nkwvRtfLzznHMSlGn3tgkuMvFCaVliW7p6ntgpQDPQ6lw==
X-Received: by 2002:a05:6870:6124:b0:23d:510d:ea55 with SMTP id s36-20020a056870612400b0023d510dea55mr14508807oae.18.1715027900116;
        Mon, 06 May 2024 13:38:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id uu1-20020a056870ae0100b002392041da7dsm2120478oab.48.2024.05.06.13.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:38:19 -0700 (PDT)
Message-ID: <fdad906a-b2f0-435c-805e-33cbb129ca7e@baylibre.com>
Date: Mon, 6 May 2024 15:38:19 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: simplify driver data allocation" has
 been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192720.269243-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192720.269243-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:27 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: simplify driver data allocation
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-simplify-driver-data-allocation.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.



