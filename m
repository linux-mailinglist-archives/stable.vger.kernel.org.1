Return-Path: <stable+bounces-217205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 08sxByEblWlFLQIAu9opvQ
	(envelope-from <stable+bounces-217205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:51:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A53152960
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71A77302AC14
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 01:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4AB2DB7BE;
	Wed, 18 Feb 2026 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SLZSaKXQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7B200110
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771379482; cv=none; b=n4fk21aonak7LxmdbEVIUkAUmKyzZRcXn8FAhqnzxh1DH0F+OMZ61SjNec9Goo5PvbvEPnxf0Jt2+v8vcMf2kpZyV3GvRSiouYBaPnnpfeOQbrAzQYPXSKcQbef6Ih/c565Yr3Rm9TcXCLAvREfxgJIaD8iklyyjYlppF8rEoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771379482; c=relaxed/simple;
	bh=s53FtDi4yfrfGvaH9gABy/957FDT/Fvee6Ceokd4Yyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2LDo/BpTYx5UPt5tkTzFXAZX28A4u57AFgMCCUC74+iYOqIBsKiQiTMXB7CvJvs34P3C0K1AVW4LMP5+g2Ct0n9Cgi3Uc1frm54t6ftXFE/cCCkSEbM+Dt4wgqXCm3sGwCwBe3v0Xy45xOxhJs6qlWomC0U6boY+rCM/bDtus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SLZSaKXQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48371bb515eso54881445e9.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 17:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771379479; x=1771984279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76qt1H1of2fUIBeck0ZIskjBGEz7CrevFA9+VCD8yGA=;
        b=SLZSaKXQjY1k6brfz983u7bIon1IxYKy8ifO26ICcYb3GaPHxOL6FFP/YImprMYULC
         NNhbqUYeo7SK+SOp/WK8qZSVtDFd0tzHP6zp5GnVe+CraH0Os8TZU43cIgR9ShQy4wZm
         5Z+SyS4ZKUSpGJLioeSGX/NcBVF2XkHvsqYlSATnSybdqji42Nz68sHJNEhG3FDiurjo
         ALF+3ki0i3qrNk9O/uhmUZSw5t4vyYTiPPg9nwx1z8aT68nMVDoBH4mGCpscWAxOex7C
         jO8QiAwMLzVHQGxRvM5cHN9nPLzz34eGN+EsWbyIFS6GS4OqnktpL6RoVFR9TfY92TzR
         /ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771379479; x=1771984279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76qt1H1of2fUIBeck0ZIskjBGEz7CrevFA9+VCD8yGA=;
        b=v7dBVd3VMaCKLxct++oZJfbX6zAFnKRY3jpJTc0JpNuXm/PWhhueDKUGdViDqZHVDz
         H3qiFCAvV2ipj/osh9gFiramssOA+Wgb1vvouenaai3d0MnWjjW1Cc0L2TbGjdkywyNY
         4SwxbL2iMODKqNKeSzUYsycxjjkT4f7nvlzGX9uRGXe5IgvpPyM02VomtA8YEWc7zE4J
         FI16B8+KPX2EJcvIgN2dP4T0D/YN970tz3BALc1RsfaZcCrRU/5aiZIm+/yjiejhlLqu
         OAUmvNOgtfMNw0whWMZptLLIPxXwXcllr83yOItklO2EOse1Si0gkO0u4Vuxsmwf4E3u
         1jAg==
X-Forwarded-Encrypted: i=1; AJvYcCVey3q2LzBG0qQtsX//yu2jgQU+AkTEXOR1L4phVdP9L/6SP84LyOdopKd2kc584/sghCWt+Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZ58wkWyrq0spkpUPDlsKoH4HQ2yF1BThr7z3drt4NPvJZ4iX
	nZAHHshkIX2Bpv/BXf8b43iwjZjI3s9C0BIHFsdZMs6OC5zbrhKHok4=
X-Gm-Gg: AZuq6aJaYX/4jLRB7kwFtAViP72gYPDutiTXYQMxYQJYqem3UcHrJ557x3QrVH/pMN2
	D6d8qLwxhOfHIF2b9jR/kFixNNsre2tJTot53FZnZtxPmTUTMM4ILWWXADL+ysSDHpzKVD5JSqR
	9y+CT5OFUr95kpGC+KvjpO8p/NFbqApc0+2OMLgB9U/1Wb1EUpzQEjYZEL99z7jxBtPtrgY9COU
	tYfZuGuVTctQFZYWWpchCuKMHSwaKuDuQhGAEdUdIXejqTfX5N7bMYWPpXqZLif/3egsS1WNBv3
	fhgOJIqHir592gUhjCwGhHxbXE0zPTZUwr+a+ddRcfzXyxW688Lb26+qkG1z5iTAKUOitlihVEv
	9qyAET7Rzo7U1yQEyOC8rPX7YBfO23GevznMZ7yJdT8QgaJMXO65NgVHh9XzqViCFV3Qd3CUXJ/
	Uu0vSei+0udVvlXrDNRne5u97Q7aYAYJ7p6n5sn7wVYDmgCbDm2tcOewaw3eQ3axgH49vudA5ws
	/k=
X-Received: by 2002:a05:600c:3542:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-48398a65ed8mr5894585e9.6.1771379479239;
        Tue, 17 Feb 2026 17:51:19 -0800 (PST)
Received: from [192.168.1.3] (p5b2b44be.dip0.t-ipconnect.de. [91.43.68.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d994670sm437860715e9.4.2026.02.17.17.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 17:51:18 -0800 (PST)
Message-ID: <95d75bcd-1238-4cee-b323-ada31ba2e6d1@googlemail.com>
Date: Wed, 18 Feb 2026 02:51:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/39] 6.6.127-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260217200004.221651386@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260217200004.221651386@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217205-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 66A53152960
X-Rspamd-Action: no action

Am 17.02.2026 um 21:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.127 release.
> There are 39 patches in this series, all will be posted as a response
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

