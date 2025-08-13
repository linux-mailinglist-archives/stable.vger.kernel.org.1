Return-Path: <stable+bounces-169474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743F6B25799
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0551C7A8CE2
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8764C81;
	Wed, 13 Aug 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFT9La8q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281F9475;
	Wed, 13 Aug 2025 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127941; cv=none; b=UGnlNKgMTOWooJsIp6tgL/NhxBFos8GlkMDQ1Hvz8C39hwPyQQqDIas0wpO63qpT8cyPHuKDo5UZGI3+HfZU1TQnQrH3i1BDhcKvMcaBRZ5jLY2Znmc4iCdE/xYTn+Q78sESPBhsNvtx+CO6vESCDiKyBukhRrOE+3fAf78RU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127941; c=relaxed/simple;
	bh=IPZD2yebRuj/uMok82uFFvp8FHqpgQcFGQjagfqpNkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akjAh1pkI/f5pWf556dv0i+WsiO7ddnb87eRBnu3kgsxxtpUj4TXbKopLaUGVx9wAQuyP7JQ7dxrHtoC3bg/74rUTrvX4vt6pq6pekECioon2SVeeJSx8RsFpwvPOrgomQy+mtNpwBVdGkN5tKhPc7wreAHFP72rrhc/vwri4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFT9La8q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244581d9866so2761295ad.2;
        Wed, 13 Aug 2025 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127938; x=1755732738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhsrtDmy6BVYWayk9pIuLqmtPvT+43DQ3nZ2+dNEhvc=;
        b=eFT9La8qg+L0fg+k1G4jbH4UrNtm8S3QZFHlOZguvLjtGW8n2neqEoviCrXOjd5eZv
         Tya/Gl2/NXh1ZX+ppRsUTthWOqLLaRu16ECpc30JcClsf82vlflxTBg4luucLz5BzoYo
         rIfoOJmpyhItUauGeROUbTZpz38fCdftOgW0ObtOfFtDLItswykcslIITNBiaASst501
         VG0k+BujArUPN1jfeptNxQyiFp8qxjYNN86HbpzjTeIcxNfHo7HYgB9BE3lkcOPRTe2f
         cwc4a93Kma8uUt3oNDVrx9Vw7Kq+fM5kQyAthntrhDcM+Y/2iYVS0T51gKyoW1XZPAoF
         7TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127938; x=1755732738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhsrtDmy6BVYWayk9pIuLqmtPvT+43DQ3nZ2+dNEhvc=;
        b=u8n4SdvnAXtILOwFlCt6hBgy7liHixvbBRhq1qNOK08ZVXKJkzuHLKgGmqoaUToGzU
         btiKNjDEBk/150ZuHGd5h2QeA5nkg6KC9VKAtROvinXi623tiapaT2f0HzQLG2TCTzqF
         h4LhqoBVFj4HNPAQnlv49JPTnopQSbBSBYRJ5t2eGK0oGGB/B3BRyYMp5TSzZsX5iv7m
         8EkUmTbRJNaKeBbTi5zjwXwRrYZM8mQAT03aCA1K4HvDFnvZXmzkZwdc3obI6EfChW4m
         y5gqVX3tBeO7QaCPbrJJGc4RpMDmhFppYmPBxGv2CCGRR/EFEJtHodkiCic+V0vJaCot
         B2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/C/f9cDAtlkXW7vdssellOHDG1jDq44CDPZAjdXq32mu8e6/lBxSR6WoZqmZpNnB0e8bm+3CnTT69fC0=@vger.kernel.org, AJvYcCV/Gf0D18v0CxP/KOnnF7kI04lFqMOGjrHnMtdMwuWi4NwdiHaN1kGWTgwce9qflDNsEsIVGIlmDfbl@vger.kernel.org, AJvYcCVelaQMherZwCMyUOVcAaV8zRMoJN5hY7xecnfnyJJcVMHlQE5j9PhGjdHBEh/zZPTTgBi7TAqU@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUYlHOBADhQGUWwuEiLNriC/1YnIfQ414t0mVl6KCtNxVfR/L
	IwIEptyaO23dd7NzhVsMPLXH8l2KjZBdp793Pq0ohfXxA7EQCptF5tbP
