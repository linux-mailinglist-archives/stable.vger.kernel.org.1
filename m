Return-Path: <stable+bounces-215783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFEJIp1hjGmWlwAAu9opvQ
	(envelope-from <stable+bounces-215783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:01:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E666F123B45
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E80030055D3
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065B313E38;
	Wed, 11 Feb 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="Ny64eHEr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062A2EA151
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807692; cv=pass; b=Xt8vvbS4BBuFTpsRMIfLPGN1nJGfJRF5+y18zmHAtr/mG40V6z8jD8OCMg2qJLUAciy1lxuGzAesqDhKGeKjkev++1Sx8qwdWkeZN2WcsibtEv8YOG0mwr+GXcKNknHTsw8TExHii2h1Fe61nu0Rp5cZnnZ1SWdSx1TzxOXTLHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807692; c=relaxed/simple;
	bh=JqiUcrVPEGkczAnmhnow0+C7TtDnYzm3KGJtLkBlmy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nODrBIAtIsgNOdqOdE+pxPfw8wQTL0S+Ybq8mBn1bUUYMgf++nsK+scfAzH9ADPN1njkkrM2uRoK50wT6hStoC8A30E9swbCzuUw4pH4omYAN2X2GsH5QaFbJtzhDl9yXEuEblUWQUsKQ4l11pheyECp31Aqd5kdid+PQAJYCU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=Ny64eHEr; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8845cb580bso843563466b.3
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 03:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770807690; cv=none;
        d=google.com; s=arc-20240605;
        b=TPh4tgmzhjdQqid1Db+C7KBYGodb5MC1ebCJgPr++9TAZmZL67FrrEXREw8jDW5tZH
         i2vBYDfDHHj34yyG0peL0ji3Xi6F+6/cPGgDg+Uq24SpxoFkSsuIzT1936/OfIUqT1D8
         6kwTdid89ItwaSFFathMuoDIRo0e7kcvM7cEOYGdhLYvlNpYTXYB1uJ4dJv4ET6+qZXl
         vcTIqUabhYe1JVSedGUQUF9gv1qCwz1U751JNqqIioXLWzGFUUMyG4Cn+i/n9Wi+JNfT
         DMMYuSRXpe6KLS1dduexbHHz8Q+vwKg2UuoWrnCFAEcTdFwS3X89t9N1jTs44N2wbezm
         wrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hpqk6MgcyXhDEIdxeR/kAmmG0DQRv4pU5g7p+4Hd3Bc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=AN1lrHMwVxTm9RHPtq8Eg6t4P32kgw7kCATyFoLq5iE/NOFH48WdJtF/FegQInMzeo
         pD7W5v4+pr+DkVR1JxJI+stsF+9BmyMI9Xp8m9yefXjk+vcGszFHO2R2eCFuOhGeS9CF
         2NbyVCtpq3MWn5m+fpkULKBjnqxq2nXRD+eOKcPoJCFgAHpYbqBPNTGG7q3jFxRpQ+ah
         emv4ZFKFcqc5xNskMsLcE2LHJNdRakkNMvSMb02yM2qAilUTBIOWYr6cLjz46Oxi7krN
         pJX65r0TGPd1t2rNjHHHaWJ30VvsFXDGkB8wt1igFXyPv+FdecS/zyCvxUqNdCsZxzk5
         OR9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770807690; x=1771412490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpqk6MgcyXhDEIdxeR/kAmmG0DQRv4pU5g7p+4Hd3Bc=;
        b=Ny64eHErgowJO1suYeC4iPQw5Bxa8C9SOsF/tCrYaWYhxhSsI4e8Q5HoI/s1CUK8q9
         CBao2C1a0IvuPSmxkvAF1V1FA35RHwSHqq9wnQWbrLiL/lvQKB4p2veLPcKQWEG38YCj
         6fx1FSvxAScwl2YxBqomDYJlJlEcODiQ3rw9eMUH5w+rntVw61+rDNty46kf1bJOfbYF
         Hzu8B7aXGCzwO+kntZZJhXOt9TMRQUGTekdDKXzh6aOTA6TCQEBFly74aABPaJjlhjLc
         60hJkmEn9nvVFmoFTEvA4N6qXZZNV2AwZ2hQ+Qa3X0rH+fd+zCBfNqHE65pMZgqQo8Ua
         APRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770807690; x=1771412490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpqk6MgcyXhDEIdxeR/kAmmG0DQRv4pU5g7p+4Hd3Bc=;
        b=ndH4X4BTfEo10WLZ8SjjrRA44FSa4T9STCTslT1aMDGL/dCIoTyTdVfmvE2Mjf9RB1
         ts2jROV9vbH0h0WNfXztCuWoKkgSS+0glbRbKg4A60FuEfVZyECG4HA9PgxOH4+ruIuo
         rUP47nd+A+G2im6KuvRFnlO3fcmVsSC9sdzyrZ7220eV+NC59lkiAicE9ZYJ0XlcXwJs
         2SOHwPakpBv//tWDHDBl04/CCWFBYebvW27HVh7XPImrYrZ5xutZxa516m15vr3QFYJk
         LuzI/o96/iBrZwpY3DebprPvpQbs1lUbPNChyclvlAjFlzW5+CEC/J58J8xPkmX7qKL0
         9PKw==
X-Gm-Message-State: AOJu0YyM0HQnCrVi3YG6J1wjRXLRub6PECv8w2G+QkO5Pe1ZVnWYQejq
	RWCtsNKWJRYr9CdUFxeTMd65PpK4scC0OUrj+I8CkCuWvEwcyct4r+DOpKmr3ofAU7z/3UMRpGm
	b3Y7H2kJmMC1YWZ+xkXlLTkFJOqgPbNmQiOk+B5YlMA==
X-Gm-Gg: AZuq6aK7ACYIP9tg5JC22gCii09a80G1AjgclyNEQhr4yOmjNJRuX4B7UKoqSw0Sjq5
	mlJfg56ioDuKQnFimrSNJvISELTM9LDdpOgf0PEvrR+fGCOM2ZdpP1983hA71U+d6nLjALjkDUL
	4SkM/tBd3aSjE/RcjaATmhd6O0UzH6Nn5IZmjtEKhtD0otFGzXZ/iCZH1Rs90KIR3T2uNGwUa5G
	IUukcUHWriX5YwuLWAlP8FEy1VNn2zkxhA+MZ7I5d5eTf6YrF8CLVfhIrJvtky+SUfXFtcZ2xhM
	fR2YTra0FCoSy1NeIgmW9n/0eeknud3yvY5qUb/nlOhpv8xOnkRS+WVcBt/Vntl5pIX7xw==
X-Received: by 2002:a17:907:960d:b0:b87:1ffc:bf9b with SMTP id
 a640c23a62f3a-b8f6a92e0a2mr140228866b.3.1770807686630; Wed, 11 Feb 2026
 03:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142256.797267956@linuxfoundation.org>
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 11 Feb 2026 16:30:49 +0530
X-Gm-Features: AZwV_QgxbucpjA5xwrXpf26rYuNL_OjL7Eks33hmsL091RZWXIRatSzNicJabwI
Message-ID: <CAG=yYwmEqd0+s=W=VLeKckOsvg8-VukTDzGNMMMr_L7VGNu9Vw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/41] 5.10.250-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[rajagiritech.edu.in:query timed out];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215783-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rajagiritech.edu.in:email]
X-Rspamd-Queue-Id: E666F123B45
X-Rspamd-Action: no action

 hello,

dmesg stuff...
-----------------err-------------------------
$sudo dmesg -l err
[   10.122028] snd_pci_acp3x 0000:04:00.5: Invalid ACP audio mode : 1
$
------------------err------------------------


Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

