Return-Path: <stable+bounces-47714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E898D4D94
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C541F22CCB
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227B3186E4C;
	Thu, 30 May 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2v9pBP+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352F186E26;
	Thu, 30 May 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078296; cv=none; b=KGQZ985BnemlwjnCvw7DqK/OtvV88xd8XwuIkjo7ChnGgvUgZ6KtkMPkJwzAnI+O0XXM8vFySqitnclyIZ6maMlIGruVKWZZNGORbxiqZ9ktwvQcli3kDm4yYdMjt6zt8IRzHbJMoAqvso0rbzNx8Sb7I8+8rAEX4KotSrawoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078296; c=relaxed/simple;
	bh=lPdCGa5O5KLkJEVwOzZXBaHd0o3xalJ9Felp4M8Wflg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC8n9I7UheS4Te8bWf66v47DdKiWCfPsEXblfwLyF1URcwCVGlUQAGLZk2vpZ3e52fo3NTxn7Cj887EZeUQAVcKKP75Uty10AJVbcdyyDsyJC1FzKZLVyVyyy1R/FZHuLOGdiU9lq+rpf+FOYyPhDyQlQE+xh/9wRvcn/m1sKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2v9pBP+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b03d66861so1004514e87.1;
        Thu, 30 May 2024 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717078293; x=1717683093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZmEU3SBpPG/sBMOca6omkgj05kfljvBQaH7bfHXFzk=;
        b=B2v9pBP+rYtQitx/zSUtJvpZO9XbAJFYgiAlfal0h0MK+6AX3yeTOe+9BOKpaXE60m
         znbWrQZj8+9bqfn5Z21q6z6muN2CeYAEHczyZsbzTR4foeFKB6GDaaMJPC1vJNP6/tFF
         RvoSsOuJoqcF2vjzyUICarOhak4DRPHpfaRN2SQvmTYpJurGCQW2DnDE74ISHVEyVxrd
         XgBezRTNts8Ow/QO868nVBWNXo+G1Q2teBGupJT3DWKLjjndtgFBbTvuJ2VHtY9NjNj2
         itf55NAws9gieMpfrIPbDDJoFKdKfXdOevQQChkVR4jqPTQkJtn5cZ26pyOol7oXgomZ
         VfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078293; x=1717683093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZmEU3SBpPG/sBMOca6omkgj05kfljvBQaH7bfHXFzk=;
        b=dk6XS3943QkNkAyY8W87TYczL0gQDVHfVd3/iraP+nSh5Gzfrq/1KiZH/uxeAQVSUm
         7njiI/OwThqK/dbOo3FvKzc2lroJYroyPOLz4Z0Tpp9rSoSJzFE0Lut3ngDZxAyaknSU
         12wnQdAulo7aBGr/hDm1jY+57r2MmQlqbgAHgRmpj1Hvk0cEKLva+1M8Aix8BEMUNn/L
         UvcFERaiaEBOcHZX4+A0dQJUp+sc0ty9Ezpte2D/V/3E0Nz0+6SvQp8swjPSN07gAFVB
         RpD3IuA83ZuQqDLVkRO17aPeFdoJehKmWIec5vi1La4AgMKfY8vG2Ro+XtPhhXbQ/9RH
         8IqA==
X-Forwarded-Encrypted: i=1; AJvYcCUfYkqsmkrQyKoGBjxbcas2PLymj944s60JRPxC62ejttXMZbioFsBwl/RJpYBbZ7lTIWG1L3O9wqn1KnLTU6XPK12CGwn3jaaqClWvPJiJPA4PBZPrfFuSE1bFH8+dl2eG
X-Gm-Message-State: AOJu0YxscTZ+/gkj8AkX7MrA7rxEcM2bC30I9hS2HV/n7Urc5ONwWmba
	w9pRV5BGlP6lSdUu8va1f8YiazQSQc9KC6mt4VvBL0dyZPPyHmm7
X-Google-Smtp-Source: AGHT+IE4P4dKpdXdT1FydFYrnu5pSdueHetjlCYLyVpEqN/8Xj0TR00W97OR5a7PsMTadqNW4Yy+pw==
X-Received: by 2002:ac2:58fc:0:b0:529:b712:e6d5 with SMTP id 2adb3069b0e04-52b7d434d4bmr1168354e87.31.1717078293155;
        Thu, 30 May 2024 07:11:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:594:c10:98cb:dfc7:1b74:ae2? ([2a01:e0a:594:c10:98cb:dfc7:1b74:ae2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127061e04sm26340685e9.19.2024.05.30.07.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 07:11:32 -0700 (PDT)
Message-ID: <71aad8a3-ab3a-432d-8725-5e17d56a3b4f@gmail.com>
Date: Thu, 30 May 2024 16:11:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: ahci: Do not apply Intel PCS quirk on Intel Alder
 Lake
To: Niklas Cassel <cassel@kernel.org>, Jason Nader <dev@kayoway.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org
References: <20240513135302.1869084-1-dev@kayoway.com>
 <20240521133624.1103100-1-dev@kayoway.com> <ZlRAWMJTTAy6Yg0V@ryzen.lan>
Content-Language: en-US, fr
From: Alex <yannssoloa@gmail.com>
In-Reply-To: <ZlRAWMJTTAy6Yg0V@ryzen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/05/2024 10:12, Niklas Cassel wrote:

> 
> Applied:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.10-fixes

Thank you a lot for the fix, at last, i will see again my ssd :)

