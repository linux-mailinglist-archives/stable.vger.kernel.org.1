Return-Path: <stable+bounces-169446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7AFB252D8
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B63628142
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE02C0F66;
	Wed, 13 Aug 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiMgzoAG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4F2BF00B;
	Wed, 13 Aug 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108804; cv=none; b=YU/coVcpEZgL9DqETr8c3WK7d+E7YMThJVtSmYyTTuhI3X0XPJOMBiGh8/jxXvlr2YfJKnlFiQsjZUhh74Uh+uAbCM4G7y+bFmE0DKb7g9TVFnUqjqy/89pHPfb1rGyGnhVLIgtPj2dtIS/MFvLC+Ttw2GWWgNj59lyjZZw43N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108804; c=relaxed/simple;
	bh=bS0H2a+QAnDqgl3hZ+WnRx3C46I3JDmj81787eAk5+s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fvKoLIN4FLwEDL95iQbcYajy/EMVen1zMH681ASi95AY1c/q6nMETWE2O8ClylFGol7L1/KCwpGqPrTKTtff511kSBTSkZ6f6Uq5q/PZkjvHp3uSre42iNeVx5ibgI+/I7mfFFbYP3I+UdTIap0NptLY/RflvIVEBDo3r0mKQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiMgzoAG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e4110df6so9082f8f.2;
        Wed, 13 Aug 2025 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755108801; x=1755713601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CFKm3y9YxdU6tj7GHV2bPw1IK0NzyIQ7DL6lw+pupXM=;
        b=BiMgzoAGZ1bzVmlfviNX6YwbS7747B+pFSmD1DGQpVKMa3AG7vcZkoueLt2L+5mQkf
         ZHogTkBEzjZWVmlWMvbIBtVxIjtAs6s77ToDXekRgEsoR9JpBmeueo7LfHAV9zIi6nI5
         SZZpV669wzBMw0Yfr/5ptXhhxC8p54hQcqOb2B5rgahugymGf7VZ/vSe77obL9Q5guRN
         5M9+tFloy6U0aC7njkgX8/hDrn4tZnp8RsCRgTzpqv3u4mHGMU3/39k/JNZl5GEDUuG8
         6vL40X5ypz7dX5U0Rff35NNJxURv4f4J4l8z3VuEZ7SlkRaB0LyCjA02UTLvPJn/wqpZ
         1aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755108801; x=1755713601;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFKm3y9YxdU6tj7GHV2bPw1IK0NzyIQ7DL6lw+pupXM=;
        b=nQ3WMSk7dgNaFl0aOhXjNSYeg7WamlreHJCcC4LtpL9sI70W5gKd+Cgqrx6XvQFalH
         IJ4UTLx0VJ8lBKHNbtHrS7VLXgxtToktKhuIuhYqjokyUNNffKEnuMP9DMQMbuGcy510
         PZdYkoy8AGiPNf4dmJoJQ+gOCuykjVbc5ffXMOkb1cB7TUfWa3WqsAI4jz2GCpYG2c/q
         Hp/ZhB6+3A/SqOk0frJn+OGrFp9ebNmzyJCqhlsg2/feAxd2nURdgeXwax9+DC1TH6zZ
         bhNAun2WQA1sDZaD3YqUEDQ/5RJFVYb6RSfYvUwdLhYZvE79sZggTJC9h72TFEzzTmgF
         NxzA==
X-Forwarded-Encrypted: i=1; AJvYcCWHF9BzwLXmk2YIs7N03Pa0GrKKxweFQxcrgrhSYECWM7CNBAEh0RHRHkCgLL19rUgRvudrFE5B@vger.kernel.org, AJvYcCXcVVH2NDgKwzfV1oSULaU/6kTThU+XdFpF+t7LC8SeycJ9IMkFsKALhxMNbDf8RjdEqYGrQFZkDQ8nyvQ=@vger.kernel.org, AJvYcCXngXj5FZU/B6QyJniWJY4jywWu7WTpZKwjoMEqLuYaiix95Drt+afadRXiBb2sYDlgNQqSYIrMUaDH@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuiH7el6npvPUxuyfZGy7EMSk1ue/8Faaxzu2RSEX+Br7t0lg
	BFPzmOWQDdHjSaySf6rWL+McekXPMX+fYKB5OY8uOsJwNzySiqKKUzip
