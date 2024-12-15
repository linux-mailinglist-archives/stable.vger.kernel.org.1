Return-Path: <stable+bounces-104277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E49F2407
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 14:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B091883CF8
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32764189905;
	Sun, 15 Dec 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVxLKDZP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F961714CF;
	Sun, 15 Dec 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268005; cv=none; b=DX+6cuso8vATeCMo1PQPDjr3f4dWwFOMpSEcGfUZPo375MMkoU+fTtgtxWiE3M1hE+URmR8ebbWMkcyYjYh1mABwNZodcZ7ZlvI16SSgaBmKY6BteEP5FeGjiV/A6Kt8m6Oxfq6orkcZRkp05NRUxq05osWuXuvLVYbpMUKC350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268005; c=relaxed/simple;
	bh=Uz3UXC3ad9lWmYPZMxXlpUyfhBtQPk1wPl9GDqGvU3s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ENrGz3A6olxKcjT3Jd4q1QNYh+OmDeLFrgu7ZwUxkonda0kqaYWA9XIWToRuY/8kqHKUTEHkPMTrSxr3HtcEWiWbDrSlpuMIcNLCebIdG3HZF+mEhxwBqDeCrWW6U4I9s0lLNO75sgyVA+wvcEH3RpM3t/rXn5VblmTzrH2NYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVxLKDZP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436341f575fso17876715e9.1;
        Sun, 15 Dec 2024 05:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734268001; x=1734872801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4uVOIqETpLgu1IftPIECanmm5P+qCIbuOEo0dVm+x4=;
        b=XVxLKDZP2KiHmGhSlKy9uTj+4Zufwms2NDeby8ReK2UxbUhv5+raIEYO13ZQaZ/Or7
         hz+vwXLg9yJw8YT8OOIW6Y+U599c+/cG7nj8JeIab5AmlNyq3IqIr0oUW/44ADuPeD+G
         OMObVhlOXXMt/U5/MAgrWiDZq7bUsPRtQdnjU7KOiD3AoiAgqytBwUm/Yx+aQJBZNlCe
         +rC33r+leMWQFYUpqDw1gxcDeg/XARZ0EzFyoy4hr66388U4kzB/X5bcvYvvv9F+kfFn
         EYFVUM7SuZt4ScCOF+jXpauQ0nYZ5ef8LYeIUmayDbdqjS+5y0lf8KIgLGn6fH+Gjz/Y
         qGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734268001; x=1734872801;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4uVOIqETpLgu1IftPIECanmm5P+qCIbuOEo0dVm+x4=;
        b=WpDbM1n5zClqKYnQnqNRuQF+/qXzNsOFiZP+Q0LqaMLJ/CIrb/mhoXkyrnQF8RB6De
         //K/splSUfrydjJ+PE3KvqBnWaR8qOFgd6zHcTJ/Jy/W62/LQrYxwV5Zs8yvPIssfVb6
         FAmLTuEEeozSBNRyp+j73RFwR8D+guJUDDblT6kTk6CP/4ix/kpGVQ5eWZWb2yk4VlPb
         fyt5F8+9dy+KmlqsW7kFvs3tTovO4uvzOyyLla//pYfPsr5dk7EVi1ygHXC7yx/KFiso
         LE4LGxahfL3aJH+mR5xi6MAc9tWvPSG9m9JSguaXkbM6up26DUZm3ODeHRvbR5sf4HhH
         6+0w==
X-Forwarded-Encrypted: i=1; AJvYcCV7NPWWUDVkft4y0S5RCu5d0VE5aovZCaZSfgQKSh2DqiYn8zmoEgFCz1sR5sFLFo0ohcOZOoUu@vger.kernel.org, AJvYcCWIq8vqr+jp6VM9J9cdENy9TmakPitxM9TdDa6NQf7icdNp6vg1sQiEy472jcQ2lSCUBIc/4X+v19VijgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9wPCqzAIfxfZxWO7KI5/F5Q50+UeeLi7/swhrkZU0pNaUetd
	uGGvfb13fRURZB1OzFaUazzOSO01QBRpqlt6bizD7DHE8eMTj2v5lCNjKQKq
