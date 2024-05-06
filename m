Return-Path: <stable+bounces-43141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C888BD650
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8537C1C20EAD
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6C15B15D;
	Mon,  6 May 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wzvopzF7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D121591E8
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027880; cv=none; b=J2m8IxCoiQuR6S/ASNSpQUAk4HfTBtKz/SifoWgPa8kjIX0Bwre01HT6m0Mw7zSrL0pGXhAUPi14Gzu5N8TZ0Sm7ZYS5x5YBsOQLQNjqVJVyxNTKBamEyQ1fc+dQ+Htn9qYAFTTLH50+j4cEYpI3IsxODp4YpjVxBrjWJShnt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027880; c=relaxed/simple;
	bh=bvJomjBUofgAeh6XA/2hgGXPj3c6dXLdwfDLZ224y8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm0I3MChr0M2hveegskrMmqmjrlGdHHS5dh25NBK2+k2cpE/r6GZPzoyDs9jzBtxY5BXbXudaX+P3K+YJCztLOLJYzr7SllMHzFWRF4q7ugHkdSf/rkkD5Krkmw95GIbhJj3cEjd2CdrECskgF5j9bh/MHItSa8RbY4Jy4f4fDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wzvopzF7; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f040769fc5so1032253a34.1
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715027878; x=1715632678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kfh7gjy5n2oa8rof7z7kXYkVcojCNHTa8SVcKzg7JkI=;
        b=wzvopzF7BJ/wk0BbVBorV5UdEns681T45iGNQKwEegpKDeTR24tilLzk10UKsqieF9
         2zRZ7TIvnpuzKlaxmt3ibAGVR5PIa5qil/jwLvViR9QlhB5Raa95tAFtATL4PS5QYLDg
         ZPiUfa6Sb6md6yNN5TVmIuq3LtO3bnUq4pHiIxgu2zZa39wRgJdo9z/28VC1rZTWrq54
         A8Obi8dBMclyeMDdazyizKcKh9H1NXjmavmjT0+uKfNCCtdyPImksHGxbY1AwaD2DZ29
         d+PFyA+vP1XUrqPIVlD6W6L5wSOg6SqgQxk2bAGllfIsBSyNmQrYcGhPyxYZyjvHZf9C
         +2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027878; x=1715632678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kfh7gjy5n2oa8rof7z7kXYkVcojCNHTa8SVcKzg7JkI=;
        b=heGbCYqnYBkMo4lzC1vNiAvry+PUWaqxg8X/s8Gio0amIEqZEbk0fqNKezOF/VgVxf
         Im52m4RvgaGNdKVE7Av0yLYyzY+EyGUWhNHO94nVwBrS4ZVV55E5WLlkbZB7njk3ZECl
         97TgW0KPfnERJvKfjjpkzPYm7RnXQtx2bMDVKqbetQpjbdhsZwl5Gf6+cuVyIx3ASxUW
         E25nWCm0fNOrxnnPzz2ISNeceXGOIFs0UbWmYrR4trxiEhBZs/JwZ3TPFk0Z04UIHx77
         khVSfNJmbLbE8vE9Mx35ZHPMa6x1mCFT0BLsaUvc7JsvTQ6pVjV1zepCJKe6j0JnnW0I
         J6Sg==
X-Gm-Message-State: AOJu0YxSI494Ty0C4/Ux0+al8t2uVo2OgkM1xftZtEQsKD9zwNUKXVTo
	9PWERITpKtbBMaUHgcSF0QTN4oNf6KVv0/+//r4TvQGEwMRvMy8yxh43gLe7/coO94ueIjy0OU5
	SsDw=
X-Google-Smtp-Source: AGHT+IHpbQqUWTdHfeu/perMnG/iNWU+kegAl2sngSPMnQ2+ryBshDqlCdgf/1Ax+7b/+MVPsNSSGQ==
X-Received: by 2002:a05:6870:b14d:b0:22e:bcfd:deb0 with SMTP id a13-20020a056870b14d00b0022ebcfddeb0mr13069140oal.41.1715027877798;
        Mon, 06 May 2024 13:37:57 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id bs8-20020a056830398800b006ee5f0484d1sm2107994otb.1.2024.05.06.13.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:37:57 -0700 (PDT)
Message-ID: <3c3569e1-b86b-40c1-b964-4e262401ddb3@baylibre.com>
Date: Mon, 6 May 2024 15:37:56 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: spi-axi-spi-engine: Use helper function
 devm_clk_get_enabled()" has been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 lizetao1@huawei.com
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192717.269201-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192717.269201-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:27 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-spi-axi-spi-engine-use-helper-function-devm_clk_.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.



