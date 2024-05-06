Return-Path: <stable+bounces-43153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC658BD679
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418BFB21C10
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748715B54C;
	Mon,  6 May 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PDFH5Qus"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA31591E0
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028383; cv=none; b=ggCy7N4YpJHeULwfgHS+Y59N1U2hmr+l4HZVTLLTTS85z56fYRlJtpXARD6mIncFVb3q+1ryVNUmcGTTNFuZin17YHmv9S//yk2KFsuTIF099A79Aq8bI/F+WGmuNUbDXbzyLE3f5hQA4Ijq326y5CrVTF505GLoWSdqZ//Yu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028383; c=relaxed/simple;
	bh=MQNKjEUSJ8IxYLnuF5MgQBKqcwkBw3NoK6nxZnnndWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYEA/7w1tPP+1PCN5ojaa6s/cqVU34WaaF5yYVzvWFpbgyXjEM3Erokze/ruS+vMJKZ5uVoKVwXGA7SlEZquKC2e4RDKq+mwN5x+pQ4d+lef8f2vrFUQnzGFfdSRWp6Mz/uTKxR5Tsdn7IqTlG8gFOIr8fxAz4GFo9XSttZXoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PDFH5Qus; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f0307322d5so1156897a34.0
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028381; x=1715633181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaJb9YW9sZNgi7roH3VsQFNm+wCEIKH8NPxIM0g1sxI=;
        b=PDFH5QusKqnyzdUnm8H742/hGFtO5NKQgBGJFbhTf8EORDJ2X8WnBf8QWqppG/WUf2
         gM26A9X3SmdzX0lE6K8rxaw1QDnPl+k9UC6SGsnLoOxmijffBKGunixJeEO59eX6OAev
         blc4aP/SRV8WtIioivy5Z2g1q4cu194NUTUTaWGJn/fL4rAIDJtJfzyeUeQBPITgpUBs
         BDeaxAbgxbrtzGT0OY+ihuUlIoPKqZ3wzHojlVwltsDavQy2I/+5okAqPl6MSyvKfXbo
         WwvW4kOXTW67Kjo5pfVPtneY3cOMYK3U16CuYF+tFsYodBY1Jw4Br+pZOJS2KK6RnEKe
         U1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028381; x=1715633181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaJb9YW9sZNgi7roH3VsQFNm+wCEIKH8NPxIM0g1sxI=;
        b=ft9R3KOguF9leUs2sXbAap1vuNto1u0WjoleNUYnKhY05WKNEk79kmkGMFHKghNS7K
         lQHkOV7aemP/6EuEK7pRh4M7E5bOzFTNWibCnVoUewQ9Gqw3gMhfRf2YQPeWDELEboEt
         Vo+6Xvvty/NlBH6oaT81B9vDGCII3x1iYu/tC8inRt0wRMnmWYK+qtuybMqZVRil/NQN
         +hUdCsb3s995wEm7+bWVAZi8idWCGm7wWYS1CtTur9mzSc/qL5T01Lgcg6AoJ73Vdi6o
         RjQdEPMXzWrw+XHOxCqWBl478lmrUk0y2HsvRbao0z4jlfp1Ty5SD/N8hf3gtkdDDW9r
         Hotg==
X-Gm-Message-State: AOJu0YyTgvyRpe6fqCHoDA0+PaMDJDLVggkATiMCute99ClGNmo3ndg/
	iLZTJKp5jE6NWWv6S4Iww4tx+lGX3OceDzT08GuYuv4N6hK31jsvUVMEy9Dw39jP81hYf1tUxrA
	VlPM=
X-Google-Smtp-Source: AGHT+IHqTACCD6CnSQscOncYHzzd6vg8K2oKc2qA89Ncp9laoYcqJHqWHE6WBpIkiPWhIzSyRIA/oQ==
X-Received: by 2002:a05:6830:3101:b0:6ee:23dd:7441 with SMTP id b1-20020a056830310100b006ee23dd7441mr15679640ots.28.1715028380919;
        Mon, 06 May 2024 13:46:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cb9-20020a056830618900b006ebc7c57b41sm2126085otb.50.2024.05.06.13.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:46:20 -0700 (PDT)
Message-ID: <a6253255-9133-424c-8dad-fc7f75bdd38d@baylibre.com>
Date: Mon, 6 May 2024 15:46:19 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: use common AXI macros" has been added
 to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193023.272000-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193023.272000-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: use common AXI macros
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-use-common-axi-macros.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.



