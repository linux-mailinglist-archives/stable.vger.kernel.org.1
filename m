Return-Path: <stable+bounces-43145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A33B8BD66A
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BADD1C20C1E
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406815B545;
	Mon,  6 May 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BGKFrY9E"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A656B76
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028113; cv=none; b=Wz4p2W2UxAe+YFOlkXycjjRxSzRoVg/XMYScnStUHlW16DLe/LLEKsW6lL37du3ZqIfLegij3uiZSTsfOVm0HivR6RJyjW+RLM5OzMobvWMQrRoICDBp1pM68/czFMZaMJTKVu0+RpSuaMp+/zbwMnGzal+JAb3IIV7QRourE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028113; c=relaxed/simple;
	bh=5pPEhDlE26oZSYHgg8roc+Pl0r1nOkMIXLVfzf3Rsys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0+8cIbmoAdKjq59hOc4WZoGsAWLTERewc2mG6cRPZQndFJ3EiwViICqZiItjI6uLT0SSkzI3JYaGehtvw4NyWbqmyR3Ox+my0r9JGYdvfVkiAb0fLo+z/axo2lP6uxQ+y8zcr+HqQTaHzzjalwbklmfl+QDQuXQ1S7Hzhr4K9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BGKFrY9E; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23f9d07829bso709552fac.3
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028111; x=1715632911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+lX/qRzifDEYWGp3jiS+KRyHZmqqDMc+Q7XnoGZLT0=;
        b=BGKFrY9EMtRj7GC7DXcRnZBkznvtRa5nq7HZiyFF1HBWVjUe4sE+DrAuaMUfyruJPo
         RUzh9UJjcBS5xgD/K4A4VjnLHxozYEVmjCSM5frGavwlJrvvU/lIoQH3TSTkT+LtR2JZ
         a3T3rv0CW3mLcZNNOP7y5rJ6AWEs6JVDG5V/bdTl6jhKKsr/7cbhGTPEYgI2w4UCeyDy
         6BtJl21sIVZ/3Heu21xDudtQ9NnWmqA5OguSVLOVVRpou7AlBz7CETUkF5gBovCyRuYZ
         xs0nC+ArwiCc97IVkDTVIsL91sNJa1SlX7ZPrp6aH1g/0nr4hY1VaYm9VyPXcGcjwKAz
         wl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028111; x=1715632911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+lX/qRzifDEYWGp3jiS+KRyHZmqqDMc+Q7XnoGZLT0=;
        b=UnI32aBPcXUyIrulQRJ9pdfy1lwJa0XfaZOcAQO6zL5kFvkMDwXZaJ4lnWbBU10NVM
         1cXEFzxPUt/UatF/kA8RPw1/7JX2L2b9jR5L2X9jc5ebdElHe7EJRcnlB3IV/RPjzOUD
         0NGjvBrcuSpbHM1ouJMPnc0/4OAzO2MpRxBFP2iG5BrLALO0yXyaaM80Csr4AMH0TDuj
         SHkaum9ATvU5ZoFsxMgmYY3/Pzhe2IEdJRMgtxsQuW0Fm8JEgF+zIvGiix7LQ/2uZjA+
         E+PB7N6uYoEPnBrHazy+ayZkVzYDHOnaIEvJA5MeqibBTKHi7SXrLBL1G2mrEis1noRU
         JJzg==
X-Gm-Message-State: AOJu0YyoEnLWnQUMUAwUV/32VyzyTwkfe509ivyOtiZXffbdOqwxOBhX
	oaMjb94o0ffXwhPc9Q/Q0RMRvWuogR6kRfjFI7NPhax7bpm0P0Pie5JkGjlSiy/Ultl3rf/uoOZ
	sXOE=
X-Google-Smtp-Source: AGHT+IF4wdDkW7DjrjLKrLHdyGX4W9ipzPZNzXfc/5f2uUM7HHbDtEwKJWsQlXFi/VOQysEnx7RrVw==
X-Received: by 2002:a05:6870:e98b:b0:22e:cbfa:678d with SMTP id r11-20020a056870e98b00b0022ecbfa678dmr12570335oao.57.1715028110790;
        Mon, 06 May 2024 13:41:50 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id re10-20020a056871628a00b002352951ba34sm2092611oab.19.2024.05.06.13.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:41:50 -0700 (PDT)
Message-ID: <13bc63c1-651a-4843-8e29-98dc7c293564@baylibre.com>
Date: Mon, 6 May 2024 15:41:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: use common AXI macros" has been added
 to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192728.269369-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192728.269369-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:27 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: use common AXI macros
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-use-common-axi-macros.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.



