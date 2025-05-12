Return-Path: <stable+bounces-144031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526C2AB45FE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E88C3ADD7B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F95298C02;
	Mon, 12 May 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnRhd7ZM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C51383;
	Mon, 12 May 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747084598; cv=none; b=t4sGzIkRm8graJ6A9jYFUsZpdta7va4X3JBWHQF/fKXNUhqxclmt603zu+Wi0k8Qx6uNCs46wQiTNQE5ild6vySPtT52fabPM/VR8Ub/dn+HqxYIRdLvZpMm3m2S9bm9j2Uy/MpKJ8ffgOLdIauOeG3ePK3LstLcoWrzYBHngu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747084598; c=relaxed/simple;
	bh=REsOT5/Kf4epauIk/+gj5qaRQFY+1LyOd7d456HgZ10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OukC+dnSAa10k8DCD830B1FGGap67LK2H8Jp+iMovxStLlbgKBzZPaG1uJbm+8/jcgkWwUltxk+yV3vkqDrBfXlohn9wx1u8ggvi4Usn0IfdaokjjsLpEXq1e0Ja8WDwTwWkjN7AMwoFT5cHRkBIf8x3UTNRqV2m8zxKq6HZmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnRhd7ZM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54fc35a390eso5895226e87.3;
        Mon, 12 May 2025 14:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747084593; x=1747689393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWbcMuS3JaNmPcNaeeeXONbeofrLDqA7Uwckra+1Fjk=;
        b=ZnRhd7ZMRU8/MiruStLKg3znE5OwuWKDYsDQ0vY1bZ94PiVOhe2ECxh0QBVeP9HU0d
         aIV3bnpgZKrMyxtc5WsUzGwIIoLb0vLCHCcIo2PBHaMU4jQFoL89yI5rYyk4Us3H6o7W
         5cdbMkbYrxeBs8Mdmm976mIkNetXU/ma/DJdkbhbz98yCSzf4kM1+9py/z2VFkv28TSD
         llujtqK2Mf7mxaPsYSiqUQ2EG46rv0qpW4eFo14Jo1iaLyC6ExnPkXnx5fRXTj7zZhH+
         pCi/xVEe6M8q2sYKfkABiMFWDbFBhLKcSbXUgLD9MuIrR0lg/pKEyC8ooLEF9Vkdnejg
         MlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747084593; x=1747689393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWbcMuS3JaNmPcNaeeeXONbeofrLDqA7Uwckra+1Fjk=;
        b=FRiptOgInKpUCSvRW1cTverjSQ2OJV9ry4/yQGXIv/wUzoP91hbOuhoqWkbTb9rdSj
         XNKTobe3okeCnIATeaMB4sEgpJiqpg63+KndpBBDmORiVQpN9S4taqzsXPmarzMgu2Cd
         4f0yNhzGSzFc6vUCSJT9DI3vvI/qpmjFxCPagyb1l5IQepu2R5dqnvARA3Oh1loDslJM
         S/s3N7rVl7UgAR3hax4741TR0cjeataU12Fh5RQdeM4YRyn1JIUEdNqJ5md/dOpaDyfL
         EQtiCY+jrrbP/YHEkv95oZLmCNQXjniFqkQmumLtj/YpTC1MDwQ/6DN0YHfGiRhRHUAe
         w2yg==
X-Forwarded-Encrypted: i=1; AJvYcCUeIfkb9nqoPONqFrKdrJWqhQ4zyX/Orv5cNUInxj0rNQHFVneNSNe6ixPnK0SeI3D+E8G8lwu2@vger.kernel.org, AJvYcCVTzKNVNBn7FDI4wzlP/+L6V/JP3li0kRaatvdfDky47aI/QP7SPNc93IuGmfHnCWstamaByjohOnUD@vger.kernel.org, AJvYcCXpP1Y/ZbB9GXLzdo0v86I/w7uyKyFyjgh1LlnKdfqZPjnteZCk1ne5N+WbZD/9dJWqOoaQ9pV0H05Iri0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZFex2i07t++V8fhUCgPXNZ0NrpTHfefEaMJwkJUtVGGoLUez
	6pFOth9fELI9xEudgYPH8vvvqWoZLqUHg3NC6bkWO8OIdYD9gTdS/XpMfw==
X-Gm-Gg: ASbGncvoNLKUmm77Zi2IGr/p40wNtLMZHtj1GUoZJsShU35+HYToLXrM8pg+9qM1qVH
	qpJ+fFDWRD+xJiOE8TMg/gahGmtzIbc4vQyb0X43l+viwIwsL66VQZJEDJc8BilyQfr++nBgoJ0
	oNinNy5/Ak7u+ICEr3WKdRtFrejBCGfuSxBVlPF5qGFBUMi0rjCHg+a+CmmnABebBEZEulK/uVJ
	FS3jzHkUSTv5/Jrb2bBWTvdtClSk+x4Z7XaayuoWUu6gOgbrIDKMSsubHbDIrrseJP/NNJzytnZ
	AJoWiwlzDwCrqnl0H/qkKEquKLC9PrfvYRZ6B0rubz6aYl1IPV8v2lVGU7cASpP3LWvQ
