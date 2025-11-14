Return-Path: <stable+bounces-194791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC6C5D10B
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 13:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEC0135B77D
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593A190664;
	Fri, 14 Nov 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H2s0BiSy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2786329
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122650; cv=none; b=fCl0FyoWWybf0Q6hk/HiAgKsLKRTbr9JEsIq4qMJK3bdnc31ALq183f/dMlNGG/rQ9sjK5aThtA8wnFcEz+eCviGCv3si0jTRxGZ7QWviom6bzUdw6VaM9TP7MTLp58kODlYTRL+p1knmX0PHwj2MSWcZOwNjsyVBEef+Pkyw1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122650; c=relaxed/simple;
	bh=/jHCYvHfudowXNxZZJBjH1r13Co+r5TD+q0QuXa4PVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzMqus4VvJm5oNnUQiatmazwPc68NG3UPqjUN2Qqx0vNYnfP07OvMEBtUB5h9aLmo01su0m1QhQBH0CCPM07/RQKdxCMJMS+hYWJVdZvw0DDrdqnLIyPlJl1VBtg6ZnOKsEpdl6X4hLvdcjcDxA2lTizZbWKbaF/h2c71r1iP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H2s0BiSy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c82bf86bso1071956f8f.1
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 04:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763122647; x=1763727447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWbVdVcKmIgQNXcQML6O29oQ0R011ddFFEiHnoRKaJQ=;
        b=H2s0BiSyTnI8++0jjZOaCLTVwk4Lxjq32VWTYiCy+p6hXrCHD7J51Ui8xOoSwsQKcD
         G3Y9gU6psRpMYUbCtBy8Gzk2fAtUze+ROOGNJVjNruaOiJXjhOc5s/5C4HddL2VDfbPt
         /G+XjnlFyV0g017qrpFOurQ5xIInZXCAboqrBT5GpNc72XIhaddMMMhy0AoO62FDlPqn
         K6fjwEZgkLBjFzDs6d4xgwwjvx3y9Yi7hK0CUezsdYcpL4jinQYw4fgO8BMu7blJiqfs
         2CrK8RhV0jN5CKbgYNRhMpsUJO8wB/n61BErei/5PaqETnoRFny7cLKGep1amAwlMvTD
         nV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122647; x=1763727447;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWbVdVcKmIgQNXcQML6O29oQ0R011ddFFEiHnoRKaJQ=;
        b=XWn675Qoli2c5tX1IfGwwUWsgEfgIpe9ff/5KIhMuZltFbebc34m5UFPQrycoPvLbr
         fxI+PgIpvTMwdvyvPelO8QiOZtJhoT90Vu7SiVyo/PXvGYERpaG0a3WgNPJs/x+QTbk4
         HPQnu8HNYaB+WyWEnsDcfAJPYrdVC5dEwmzrhcPz1Wb6g5KYJdLhqj4beOZlFMZZ9lTX
         fRpp+bPHXSyKqET0ZkFy0y1fBApCGwtOi4pJvqk83gU3fKs6MSB0pkx9fmtLE+0HQ2Ux
         IYVbFfhwmJncgp9tPoOjnVVdH8SEdppMJ/xp2oODRgRyKmidPAKyDjCeW/t6Q/R1ZUDI
         Kj9w==
X-Forwarded-Encrypted: i=1; AJvYcCXVSOso6cP+VFZK8kMrj2RKwgHjJv8TaDz3f+Ri8CY42quvG1Fnvuo+9KHiQTBEpUjkfwUlrOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6AAM6fqJGxTOwsShAG0n3nE+fe2RXJiGQ025Hv+gsCHDGAY5
	lizHV/6QwxEQFGLxhod10CEMJR8Ph5HxC11dK6JEXyxxA8KJ/y54U/lBFlrI6lbYYYU=
X-Gm-Gg: ASbGnctR9/5LPUMlpQ3VI/2m4zStPZ+wIm4M+BDt1fF9RhZ+WRVBKanJ2eF8wJcm0gy
	16J4qt5dMupHHgA1usp7gkSu4h3wuccgFlWlyj76ISnObGmXFKlpulTHaTabbnczScEndMvTH4W
	gHXKZsAvjY2FbA3BHvqTBDVe0lCwiYqbXz8w5IQFj8mjYrUDPFOekNwCzTQ9+R0tByI4WZ6qTKu
	17RTm90YSJVQl5iOitC52CUJtYt6ll3o2bGoOlxYCutEDGrvKanGnkaNqeWVKa/YTZbm4LuBqGH
	kR6hTiKRSd9Gm80EVlaIpwkdH1OWjpgX/EkX79UHuTFJ/CGUPXFXGvelNeK44OJcUfZXtkYjA4p
	IlWkkEDVjhlKhIpJF7rPu8CJyxRhJOFm+6yfzZKlFBHXqDmkac2vXpjiq00a67K8Trl0gv8K66/
	JbCa9w5I6m
X-Google-Smtp-Source: AGHT+IHWDEjSqjebElJ40Y85LJmLRDwBFGhrOde2zVXNUcqPkVLjSRdizuSu3jurgeaQwyEgPyTdEg==
X-Received: by 2002:a05:6000:2008:b0:42b:31da:18b1 with SMTP id ffacd0b85a97d-42b59397865mr2717515f8f.56.1763122647208;
        Fri, 14 Nov 2025 04:17:27 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm9409253f8f.33.2025.11.14.04.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 04:17:25 -0800 (PST)
Message-ID: <ffcb6730-2e1b-452a-b44e-60c8432175e0@tuxon.dev>
Date: Fri, 14 Nov 2025 14:17:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: microchip: sama7g5: fix uart fifo size to
 32
To: nicolas.ferre@microchip.com,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ryan Wanner <ryan.wanner@microchip.com>,
 Cristian Birsan <cristian.birsan@microchip.com>, stable@vger.kernel.org
References: <20251114103313.20220-1-nicolas.ferre@microchip.com>
 <20251114103313.20220-2-nicolas.ferre@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251114103313.20220-2-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 12:33, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> On some flexcom nodes related to uart, the fifo sizes were wrong: fix
> them to 32 data.
> 
> Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
> Cc: <stable@vger.kernel.org> # 5.15+
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Applied to at91-dt, thanks!

