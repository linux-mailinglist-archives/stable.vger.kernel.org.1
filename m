Return-Path: <stable+bounces-214373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E1eABvXgg2n1vAMAu9opvQ
	(envelope-from <stable+bounces-214373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 01:14:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE3ED66D
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 01:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0247D30107D8
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A1469D;
	Thu,  5 Feb 2026 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gYEjzZKT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAB3C2F
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250480; cv=none; b=QV5Pwlr1BzEPTVX2D+Tihl4OHo1IfIXbFQZCn47+UYoMUY46IaZk0jkxjHklQvmdxBN5VTjZWJ+wp5SbihNKpskhBkton9gNx28nKSwiFhUlOCRIqy7H4nzYCPbiCy1sQ3V7G0gDYnYYRNb5W2thU+rbOW9MeHFaoT5EuH48cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250480; c=relaxed/simple;
	bh=uFO4zVF/Hoko0cv5qb6/oBheywm979vzS+61mnbUN/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3JoGx55+eOJpLIoOdSl1fCMP48wib6sTrV+PU2Vt51UNRakIutZIWSjG6Kr0ijkHPENOxaTSXnKhyg6K9dOuKaN83fGbmE3RguPdycK4ddMuQJyh89Sj2ZMjHwZCfponUhEMthmqtL6Y1MOCwp7vs/i5IS8eb4oMhzruNgQiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gYEjzZKT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8837152db5so54874566b.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 16:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770250479; x=1770855279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqowFhkd9Numzoj9YJVWPlTlwbbzoHzVE/LJNEUfcK4=;
        b=gYEjzZKTT+jkc88V0/Eq0W4LUBzRacBv8rLvsmsVpbhhoM6eVsgUHR+6D4QltB9vsy
         SeLGwVscwKcVM7Od2XW52WmzywNO/IS4d/lBKk0A23rRlBz+CZz08LQwpE00UwR9xmAV
         lTJCtEDiJMpAGD6WjxODizz7vZYl8VvX5IFOTBqy6U0gzcOF5cBKTTM5SGRzCco++Qqh
         mYuKXISDHwncuZqtMublRooefw1LhOajUiSGzfE9g6QM75qO9DdeFqAOZsHwER1AN+ve
         o108c43H+QwqvTZiomFRHIMACgj5GQ1E98FAo7x9+FJy/fX2k3DgfuRRvy9Y7k/5NS79
         zp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770250479; x=1770855279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqowFhkd9Numzoj9YJVWPlTlwbbzoHzVE/LJNEUfcK4=;
        b=rKEn+ZdktYT88f+7MIaw/+cxXA29P6GxSDO9aZBj65bTrm8b/FH9gpFnhRbJb55V8l
         xUJR7SRmTEE3Ah6dt3WJSDiWbBcyqLbUK+GJ36xwJYxqrMOA1gJ0Xh4i3+S3Dg32CFif
         LpRdFdVDWrxoPNMPk5ClJ/0l7jVbFwyt/Cd8rQssY4AEWDIrcqHvrMzk8MQ+/cbxIoX3
         sk7p+aT4VjrwKlnG4YoFsLY4DWRwoYWhC0N2m7XGj+hzTFlLgWUpbzot5CTb/AIWBNgg
         YyRKRXXxaTpm9y1sIhRUsPbErAZ+atdpxJsEgr62j+v3QLnuweLsZOeIEoDLe+qxIee3
         0Qqw==
X-Forwarded-Encrypted: i=1; AJvYcCWrgOPB5qbf1iU5qaCBPwQOpibdT4mmjagMKH5nzjl8/zRs7O0AEEV8ZLQf7K38SHyYIWV+ryI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdLNmSCq0aaoVGDgG/02NI0ahKRJcBxnr8B579vrTNfei0T0q
	bMnFkv4slhHYfxu+1Gt7kuA/pWOKl/kiYsfYE1khhzR5lNpwkCPy6GxorwmZ
X-Gm-Gg: AZuq6aLwlJoxZHPgmU7DDxRRcsclhWBio+EvgxFWpWzUJvS6gQUPukE6xpEkEuxKq4P
	XoBwSZhXds8PFmMHLb8mnUrzR+q54KOUbkYqihkAeQ6yjWyAKKVjFCslk+CXu6WJXEMMfgNIGqD
	/bstFGKN6N2GX14htHxN8Y3usob8Z4CCf96IuvEIueYv0lcSXJBJ9EoXxYgVqaJOVWbZFvDNAVz
	/4rfJsusGiu1H3hMxme04XqnGicD6iwdm03mQsEaJkza+hiL+lOEDkK5cT5Q/G6TzdY6Z4eeokw
	GwpmSJ9Y00WY2FhdQCwPkxS2VgP/FswlETetivEX/tNekLjIYKM832NttxCxjxMvOP5Y5GFACIY
	kdPdmJurGDeeE0NPrYza0TURoNFUYNqI+oGNjJNTnqkU0KRU+1iqFf7ojt48ayw12fTxHqyNL+q
	+JY8kFI/5qW2XMzorw/ukGQszM12YIchCKWpKmEdVT/U56qUXX5Z9u+n4eVGHBxMq1T9hYZyBV
X-Received: by 2002:a17:907:3e25:b0:b73:667e:bb29 with SMTP id a640c23a62f3a-b8e9ef30c03mr308075866b.8.1770250478447;
        Wed, 04 Feb 2026 16:14:38 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4d5e.dip0.t-ipconnect.de. [91.43.77.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea001eba8sm169483766b.48.2026.02.04.16.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 16:14:38 -0800 (PST)
Message-ID: <c19e958d-baec-4c42-ad04-03e163b39363@googlemail.com>
Date: Thu, 5 Feb 2026 01:14:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260204143851.857060534@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214373-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Queue-Id: 68CE3ED66D
X-Rspamd-Action: no action

Am 04.02.2026 um 15:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