X-Gm-Gg: ASbGncsMpZb4jzKgEAd6mIPfoXWglTPffCo/lYZJ8WYW4uozK6T4QhdeYO2tgJFuSH8
	TiYMlEQWEN3jV4M8eKqeP0CUEfiOSyrFSR2Wp1xImcYK6GOMyqYt2PqGQJ2ydWIbxkuO4HahGLj
	aQH+S+o+JcJMsuUeaDm6phHw97xl0Om9KLieJQbiZX8V0LVEGYHt4pmexBwGccDF8/Cv9Y3sHkj
	BOat7CchsUNja2MvwnHN4RZZ13FqBmCZB04nzAQKEcmbv/bX2Pu1KL33Xva2E95klrrQ+OfMJR2
	CNZ9fcxqiWgoC+2o/HxXF1s5UcsrXusxFlgBfn8xRyxWenmC34CrWV25GAm8hidIfJsWKwD1HjW
	BEh1oR7vIqextT8R9idRqlF1bKLHZxYcXBOXoMw==
X-Google-Smtp-Source: AGHT+IGhKvZwl0to1Oo4/pwCJw1lBPPHJZC5G0h6a0/mKBazrrc9aWQ5GrOz4lZ42Gtxfp8bRDeQvA==
X-Received: by 2002:a05:6000:2586:b0:3a4:f8a9:a03e with SMTP id ffacd0b85a97d-3b9edf84e33mr85213f8f.3.1755108801153;
        Wed, 13 Aug 2025 11:13:21 -0700 (PDT)
Received: from [127.0.0.1] ([185.115.6.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8ff860acbsm22133742f8f.51.2025.08.13.11.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 11:13:20 -0700 (PDT)
Date: Wed, 13 Aug 2025 22:13:18 +0400
From: Giorgi <giorgitchankvetadze1997@gmail.com>
To: Zenm Chen <zenmchen@gmail.com>, stern@rowland.harvard.edu
CC: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, pkshih@realtek.com, rtl8821cerfe2@gmail.com,
 stable@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 usbwifi2024@gmail.com, zenmchen@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_USB=3A_storage=3A_Ignore_driver_CD?=
 =?US-ASCII?Q?_mode_for_Realtek_multi-mode_Wi-Fi_dongles?=
User-Agent: Thunderbird for Android
In-Reply-To: <8560A878-1EAE-4FE3-B96E-2916E27F90F5@gmail.com>
References: <ff043574-e479-4a56-86a4-feaa35877d1a@rowland.harvard.edu> <20250813175313.2585-1-zenmchen@gmail.com> <8560A878-1EAE-4FE3-B96E-2916E27F90F5@gmail.com>
Message-ID: <A54117AB-2BFD-4864-AEA3-4F1AF977A869@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maybe we could only add US_FL_IGNORE_DEVICE for the exact Realtek-based mod=
els (Mercury MW310UH, D-Link AX9U, etc=2E) that fail with usb_modeswitch=2E

This avoids disabling access to the emulated CD for unrelated devices=2E


>On August 13, 2025 9:53:12 PM GMT+04:00, Zenm Chen <zenmchen@gmail=2Ecom>=
 wrote:
>>Alan Stern <stern@rowland=2Eharvard=2Eedu> =E6=96=BC 2025=E5=B9=B48=E6=
=9C=8814=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:58=E5=AF=AB=E9=81=
=93=EF=BC=9A
>>>
>>> On Thu, Aug 14, 2025 at 12:24:15AM +0800, Zenm Chen wrote:
>>> > Many Realtek USB Wi-Fi dongles released in recent years have two mod=
es:
>>> > one is driver CD mode which has Windows driver onboard, another one =
is
>>> > Wi-Fi mode=2E Add the US_FL_IGNORE_DEVICE quirk for these multi-mode=
 devices=2E
>>> > Otherwise, usb_modeswitch may fail to switch them to Wi-Fi mode=2E
>>>
>>> There are several other entries like this already in the unusual_devs=
=2Eh
>>> file=2E  But I wonder if we really still need them=2E  Shouldn't the
>>> usb_modeswitch program be smart enough by now to know how to handle
>>> these things?
>>
>>Hi Alan,
>>
>>Thanks for your review and reply=2E
>>
>>Without this patch applied, usb_modeswitch cannot switch my Mercury MW31=
0UH
>>into Wi-Fi mode [1]=2E I also ran into a similar problem like [2] with D=
-Link
>>AX9U, so I believe this patch is needed=2E
>>
>>>
>>> In theory, someone might want to access the Windows driver on the
>>> emulated CD=2E  With this quirk, they wouldn't be able to=2E
>>>
>>
>>Actually an emulated CD doesn't appear when I insert these 2 Wi-Fi dongl=
es into
>>my Linux PC, so users cannot access that Windows driver even if this pat=
ch is not=20
>>applied=2E
>>
>>> Alan Stern
>>
>>[1] https://drive=2Egoogle=2Ecom/file/d/1YfWUTxKnvSeu1egMSwcF-memu3Kis8M=
g/view?usp=3Ddrive_link
>>
>>[2] https://github=2Ecom/morrownr/rtw89/issues/10
>>

