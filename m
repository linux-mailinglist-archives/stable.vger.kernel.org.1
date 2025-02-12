Return-Path: <stable+bounces-115061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F2A32939
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 15:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F18D3A230C
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FA20DD4E;
	Wed, 12 Feb 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YO5m4KmK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BF20E315
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372121; cv=none; b=ewChuclM8USpQZbYSmbJpqyErWIXSFxa/Kj/mXrc3DwXr3nGsWbRJevQ9afV1rKWBuMVGkzG/OdpbHZoBYCnHmqvISSVXHS156RTXXcNaYpHR3B+T3zyCtiKuRSdM+IpIKW7sTvDde7qCHUF9FjLCd+vUrTZ+HiZ6g2EyPSsEzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372121; c=relaxed/simple;
	bh=IbtkV7VYdQ+EOOTcesgmqmBfGe4HNr+O1bDE8ixf3H0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jGjzd1SFOwhAYXFI9HEbpgAk8SayT6OtjsIoBTSm1lTHUWjxhcxW+ipgofAfNakm1mK+QLGPT4P5uXZo3T38aOHG4PG2sV3eGxpOQP0mjGj0KpPv4q7cL9KPFlamEXphDx2y3OEqQ8ZEMpEZ4D+Hb7L1ns6DQKUWLqRBORxAz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YO5m4KmK; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2b89395a3efso1631921fac.2
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739372119; x=1739976919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MSNg6ZKNxkzJrjibxZqNXmnNpAozgQEy/8YtDWWeQ0Q=;
        b=YO5m4KmK/AlHy7HfIQl2mbORBTV1sljQ11Ca6NvIRy9J0g4eJvHJPAZi+Go1OEX/6p
         l3hFYWjdfD8hafLkJaaqdXKN5nm3kClnXk9UB0GVckYxohcKfO5dofGSMc/G87Bd/a7v
         jIwTJrUZrY5kykY7XTRr60nQ5U+B4HOzuqzP/Vmd8uvaFENnbU8nSzujoirTOfklqdTw
         82GsrSoND0deETE/0ALcWmsjalyFNihjm7Lpl0W4FDrlVQY3PbqLYgS/Uig5F5xCrieX
         OEmxivRcdGLaUL4UV/6+RGM6Pf3ERFpp1hN1gpGC6yvRuqkdfJyoWzZkoyVReLEtHPyy
         HUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372119; x=1739976919;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSNg6ZKNxkzJrjibxZqNXmnNpAozgQEy/8YtDWWeQ0Q=;
        b=QFK/MyfmjkSTS6519HR5UmkkhQg7LAMlPteZKvM7WxxLjHmigY4uC2WgH1rNayh4mW
         1HgSival23GDGXYsJRofpqdB2oGjYIoGGyq3mQzyl6d4ITyIORxQSDzNl7nvZzBP1Wet
         U9JmvR2VrNPSppQ0n4lOMC3gBL/6zAJhwCOmLMLUXgauPuJqPYwew6QGiCjmd10dFWXm
         vu8bREMoLxhbSsk/InWd2sEJ7Q9PcOWtyPqOw73lK6rZvuOj0un/JcdW7PRSR5J0eHs/
         npHS/REtpKdkKJD4CNtYE/MXSUrwct36DJkxsYKh8k/IytPQszu4YXHCXE3apOtQWFQy
         CtWg==
X-Gm-Message-State: AOJu0YzwuBvhGBSJKTUQd+ReaCW1S6hsar+2cIHwK3ZKQ9o8lkbMzfdW
	WWcVz5WzaFIdXbmWqQNXWmrO/OdH5mZu6w/bYd/BopJvwH3hWr8bT8UKRkzAFCBC0v2BX+TT7nY
	OWEPTGZU01/wZ4bvmJ/AzklxHt4IGWcrj
X-Gm-Gg: ASbGncsismTMPoM57L4opNZ56Rm5vVRnXn09mWmlOcODInmB/YsEqeIxvmuLn5sVElv
	etTZm55KpAbYkAGHqLdUzi29FnA83znE/xwTvu/fumqF+XUCHhQxXLW4aZ9jLJrjw3NJbVyyfwd
	Gt1QicMaL3elk8L8HXW+PLBY+xsAUSkEE=
X-Google-Smtp-Source: AGHT+IEG3yKnzH2nfEOb3BpqpatWdPALoI0meFuH9P4QQ3DJpeuXmmEPPcSQ25B/BU8RcOhyRkLePQ6xnYDFaP2ol0U=
X-Received: by 2002:a05:6870:3914:b0:2b3:8b27:c352 with SMTP id
 586e51a60fabf-2b8d682ff06mr2378978fac.33.1739372118789; Wed, 12 Feb 2025
 06:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Avram Bublil <avram.bublil@gmail.com>
Date: Wed, 12 Feb 2025 16:55:07 +0200
X-Gm-Features: AWEUYZnJy2lzPNeOGF5BFFO2WMoYTOsevQ8QMq92WEyjMbO3WFupeJlHqyrOtBM
Message-ID: <CABtvoZ1Y8u6KwoKf07X5_nJ-S-WrMVS_21tT2sezNV2u4AhLNw@mail.gmail.com>
Subject: Regression: 6.12 no longer loads the snd_hda_intel driver for Cannon
 Lake PCH cAVS [8086:a348] (rev 10) - (Realtek ALC3234)
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The card works fine on 6.6.
Here's the output of alsa-info.sh for 6.6 (where it works):
http://alsa-project.org/db/?f=ac3a0849a332189eb61a640fe94b46de369a655c

Here's the output for 6.12:
http://alsa-project.org/db/?f=22995c74392ed86393fc2c180ab7ae010e6cbfbb

Here's the output of $ lspci -k | grep -A 3 Audio
00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
    DeviceName: Onboard - Sound
    Subsystem: Dell Device 0871
    Kernel modules: snd_hda_intel, snd_soc_avs, snd_sof_pci_intel_cnl

I have initially also added modinfo for snd_hda_intel, snd_soc_avs,
and snd_sof_pci_intel_cnl - But my email was flagged as spam, so I
won't do so now.

Installed sound related packages:
sof-firmware 2024.09.2-1
alsa-ucm-conf 1.2.13-2

If there's a need for more information, please let me know.

