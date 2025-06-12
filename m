Return-Path: <stable+bounces-152571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84197AD7933
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46120162F30
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AD027146B;
	Thu, 12 Jun 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OOzYm4Nc"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5F235C1E
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749941; cv=none; b=uPqAvz2Lsf80hPXXhs1UjV7dCQ84jpxM87BaOoT+jS6Txu08ynh/zVMzZLFWLaRESVkY4BNOI7FdL6qM8WC6impU2DBgZbofx8jwfrQP9jcJX1FRmg0vB1yf4KiTMgpXK/yhRngqw8tNJ5lndTkDHjdTVMJuaGCwQbI4kJt3OwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749941; c=relaxed/simple;
	bh=aAB2yhGhf/FAgwfubAOGkPhordjM5AIhfyD4t7m2+L0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WUsNuUTJQ+g2+gHL2aRluiwJdwaAVmJoYGmo2qD1a839fMZLLTKmnGEGwPh82BSAJiF3OExpImm2g5cFh+q07hOvw4mG53bscZ7NXlt6ExyjnQmCl4B4JK3KjQzOCqSYUPe84CZBVqhX0mP4UoND8MR21kCr/MaWgeQYOrajdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OOzYm4Nc; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so9894565ab.2
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749749935; x=1750354735; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l80CneWFsJjwT0yLsFNo3lvCWgsM1Nlzg/3pe85ojOg=;
        b=OOzYm4NcsfXm8GicIXnnMqadPKddBHgmfLP3+Nml+L3nip09eMLbmwNmQGrvribKgV
         VznYx/5A+9NZlTT5LgP83D8QGzR2t7+n3Lb9bJjW9lQRmqB3G0h9+PptiMorbk65trON
         v/gjNSEz9yhvHzTjw17a8Eu13Feq7B7CBEwIYixGr4Ltg6XH4/Tp6+WBLz1X30Vvgxap
         /4k2q6aQCXWvkRk9s2JmdFud9hZ17Up0hMRqEBSc1RPoYyzZj6cS82/I6EbI0pgHO4LF
         uE705o7ezPPZxYqq6PS5PFrH6UXUXWs1fYq2CmwIU2Q7h5gA82/4+tHMecVHZvkvtcUa
         mHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749749935; x=1750354735;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l80CneWFsJjwT0yLsFNo3lvCWgsM1Nlzg/3pe85ojOg=;
        b=oJRePokeS8OfSnaNvecxhlyvasENmY5gJ5BnQgjfNp08uHdTl6cVmtvpALe3sao22v
         zXoIrOYWwc9HvOOvC9lIrYwbr6uK+vMMftdpiVU5MaMZ81fezcNIOp4rAnTKVJuOaYML
         +vueAPtfdpHgFGgI9ueRlzQh2ufqu0LqafCyk71LhJRxWADf5HMQFw2Fw19NI2vk37pJ
         La+RPj4cczCZCTaGrHPvcEW+iG4fRot+T38EbyS12b6kFujmQ6of0wYAt7yCZkFun6Em
         OBkpchh6bwPMNrcIWIL9g4VJop1Sg6g3necSPV6QpfrLuhNLSYOSi1koOTjgENyEjreD
         saLg==
X-Gm-Message-State: AOJu0YxX/AOWRYMUGMVMakQGqiMYyq/JB2Oy0xdw5B3THLEQQ752Xexu
	lFt7GSpiPV3CsuzSSIH38d+GUW5+Tc4ZXTkUEmTSNGYvuc2cm1bKLvIqZsL3O7NEbu1LogBnKKv
	10+r4
X-Gm-Gg: ASbGncuYDL1UyJjbTpIF7gy57mrcG5/82eztIrkocqJ3y52c3H83aPzDnXS1YVD9mST
	z74tA39fYBTwyT2Z49Dc0V7ZOcQ8w/0dfIUUehc0CVKTY5jwD9/mick0vcl3f3Se4QSa2dn9Vbz
	mi6vbzeUBLp08zSieFEFQjnnx347b0iio6R5d9Jly2oXmzvfjX/+54DosBt//7qdofqotCi5RVc
	oh6TWdzsJ2taSoRzrFJFspmGhlr9Wgth+uuqPwmY4BzF/WLsOnoKwWyRqmrF/uW8NywgiBUYuJL
	AHia7OBx59rrlYrP2ZJNj/+Wg9FW9bJd2CagZ8EsVh4cr3ocSMWu/wrRDg==
X-Google-Smtp-Source: AGHT+IFGtB43XuRE8+GzV2Kq0gUxzq7HK5bEhShdPoovySxqaJf7s2ir1gMdVnj/TIsQuXoubg0iYg==
X-Received: by 2002:a05:6e02:180a:b0:3dd:b5fd:aafd with SMTP id e9e14a558f8ab-3ddfffb6db3mr9808735ab.2.1749749935389;
        Thu, 12 Jun 2025 10:38:55 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ddfba05d11sm5430575ab.3.2025.06.12.10.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 10:38:54 -0700 (PDT)
Message-ID: <906ba919-32e6-4534-bbad-2cd18e1098ca@kernel.dk>
Date: Thu, 12 Jun 2025 11:38:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: Revert of a commit in 6.6-stable
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg and crew,

Can you revert:

commit 746e7d285dcb96caa1845fbbb62b14bf4010cdfb
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed May 7 08:07:09 2025 -0600

    io_uring: ensure deferred completions are posted for multishot

in 6.6-stable? There's some missing dependencies that makes this not
work right, I'll bring it back in a series instead.

-- 
Jens Axboe



