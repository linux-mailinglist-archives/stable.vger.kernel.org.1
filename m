Return-Path: <stable+bounces-151870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6EBAD1106
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 07:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361F1188C4B0
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 05:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6E1DE3D2;
	Sun,  8 Jun 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbmVOluL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29FE573;
	Sun,  8 Jun 2025 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749360423; cv=none; b=AfleMQWbdJ+oBKcEdIJtQDuR5iJIbrmD2HSteKUhTjUYfKcXLbLQrjgVzPYlJjMHMNAN4NVEH1Eab8CEhcz0YBW+2RM2D+bpT2qHsbQIRnrBowmU9jXzEvWlJfT5zTz//dFkegPWYiczEOrfvAebX5+UJiXML4kc54oict80soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749360423; c=relaxed/simple;
	bh=dRrL2HB8b8HocCliNlz4XgmTphB5h47K3ni4076ycps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo9NSY2JE1OB+wulcAQoWn4L7WaxpO7MKNQ5L6DIa5PifSbtOPilk0m6eNOOYRosNqXUInE6ooLYwhHQ1hP5F4tV8wIDEPIRilnPHC/uuv2HUvQ1ya1jxQLLKxr6xsK3ZnApGOQ1LGfvyG3KToBZ0CoT92+X/RzU5AfbB7+Ak9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbmVOluL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234bfe37cccso41191145ad.0;
        Sat, 07 Jun 2025 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749360421; x=1749965221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRrL2HB8b8HocCliNlz4XgmTphB5h47K3ni4076ycps=;
        b=cbmVOluLw9ieFQuFBHVE+zOwxkhNjf9OyrBZscBnuESioHcL8dgcVOS/9X8tVoyYRn
         +a6H+6bSGphJE/swsnhGSeqJjWM4RogLnjHo9Cy+ufBHjhEG5s76R5K20YN+UEt9gcdG
         XySnx6Mw5+hh9LkcQt8XLTzND/tzxUCK0XuHihJp5IdmH2AS6X/DGS7Uhs/whrpDCU1w
         d+GmDZgIc/EzFiFxjMUeoB+Lmc+HVjpBqo7eWDxznkD5Ta30Se+QJANGj4KIz0wH6/5w
         asF3sgDpv1CLvlcvAJIFRiDe7oxznGUUp1cpFoLnUOFQbIYxjkZ1bc67h7Gykljl+cFP
         wmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749360421; x=1749965221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRrL2HB8b8HocCliNlz4XgmTphB5h47K3ni4076ycps=;
        b=qi6DlRqoUpfuu3SEtf/4P7v3Oryf+ivte8vQ2GLpcg1iiyduNGBb1TFyynJNuCtTvF
         ghFXITA+3ySpNfytZq6csmp/lPrZ09hKARuisMBybtZlYoGhx2iRhT7/hUw40Dl1Gzcc
         PwHSExu9nYQ9eDo4RnDt29mxNbdBFnSSIkPqy63RDLs2glH9E8LlgFF3NKPrmt3txKHy
         SiqPp/OOXS4kAIHKgUPo/QMXpe6mxXgQEFfp4MJrVoHCNHqNkis7gLvA5zrdHVpeChmY
         e3nOaKMTkRpcOS7MlOaM6Ln0G/0OPVXzpbq9KijYLotrkW5tPlc2oI4ipTeT13dppt6T
         rezA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oFZnl0+t42n8oXlhZPTtsTj2BRgCckS2UaIoHUg+a8/qLb4Igfy7dPpneh5iBngKQ909UmC1@vger.kernel.org, AJvYcCWSuChp/Q9ZVYj3hZ/V1PsapHPyW1UFJvl6bduCKmk6oE/N9LHRGGshqV4DQT06i5xdZRMg8wUXPAE1Vzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XglZMqD1BjrnWFI9ftVDlUmdU9fUalc5qneSNzBcTeVn4Www
	lzjfsIipTFlNmbPn9Cvv+AT8gki2RrfuDOMe7SOnmGW9jBrhr2mqyOiDcjfN36NEuPml8Noi3WQ
	cn0ALqoZdm1VCKhGQhSooo3RkVchPbZM=
X-Gm-Gg: ASbGncsxQLTHsiQlL/LgEw+BOhvIqHAm1xHc70cpCxAqAoRs5wir531wScoY4isDBqX
	Z/nlynnouF1s1+X2pxcuPuwmRkZBqPNLCpEGuORvIW/3f3ppi0gy1xGo9mjMCKIUHuTqCaxo8Z6
	7tq2oeYwwlJ9irxmlS4/MadSXmUV04qhckCH76c5pFbJhbJyo=
X-Google-Smtp-Source: AGHT+IFH3mjameUS5DgXrXypeS0/VIDnq2gQ05i1f/2jxi72R44xM8J37QLH7gFhbv6mXFQ1B3kfJro1laNaeclXNQg=
X-Received: by 2002:a17:903:120f:b0:235:2375:7ead with SMTP id
 d9443c01a7336-23601d4c62bmr143269885ad.28.1749360421177; Sat, 07 Jun 2025
 22:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607100719.711372213@linuxfoundation.org> <7fb63be6-8c3c-4f8a-8a34-9a6772c7ede5@gmx.de>
In-Reply-To: <7fb63be6-8c3c-4f8a-8a34-9a6772c7ede5@gmx.de>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Sun, 8 Jun 2025 07:26:48 +0200
X-Gm-Features: AX0GCFubASqaPghHGVYHa91dU2WRD0JBR-5fjSDX0Abh4qTl7VRZr5wDFZHECcM
Message-ID: <CADo9pHi4byk+5X2Kg0NUnwzHYzGh-Ka-AuW9eKWJ9ky5p03GJQ@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
To: Ronald Warsow <rwarsow@gmx.de>, f.fainelli@gmail.com, 
	Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den s=C3=B6n 8 juni 2025 kl 00:28 skrev Ronald Warsow <rwarsow@gmx.de>:
>
> Hi Greg
>
> no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)
>
> Thanks
>
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
>
>

