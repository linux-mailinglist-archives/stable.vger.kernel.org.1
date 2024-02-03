Return-Path: <stable+bounces-17789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556FD847FB8
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 03:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81E4B25312
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF7882A;
	Sat,  3 Feb 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jvhmreDY"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E8F9DE
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706928346; cv=none; b=QSg/COLz4y+RL4iB578TITpEpUZmCilTUVZ1h9hnZHo02SiN0CutU0ZQpf5ALXRXT4eHoNSoglKY8LXHMKribXNWK2F4om5sclAsdd7KZAahK56Ug5Ub7ubj/DBasan21F9bGZsIoUVZsV4dcFDxKTukv7DqWetudGUPVJHLc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706928346; c=relaxed/simple;
	bh=eMmpm9D1VRMDoOm2C9Wcj2Rh4lvyUqgntAlB+T7UHe0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DVxfszyCiZHepVaU0EbtvVI0+yjrad9BV+L7kJeZP/V61F52OH+CkzvH3t089ggmDIzNjsoltY7ls6Tde5kiUjxfQ5s+bkQlF+aQ2RDUdrrNKitqn01GZNPh/QBxp+S8fPMgTDXwZ6Iw39SMCqtQ95U5CqLfemeegBJOeQs8MPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jvhmreDY; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-594cb19c5d9so1542290eaf.0
        for <stable@vger.kernel.org>; Fri, 02 Feb 2024 18:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706928344; x=1707533144; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiCf+vXw/vrQdA5jqpkianEwZDzpLmx6VygCFzNFFyU=;
        b=jvhmreDYtDUfmYBZxEtN1HrO9sQnsJB7D5U32VxT1yfgqlb6omk1NJahPOfphgIEO8
         Y++g/N7HFY5CEi2X2vdkBwjvCsVxmzNaFSyXAhZr/hS2QVVKNqrR7NNIKUxgAWQytRvv
         fr3j0HHRiWqJgosd/02Fp0b5yzEpxFVM9SNrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706928344; x=1707533144;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TiCf+vXw/vrQdA5jqpkianEwZDzpLmx6VygCFzNFFyU=;
        b=wQUtkM2KBMFjTiqJn/znlWuyE6ZzE+sBN9iXSnnsvKzIysP70lBhJDbz1C5mYdOvSS
         gxuXqegtra5iTsJSUWfzQDegY+BdfDEor5F2T4WwjJTU77/WRZICtnuISktkCPWHJ5nk
         o8uA4vznxqtjB+wHIjDusO/9RPLmoP2tI8QnDVpy3XToIUI6/yUx55TVjLx82DU36fTE
         wh9LteSCFMdovfakFDHLlKW+49bFwXymLg5dzCjqRZ77dpIDdz/QuEPktsQKlgsBss5f
         3LSXapT/C/oZX4K22s6XyPnM/GI6itcZEqGzpL2HqiJfRySuHE5OeUiVTGSUSw/oeS3e
         0BYQ==
X-Gm-Message-State: AOJu0YzCXDxCDWAmuUvsNhXDfzHuqhsJbjscm01c2km4u88n67Rba6iz
	6HKKKl6Of/LamRlMD53b0VHhcSg7d4rd4oF7I6nT61tBtkBOMMe4tN0dDghN8pKqKM5myLkHCLa
	h6SNkzqQ=
X-Google-Smtp-Source: AGHT+IGyzGoq31C1MkEL9BBu+gtt2B7T9u1AfwrDp8NYtrLuFNeUM78slwISaHked/S30J27Eaaaeg==
X-Received: by 2002:a05:6808:d5:b0:3bf:c445:7827 with SMTP id t21-20020a05680800d500b003bfc4457827mr182687oic.3.1706928343833;
        Fri, 02 Feb 2024 18:45:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUl9LBg4+16GDNvnn+LU85BXpWpNrDbl6O71E8gDtDHI594Cdt+xcYEyq/wqqI7gi0tK4SnHiVPUg1ystMo+fDxof8IMFS19iv1qUUkkh/KbpQYd+aYMeStVM3pyuMNE0aNa585Gh+1qL78
Received: from [192.168.68.60] (076-186-130-074.res.spectrum.com. [76.186.130.74])
        by smtp.gmail.com with ESMTPSA id dd7-20020a056808604700b003bd4ef0c871sm585792oib.41.2024.02.02.18.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 18:45:43 -0800 (PST)
Message-ID: <3b82d3d8-c0c3-49e1-ae68-966f02fe5429@chromium.org>
Date: Fri, 2 Feb 2024 20:45:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com,
 linux-input@vger.kernel.org
From: Aseda Aboagye <aaboagye@chromium.org>
Subject: Requesting 3 patches for Apple Magic Keyboard 2021 to be merged to
 LTS kernels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear stable kernel maintainers,

I am writing to request that 3 related patches be merged to various LTS kernels. I'm not sure if it would have
been preferable for me to send 3 separate emails, so please forgive me if I chose wrongly. (This is my first foray
into interacting with the kernel community) :)

The patches are as follows:

    1. 0cd3be51733f (HID: apple: Add support for the 2021 Magic Keyboard, 2021-10-08)
    2. 346338ef00d3 (HID: apple: Swap the Fn and Left Control keys on Apple keyboards, 2020-05-15)
    3. 531cb56972f2 (HID: apple: Add 2021 magic keyboard FN key mapping, 2021-11-08)

These patches have all been merged to mainline, but I believe when they were submitted, backporting may not have been considered. The Apple Magic Keyboard 2021 (Model # A2450) seems to be a popular keyboard, and without these
patches, for users on certain LTS kernels that use this keyboard, the function keys do not behave as expected. e.g. Pressing the brightness down or brightness up key didn't work, and bizarrely pressing the globe/Fn key alone caused the brightness to decrease. None of the top row keys worked as expected.

I checked to see where the patches were missing and figured that it would be good to have those patches in those
kernels.

I would ask that patches 1 & 3 be merged to v4.19, v5.4, v5.10, and v5.15.
I would ask that patch 2 be merged to: v5.4 and v4.19.

For patch 3 to apply cleanly, it needed patch 2 to be present in the tree.


Thanks,

--
Aseda Aboagye


