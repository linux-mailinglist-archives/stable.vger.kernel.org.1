Return-Path: <stable+bounces-235468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGmxE0Dk12kVUQgAu9opvQ
	(envelope-from <stable+bounces-235468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:39:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CB23CE3B3
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51A4F3012B51
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195FB37472D;
	Thu,  9 Apr 2026 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SUpV5U9E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2C327C00
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756349; cv=none; b=kYnvJuDzLswJfGG0qDG5DaWCtHTOM0hjpz3F/mXnXe4E3MaDBb8jGpJeOMBDOoEbNpgUW3E1jOrfYiPZutgpomNEXXT4QQeP//+fEcMM2eHZ9hLMcjW424FIkZInzAbsag9mYfv9J2vT+2p60vTNdbqV9c1UDEH1tZOS3dPO4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756349; c=relaxed/simple;
	bh=GKvgfkfcj4HQg4NUelc654wAL8Mnaydk/YTIkAyjQhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqX4t2kYtcGWsYPz3c+bhP1D/u/aF142V2CBwTbKA2XAmsYIgoZ41NMf8uzeJ/T1CTbfBQrYr/H4jpAPHiQrgvTaTLJZ03Ba6XoHi0GYVhefSuqH4VtoFSxjqHUz01erg08FDqBbxrvhWdUkaeaawh5D4QV7KfbTlpezkYTkork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=SUpV5U9E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488afb0427eso15410715e9.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775756347; x=1776361147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGTNZ7a2d0nEeyyNcI7jhx5RiQvkCQG4QZxwBBVBlMk=;
        b=SUpV5U9EASX2/L+28CShMaZJnsZaCiSqP1n6kTGFEYZoElVKm9BHuyDRR0pAU133cI
         JU/8lVFTqWPliQDRiDHDrXrIzSzk8HmWQ9GgAwVW5UQsZMEroUkcz9iLOp8/Dy8eEo3Y
         0F3Rfe+9HbaWCoN6BXFC1jpisFdreaUkqeIYqK7peptobMFdw+7bdXTwPbe8bD6UXtYK
         OKd52P8MB+BR5lKTEGFCd3CXlaf63QQzeY5uJBHAbVepD+kfL7dplXr09THU6Xf/ifSN
         dRhYFwIr4jD/Iy+gLj6IgeYc/xiCM2u0s+zeTOPIjoqTLgwwyZL5ZzGLlYgR1HKjrMmp
         +AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775756347; x=1776361147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGTNZ7a2d0nEeyyNcI7jhx5RiQvkCQG4QZxwBBVBlMk=;
        b=d/jAnRhowVqGMpMdEXssJJdJ2YN1bCecwS8C+MS9ZfzyimVVQrBcoLf18MFv184k3j
         +DynXxKpjbTq6ds2AkM5asofbLyW5K4RS3iyRWSkurCCJtaVP030L5izvac818tSRT97
         kCwNSqCppOqmVE+ZV9rcdMgyVGxCn6T+F6NN8w2nIWRjlPIA0W5uwjlsovyzWvWejsZD
         +mgKHZCVOZKL2wRhkmVeTMuJs1eX5bVUnpnOOp1CLoc5ElHZ1IIl/DOtcEdGtXwhdbAx
         rd8xr5JsiFuarCXJ7PPfY7h9K428eMM6itLgjOpt9ttCkBbOdvJdMzN+1cssOTjL+GqA
         fCrA==
X-Forwarded-Encrypted: i=1; AJvYcCXL1KdfdOhs2/QsRnxaE9/N9PtYGpsYT8NEsZJxlMNC1l7XIPcFteRt9ucdvfXP9Hgn3Dg/ces=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbLWo1U6Q4MG8fz264KJ8w0sVEWwdPzBe1fljKrkIm0Pk3HwE
	8knUHjZ07DlX48IqbXspdsd6pkY7GgE67bBpij7+f4l7taX11aZMgKI=
X-Gm-Gg: AeBDiet51XE/OSb+Zf+7NDpWtTh3sgZ5dCX+Kg8549okPcxA+fk4yUV7i/EpD9u31gd
	/oG7EPAk1qpy7eth/Mfe6kX1IcrWhO2+q0VM40TIjzGQa06Ye34OwduOsDApD0C5xyfmTq57OkN
	cPxh4txJqIkqfC7R50HnLperb/sIG5icg0hf3hYmQO1czM2AtjOy3TvNWb8izBo2GDNO1ju4VnB
	NZb63hWLE5OUZB3SJF6zj7FfEe+EFY2XibZm/Sa62y4PPaLKvv+hVXnwPVfKdG2Jf9oIsTxquuT
	GLLTzOhiAyk8Uoc7G7TeERGIpuXyuWXqWxN8BbrsW4Qn4M4BB5QzgpNtLe2T6d5Z7dlCxgjec0h
	qnsuQZBHUcNN3KTY0wLepSrNZhoK4rahGxBDFFJ7TB4uk76rQw/ChXEj5BPkY8p9cfoaRlPyixl
	XmHzTPfYljDg1QORK41tU0gB0d3pC1zVzabbH+4njwz51mQZwaZWvaHp+cerE7jk3oGspRX+1sH
	4I=
X-Received: by 2002:a05:600c:1d86:b0:485:304a:58cd with SMTP id 5b1f17b1804b1-488997153c7mr310683505e9.4.1775756346605;
        Thu, 09 Apr 2026 10:39:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b057c8b.dip0.t-ipconnect.de. [91.5.124.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d809ddsm1099735e9.19.2026.04.09.10.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:39:05 -0700 (PDT)
Message-ID: <d9450f87-947e-4e25-a9e9-a608939d9043@googlemail.com>
Date: Thu, 9 Apr 2026 19:39:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/276] 6.18.22-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260409092720.599045151@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260409092720.599045151@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235468-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: E0CB23CE3B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 09.04.2026 um 11:27 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.22 release.
> There are 276 patches in this series, all will be posted as a response
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

