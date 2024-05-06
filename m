Return-Path: <stable+bounces-43144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8298D8BD669
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC4F283427
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD915B553;
	Mon,  6 May 2024 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zaDpKGr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BF15B556
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028086; cv=none; b=NZjFt/q3YwksilqHoE8ZYiW+tWXSRPzc9QUPWnZzhx9I3hWlVw3SmBVoaVjy7pGwXoijyGtFxD7KVLROHbS9Hm3rs4EqleEByBBcRrMYL1F2St5y8BNRzYbxMP1ds1cYyk4GFUJZZPfJrI+9bGxyYKHqRj18BdcmLMyFG3JqVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028086; c=relaxed/simple;
	bh=gV3IgstE6EyWmpnLlM00AK7iQT2R1EdAPNwX54nioZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5oYYIhm33YoHAImirBz9ptrtK+9/4bvGDLg6yXT/zZ+F1SZZVmuioF/XA26iRg9Gl66WDXvczbQEt/5R9rplSCefxUHdX17KYh+9v9LuDsSIrMaWw0dttRBjq1OsQDlQN3Sj0lxWI8CLtMwTObbrfp1HAh6YOKN8J8QKBGzT0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zaDpKGr4; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee55714625so1002180a34.0
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028084; x=1715632884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpWtxUIYbueMl3f/25QEy6F7zE5vt6N31nO6x+oL8P0=;
        b=zaDpKGr4KNb+EEYwCZv06bT94A3z8Em8MrgusTD4DDPTFp+H1O1sc6RB8I2PT5htHR
         NoOiAbP3KLuUSUdcS/c/DCg8iRmvK8GBvm0Ix4dtwQOoHtZ649ptd2F58WN6kBizFeRM
         EDCJSpjOdFMdf7rXPMWABWiydkJzQTIm8MqOGV5PGfMw+vawiu4gLf9dN4PnS2ADOxav
         AEX/A6RVx+aqZIZirExnzlh1ohZ3HjBUCpBsEmyFb33PKmpslalMPDT6OBsQzFVEDwQu
         kI0oIv+gFzw1IFansbZt/sG9mAv1G8NoWCsqnTb5NsPCFTkmDl3BFAytFiD9yBYzmVuv
         2wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028084; x=1715632884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpWtxUIYbueMl3f/25QEy6F7zE5vt6N31nO6x+oL8P0=;
        b=poIfGryB/p75nKAxnbgZN718Y1nJiOQKDXtPyOGrJwQaYfhywYNSxbRAr1S4qJcipE
         FzCb4/cUHEXJnnwedS9vY6EqJkQ5bfgmtD0q2in0h1Srj724thp2v7DbHA+Q6pbz03rJ
         a861olYzbNkY1oyYA9A8lND6OZ+1EPyXW6a9/B9CzJiLX6UdXNVo3lqYE/uaPgpkyfz/
         wQFX6NRlvMyz8xg9ps/4D9KSo25FtkmY11Wwm++WIeXQXRlD2lM/U9/ASDM43lWqyEdd
         6ZbxQL7EOtlj99cO/3pYZ4jGkoq1xohWjwvdYNUp8c6ZcUyVgVgFt0wzdxodzix+Q2dB
         tubg==
X-Gm-Message-State: AOJu0YyTF+B+530UZJ2iwR6CeATxzcW9boKmYnGq1xf8Gkk1gAmcmuDA
	/iuTniBM+1QcNG374d4m09cgqinI6q1DVfSfouqA3ww2Yn09h01ROCaw7s0pjUirG82AJuIEpUJ
	vCN0=
X-Google-Smtp-Source: AGHT+IGXM6+h1EUFvVcKEQ9ZpC6T89sr9ocT3wzUvpvWf10Yu6YCjGhkwAVYS4UJ93OQID8Fm0Gycw==
X-Received: by 2002:a9d:4d9a:0:b0:6f0:3c41:648 with SMTP id u26-20020a9d4d9a000000b006f03c410648mr5316653otk.36.1715028083685;
        Mon, 06 May 2024 13:41:23 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id bu21-20020a0568300d1500b006ee672faecesm2153546otb.8.2024.05.06.13.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:41:23 -0700 (PDT)
Message-ID: <1c1da725-0571-407c-ab68-ff38255fd853@baylibre.com>
Date: Mon, 6 May 2024 15:41:22 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: move msg state to new struct" has
 been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192725.269327-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192725.269327-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:27 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: move msg state to new struct
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-move-msg-state-to-new-struct.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.



