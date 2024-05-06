Return-Path: <stable+bounces-43143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC508BD652
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3561F21A08
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A115B15D;
	Mon,  6 May 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RoxDWwWy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A015ADBA
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027932; cv=none; b=inEfRAf36rCN7MD/97YOk81nqJx8s2bQ1p4+TYXPLt54OVdoic4z7Uj8mlxUgSrIHFLlU0JErlRD9kTLbX6KoCn/7UjAhm+nxwOMQBbOhGVwQX1dIbOko+SdyDBeudlRMsA1KqBQKWa2nCyVZOEvR22hF3SdpPql2hsPXU6VuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027932; c=relaxed/simple;
	bh=XCTQGNcx8f8Li3z4cXJ7DJqH7rttzprFsGFZGGHc1fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/Pa0BFDvSqNG02aHVEFPbSTTzb0YRuZ5KedRUYMAKXC6lcNAWBEMHk9xhBqfe9zjfBH4iGbA7nH+DJ0u4rz+hvoOFfDgKcj75L46rzcyq+QcwXQRNtdef0apM28YlMg61yXzBeuHvrhZA0Q1dc+LgE2DAf06PpgOnn3WCCzZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RoxDWwWy; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f05160d778so580638a34.0
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715027930; x=1715632730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkKX+ZiQJgIIQ+3YnFIEowFbaWVkaQYcdr6YmIq0tPU=;
        b=RoxDWwWyuI5CabKbkKipQdotnfETvNiFS0TZwY11a4M2urJVL5NBY2R8thxXB9h1s1
         AkWU6lcEPIxkbVVWOWREQQP2xKBvxFFZUeJPNbteQT8SMtye1ApOeTiK3o0BtHHlBiG7
         xBnU6nGrXED8ouNWLnywhCQuAubcjLaMxLC0kwp1JxhO27yti5pgETcZ0zFnCEgJ1EL9
         Jmz6aHoX0ntpLgc79X/lsDXh+mbPgGUg5nblcK1HTWt74WFCIFAVfqUaYv5GnoF9/pum
         ra9wyjft7ji+F2Xi7rqTb8oSi1yflxyHftkhMMCfOXQdNX9nLpaaUOKbeWzGrmgF/99d
         6yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027930; x=1715632730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkKX+ZiQJgIIQ+3YnFIEowFbaWVkaQYcdr6YmIq0tPU=;
        b=p6Cw4DvXIZtQjmTXujJItX19Hl1cbray9Q3Gbi5K1HCKfiU+b2dG1jXY5YFlBIgC8U
         F/XDHI0b2uSXzG0kdZ9w95ad0j817ngoLecnvIFH7qOmJM6/x89cukvkHm9I6BvT8NxN
         jGInxIWi8hDngDwCJG3ejKqB/rwBzfAd+zfQXHXYemrPSk2oZSmcokVOsHyeqoMGAHrK
         xAgsn+qZphn8PLSDii2IucefB7evy0aQEfsGTkO3CcGWSWpEEMZmlAgFr31UpPk1iEzc
         E1MsfJLmLxDxxdLA9Ddn6rbo0mLw0farIc9q0SpCzEmsXo47B8eX5INLnonPfLDuojOY
         zofw==
X-Gm-Message-State: AOJu0Ywmq8YGGISPmMbiHtIKiHkrhrPSsldxZGT6KzHArm0G1MDkJ+Kd
	4vnmLI+Ijki0x3jq8GNtNiEdY8hZ480/ubAOxjVRPbmnetesx5xhoQNt6EJFcU4n3SpeSGiNhgC
	9oB0=
X-Google-Smtp-Source: AGHT+IGPawI4aCd1OSTws+WF6ERuR4mIIUg2xLTT2XGZ0j5EssXlKakc/W9da+xswvkZ5JaN3ItJhw==
X-Received: by 2002:a9d:75d5:0:b0:6ef:8b89:acdd with SMTP id c21-20020a9d75d5000000b006ef8b89acddmr369685otl.11.1715027930211;
        Mon, 06 May 2024 13:38:50 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ea13-20020a0568306d8d00b006ef9dcc95d2sm2132164otb.77.2024.05.06.13.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:38:49 -0700 (PDT)
Message-ID: <5c271cae-cbbb-441c-95a2-d4848621d8f8@baylibre.com>
Date: Mon, 6 May 2024 15:38:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: use devm_spi_alloc_host()" has been
 added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192722.269285-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192722.269285-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:27 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: use devm_spi_alloc_host()
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-use-devm_spi_alloc_host.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.



