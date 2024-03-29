Return-Path: <stable+bounces-33738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046258920AB
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46BAB39085
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AAE386;
	Fri, 29 Mar 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6zU8Yzq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1052F6F
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725671; cv=none; b=tfTksKbHlKkNoUZ5q36wEG/ccCH6vUTsZVOs/3EKMK5XEfZF3OxycgMmJBrGG21/yJ3xkprJikGOb1NE4xvsQyT272LqiNgXY7lvrmXt2yYDOx7/rR11FjRp66QHpB7lvqmaVUIeP4dj2QNxoRl6BmD6ruHq5B0cmEWC6grRAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725671; c=relaxed/simple;
	bh=2YD/CMAbrUGVAP0HPybXV7ApTqLDwTkW8f0hGkdl0h0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=X+Bgij4X5SB+EJ0OAZNPVxbSZicj4zKvVCw+ZkLDUdNOnpju//riVB4n2DZ1BlllmsTClsoSoBdlVx+J2UeRyvMPDoGjXg6mL88Lj3OSwywHZqq+F08pC2jOeaz1fFM1cYWnt36Ah7myP6s+3BSB5RVhk1o9gVCV79mF1zvNxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6zU8Yzq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e40fad4fdso34404366b.2
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711725669; x=1712330469; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4ZNcLkhCoetnyeaUQXMj5X/oh8psgAL474DwX1Jy6k=;
        b=h6zU8YzqszsBvGRrNuVvc5kIZu8jJazzsVRJq/nCe8KvLnZSlRgmrEhN1fXhNV2N7p
         A6c0J2wRwFZKncZ93saVAY932OGjdxQdSlWlO223cwif8ArD6haC0hQRMC9OAhb4UFxJ
         ZbHkbtGwdhDV4J76WUAjZqiw8+7K2vEdcGsLp61zlhuPWG0LY61duBybDvEan7n7EnJ6
         3MOoqUKburlZ2aExBWZoincMUb6fn0JC/nQvLrz41mCvL7RXcOhd9FyJ4KxQJz2sWkVe
         yG+47vz9Ldhl1B1SlEKLUnF7QKyPc7fIu0HvvbVoUfuuUOx1dNDXTYmzgevW7rNIvBzT
         WTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711725669; x=1712330469;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4ZNcLkhCoetnyeaUQXMj5X/oh8psgAL474DwX1Jy6k=;
        b=hXYshltenHVS1YMWlSfH6aY/Z6MPocFRKwDRUrXKv4gbcun5kR5XvtYh3QYT/VTTBy
         luWuwnlUkgmKJ+HQor2XQEUA25m2fjaqxV/NLhdmDNDKDRx+AYqUbGi3i9wUwfgr40pr
         RB+2J6f54OOVCmcpK3qBXcAQdqFaknmcDiJZr3wqLdBLFvOn0VSPZYjZmPrUnfON9Dwz
         cUZFEecdD2S3ctSWFM5s9vmeBhNqM8/H8ORZxqQHxA3ALIwKgiUpfcQ2dySk6ICJKFuh
         Gth0kU4UmDQBvzdywX7S2wXo/kz8B6Ky1xoI4HnCtwySrr6HWNylxaDF4pHMvb3IH0rK
         cv0w==
X-Gm-Message-State: AOJu0Yw9HwXc9Fc3ih3/TLzre0pLBv5IxgxUKApnfVEOGUTlKmb3Sp/E
	Miv1focRfBs9d2CaowWJ9skxGBMVJMR6HeDHMLE/pE50VlbbgT980afFMtU=
X-Google-Smtp-Source: AGHT+IFK6nWKmBOXCVlZeadYZrCqYsuM0BLFwEpD9HVvqOtfWI8oK3w5X3EUQMV4pmqDTVYwkeG3xg==
X-Received: by 2002:a17:906:3454:b0:a47:4fed:514a with SMTP id d20-20020a170906345400b00a474fed514amr1644434ejb.52.1711725668528;
        Fri, 29 Mar 2024 08:21:08 -0700 (PDT)
Received: from [192.168.178.150] (i58039.upc-i.chello.nl. [62.195.58.39])
        by smtp.googlemail.com with ESMTPSA id q16-20020a1709060e5000b00a47531764fdsm2032012eji.65.2024.03.29.08.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 08:21:08 -0700 (PDT)
Message-ID: <1ee68691-9eb4-404a-adb4-fdaaf12c905d@gmail.com>
Date: Fri, 29 Mar 2024 16:21:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Content-Language: en-US
Cc: regressions@lists.linux.dev
From: =?UTF-8?Q?L=C3=A9o_COLISSON?= <leo.colisson@gmail.com>
Subject: Regression : Latitude 5500 do not always go to true sleep mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux maintainers,

Since I upgraded my system (from NixOs release 
2caf4ef5005ecc68141ecb4aac271079f7371c44, running linux 5.15.90, to 
b8697e57f10292a6165a20f03d2f42920dfaf973, running linux 6.6.19), my 
system started to experience a weird behavior : when closing the lid, 
the system does not always go to a true sleep mode : when I restart it, 
the battery is drained. Not sure what I can try here.

You can find more information on my tries here, with some journalctl logs :

- https://github.com/NixOS/nixpkgs/issues/299464

- 
https://discourse.nixos.org/t/since-upgrade-my-laptop-does-not-go-to-sleep-when-closing-the-lid/42243/2

Cheers,
Léo


