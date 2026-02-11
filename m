Return-Path: <stable+bounces-215777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K+OBMlYjGm9lQAAu9opvQ
	(envelope-from <stable+bounces-215777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:24:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6539812349B
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171CD301E6E8
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B616367F3D;
	Wed, 11 Feb 2026 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="OXnuHrRu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4735B625
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805437; cv=pass; b=OTDEStDOFi815km/gdm445oZ26EbExPArJDDX7T/Fctdzfq5t4AHRE5jdH8tXYX+mOCI7c89uD118Y93phJ7MB1CtjY8fAaS4VGEqfW2qRbU5cpQrAKvUEwlv5xky8i2G/qsmFi4qId5AutpC1J3Puw3dCUULCaSjlFBLCqx1Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805437; c=relaxed/simple;
	bh=GJN3JThm9HVHgiMb8j+F3eZ0lgRN+wnA0Q7Lj0Wkr5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVWHB9ziBkPtmcsWgc6Of0W+CcsZF0Q3zEYdUC34UWY9c8lX0DgJ063ZB3y2oVaZUr8uiNIoY/qRGpdTjubkWQLDPuJeKwJRM/z8Ti5w1018Yf6IHBACzgUuGfUUD+IXy/7KxuckWs4dT0nyPN+ezO6EUqJDB0msxUx67AmR0aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=OXnuHrRu; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b885e8c679bso698095966b.1
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 02:23:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770805434; cv=none;
        d=google.com; s=arc-20240605;
        b=VdXVSidFJF0jg7f/HtEPzRP0pDaBEVgNzI5wrBy9uwmCkCr/jEVP/++0yINS+7RbHH
         vqWga4rlUvESLVWQXG33LwrQyAib1+NAacXikxSemneSUWrT0wEqekZYPU0IQEyJhlaL
         2WnxxBuwPe31yOOTUKg8dJqT6WJhISJkn7grRcfAUBrjFm3dtTeQRVYzUw2OersJwI2D
         vXX1D+zOadrGipDtiJtw8GXLzXPpc+aVqhC+9vHhiqlto6OAXk9rXeivhZKMOKSNhWiZ
         UAmMhKJak4Of74FuAnRNWFA50EyrHlfX4bvhmI+S+HqO268E3WNgJZmPMcPNfZ80RD/p
         3a+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v4tmqZhYNY4ez4j9clJooVuPTcvKuhrRqyO3PCivUnY=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Y6P8YNYh0/wtzogcj970HKfVgp4YYhmardFXwT65oBrtOoSW1poQUXjpomJMhF5FZe
         YkuG660jb48WBZDpcBDJdNFvrev7WeDcSmDT8OiGdxGyCUxPPvHAG63l/YJm5O4FEvqL
         eosre6td73MGP8olFoZyJMONCdcbmGCd6Q+Um5oGlCkcRSgRFBb5cgvPw7JOP7qAm22U
         KjXLTTH8gsqDtahDFJKsAr+Osh0VPmP8eog/Fv4VuvUrfyfDYW8DgLEFixm4b5RkFh2c
         ELYc7mW4IDfozJ8RcH5wrmJPR0X2MVWlr1xDw4pZt68hCKhlq1Hjj4UQmK7kL2RL1kF9
         TiWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770805434; x=1771410234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4tmqZhYNY4ez4j9clJooVuPTcvKuhrRqyO3PCivUnY=;
        b=OXnuHrRuoDGjdb21HTMJ0W6pCCjS0fkchfEX2FO6PZGitdYvDWrr6HFocioXqQ/xBP
         qc50y3diH6vYdqDFfa9sCitpECWri1o5Ovfi31ApfdY0BGHBqIgSnoqnNG6go3gns0lu
         Er0J2tLXKhSGYY27lnnoGD6Cahwyvf0R7NFZxkqEsSGTX4p8nNH1IqPLZlo8++3IZ4G6
         u80jPEnwM4rC1S856KkLlVJYfujDDy3VFm5zIbM7QgA1c4PcPxNjEzdfCnfzY0JcBC2o
         zwQQ2VkAlQgfNe3MZPoyygChgKXyCrBFjNm/0NMBvk2SUVVoKlKUYyAh0SlnJ3CM4n+l
         gDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770805434; x=1771410234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4tmqZhYNY4ez4j9clJooVuPTcvKuhrRqyO3PCivUnY=;
        b=nhRlXq+JV1XBSgDPT4AQ5LiId+YCZIkXHARr7wGeJkByEMXZzeHzIQyxVAWAbkV0zN
         UkIaL1W0kHuZYAx44O2uBmH1uOfUsn5Y5vJCSwL6KL4Ocz+H20Id2DB3vOba0Axvr38C
         MzmV5wxTvzw348oF9GtXXS5TR68KyXYFtilfONHr/y9NNw1gPTY9PMZG1OBclC1xWj7u
         4qs+4+6dBPNxLddq6Pja0++XccyYaHkph5/I9TQ9lVZHKM4Vno3oBH006sUZxaTvmxeR
         Wp1KPTP7TRITuQIKJKd+ULOKc3C/yeQqHqXS4eoxYRko+HTc0aN2qIbK2u4l+OLQFt0z
         LLsQ==
X-Gm-Message-State: AOJu0Yz7uXVV6AmLRfiZD0I9cKjwYcc6M71am+SN3hMJA8Ya4JAp49mc
	0VmGImC+Vyt/qX08BFBHvyrM5aiGtwRF2f2hRFQo06nHxE4j2JeOu9E8rjemqAEkbYaG2vm7NI9
	jmchb/yw9a6scSmY8TbsLnkCDay34+fTeRkrMmDdfLg==
X-Gm-Gg: AZuq6aL9DX3mIBLhskb3SSL2lVv1/mNjWEz+X9JUkhLlJBNtpR1kyCetnLC79IxrSQU
	sxw1oWOjytKmOGZ+aDGZZJ5eaJFfb0RP4yVwMNusEnF6Zi7c37thKOaNLRbCNKWC2RfaeDU/GTs
	Np4cC2Uz1fxy66VP9IepXLHxd8NadiJrO86JC1M8pvKvbP9ge+IiVMfUA5pIxRN9bDJbUJ++6p0
	OP+b7G6H21TPuWa9iZetJVslTZUbAx3N2Q8Xqo4RhRPChJZJmzZeXj4nkaMkkaFgBHoOtdsVUMe
	XH+Ex3at0odvsEpa97pVEaAKxwx5Pi747/7BL+6s1Q25cjEpTWSUYXvSO51bT0MPtEd5xw==
X-Received: by 2002:a17:907:da17:b0:b8e:7d43:edda with SMTP id
 a640c23a62f3a-b8f6aa110b2mr114508166b.29.1770805434267; Wed, 11 Feb 2026
 02:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142304.770150175@linuxfoundation.org>
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 11 Feb 2026 15:53:16 +0530
X-Gm-Features: AZwV_Qi8WkFzLyUcNMT6WAEOAamSKCAjyY14DahhzqQC69_qgGWcKCTYt5W4tP8
Message-ID: <CAG=yYwnOCr-zTW4ND39LG-_G37iJC-CEoNR7PLYksu1hm2L6tg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/86] 6.6.124-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	TAGGED_FROM(0.00)[bounces-215777-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rajagiritech.edu.in:email]
X-Rspamd-Queue-Id: 6539812349B
X-Rspamd-Action: no action

 hello,

No typical  dmesg regressions

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

