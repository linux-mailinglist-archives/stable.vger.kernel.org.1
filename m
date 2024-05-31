Return-Path: <stable+bounces-47757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1168D585E
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 03:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA9282ADC
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310A8EAF9;
	Fri, 31 May 2024 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="VcajzOfq"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5EB33DF
	for <stable@vger.kernel.org>; Fri, 31 May 2024 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120077; cv=none; b=r7DWRNuqj1aE5T4u3IlKYsCJFI/Tht9b/ebMG4ErLMHl/RXE3HgsE5zjMFW4PMgeIs5HhMEz4pgPAutONnPAwPyh0hPseguaBwnce+5TgTjXdV7QrIglkL2ETaAva+9JmgG8lBHzJymDw01o6QpubN8YfB3cGmmkf9Uo1l3WRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120077; c=relaxed/simple;
	bh=spFT7fqw/RnowwUWeM6qD9avCugctzGtTh7kK2XoxhA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nLvWNa1ADgRWkAaXTOH2tPfEARyTEPXTVStxsj8CV7NP79QeDft3evq5FOie0s6M3lOs6dB2jc2Ha+2pVUZ2lHpZOYfSfY94oknUbMzSoSkptL2VKkfB/SgQj29dUZ9FtBbZxz9sP7vAedyobhU2YWMgLIvt7QQUg3ySaimlC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=VcajzOfq; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e21dfbc310so66701039f.1
        for <stable@vger.kernel.org>; Thu, 30 May 2024 18:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1717120074; x=1717724874; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xWbTyt19+Ee7c28JfZmNhNlACXrTR/T2Hhrve401sas=;
        b=VcajzOfqBHkRVHMH6/JiCHuVaOJRNNlSeHuknAkKn65+PKhFSkgbeyylx+9Vdl4lyC
         i7ZLiD/Pea5pLzyTf7pbHX/jlHd9mjoEj+UP+JmsNcgiTxEIiod0sev0b6TJB3Zub2Ab
         +VZY7liamXiIQWcOLwxZTSZUSPcro4B4k3g/IN0ByMe/mPrhnTcB46J/RYJrDOLTS4mD
         D5deQwm7sb2qzfJKJH02Cc1DmgyOEY2Fms5sAw9OWqh39I88MPKhY84kJI3Qm9FyjZf8
         DcDPeAXJ3h5rLU6G8M2H2fbNHNYuW8DhZr4orme6E/n9IsLxikcEefFeHoyDDHhVqAFo
         hiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717120074; x=1717724874;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWbTyt19+Ee7c28JfZmNhNlACXrTR/T2Hhrve401sas=;
        b=IGDCq5u6nRAg1h1yF9FpKIoP2K8w6pCvMM5fUfF67rdRLyl8SVgwMGsRy2HQCkoiXL
         9i4Cr+2WxIBREskB+6Xa+9j8jhm0CntsFL4gu6HXs0h6VONi3rpnIDYNz8Y1IOVZUMNY
         E228Rqivtbo9v1y2FP5pnDs3rHovDX/5yJ/TgUKr4BFY/cWJZPXdwk27OvcGxD7eELdT
         PBMrm6Cluqil0liLVphentGVKabOcnE1/h/rkEob/VTZPDBp6eiVEV8GE/tanT/WNwJ4
         FLFzx8Ecz2tPwhwpz5+Kx189sXCMG6O7Sckph/h3eHbwFFrysnDFZx9LInSzsWrhZQeb
         f3ow==
X-Gm-Message-State: AOJu0YzkQaQ6v0uUM4s6yxZxTWPstghtxw9c9HEP6EOjrd/JJ+SRNNCI
	UMqNATXWrVKlBRjamWF6xhAx83WwoscNVP5r+i49AuZ1kyMSkZbcmFLKB1uSheJKN9Ni3Rb0AsI
	Nyjg7Q+4e3VIFR9iSDn981mDrNgby7q3GK88xvEHC77LqAquCIkQ=
X-Google-Smtp-Source: AGHT+IEcFR8QwHmjrV6Qpot0evdhyHJfbkD7oP0xLMP5dPSYbuwvk2i+qVOM3LzlQWB31hMHMiByMD0yK17+D9mjh/Y=
X-Received: by 2002:a05:6602:1489:b0:7e1:b4b2:d701 with SMTP id
 ca18e2360f4ac-7eaffe72422mr69953939f.2.1717120074554; Thu, 30 May 2024
 18:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ronnie Sahlberg <rsahlberg@ciq.com>
Date: Thu, 30 May 2024 21:47:43 -0400
Message-ID: <CAK4epfwH1KvQgEgXt3ifmQtnHDOKG7xJ5G-5H6cvqUH7dWfGtw@mail.gmail.com>
Subject: Candidates for stable v6.9..v6.10-rc1 Out Of Bounds
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These commits reference out.of.bound between v6.9 and v6.10-rc1

These commits are not, yet, in stable/linux-rolling-stable.
Let me know if you would rather me compare to a different repo/branch.
The list has been manually pruned to only contain commits that look like
actual issues.
If they contain a Fixes line it has been verified that at least one of the
commits that the Fixes tag(s) reference is in stable/linux-rolling-stable


2ba24864d2f61b52210b Syz Fuzzers, Out of bounds
3ebc46ca8675de6378e3 Syz Fuzzers, Out of bounds
9841991a446c87f90f66 Kernel panic, NULL pointer, Out of bounds
51fafb3cd7fcf4f46826 Out of bounds
45cf976008ddef4a9c9a Out of bounds
8b2faf1a4f3b6c748c0d Out of bounds
faa4364bef2ec0060de3 Buffer overflow, Out of bounds
8ee1b439b1540ae54314 Out of bounds
7b4c74cf22d7584d1eb4 Out of bounds
1008368e1c7e36bdec01 Out of bounds


-- 
Ronnie Sahlberg [Principal Software Engineer, Linux]

P 775 384 8203 | E [email] | W ciq.com

