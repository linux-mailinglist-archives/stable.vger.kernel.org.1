Return-Path: <stable+bounces-195471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05EC77A3B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 08:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49DD64E719B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC447335090;
	Fri, 21 Nov 2025 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FTVkWSVE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6932D77EA
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708584; cv=none; b=WPsEUu8HtP0bJF05A47Ecqp2U/29otRZftlUvh+PbipBIs+pp7dBbG/ZKbhK0XH0ZO4i5bSuNaiVLaZbDc8XfZ2rOIn4qJyTcB5o8uFr0JnvlYksdUiENxmsi0v7rIKckY2FqvSJtDJupSJlFAHIIBjd1W+GLK7VbKMhaJ8CKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708584; c=relaxed/simple;
	bh=JU2fVJACbNZeuoKvJYHqmGJRlLq2Weomkzck+OYLO0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6HegBtGMk5mCAM3nNa4rFgU/sRYm+eFa3HKf6+nnTE4Xo8hdr1QWEYdDb15XlZbJaDJ59PvD7U9iQwHzooirPJMDYlnHc60PULbEDLsIpirtpEVQ51l1PozThfoEGo2Zl4ZxWUy4W5d7ZKAfyxt/dtVtSNIDbh+ZL1uZG7H8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FTVkWSVE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29516a36affso24216735ad.3
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 23:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763708582; x=1764313382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUqmuYJP8913m5lYq21HT+nfUHsJaJp0XrmlhlH6Dv4=;
        b=FTVkWSVEOu20LilRQVV1mjEwAHBeg+0FfBTDjxIVwf2MUnAP9kwqMRZM4KKo65TH1F
         oy0uHFINzeVP9cBu+sy4rvsSbX91KB/5Hoan2xJHEW2s1MGSEpTST/6UXvUl7z9QPUCi
         Ybf+yYZ5T9GI7mLnqkEZirmi6fp/KmbOBzv8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763708582; x=1764313382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUqmuYJP8913m5lYq21HT+nfUHsJaJp0XrmlhlH6Dv4=;
        b=E66u+9M5KN/eU3gGQkXrhgTNTGCTeHxgegv+V+KcWZJVR3vCL6EA6zmXoVo0bJxSx0
         Zw8KgHvSkesLzhSQED3NaO69lgapxaYWONEIDBPmjWE3ychrJiMEP3DMRtx8HXvKcTQN
         rCurAj7ahj8wqgEzlOCc60RTaeHpdGLp9k+xo3wXZQYu33lBJo7GMAwszLGPURmDN8tj
         trNu03EHWa2+NvfzFliw2xpCsmXpOR2Q4z9ggYaHtK9caxzTRTRkW54/okr5fM+Tmxvp
         smPvRZ5SDOB1UzZhL3BtTtl9cB5lR9uI/7vab3134Q0uUJh4bLwLrv/OdpoFsUNMJA+x
         mumw==
X-Forwarded-Encrypted: i=1; AJvYcCW1KRAUlfEP5jEHCTAEe4IEpWoB1+XHQkyxeFxWjRtYpDlGnTBBx4pPnYvcghUMrYC5qxMrjeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83gOwcf/HCpdSHYwKmrC5/h3M2UmJ8pt59GnyeDuTpq4+n/N7
	si4Y3TVTcWToKEkvUGzjy6m5d68NekLA9LBJd8mb2n3hCqTLUWJboSK8+qK8rt1L5Q==
X-Gm-Gg: ASbGncupjCZS37EpwRqAexbsLve3qK5CgrohY0KXZ6Dk5nMcWxC8g7Wppsu2UU11Bc9
	Z6us3e7RyoJw/Yv1IM7OR4GDFiLycVVpmZnezwACc/Fuv8K0iyRD79rAsgtiwbGq25R6NcgPnH/
	C8o2LOqU+8ImIVt1RCVnliElJoBUzQrw3tR0/pRy2n8X5vjsgDIh2KUzOXBvyWSAlCJhCjSRYxL
	aMR2L/90i8KlLxfq3PrX5CLB9nGWQTfkiWk6iATzqrE7NP4Ez8feUubTdW7BfX/29m1+weOJWCv
	aF8fct4Rc4uI7/t+kRI2zOhcn5ncr4yovnR2AflubDW7/mEooXi0LgkgR6gAv3aT69EMANzalqD
	L7+DmDHq0v/1veNGlaXxp0fl8AZQGmEhJb1JV22n6rFvCmrgFGdlj7QZVIbfHNym1m8lHB0FW4Z
	lgReHi6i7DScy7fg==
X-Google-Smtp-Source: AGHT+IEywaNCQBrtiWz1bn/eb5EPn9UR031f2xuv/3gnOuEstH3DE7HyY9UXL86t/eUO66P2uxwn1A==
X-Received: by 2002:a17:902:ef4c:b0:297:d741:d28a with SMTP id d9443c01a7336-29b6c574f8amr17827885ad.31.1763708582512;
        Thu, 20 Nov 2025 23:03:02 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b27509dsm46060775ad.78.2025.11.20.23.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:03:02 -0800 (PST)
Date: Fri, 21 Nov 2025 16:02:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yu-Che Cheng <giver@google.com>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
Message-ID: <s3lyjszylckzg7mfefmysve2tsm53kmorgxly3nln4r6xha264@rct3fyk3d52a>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com>
 <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>

On (25/11/21 12:55), Sergey Senozhatsky wrote:
> Hi Christian,
> 
> On (25/11/20 10:15), Christian Loehle wrote:
> > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > Hi,
> > > 
> > > We are observing a performance regression on one of our arm64 boards.
> > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> > > Rework schedutil governor performance estimation").
> > > 
> > > UI speedometer benchmark:
> > > w/commit:	395  +/-38
> > > w/o commit:	439  +/-14
> > > 
> > 
> > Hi Sergey,
> > Would be nice to get some details. What board?
> 
> It's an MT8196 chromebook.
> 
> > What do the OPPs look like?
> 
> How do I find that out?
> 
> > Does this system use uclamp during the benchmark? How?
> 
> How do I find that out?
> 
> > Given how large the stddev given by speedometer (version 3?) itself is, can we get the
> > stats of a few runs?
> 
> v2.1
> 
> w/o patch     w/ patch
> 440 +/-30     406 +/-11
> 440 +/-14     413 +/-16
> 444 +/-12     403 +/-14
> 442 +/-12     412 +/-15
> 
> > Maybe traces of cpu_frequency for both w/ and w/o?
> 
> trace-cmd record -e power:cpu_frequency attached.
> 
> "base" is with ada8d7fa0ad4
> "revert" is ada8d7fa0ad4 reverted.

Am getting failed delivery notifications.  I guess attaching those as
text files wasn't a good idea after all.  Vincent, Christian, did you
receive that email?

