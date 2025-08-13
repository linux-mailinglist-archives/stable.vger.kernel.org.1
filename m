Return-Path: <stable+bounces-169385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1655FB24A30
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D11B604E3
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C112E172C;
	Wed, 13 Aug 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="fT51MIAM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AAC1A5BB1
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090492; cv=none; b=uUGrtKzC0j7lICF8PO36GX76MClNwnln2wDPeyaLiRK31eScmerzEFHcpC5qliWNSnD/bD0ut7hlOUrGRjcgxYGdtE1cmTemg8nWaJEgxXqL6O4MTnS+7PWFkN8fqeqk32Gy7Eir/OmoF0HEENU59Uz8YSXAy/0+S+hOsXIMGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090492; c=relaxed/simple;
	bh=1pwQC3sEONEAAvu+FAQCD82dSlJxfgXF2c0gr1vct8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuh3zq6tQB0ZVDi5j+X3pz7ReC7BjaGPFFwGs91BpqPn1vnEHjKDyHb10brpIU+Ze55C13KjdaGB19c2Gd82M9ztZXj/sF0ULUacOT8alUCYKFNrZhOttSguJVZne7OM0kFy9B67bsmahVTN/jsBZqcYajRbatuzq2JMb7CdXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=fT51MIAM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b0a0870791so89261781cf.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755090489; x=1755695289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYLwmIoR7ODU7t4F7MqXFYTcBZqidg2qKZ7p7O1eaZQ=;
        b=fT51MIAMfN+L0trzQURHjOBm/fmlc3iiRG7/XiD7btJWFSb9hjFwTy5XvjOWqveHbD
         wLPnGNHnzE90HzpxG/aYwa9E+gdbOgL9e62njua4eLB6ImweDiUqjD53OhGmZcH7omh2
         Up+//5MlaMqPRRv+fbKqxOuQNhiyJfmUwUNYIQsH8VEV8/x2iWmCRmgRJapPMFz+HiJp
         I/e3WbhPPlUDh/eiI0J1X64l/Ahm8f3wWwOQkPSCKlG1zv1zVmJKP6RVFjah74T5IYdY
         9WyjohF94sRaDZCDnafB9/9sgFbTB9TJRJIZ0amKAs5Ze/DUfCr5xBsji0D7PTleOIPn
         9KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090489; x=1755695289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYLwmIoR7ODU7t4F7MqXFYTcBZqidg2qKZ7p7O1eaZQ=;
        b=Yd1tWTK0ilpg4RE/XGEVRNOySUXcx2HdYEEnXt9yH3q+HrRBZEMiPnjzD1oneq/nbf
         4ZhTsfF8fygCKN6mDt3taF1ZyPiMH1D0viIoMXgT0RiPOLu0eENBupD2VGuOVnGfxfen
         hNfupWBZ28j+tbQVKRGLfRTfR9Q2V7ax7i6PTAayoFlZLC0OELuZli3wvHyHTt4SPOI7
         8kyEh+dO2ITtkjp22jgn5Eu9nJhXBPWL4mTCdwNA27zW3lnFz/yNJxQKb8IV6FflBwWq
         pLLq5Hj4tysLe89ormQCCTiWJkGKZqbo0aqi9Ue1f5ct1CMw9dqwfdHZWk5euYxaiF6S
         bO0g==
X-Forwarded-Encrypted: i=1; AJvYcCVK1ttSbrwpAx40bq9Yn0Bjpi1zn/ZkGXQpB9Chp4U5jW89W/wDQTQ1he/7sSNSFzN5bYFhcgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3s+XVoEKOPrU7hiYN5BxGsqVTvLoPH/cwyQGNo+zQigXt97Qo
	Bq4P5CSUmo7/6m6o6BuzX4c1ZvK/Iqa4kh2QWMIbFVlZ09Q/zu13vPYYN90DLfVcSQ8=
X-Gm-Gg: ASbGncsmxRBfFGf8C2C6AYHZym8RyoVUrQBwTE/PM3rPN+tGw5moWk0c4zJD+TpcEpG
	e7lcYHuU45zr6jZ/M2JY0BcJyybJMq2b/CDDrzzdW8qsvVKObOi7PiCKJbPmOtNoA6kbVwjBGAW
	2iurFvGQQW0HPQigZFgJhwo8RuLhEmMS+TwiBCFbnb9YpaRXLIhJD7Nq63lgkRAQDuJL8JXa5yC
	ZhvR1UBsmkxU+R/XiY4H84XW3wOLzctOdtYAaFTc23gwEhuHRg+vjRxONRMv3b+zcHpS7PCMtzq
	lnxtCVtWU6+E5zWg4a3zRALE9TukQPRnof2YtBsXDei00qfdJ8Y+AQ2lq1/MZHsKrFkQMg2Fp1w
	9mjA6HNVTHc+Sc3eqCy8QPA==
X-Google-Smtp-Source: AGHT+IHOQuq7xqUP9UjBEVVTqrAdJO6d4BVHEpSN1f1carg3pLIr+GU8HjaN4gDsBZDXdZno+UCFDQ==
X-Received: by 2002:ac8:6f15:0:b0:4b0:cb1f:e390 with SMTP id d75a77b69052e-4b0fc7b228fmr38411531cf.29.1755090488685;
        Wed, 13 Aug 2025 06:08:08 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e67f728a6asm1954259185a.64.2025.08.13.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:08:08 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:08:07 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 096/369] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
Message-ID: <20250813130807.GB114408@cmpxchg.org>
References: <20250812173014.736537091@linuxfoundation.org>
 <20250812173018.391927854@linuxfoundation.org>
 <83b69ebb-a052-482e-aa6d-34194ef18dc3@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b69ebb-a052-482e-aa6d-34194ef18dc3@arm.com>

On Wed, Aug 13, 2025 at 01:20:41PM +0100, Dietmar Eggemann wrote:
> IIRC, there was a small bug with this which Peter already fixed
> 
> https://lkml.kernel.org/r/20250716104050.GR1613200@noisy.programming.kicks-ass.net
> 
> but I'm not sure whether this fix 'sched/psi: Fix psi_seq
> initialization' is already available for pulling?

It's included later in the series:

https://lore.kernel.org/stable/55070b66-0994-4064-9afa-de1e53d06631@sirena.org.uk/T/#m0ddd243fe107dea7488d119cb60e8a9e18e2c9a1

Linus just didn't keep the CC list when he picked up the fix.

