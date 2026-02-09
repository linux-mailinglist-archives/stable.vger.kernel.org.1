Return-Path: <stable+bounces-215555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNg8Hn9CimmwIwAAu9opvQ
	(envelope-from <stable+bounces-215555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:24:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D143F1146CC
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A01F3301DEC3
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33493370EB;
	Mon,  9 Feb 2026 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Um8Hf8d9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6E33372A
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668666; cv=none; b=SEgnwgCbPs1dUddq0ArejY/a7tNlNmL09tkIvnnQzRjh10kuzRBvex53No2lgkD8UQY8Jb6fPShrmmRGt72LoKCQldLntq50eKf9ynlTxWEUsVFlT1JBYDBi9hW5hYwNUPbUyL2ZVF9hiq1PwVmGKdxuvf/o7PihphSpvmYu4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668666; c=relaxed/simple;
	bh=3/eidtbor3vGsUs5wfO4Q6med4BbMqoBLLkCHX4pvzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBI7lCS+omR38Tux8EL3QiUx6ZbL7AxIWsUscLnJV+4yZ5oMLmfT/QaTadMsOASfPlF4h2OQPusX3e/sDPHW9GANhcWx880BcwINWFdmQmKXzEyco5EATsx10DNvDKsLc97IHpIXN7W0Tk7cYFJz5W6UpBrHAavE2B3bNVRdq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Um8Hf8d9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so1585375e9.2
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770668664; x=1771273464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXzmvqnsXTGi1Auvh0ztV+o2gDRQH8T0ZKaV9J+SPpI=;
        b=Um8Hf8d90SktNfX/KIlngG1reQnBwZbcHWzxpxdfF7dqU0Fn+FiOqjTkPJNP3TsgnB
         aSi6xInl+lDKHKw9OP6GzKncp6ti1zz3Oncr3OS4FrT/Zq4OQQ48QFtTHkrGh6cwYCKU
         G0Z5SPWjXWUuVwXV6a20ym6GAPOdJmDlIx13JWstmNWqGEgXTyLdnSUW55Nxs6wvTbUu
         QHk9tgLt+x5iI7p/OJnHiy0U1aKZYFSh4R8ucf5cTBH/GZiDTgP1Yte3NmYW6hK6YoYh
         CUG0YfTzBBQ5SmIdOkVCoSXpmpwvc7qfkuxATuIi9xIN5sQxcJ8X6tzMnvfVTvFeF5H/
         /z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668664; x=1771273464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXzmvqnsXTGi1Auvh0ztV+o2gDRQH8T0ZKaV9J+SPpI=;
        b=fhAacZGlKh7sqkNZ2mlayopk8QpkFx8xa1siRu9zI6e9BwtAr+A3ql9CAVxTtMVC6h
         9/y1soWgzjdGE51QcGlCPpF1i6oX+PHgYEt/p0P1Gz1r8mMwxixHDHIQPGhunZ7Uk4SI
         jh4CIT9E5Pz957w3aAPotuKTYekt3Hj9EQv8FmGwMr5gurQGPkb9jsxRe5flQN2LPYCg
         P+IcdbYjrC8fzFjvSJb8o/w+S1wW78bayd/sHqNFH72/Ujq9rsOtir0M5t4xhuKLxJvP
         VUzbI4l1s2+pIaIsojm9HlCzmJ95Dxr4nmxT3hxfo72Q9SdVSSHz+zh4P1xnTtKTv3x8
         FutQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKx4JLrogtH59EWxFqOo4MpjM5RfDfikOAoEEXpIYq/hehxY8qn4TUuzQgAY3d6m1FvaFWhA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJGSQzD4TDRc8OSYOJ4moGqDhcU0//g2hkxk2EII6E1ml+6tK
	YL3ta1FPxoJ2Fj9sBM1U77zx2NLpgn8t/5gwjgQ0mdWB7jPS8d+/RHC2lDwc
X-Gm-Gg: AZuq6aLnXDhW1EyRuE7IZcFfeWwXNV404C8F/+afDcsvHGgUh0sTRtrz7Cfb4IpmJm0
	ogWi7zLtQkUf2IKRv7MukqzN1AUZu3SHAW1F/UkibJAQv8vm4tKRLE5KnzLKKipDDxS7fy/y3wm
	yb1xy0LIjuyDFZV7gNhudbjRFPYnivgRYFSeh4q7ibfNaeLc/lrkIjMOxwoErxMZhh4Zv2xG5xX
	HdDc5V7xKrRs0awu4fM/7MhhHWSJmHmTrD5+Y4s3yUlYWCKnhs9gZJm6nEdTKbJPc9Mcy01bguJ
	yBEA3JdUGRLKYYoe/ff7/rKqvKptVSfznMi3O6WT1qWG21TS8vGjIdhhLc/uSY81Dj1dd6SM8b4
	ZaybD5lSTvBYn4Ua1ReMpBRPAV/xV9vP9m51UddcRojArwGaf+e4xhE1B8Wwlm5iEsCp06C8k64
	/jy/Qy3ICkgezjR7PPbVGPADIkN6xpzgGa78L3Y1d8RMkwSGksNLolJSntLOmFQS8ZqQzfCssDl
	g==
X-Received: by 2002:a05:600c:6289:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-483203393b7mr195515835e9.33.1770668663758;
        Mon, 09 Feb 2026 12:24:23 -0800 (PST)
Received: from [192.168.1.3] (p5b2b41e3.dip0.t-ipconnect.de. [91.43.65.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7d55c9sm10964945e9.8.2026.02.09.12.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 12:24:23 -0800 (PST)
Message-ID: <65e125eb-2d2e-42f9-ac6b-95c4832c51cc@googlemail.com>
Date: Mon, 9 Feb 2026 21:24:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260209142320.474120190@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215555-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Queue-Id: D143F1146CC
X-Rspamd-Action: no action

Am 09.02.2026 um 15:21 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.10 release.
> There are 175 patches in this series, all will be posted as a response
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

