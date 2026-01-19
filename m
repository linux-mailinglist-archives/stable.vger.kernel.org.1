Return-Path: <stable+bounces-210305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFC2D3A532
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7DBB3002B8C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEB22FFF8F;
	Mon, 19 Jan 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="1s4pZUry"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6162C15AB
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818998; cv=none; b=ho6vYaWxphwqsZS/zd/GPeebOe0JbnrzruMsAfEWgYOQh2b62v0QoCL4wPjLZIVc6yi5YyqlxtQx1LqS65HbQC+GN7fAxyruZUJO2guov1f1hwYNf0njwZ9v+a14wCcmc7AGqOnDYJhZjHEs/i9uNoZKkKXko3TOetEmY7HghO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818998; c=relaxed/simple;
	bh=fdSZnItbnWe4YOr23M55N7Lb5w6z1z0b/nMMiJqGKVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znv3gmx/bY06asvNvLEDP5HNnwG11VEqpATrJiHFAgF7OLX7LlmXUg/lxNxR1aiGjT3t2P4nNFFTbTRS6TC5jS5Bcf9dAbSvFJiH3C/Ehx5hH14OqRS4BZCSQN8fXT/sW3itmWR6YssYe5zoeJ7pyQhXHioADQnlahzViBsazOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=1s4pZUry; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8765be29d6so599384266b.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1768818996; x=1769423796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pExUEOHaA9xNhuJIw+adBh5OVY66pOfgQ5oeHIFkeeY=;
        b=1s4pZUryxfkGIivJGTO/533dOzC6CFBA0ReQWOtZOZjs/6x7tkouru1KuMuzFv8g0e
         eRMjlbH57xWSrzqPIV1kDYAhLmtS8emKIpKWNSTcYJl0DX9gS0F6hsijgHqeLUXnJlUK
         vT8C7e7IkGkshNHFvKQf2Eky15ddo63Fk10Gkb1yuJE5GWgeQWZhzHHE4j5Qkd4zrybv
         eiMq4eeK/OVPIOzuoyF6jtvJ0tdYkHwOBK1wE06odu28VwpXLqgyZ/iV33THVJy1pI2W
         ud2xiYidYzXq+XEeKL/CjW1bmUvv82uv00aim7UL+L2g+V5BgW+EbZPWAHElHoyWPgha
         2sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818996; x=1769423796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pExUEOHaA9xNhuJIw+adBh5OVY66pOfgQ5oeHIFkeeY=;
        b=Dx7ox+sd3d0TCOlGGq+0jmFmHzew0xtAa5Hkn1eHLiWjVKzLDiKa9cLoDgMNnK9oET
         46GPxnBoedY7ei+VbjbExw3FNmEro20fHEiJjz4ESagqtxpCPgfMnB9lvpYpgr1Gn3ze
         3a9ZVxL1gxGvt4ezvETP06N7v4Mm3WIGQqMykfouunzmY1RAcAqHGCLfboinF23eCcjj
         KgiUfAw2izgfLTcyKpw/L/3zu0Y755r3wrBNv5zyvQaUWpPgJwLJeiUC60kTNvqpWWwF
         QvM9CLfDzvuZOutv3Q+XTHnfuGirkbnMHi7Pae8gBTnMO+vZnT4c9+8EtUldxkuFv9au
         RBUw==
X-Gm-Message-State: AOJu0Yxt92yhJGitc9smdw5pCufCDb8sc9iJKw/xZ7F2hQFt13OsV3Qd
	wjB1IGSbu/jfPIAOD8b8bjCEk0ezBaamdIiyTKbfgBcyIab6Hs3K96txW5zb2mG+Ewl+y+bQiuH
	3eSUrAik0HMtX5OiP3zom+SS2gNwRVQ4yJAH6SyvptYfUUDBRucyJZyFtx8PD
X-Gm-Gg: AY/fxX4b7abyrLXb/SzcNGyLcsd7SaMWDXo5iNtoV9Kj8vE9PsqYMn8CFf2zrykz85t
	6RJZ4FgzOrAuGqe2hJLbja/a7F84/VWUy0iBleEAAwRfE762iweTiCi8ctW6kjnoNIQ6/YiPcEo
	78bMQm1TnafTq7Yepxr9w123wRh6IxS6dPDZ57yF/RO3rRJDVSekjcVUSbcOUIIrtmAFu6euI2/
	dGcx+SJyp/3wDNLLEyft4F9FTdDEWP/scbfhf6oaUoTqLWRaOmkTtqA46GsIJzblnmzVEDr3Stx
	gp0k/gQY
X-Received: by 2002:a17:907:3e83:b0:b87:7e8:e268 with SMTP id
 a640c23a62f3a-b879300cc4bmr943539766b.37.1768818995635; Mon, 19 Jan 2026
 02:36:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164146.312481509@linuxfoundation.org>
In-Reply-To: <20260115164146.312481509@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Mon, 19 Jan 2026 16:05:58 +0530
X-Gm-Features: AZwV_Qhgw4EwW6jhkOQm3Hg9TmTF_g35hNsXAKMoQ9WqkvY_qlsieTpoQ8-Z5Ms
Message-ID: <CAG=yYwkgtiSbzSAPK+G8DgkPLsByUX7QBE+LiafT5WScBzqRuA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/88] 6.6.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

hello

Compiled and booted   6.6.121-rc1+

No  typical  error from dmesg -l err.

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

