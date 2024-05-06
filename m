Return-Path: <stable+bounces-43147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE6C8BD66F
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EFA1C2082E
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711F56B76;
	Mon,  6 May 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="siBwFAuc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BC1581EC
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028231; cv=none; b=DlCsDD6nnGpQkwGp6bpZBkVm97PR2eVgoDHchNNclS44Q+v1u91lgqJzYsTB1v4hKfJeC2vaioLnwwq0UmaTfmYczuDDI+moLN4PbNgXSWI2lKyhRuBuX0uTEfhs2lM83Jl+GZGQnWW6Q0Xkha55wNcukI1luCWS9rAs0IE6YAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028231; c=relaxed/simple;
	bh=9G94LjS23mZncAJTsjzovMYp/3ZmOc/2XC2Gk7lmxRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F68zthuHiFfGT3RcPglAvkhZySDGoImt2UbVqiyNI6syBAXSG5i5L4G6AV62ekjr8imzGrQ+TjlDXSwhPKHnVkVzzwecQEaTYWKDk5hDfQg6TfHRBg0ktPtFPwVMsfNXlzSJOwqXRzTy9/bW6kIFLUyJV8WQOt4vZL+zeHwjbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=siBwFAuc; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f07115e6caso556966a34.2
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028229; x=1715633029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IN6GPPbUnliAaDRnyMrEhCkqq8n74e/H67HxdhGB9r8=;
        b=siBwFAucXjw0Yv/PHOfsqBqVmJ8ORBxM2LVPKlPdN/pgpVm9nL8A/na8BqI7fieFxK
         rOAuAEYX8K4KYm0rPQOUD4usf2GSs7virf3qGABVIBxh7QGN4JnH+YQMEtEVe2u4wfLQ
         Elytdn7ROIyZvxol+8bpAf9NwZCrTW9draXctBUf/Q0pFGarcA06YmuSvCH1lS325LCS
         HvjMKFHWWTpRJlMA6q3ZZGio1s+mpE2KiAAc8Qc0ofwByq6JyJgfAQH3wV/Ywg2XdeTq
         aqgXJi2+3Q3lRitp+UejfI/Dup+T+TW/cDK8uv3Z0lKRmfVLHO2mL2v7g5sZPRbmjMJd
         AbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028229; x=1715633029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IN6GPPbUnliAaDRnyMrEhCkqq8n74e/H67HxdhGB9r8=;
        b=V5adHdtB8cJa4CYcTVKPRkzfw1juON2lKvv6oN35YxPqd0xCqT/3cOE2gKgUGb2qz2
         0DrRn0Qt6Dq/Y8PpBlQ9YiQbbySI79cGqycVZUD2K2EjHg0AiRHQeRrEDEE7HLgZaa2f
         cz9uOoaBCdSpRdQZ42ECWe2U7XydsEuUFk+Q1cqRe40fe0SAT3rRENzu25fCLSPnpUXo
         ZeK9jQWW23hhUKCIWZoa5v/k4TqsswtSAsmwyJlHM/zq3rWUGCoZBBOug06ETYAcsRed
         0hWoE5Mnf1LgrkZaMLTooHShhQb7caVsLCu7Pz0DK4acZmI36KhuJJIl2MxEsMwSzjEh
         TDoA==
X-Gm-Message-State: AOJu0YwLWPYycnHgbYlWG6mMHlvALGfH0xZV1V+1L8mO/gFVPw3THJgq
	zpj3EsBzpL5UFVkgydsPjhFLQTAxWiv/fB1tsYxxJ54FiKbxMu0BZkhrNnrweqjYBfY6QH5qMl7
	gEiM=
X-Google-Smtp-Source: AGHT+IGDL/ssbT7A9s7dlyH+s87HxH3RoXKMxWgdhTtvjjKhjwQ6fHulwHpYsiqOVLGqfqFRT9/4WQ==
X-Received: by 2002:a9d:6c06:0:b0:6f0:6420:35cb with SMTP id f6-20020a9d6c06000000b006f0642035cbmr3540717otq.29.1715028228991;
        Mon, 06 May 2024 13:43:48 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d6212000000b006ef8773670dsm2108803otj.64.2024.05.06.13.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:43:48 -0700 (PDT)
Message-ID: <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
Date: Mon, 6 May 2024 15:43:47 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 u.kleine-koenig@pengutronix.de
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193007.271745-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193007.271745-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: Convert to platform remove callback returning void
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-convert-to-platform-remove-callba.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 


Does not meet the criteria for stable.



