Return-Path: <stable+bounces-200710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F01DBCB2CEC
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37DE230A299F
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A52F6587;
	Wed, 10 Dec 2025 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="xh/TnW8u"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1982D6E6A
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365765; cv=none; b=M/mK9ONIflRu50pmVVQDr+HTbkD7Il9F+J0KEgt/l1IBmX84zKKYZzaxb9hStgO9zT3Gu6Dd/eKwEK6yFknX3TC/zOwCN5qsMrdnDth1NN9JdK9HR2tmMi5kQygIPxcNVcChQJA3jpR06hqDNIKe/Fg6pM+ydalAFTPq0sSkGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365765; c=relaxed/simple;
	bh=RwJqEKrjOHmef3MWEP1ZSzKUDTRwliaRL3I4knFEl/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHrn9L3R+gubrjK4rRv8Ni/IQ7t06vvvSQ1/A+pRX77aIzBpC5k4P90Ug2tg1AKRDaqhb1iy7Y9eGe7pKloptArdY+NeFtu3zJvm34bO7R4ffZIfTsvvpSwWkXVxT955zpIoLUBELT6sBeCYDqCmqlscM/dtJvw9nHCY/YI+o4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=xh/TnW8u; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b72b495aa81so1021242166b.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 03:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765365763; x=1765970563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y3fR6ViPsGqU8MfdXZ3Af4k0ImLkw2v66K7RQbWl7oE=;
        b=xh/TnW8uYohX8CtrUKqZGUptjvja1s++yVk6grsnVIAq0kuvgi00gjXhTTJT73kJu9
         KMoCjy/smfn16FvyajQH5XKTzrqxyJGmcNjxHfVwSqTsksSTgIBhVT3yoXdRYZm4ed9u
         jy7nbEPhJaZKPdNMpl7mCtzWGOYZiPPsbIyZQ07tBPE/iR46HdulPzveqfqHjfznoi7/
         qnyxevv9BKkAfsBiynKohj2Fjh/xCBDxcZS7mYnVGNgwKB51A2KLStRLUf7HLSVAPDcZ
         OqzxmXv05yTY6QmP8DWUS2t9CqHqZPqv0RGMji9SZQOF/dh1m0oGl1Ao5ZUcCFF8YaBO
         CKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365763; x=1765970563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3fR6ViPsGqU8MfdXZ3Af4k0ImLkw2v66K7RQbWl7oE=;
        b=oqAJNTigplLAw5SgzC4w6AVatETNEu704BOgGVLFJfkf1SlLtJOx78mID6rcxtbduJ
         ebOjHg/KirhR9jCIwP02ZQbvb5whfQHp1/eJj6W6cNlh4XBJpNUHriFer9zoRV3FEP1y
         Sd5yCxw+5OiCLxYWaoWEmC1uPZXtSopsQL4/w10Rnvz4W12U2muzvZhuNQFTLO0PUcFE
         K8o+46FziiScQ9ahn/TG/HnIgxD+TMfEMdyL7GDRVHVImmlBm9MBGi1ucx1g6Z4RimxS
         6hT4G0HbU2wFQz552XOJz+Fr6+P9WRIbd6QuFfSULJ0jhDiS+TEhOUhgMsXLlpcOz4Q7
         c4HQ==
X-Gm-Message-State: AOJu0Yy2JeS5584N9Yd3z5pPnZOzf2k6gqowJnlkJvNemvf2iqZTDmnW
	gniOFQ44NcE7vzTRD9lnEBmsIFHU+ylEt6pstfCsmlEfcxtUBS7QHmrQiO0m9KjeJPFCcd7zVeH
	GcvSMGM/x14QnqeMd+bSXQzxk0dEoiZ4ONWPkiL6rLg==
X-Gm-Gg: ASbGncv663DPyHYMauMMltRsoEvhSjFjtjnAaNSGCbJyNAb9gmtL/9lWJfF7H/rkpKy
	rcZe67K8r2GOOUidGSlbZUS2yEaJJ7deAXCz57blL5kNPHjpdoIpLt6pNhPEyCuKQo7uGa+kLtz
	jgPBY6WkeNlhOLt8LljYd5cvPAN+r8wrQCUKuwzW/GNcJjjTsDUJshSyhziDUXN2ZZMWle18eMr
	9Txldsu5NSUI+VD53iq4ndFsTwYTJyrWJm/pFn4pmXjWBTgPooMaj21YpoHhYmsn4uE+SrBclLa
	xRPgGg==
X-Google-Smtp-Source: AGHT+IGpkdTQkei/z+CfKPvwYo4nremFkFGY5G/hzKyLEiR07JwWYOd21PmvfRI5FQr2rguFgg0RpN/HWyzj145KWPo=
X-Received: by 2002:a17:906:c103:b0:b73:4b22:19c5 with SMTP id
 a640c23a62f3a-b7ce851c42emr213067466b.44.1765365762765; Wed, 10 Dec 2025
 03:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072948.125620687@linuxfoundation.org>
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 10 Dec 2025 16:52:05 +0530
X-Gm-Features: AQt7F2qBf88HbQYd-YGXwdQSek9eban_IwWQ9i4SEquMn5zl2qXNvQTqRH1acrk
Message-ID: <CAG=yYwnRwG+uD0mS17X0cvzruY=nRUyK_HvQhtxJQCCmi1YF=A@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 compiled and booted  6.12.62-rc1+
Version: AMD Ryzen 3 3250U with Radeon Graphics

dmesg related  no  typical   regressions

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

