Return-Path: <stable+bounces-185998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7623BE2BFD
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE8D5880F4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B132D459;
	Thu, 16 Oct 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IvIkSAKq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E432D427
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608845; cv=none; b=n/XxDXVxCEvId+O8peRR68dll40thMAmausWf1QLla0O8cplT9/bJs4xmJCgOrYWr7ouMHENbg5FkFhhfd7pNODGjcDttIVhAGRfVAOAf1Sh9NqqTqY/igYfKDmKuQcBXZiKyWcdoLEeBOXWAwypPvR4cd6VWvQS5RSNSwYSQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608845; c=relaxed/simple;
	bh=GuHdpaWnWYFigwpENImVEQ8FLU6LX49o1UO74ZnhrBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAP/JUZ2doDFkzutjfh4ZuUPGCuYhYhlA7dDh4h8LB1Hhxt3wPBTH7o5aLS4kqXG4zmV4iiWbVhXHT62zyfZauR8jtjLM/huPsUAjs7CjVbZCNyGNdQ2472l0x7CC0cj1HUw/525bABjuR+G2L73ovINzPtNnRhN8ybVFTz2P6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IvIkSAKq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eec33b737so8624915ad.1
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760608843; x=1761213643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzhZSXVDw5HBXWXhpgNz8QGmIpqR91GrblzBsUR2jdE=;
        b=IvIkSAKqs0wrbYgEtNn+G2fPOcEq+fFL8J57V83XpTZ71hxTH0Xy0ur0iZNhpcTIuj
         zeZJUDyLzmaAaEw2jF8pf7RIQ0GtDJSp4l/JPtefL6Gfz+uS7QZBfJazqXCrmA4Iho+D
         9Xm6sNIF4efqGmwI9Ww4ok8op3ivPC2qLzWH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760608843; x=1761213643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzhZSXVDw5HBXWXhpgNz8QGmIpqR91GrblzBsUR2jdE=;
        b=s4UIWc6K7jLEn06PuN0spslqQYtAH4LCXPievNuuY6wze0j0SZNnJ0XcppOX/Ag/mO
         fgBDaTlV8aQMB5JwfTmspFgt/7g/hk+YyQxZOaFTzujDQrI8pn43qIEhJXJL6XmoX9/3
         RfHcYNTzG9wtXlj8ewtOyImn9gsMfrLWBAK94a8XfOuwv8q1d0gKCU0iTwNDqTy9adi+
         +BkAbxPuk6IjyHJ9xVCtYfjUmuC4NM6sOe+RECZErZ6Fhaq3cq8vf9BgeF0W9uFTZLns
         YwD9wqu/pW5C8XdzFCSsGQBZxKGJ05fZfbmUFl1BoWFXq+XBNEFQGwjMLeYrrwRhBFe9
         KP7w==
X-Forwarded-Encrypted: i=1; AJvYcCUXvyOGfNoZI/mlsH7Xdpqh9fu3CD3Btk2JaZKmn8u2QWqyFnNI2371g6VcLLDVhOD2lT5niQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWg1rMvHws/4d/sTdBB398skSTe5VSQk12kr56D96Sl8uk7mrS
	gABvrgVhLezoi8mgTw2fot7kDKI5HPKPkC3QMVzcxyKIx+g384iDKNDy+icI3rZZDQ==
X-Gm-Gg: ASbGncueH5qZ65wi37GBOOXILhBOWLskJwXTTI87NgSY73Kb9r5kbNbZZHzYy/LjGtJ
	U3LOyjH9zK5uW0nq9mBlUFpzK0o9AewZGoRHw6Wev4kvhm97wvOHBqWR68erMBuESCQ48QX5KcI
	v3+Ct4PlD+dI15g/3cco727d96J3mom5Olet7hJQPcf66ZVODFArK9up/IAw4N6Q08HW6UjMWRS
	Sx7G4wyQy7RoAvbclVMdbgVcEMjOpfNsq325qwCWM3pTRG7tzC3oL89VP3a6BLhXd2YSR1FFvJ0
	uNJp+SrUH/vp/MII6+vVzzNFbscJkoS/d0unjsiWxGuuSCKyrDFDMG2sfDE64fpfsKVGc7YgELg
	ftMzSkilqZch5IFaFGvC3aO6BYVR6CE83CoUM57AC4b1gDV3cN4JgiMWCYlSX4F3axoR6zcOagu
	ZcA/vvXi6pRHF42w==
X-Google-Smtp-Source: AGHT+IFuKHF70rg9myfkHvvqf8ak7ClXze86hhc+4ZWu7glDGpK14qjiuk/CiRAUD3qVgrKVbYIklQ==
X-Received: by 2002:a17:903:2388:b0:290:94ed:1841 with SMTP id d9443c01a7336-29094ed1a6dmr39122505ad.41.1760608842794;
        Thu, 16 Oct 2025 03:00:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:98b0:109e:180c:f908])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934a8e6sm24587115ad.30.2025.10.16.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:00:42 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:00:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Doug Smythies <dsmythies@telus.net>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ytv4w7uw23fwdkihbgrpegmco6yzkxmzjbakmxtricreou6p6k@rhwxcjq3jvnv>
References: <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net>
 <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
 <001601dc3ddd$a19f9850$e4dec8f0$@telus.net>
 <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
 <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>

On (25/10/16 11:48), Rafael J. Wysocki wrote:
> All right, let's see what RAPL on that system has to say.
> 
> Please send the output of "grep .
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_*"

/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_max_power_uw:6000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_name:long_term
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw:6000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_time_window_us:27983872
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_max_power_uw:0
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_name:short_term
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw:12000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_time_window_us:976

