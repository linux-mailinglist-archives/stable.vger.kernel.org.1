Return-Path: <stable+bounces-176745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFB0B3D105
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 08:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAACA189F8C8
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93164AEE2;
	Sun, 31 Aug 2025 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/jrdlVc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A52A48
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756620202; cv=none; b=rpu99KQYKQB9ygtO8UDxnKfNvj6G2UjjsvaFwc3cLgYur4FTy+RX21SlzHKq18ozfCHJZu6I2Lj3FhsP5UHMRyMWOfeKOFLhCkxkKbI8bge82L6KhYueIzUNAq4z84K/3cRwcBZJHdU5OFzAp7F2Ne1gaFU0v1QQI2JR30uCOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756620202; c=relaxed/simple;
	bh=00BGTRV7thNsXHvRvWG3kDraM5XWXoya0MLOBm4b5fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbFXRdsTl78JStx/Z6BDi3Vzf2tmvlQ7WeNkSb52b53AnTXyUiPGe8NjDkBdPJnnB7l+YMr3/tBh6qXWi7Q0DVtDUteQXYZl0fLFlEPmmO6iCDaGe8m0mHN/DSOv9DfLhVT3S0kAHwBxrJwdI7hdyCUFggcdmEVXDs2JhdpmEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/jrdlVc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-248d5074ff7so21780595ad.0
        for <stable@vger.kernel.org>; Sat, 30 Aug 2025 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756620200; x=1757225000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3yztekeXcFEYzGBwSZXBzHZHbgep6UJq+xxxAXFBo0=;
        b=K/jrdlVc+9UKxPH7j0laT+2hKjDuJ/403c0VidMGsd481BqlvevKTuF9wUYHZLdwjp
         Fek2mkFFL+2zn4MO4LvI5m8pdbULKFl3vlbPQRqR8L2lxeY3C5qbGia9G0Jea9o+BJMu
         b+NY5EbAjaTVBG6Ct0F3DSX+FtfDa8YmFN4tGwEK2PojELSYPM7Dio4vZdOEbgR4FWme
         d47+z8mSE4eSWvaVqXD9kB8a7ReD6dgyROP8EzMaeVF+TEEhYa9T3DSYS+nvCuoACuse
         0HdS3Lds1XofpLkZ76rw8PjyqF5f5QH57bUdCzgp+vgTHvBpOv5HfnwsaPiVCL/nSyHn
         WC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756620200; x=1757225000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3yztekeXcFEYzGBwSZXBzHZHbgep6UJq+xxxAXFBo0=;
        b=CJ5e4MgVJ7HxjRD1zwgyYtHk1a99S1UcN3yNjDgVm+6cInG2+7BvtcdB6fPn86r3xr
         lADlOkzVIT4qC7xTpsA4zDpiWYOk//AmSaydPza8ioXAsmar4bc1o+uO1XeMbrpymkb/
         3CGiYvSztaNpH6y5Hz0AysCrv9BijGDGxvaiRNFmTeXofpsc0OjCWtukSe91FEr9wwkR
         vO0/zUzy2TLq0a+zhmWlaRdtLvIxSbPCp4SE8z9j4lNgwsqU9vlbueFlPcpF6JJyJHDO
         LQbzQUUvqWKNB778mw02220A+xlwqH7U3ZgFmWSWxw45ItoCxEuYFimmHdMwJF+FgR/3
         YsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtyM0pSJOWguu74rHbqQcsHQSOtf1LVJrNBlkmHoF9aKxU4FjWN2QGGKLQUjOMl6ns3bFIb+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr4gwsrFgtAVg5gApHksaopDX3LUjOi2+2Kcql4H8IBGszJi+T
	a72S2RqtFVeZX7G4/xEpbyqf10w69A0XUO0RRLi5e3QvE6h+RyGPKURB
X-Gm-Gg: ASbGncvCnT0FlpFUY4puxBWe7iqguXKajgEm3c+c/ruU4E9gTe+kMvom91CEA6gz6f7
	00DfN9zYhIk5nv7pQz/yGqeNbzdzF1g576XU5c8Euf+XGcwCuFoBtdHy4DiRQH1n430aHcvbfDd
	ZvSZ34TBsdhadvmTNGugPjMMHifYOtJkhm3tX03YqfRo6YBBGQhh4SsB6xVRgwVo8ZR4kXiTvBP
	Cl/Fiwf0PTHQ311k9bYWDzWyTPCR12vPXht0jD6D+7VSGP0qGDbH6yC+RX1NzIO4mmGgZK40ctS
	UrsDTqVJIa0cZklbiSCtNm4qbq98BGcTnUjYffYlvJJbd3E/dBxtTM++A4h16ARO9R68bVZ+xCU
	19MllLVIk7IkarVRFf4qdUr67VHZtg0klVNd3+FxHWSy6QeRdPoh+ApbpShYRqOk=
X-Google-Smtp-Source: AGHT+IFBetGaH6KvkXEXVijgbdd9O6yRIbGBovhMr6vm73dkCAgJD/IRiJBVU229W+bkkCDdHGC29w==
X-Received: by 2002:a17:903:3884:b0:240:417d:8166 with SMTP id d9443c01a7336-24944ac250dmr45045785ad.19.1756620200280;
        Sat, 30 Aug 2025 23:03:20 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24903758b3dsm69262065ad.61.2025.08.30.23.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 23:03:20 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: guanwentao@uniontech.com,
	mingo@kernel.org,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	vincent.guittot@linaro.org,
	wkarny@gmail.com
Subject: Re: [PATCH 6.6 8/8] sched/fair: Fix frequency selection for non-invariant case
Date: Sun, 31 Aug 2025 14:03:15 +0800
Message-ID: <20250831060315.5693-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082213-awkward-harmonize-4212@gregkh>
References: <2025082213-awkward-harmonize-4212@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wentao and Greg,

After upgrading the kernel from 6.6.88 to 6.6.89 a few month ago, my 
computer became very very very slow [1], so these months i keep using 
kernel 6.6.88. Yesterday I tried 6.6.103 and your patchset does fix 
this problem, thank you so much!

[1] https://aur.archlinux.org/packages/linux-lts66#comment-1024908

