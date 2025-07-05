Return-Path: <stable+bounces-160262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38214AFA175
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4861BC5BCD
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED4215F7C;
	Sat,  5 Jul 2025 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEwSVDeQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F018786A;
	Sat,  5 Jul 2025 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744276; cv=none; b=KUodFjBJrtMwEk18eN/OYETh+hyw/sd0jutN+eLv1OgjvHtymoCF1dp9DAuo4H7zLD8vV5vv+Dsj5xztVRgDosQu76VrO+seuCfFBp1c1uIcMqABWoWCCMeQgK55raBHQAFDotYXw+vWPqmI0szHDuhI8PZMyTQR5I6uJkMyzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744276; c=relaxed/simple;
	bh=rhkYdI0qaK2SWqPGukgpUJQl2Y1xf63RjS+xGlf+ENo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt3BfkwK5MATSObZcjjh8UdVZ6NXEPbWecA8iRM08r5EZ4zSOelQ5Nl1Renk8X1fi2PjOL95uot/in96/qzDt4vzivN+R+7anUmzATuUrilQLNQ7b/UVllrSpZrDy1tfMQQq4n1Ia/dSXo3VfMPT+vPyRPhF46ZmtoIxj8xPWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEwSVDeQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso1845567a12.3;
        Sat, 05 Jul 2025 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744274; x=1752349074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdsPWIihv5HWhO3SsoK85fdkL/eyjqb/7Z3okGZnaXE=;
        b=HEwSVDeQJ3Y5Nia+RPp1Fl+QzQhx0EY+lsmoXB5Zix1Y8U/28Dkry03T4qX5PB5kiB
         jAaGnPoJtXKjWjyfVMnLZ17aI4u04zpJj3coYgS9biFEM+wiuyh1ufUUpz5pFzr4hLQr
         DO7/c+XpnTCnm+gspMJA5FJndVeIRgiS48+1jMGz2YlKp/VF72bnBUp07hmpaaI1qC+o
         G8vm4i8MeeiwKCxqX0jC2cj1FAQMWf4ktzLfXxcm8h5d3zuocYG5IhAmzhob2OknazsS
         /DcSfeJ7238WagwPSK/UmJK11AJIpfCU89TeF62UECs8ANTW2WqOOLVWXTvyYPam8ZgO
         XNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744274; x=1752349074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdsPWIihv5HWhO3SsoK85fdkL/eyjqb/7Z3okGZnaXE=;
        b=NMrgMdODEc+keu22yDBGHZEQkIekjNJ0uGvbIUcn314C5b3eHd1QMXVpMCVZNiLx6h
         ecrxw0xTEuCOLw+8vNV/Bo89qLZAYS/gZqEQ+mamK3Rf92g45sTltlfY2N7H/8U2l7dT
         yWvvZiEUpVd81kpGbBs5SC7P6W0o2pAyb715av9Dvpp5zu9aDDWyPb/bmU8+9D8UtnxT
         Cw716nvZUlr91kzDBHkO+8VWxxzV46mzV/ju+mh2w/ws6RfKFdR+uDRMzFnVgqeaiJ5d
         J5wVr83EpfGIEEQExSPT7zCewC+T/mvZO8xxkZn96XuFuTZ+q8QVlYFOIHSyyVIxY6lo
         iSBA==
X-Forwarded-Encrypted: i=1; AJvYcCX5xX3ZZIvfmHBdT8LhljqtFCc3i1kzSUaVIHs9N5t9E57iIy/S4m4xrinfwlu6lz9PbPkImEvdYhuFFNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3Sb6I/1UavimZZ7/FezG7cAI84YxISsw1jQ0+xGVAahn98I8
	4Q0mxfdY/eHaf6FIOOZJbCTpams1wW15drB8yrPKMPXWbqUQ5yfTJOiU
X-Gm-Gg: ASbGnct5GQrEQTHzrRF/YCvOGzQIoAxJfo2HGBNjrk5gAVwiIZiyNhIg8OrdZ5Xuj0L
	mMgQb4hqHdIfs1ZRsO1jhT3gSVcsg5FI9lb3MyyH1ZLmIYOllAbN6ttd1EKH9T5Je9XvLtZx6AK
	tf2Eoc/TGJATEzWvaCAapRMO2Zh5CSgxCZKfiJvhVJkw6hOD5PkH8psTEwsmrNvAdbIqt8Y8yyJ
	LopkVmjX5DpPnxPeDIjpPxboXcL+2fKUvGJ3PIrWFRw+3VdNVMqIGJY6fKMsjP0bHFI2fAUsVuG
	QYJL7g+87tHxOkpma7PUYf+X0Ydtf+92J60/Qk0LIzOBF7n9YnHMq92wjeeebZ3v3L6e3atfM7E
	=
X-Google-Smtp-Source: AGHT+IGfY3WUKLQ4Yk5uf0Fkrth6sHY9ow0rMP3Y/0jgNKH6keGdaw88vCvOFt9UHv0SUx6yzeFNuQ==
X-Received: by 2002:a17:90a:fc4c:b0:315:b07a:ac12 with SMTP id 98e67ed59e1d1-31aba84b709mr5335559a91.14.1751744273648;
        Sat, 05 Jul 2025 12:37:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaaf5ae08sm5305720a91.41.2025.07.05.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 12:37:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 5 Jul 2025 12:37:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/413] 6.12.35-rc2 review
Message-ID: <3037c3e6-558b-4824-8c78-a36990f4e4d6@roeck-us.net>
References: <20250624121426.466976226@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624121426.466976226@linuxfoundation.org>

Hi Greg,

On Tue, Jun 24, 2025 at 01:29:53PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
> 

Some subsequent fixes are missing:

> Tzung-Bi Shih <tzungbi@kernel.org>
>     drm/i915/pmu: Fix build error with GCOV and AutoFDO enabled
> 

Fixed by commit d02b2103a08b ("drm/i915: fix build error some more").

> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: do not disable interface polling on failure
> 

Fixed by commit 3bbe46716092 ("smb: client: fix warning when reconnecting
channel") in linux-next (not yet in mainline as of right now).

> Jens Axboe <axboe@kernel.dk>
>     io_uring/kbuf: don't truncate end buffer for multiple buffer peeks
> 

Fixed by commit 9a709b7e98e6 ("io_uring/net: mark iov as dynamically
allocated even for single segments") and commit 178b8ff66ff8 ("io_uring/kbuf:
flag partial buffer mappings").

> Yong Wang <yongwang@nvidia.com>
>     net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions
> 

Fixed by commit 7544f3f5b0b5 ("bridge: mcast: Fix use-after-free during
router port configuration").

> Niklas Cassel <cassel@kernel.org>
>     ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
> 

Fixed by commit 3e0809b1664b ("ata: ahci: Use correct DMI identifier
for ASUSPRO-D840SA LPM quirk").

I assume the missing fixes will be queued in one of the next LTS releases.
If not, please let me know.

Thanks,
Guenter