X-Gm-Gg: ASbGncuaMII66fIofbfhJoJMq3Y166ipM0Ok7BWMZMIhRg2ub0zg/RvGX+ObM94qS6r
	dsjwZ3hPE82qQ0a+RiVGTY90Ewyv4L2rshN+fXFPprwjhtEsicg/SjpbD9lSy2Zezy6DYSHBcAB
	UK5dETsIm31JVP/aYV4rNl1PZYBCE9eKuF8HRyQWJ6Bsh8fOvfvHrsNLU+6VBbulK7DX4/xO+SE
	gJXsDChxA6lmLjJoEJ1pEPl3mk/dPf0TeIrqGAkjMJy43NTW8afzn2lqQKC5/ww2Hq6oFJjFT8U
	IvApAjlzXGKOZefYl79X/nFv2t9SCuRd4YDmeLNkY66Dj7/ZrxjhRmm3/+rPFhS2V6mF9XRpLTx
	5gq5zg6s05JaO7tGalBg/YBAD0ihBNjlliXawyavtkvF5W2w9wp4W
X-Google-Smtp-Source: AGHT+IFIC2SD7jfDV+NnFqnL7JS06OvdUNGKsm3ogVSquVWJS5AdJuRgUW/FUpYLFzvsqZ0kjdzGAA==
X-Received: by 2002:a17:903:b8f:b0:242:9d61:2b60 with SMTP id d9443c01a7336-244584b467cmr12353115ad.6.1755127938319;
        Wed, 13 Aug 2025 16:32:18 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241d1f0e945sm335665145ad.56.2025.08.13.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:32:18 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: giorgitchankvetadze1997@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	usb-storage@lists.one-eyed-alien.net,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Thu, 14 Aug 2025 07:32:13 +0800
Message-ID: <20250813233214.5069-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <A54117AB-2BFD-4864-AEA3-4F1AF977A869@gmail.com>
References: <A54117AB-2BFD-4864-AEA3-4F1AF977A869@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Giorgi <giorgitchankvetadze1997@gmail.com> 於 2025年8月14日 週四 上午2:07寫道：
>
> Maybe we could only add US_FL_IGNORE_DEVICE for the exact Realtek-based models (Mercury MW310UH, D-Link AX9U, etc.) that fail with usb_modeswitch.
>
> This avoids disabling access to the emulated CD for unrelated devices.

All the Realtek multi-mode Wi-Fi dongles share these two ID (0bda:1a2b and 0bda:a192), so I don't know how to achieve this. 

>
>
> On August 13, 2025 9:53:12 PM GMT+04:00, Zenm Chen <zenmchen@gmail.com> wrote:
>>
>> Alan Stern <stern@rowland.harvard.edu> 於 2025年8月14日 週四 上午12:58寫道：
>>>
>>>
>>>  On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
>>>>
>>>> Many Realtek USB Wi-Fi dongles released in recent years have two modes:
>>>> one is driver CD mode which has Windows driver onboard, another one is
>>>> Wi-Fi mode. Add the US_FL_IGNORE_DEVICE quirk for these multi-mode devices.
>>>> Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode.
>>>
>>>
>>>  There are several other entries like this already in the unusual_devs.h
>>>  file.  But I wonder if we really still need them.  Shouldn't the
>>>  usb_modeswitch program be smart enough by now to know how to handle
>>>  these things?
>>
>>
>> Hi Alan,
>>
>> Thanks for your review and reply.
>>
>> Without this patch applied, usb_modeswitch cannot switch my Mercury MW310UH
>> into Wi-Fi mode [1]. I also ran into a similar problem like [2] with D-Link
>> AX9U, so I believe this patch is needed.
>>
>>>
>>>  In theory, someone might want to access the Windows driver on the
>>>  emulated CD.  With this quirk, they wouldn't be able to.
>>>
>>
>> Actually an emulated CD doesn't appear when I insert these 2 Wi-Fi dongles into
>> my Linux PC, so users cannot access that Windows driver even if this patch is not
>> applied.
>>
>>> Alan Stern
>>
>>
>> [1] https://drive.google.com/file/d/1YfWUTxKnvSeu1egMSwcF-memu3Kis8Mg/view?usp=drive_link
>>
>> [2] https://github.com/morrownr/rtw89/issues/10
>>