X-Gm-Gg: ASbGnctdKcSJJtfSEpDB5S7VNDMOZ6oVSLyo91/+cl66lwXHQcmVbJ9r8HoJMQRnF+o
	Rq+7Xw5C3ftWug79FdEAgI6FtT1t+NreFJNMEPTo/soU72fXNkfhI+tPiKuyKgxZUD8tevUAFxF
	YYbN2Yd2zM5N8cG5QJ81ipAFA/BGLxvF5YU9Mo8rc5+ua8LkrT17C+zXR6awTvsnblAyi5qZJMJ
	QB4MYh0mEIwXWxOHwVgaMlxXOTC64dJK/QSTaFGxiipNEHvvPrd8qhtaeVXvI+4EI20pH/060CB
	uTtWPrwVEWNOsUiespCSHbEBuDXuQg3ENqs7/g==
X-Google-Smtp-Source: AGHT+IG+kkDedAFwVxbAoEhT782acvDkTzFx+j9v7R2pyj9Jq7Po5tzUc+SnvetmP8NADbWAchG2ow==
X-Received: by 2002:a05:600c:3d15:b0:434:a1d3:a321 with SMTP id 5b1f17b1804b1-4362aa1b06cmr96201315e9.3.1734268001140;
        Sun, 15 Dec 2024 05:06:41 -0800 (PST)
Received: from ?IPV6:2a0d:6fc2:56d6:3b00:20f3:5417:1c06:8272? ([2a0d:6fc2:56d6:3b00:20f3:5417:1c06:8272])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c608sm109721265e9.16.2024.12.15.05.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 05:06:40 -0800 (PST)
Message-ID: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
Date: Sun, 15 Dec 2024 15:06:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Evgeny Kapun <abacabadabacaba@gmail.com>
Subject: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
To: Linux Sound Mailing List <linux-sound@vger.kernel.org>
Cc: Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions Mailing List <regressions@lists.linux.dev>,
 Linux Stable Mailing List <stable@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I am using an Acer Aspire A115-31 laptop. When running newer kernel 
versions, sound played through headphones is distorted, but when running 
older versions, it is not.

Kernel version: Linux version 6.12.5 (user@hostname) (gcc (Debian 
14.2.0-8) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.50.20241210) #1 
SMP PREEMPT_DYNAMIC Sun Dec 15 05:09:16 IST 2024
Operating System: Debian GNU/Linux trixie/sid

No special actions are needed to reproduce the issue. The sound is 
distorted all the time, and it doesn't depend on anything besides using 
an affected kernel version.

It seems to be caused by commit 34ab5bbc6e82214d7f7393eba26d164b303ebb4e 
(ALSA: hda/realtek - Add Headset Mic supported Acer NB platform). 
Indeed, if I remove the entry that this commit adds, the issue disappears.

lspci output for the device in question:

00:0e.0 Multimedia audio controller [0401]: Intel Corporation 
Celeron/Pentium Silver Processor High Definition Audio [8086:3198] (rev 06)
     Subsystem: Acer Incorporated [ALI] Device [1025:1360]
     Flags: bus master, fast devsel, latency 0, IRQ 130
     Memory at a1214000 (64-bit, non-prefetchable) [size=16K]
     Memory at a1000000 (64-bit, non-prefetchable) [size=1M]
     Capabilities: [50] Power Management version 3
     Capabilities: [80] Vendor Specific Information: Len=14 <?>
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
     Capabilities: [70] Express Root Complex Integrated Endpoint, 
IntMsgNum 0
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd_hda_intel, snd_soc_avs, snd_sof_pci_intel_apl


