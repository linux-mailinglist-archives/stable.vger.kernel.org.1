Return-Path: <stable+bounces-189055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CAFBFF28C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 06:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F9A3A9BF0
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1425F797;
	Thu, 23 Oct 2025 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="Dyt2IWPg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6C252904
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194718; cv=none; b=VvFc73fmYOts7HQ2WTvRe6gBQPR8ofNuEbzxElQg0C/FbXJX1p7Cv6I5ITgsW59Vwt/qB84yZYf0fLHmUZEZGdgxKxkktMfoyERdQ6ae7NPPUztdvD4RvK/1PKlJ007ehmD3DcAkoiEJ+OFSLoRqtONchRPmUErkH/qPvAIpCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194718; c=relaxed/simple;
	bh=dDXZ4wlWh0zWE73CQei9SNb/wNKyNyNkdvTY21hhmRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KtC0MuUiOTdj8slxCb8519dULUr9Z+8DfD3kEO9xaEa8jvDA2Kx99psV++YakvunaRPpziHj3zIAP1Lf7fE5EAkSKX2Iq//EbL8vm8GnJ5hk/km7etslcyGPcbWyvjDHJrW32FMlf1H3990VKEuO4p43yOAoSqrxx7eA9KeCsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=Dyt2IWPg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e88dbe8b77so3467921cf.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 21:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1761194715; x=1761799515; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxAw5CcaNyJRUdL9g50f2nQhs9yBUN9LI3kQV7R+EXE=;
        b=Dyt2IWPg0y/LKwDvPqfaV9Xtam35tvueaP+OP11DwK6jU/oWLjgKA4JStUxKiXWhXI
         mN9R2jUP62evu/BI9IqnT3obgVXIYRL6wBx90qrdlZsM7HttlcRrfAKGhjyuj3jhJdDp
         2uBL+XRCQ58eAExxWgdfjk3eoqSow2TEf01btZVuPqArM/gAVPnR6USX8wA5FNket3mb
         rO4R3RTF7vA5AjJNeuNlBRhOpZcwahpKqcm5rdrMc1s8DWNw4SD5I0pEYtv8dtZomriV
         4tr6QhNFo8cvAkvdtg7CcsCs7tncNRF0OZBMp+Q5emdB6euthCM9gqJlKJyaEB7hhpme
         lqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761194715; x=1761799515;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxAw5CcaNyJRUdL9g50f2nQhs9yBUN9LI3kQV7R+EXE=;
        b=iGQMupR+UWIZMn28B5lvi3MgesjBqTCqOHrPyeb9VtkV/EhEQYM3yZDcEMdk35Ck5V
         4HQ0sP5E/sMBpcPDlgyDTF2LM4OdaIKmKu/Q1wGumLgFU59/q1PmaAUcXO4n2ZrGCEAO
         MPZQtaWz/hIG8BYriqMIStAdzkdYIvSrynn0xgdMMwKj4BCVwil2wbIpTG534JbKqBZM
         CCG9kyI5OSo7JBP7iz8T2xxrQHxCNaLMGZnbuhRA94O7nUObCnRtIVWZWzvRp7rB+/9b
         BWgEdB9yPFOTLI/NkY38bwahMZU2YDy1ulgxZ8wg452qJH8LO3NaJDbZXr8CmPgpWV5E
         LLPw==
X-Forwarded-Encrypted: i=1; AJvYcCUIl02Dh7M3L4wR4UExOP1aYdhaSHySUdsD1GbX+EnBIyQ/362+bQ6TqOKgQC+Ic/pl4qWSr5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxat5u/HOKyLkptxKyxw9b1Pad7/qmqhZ8crFB+oFUjH8n5FIiC
	eY5ljgahg0V7hjpve/Ey4CTEbx3nXTlvIE8RPXn8CDTwmcjM7poNNyW+IgNZ8vc4tog=
X-Gm-Gg: ASbGncuUONjApqByToxnKlVAywNC9kZlZKtpmRRztJ+l8Kq7OnkS8zDGtp7hPHSsTn/
	3SZsof2FiBkR67CGL8luo8nZ0hmSpRX4oSlNOmcbFEfokbNGJc/JuoHEZwlnnFQmMFcKbFLaavm
	/CmurdrjCl126rrbURLhU2sVWMA7yMUHQSkUy6oATrQGPjCknALiINJWMK+kx1bFRAySf/gA9UZ
	bS6t+DuRKAVqHzhS6yd2GfXxCWweNwQ/Z5TSX+U1FtTKTblogtJh2tJt3jBuwm0qZC1j4v4Zbwe
	iurMc1UL+sZgJO4XaYeRj6l7qfLyKzxlxBr1E5rIKdVswKBb7FV5je4cCuxTnPwGK5bxIrxxcjF
	euQ7LhFWH2B4f79PPAhN5kKoNC1mb25N13ZFLVR1QNqUL/qk+7Von6eq2hBIDL+1A08LCjpJdRm
	mBoAEMH3ANJS0+dls71PX4RjPwqXviYA==
X-Google-Smtp-Source: AGHT+IHAxwX1q4xENozHdVwqKqZ7TDRt7Gbja+SgOkIQM2H6Yykm4zUm83IbTesCfNfk5IdGOKlPzg==
X-Received: by 2002:a05:622a:138a:b0:4c3:a0ef:9060 with SMTP id d75a77b69052e-4e89d27666dmr281053671cf.26.1761194714911;
        Wed, 22 Oct 2025 21:45:14 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-89c0e688d64sm87480285a.21.2025.10.22.21.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 21:45:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:45:13 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-rtc@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After a stable kernel update, the hwclock command seems no longer
functional on my SPARC system with an ST M48T59Y-70PC1 RTC:

  # hwclock
  [...long delay...]
  hwclock: select() to /dev/rtc0 to wait for clock tick timed out

On prior kernels, there is no problem:

  # hwclock
  2025-10-22 22:21:04.806992-04:00

I reproduced the same failure on 6.18-rc2 and bisected to this commit:

  commit 795cda8338eab036013314dbc0b04aae728880ab
  Author: Esben Haabendal <esben@geanix.com>
  Date:   Fri May 16 09:23:35 2025 +0200
  
      rtc: interface: Fix long-standing race when setting alarm

This commit was backported to all current 6.x stable branches,
as well as 5.15.x, so they all have the same regression.

Reverting this commit on top of 6.18-rc2 corrects the problem.

Let me know if you need any more info!

Thanks,
  Nick