X-Google-Smtp-Source: AGHT+IFTxOz++Epfa9FUTfKl46pds1Z1TZVgLGjtOWGgDj44Awn8Wu6umfFxWxnIFLPiy+CDrfxGQw==
X-Received: by 2002:a05:6512:2312:b0:54f:c65f:b908 with SMTP id 2adb3069b0e04-54fc67e2368mr5082998e87.49.1747084593039;
        Mon, 12 May 2025 14:16:33 -0700 (PDT)
Received: from foxbook (adqk186.neoplus.adsl.tpnet.pl. [79.185.144.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64b6fe9sm1608430e87.149.2025.05.12.14.16.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 May 2025 14:16:32 -0700 (PDT)
Date: Mon, 12 May 2025 23:16:28 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, Jonathan Bell
 <jonathan@raspberrypi.org>, Oliver Neukum <oneukum@suse.com>, Mathias Nyman
 <mathias.nyman@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 08/15] usb: xhci: Don't trust the EP
 Context cycle bit when moving HW dequeue
Message-ID: <20250512231628.7f91f435@foxbook>
In-Reply-To: <20250512180352.437356-8-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
	<20250512180352.437356-8-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 14:03:43 -0400, Sasha Levin wrote:
> From: Michal Pecio <michal.pecio@gmail.com>
> 
> [ Upstream commit 6328bdc988d23201c700e1e7e04eb05a1149ac1e ]
> 
> VIA VL805 doesn't bother updating the EP Context cycle bit when the
> endpoint halts. This is seen by patching xhci_move_dequeue_past_td()
> to print the cycle bits of the EP Context and the TRB at hw_dequeue
> and then disconnecting a flash drive while reading it. Actual cycle
> state is random as expected, but the EP Context bit is always 1.
> 
> This means that the cycle state produced by this function is wrong
> half the time, and then the endpoint stops working.
> 
> Work around it by looking at the cycle bit of TD's end_trb instead
> of believing the Endpoint or Stream Context. Specifically:
> 
> - rename cycle_found to hw_dequeue_found to avoid confusion
> - initialize new_cycle from td->end_trb instead of hw_dequeue
> - switch new_cycle toggling to happen after end_trb is found
> 
> Now a workload which regularly stalls the device works normally for
> a few hours and clearly demonstrates the HW bug - the EP Context bit
> is not updated in a new cycle until Set TR Dequeue overwrites it:
> 
> [  +0,000298] sd 10:0:0:0: [sdc] Attached SCSI disk
> [  +0,011758] cycle bits: TRB 1 EP Ctx 1
> [  +5,947138] cycle bits: TRB 1 EP Ctx 1
> [  +0,065731] cycle bits: TRB 0 EP Ctx 1
> [  +0,064022] cycle bits: TRB 0 EP Ctx 0
> [  +0,063297] cycle bits: TRB 0 EP Ctx 0
> [  +0,069823] cycle bits: TRB 0 EP Ctx 0
> [  +0,063390] cycle bits: TRB 1 EP Ctx 0
> [  +0,063064] cycle bits: TRB 1 EP Ctx 1
> [  +0,062293] cycle bits: TRB 1 EP Ctx 1
> [  +0,066087] cycle bits: TRB 0 EP Ctx 1
> [  +0,063636] cycle bits: TRB 0 EP Ctx 0
> [  +0,066360] cycle bits: TRB 0 EP Ctx 0
> 
> Also tested on the buggy ASM1042 which moves EP Context dequeue to
> the next TRB after errors, one problem case addressed by the rework
> that implemented this loop. In this case hw_dequeue can be enqueue,
> so simply picking the cycle bit of TRB at hw_dequeue wouldn't work.
> 
> Commit 5255660b208a ("xhci: add quirk for host controllers that
> don't update endpoint DCS") tried to solve the stale cycle problem,
> but it was more complex and got reverted due to a reported issue.
> 
> Cc: Jonathan Bell <jonathan@raspberrypi.org>
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Link: https://lore.kernel.org/r/20250505125630.561699-2-mathias.nyman@linux.intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi,

This wasn't tagged for stable because the function may potentially
still be affected by some unforeseen HW bugs, and previous attempt
at fixing the issue ran into trouble and nobody truly knows why.

The problem is very old and not critically severe, so I think this
can wait till 6.15. People don't like minor release regressions.

Regards,
Michal

