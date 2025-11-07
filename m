Return-Path: <stable+bounces-192689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98AC3EB05
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 08:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B76784E4FC0
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 07:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E7304BD0;
	Fri,  7 Nov 2025 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="Gz/gXOQg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF73054EE
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499084; cv=none; b=JyDUCvN5bpKFfezPqR0L70kJBZwGEVb6Zspka1liRJJP1gOd7d/yxYCiP5lAmjGsvyxY7+hvtDgQsdDZGLkl2HTYqZnR33PDuwC8ZCCKTzKdreK3Kx8KgDUB8sw+se+QvedtmXrq9g+IWS3WSuxp3m5GSAwAn9rU5yDtQBA9zK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499084; c=relaxed/simple;
	bh=XtzOsbt2hl6xTu2IJUUbKD60Sc3xgdEK+LN2FPoMKUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FycfPmBanhdv1WfxSqPyFbkZKd0hPhPO/QmsuGEN7k67r54bJ4jDxpIVAyPgnBZ7yD+4qbw9SyKxCMEcwxNTJcFnP5R2rfm4doOBV7uAQqE6RtQT4VEbY+0tCci1OnTwU9/n6BjEFZ8z1aKG5kFmcBw2H4JNtddUHWScq2Rm/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=Gz/gXOQg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed9c19248bso807511cf.1
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 23:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762499082; x=1763103882; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYnIiKrQX8aCtjj//tDqMdxlWqP5fq15qVk6nPAkZoo=;
        b=Gz/gXOQgt+dwzIv+KSlNZ9YmsY0aUnJP6LxVbCZDaMfQiel5yb5nr8msIa3TLRFSJu
         tUQf9T/cXxxnYt9ro9XlGu0YYPoRbxA06W4rs+yDQKtKKVCW3j85YFgi71yb6kp31kme
         YuxDqNQbxjsPhRULRC4ScjuIHf2kErzsMZw5wSJor4n5G9hI2XkXtd8Iuc/Vn3YQyvGK
         4llkusVoAhduhwehwrqPBTdt2KI1U68YFh5TAXMu8toCiU8k37dWPufJG6k3oYIB4sjf
         DP+bfZBlz5cPwwZcJ4c8Zx5vGyuWehxR80ZgKaKwvYJlibs08StXOUUWfjgJcx5DgMJR
         E6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499082; x=1763103882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYnIiKrQX8aCtjj//tDqMdxlWqP5fq15qVk6nPAkZoo=;
        b=dqISmrAw2pvnaK9C7xSZEeTUyslTLKU69YgVkVc9jdvdcvXOyadZISu40rZXn1llLH
         auPTLW6BxIfMp/S7wnUX8xLK1md5bmgIKgiC2CxWzuqSsxKXnOZ6BPt9E9ZnV9j19H7B
         EeFAIde4ogCMfZ9XtdC2sQ8DoWhClJi5Q134pwR7tko2tYlRYQIay3URAQ8OAKTFD2nZ
         jUdL0JOd8aBVK/TqdLVgUladR7xrAfoLnV2wx1iyNZ1Fcou6FCg+wUlNp7sYsKgThIEs
         VkHAp1R2Amdm9JOt3UO2fCKXBsKsF/0aXH0vYHJVtC8J5cL2qZB6RNCt1hX1jA/C7kGP
         ZaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmyh5XWx/uZX+g0GEpQkD47luzhJEw8Bvt2Nx/NePt/OqLgXI6uR6GFWniQF58C13D1aN0ViY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAkwnu7GsQh7goOuSTgz+EPyKN8WwJRlZ69gsArIV49x4OYSa
	QGRoJl5hl246VGPYHbAa1xFNYOp5mGo8vBATo+4kXADrykiLv4iZi+h9MCvvMKPm9wA=
X-Gm-Gg: ASbGncs47bhTY1ADKdKN1lxyqvJGH+tsaf+DJBDPD/9r0Bzn/zO960IOm278HEeSnHo
	y/qOi4NyIvwpwu3IYMeyYeGLEUfT/OtNiSRfQrPPDugFcUQZfRkhzOCE1u0jW4gG9O4TAS8Dxug
	5AptcK8RLZ9Bqf8OCoT9LS/qZDZ4q+p1dkLZxKPnd3HPb9tWtozXTmE4SsWkkV1evWuyuxg/UO2
	1PAjwe89FEytF5yf0122olbRFuQjR4486LNdjY3z3qG1ZN/7Jbacb9mbK5EBzV5mPBQ5x5HgIIt
	AqhMNuFDmfSe/3N/QDNkWJX+rdTiJUbafctZC03HJaERk6rmIMm9Clj3tEg6HCimCOyXoDihzsx
	+26o7hp7l9uIqW0FQCwm0TmrVkIlkuf66gwDhUezRwfD02t+sc38OwDavU4XXTBv40ENl7+bjrf
	vYJDpSkU777EqPQNSzF6pSiqRxSqP7iQ==
X-Google-Smtp-Source: AGHT+IFwNzL1muZtb0IN53C7CPHVqzEIYh0SCwcsQzMl/w3PfdY3Ho9ZrT9AzNk7OQH5c7wzQoWICA==
X-Received: by 2002:a05:622a:111:b0:4eb:9c80:f6a0 with SMTP id d75a77b69052e-4ed94a4b3bfmr30924711cf.52.1762499082271;
        Thu, 06 Nov 2025 23:04:42 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88082a3ac4fsm34529256d6.57.2025.11.06.23.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 23:04:42 -0800 (PST)
Date: Fri, 7 Nov 2025 02:04:40 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-mips@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: PROBLEM: boot hang on Indy R4400SC (regression)
Message-ID: <g3scb7mfjbsohdszieqkappslj6m7qu3ou766nckt2remg3ide@izgvehzcdbsu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After a recent 6.1.y stable kernel update, my Indy (mips64 R4400SC) now
just stops booting early, just before when I would normally see the
kernel messages about mounting the root filesystem.

There are no further messages of any kind, and the boot process does not
appear to ever complete.  However, the kernel is not fully crashed, as
it does respond to sysrq commands from the keyboard (and I do get output
on the console from these).

I bisected to the following:
  
    794b679a28bb59a4533ae39a7cf945b9d5bbe336 is the first bad commit
    commit 794b679a28bb59a4533ae39a7cf945b9d5bbe336
    Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
    Date:   Sat Jun 7 13:43:56 2025 +0100
    
        MIPS: mm: tlb-r4k: Uniquify TLB entries on init
    
        commit 35ad7e181541aa5757f9f316768d3e64403ec843 upstream.

This reverts cleanly on top of 6.1.158 and the resulting kernel boots
normally.  I then reproduced this failure on 6.18-rc4.  Reverting
35ad7e181541 on top of 6.18-rc4 also results in a normal boot.

Let me know if you need any more info!

Thanks,
  Nick

