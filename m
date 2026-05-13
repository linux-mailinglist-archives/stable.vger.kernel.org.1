Return-Path: <stable+bounces-247041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMOVE7v5BGqNRAIAu9opvQ
	(envelope-from <stable+bounces-247041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:22:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE6E53B656
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C49493009E0A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A178384CD9;
	Wed, 13 May 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lzSB+u39"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A133BBC0
	for <stable@vger.kernel.org>; Wed, 13 May 2026 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710965; cv=none; b=UXpKGIRj05QwzOfgOzHy37Z5ZF0X5KuA+ocXPeGsF6Hm1d0CX8igIGI/In1GVaRIFZMGw5+yKZUEq28Vz4+1We9Y9Y8f1L0cX90U4W+E14ky2kg7JDifNykjelKm/G9XLkBVyI/40i/NLCVoLwrEaLapoEK9bN5BiOi7dxhzIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710965; c=relaxed/simple;
	bh=+H/yxd5K9nn+nhvqGlw8mcNM/DpbIwwmMzUSEH+Y6Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/ufhfwQamgKJAcBnW0QcKs//Nw19sI9d0WSzPYyq6L38q5k9oR1T5/MEV1Xr14EkpLXmski2HU7qd4pzt3h2Kesmx4L+0D2IkLSC6WZwy17VftKkamFrOz6QHaCqsmbnb8JNL+Iu/HSHN6rlpX2Qoxzy/t1MZQHuhYweTEJnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lzSB+u39; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso83197655e9.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778710962; x=1779315762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nc7PdcjPTXGOgaYBtgkZdnvKNVmZOTErVou+sL6n29c=;
        b=lzSB+u399jawFGHOs2gYr7dAzZVH06b3LvmmSG7so9s/vHaHG91Tn892Ewc4PDhC+V
         KJfciNri0SpmtwCJmlYJ9SO5eSqahV+rOnUDjnyV8vS7vOUUgCD0X9vUfUULHuuFsTJn
         gj7LVy0OK15oE6KEWsUx1xq0eGvdsQZpvPEJ1JSspWP+ku2MDbAEkD1JHSJ6WtVBa3UQ
         FeQJpJpm5Ys75Ai7+qz/QxrdY8iZ5Srtpk2wH5WUjdEU8nJSUbBHxjUfooB/r+k2sWoc
         O67o4aT4m/J7kTgs44Xuaiq9/zN2fN1PMtcFAwmUPj8rWWGPv5rkn2qu2mGDhm4MttNY
         pc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778710962; x=1779315762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc7PdcjPTXGOgaYBtgkZdnvKNVmZOTErVou+sL6n29c=;
        b=G3fN0/tXmBMqd9jHWunb6V2gi0l9wyN4S4FdEXZ3tMmIvIFZCnHxwx3YEuARPDEW6K
         9lBS5s7BO+3/tFrKv9E5Qf+k2ckUkBQRhZFfLdmU4qERM04phpCI8SFs3mNdOJJG+WHW
         8wupx36VXKBXBPsF4QsDmZSs+hS6ZwWydhR9Uet+kUeCmlS/2B0aLu5LBVMyt+SaSrNS
         hgwQkhL8X1KsDJybzCcj+/vmLklzBd2y1MTQb6JGMcaQQYGHCzBmS6cBsOtRELbJezvK
         mI6w3WSd1qIhjG0/ZH2tiUjWMjOnn+giAL+ohX+4EBly/8hYqDtNCXWFTF6xzP/iJ9OP
         8nFw==
X-Forwarded-Encrypted: i=1; AFNElJ/qtAPsoCBqQTvEiIZgNFfNPin2aq5S1fCfJQ76TsnDTTdcyRqnGA4G5xAFjnaXVAuSfUy+jMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrgiDyIRsCIE+nxr+WEcFSMOdl8NXnPsoZvESdK3HwrxwAaLN
	LAzMPQOdgGRhpdLK46wCAnAomBB2mWjJAWcwGpBtPwZfcEhz50OcQ8c=
X-Gm-Gg: Acq92OH5F2UyFwMiYM2UIofsKS+pz8awwJ1A7/zMo8XjbRxsXFzv9NNbw2cIUuG6uaH
	5x1bs0B8HNbqyv9JOpQfDTn0cxvhj5m9p5lZtWKD9LMOA9DHZR+JY4oQ/+rWluzCSWz0doKyEl0
	jRJPaCFSSlXlpiH7r3rbKT01HHEP1vKg5iNM/kS8Ht/8QXbT4dh7/0XlHRPt0ERWbmRMnWg7D94
	O1ZuOUPnuX4YzKo82nWv7Tr/yjBY/gMOtvujX4xtCmnds9nLVHu6z2ptL48c5mxkwyyZLfH3nz8
	umHZ8NddBqwyTUvFhmuRNE57j+aLY2bHw7zDp6SA8vwBfIe0W4UzZxKyRW54LF5gecDhD4LEuUw
	3y1tFTAGyDW3d0KDsdFkCWO3EwwQQDmjslIGoDAn8vg7eKnBxpUQ7wH3HD7gMYdamwgiqZYnH6R
	66gF2MHeNFS/OCBUZyqWxs+O20XBbw22nL5EF/UdgczPbfTYL21BY8A84zX9zu9RuyPo0XfXMBk
	g==
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr73514725e9.19.1778710962051;
        Wed, 13 May 2026 15:22:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b057262.dip0.t-ipconnect.de. [91.5.114.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm1926137f8f.25.2026.05.13.15.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 15:22:41 -0700 (PDT)
Message-ID: <f8262ddf-050c-454b-b8e3-94a63bec4d4d@googlemail.com>
Date: Thu, 14 May 2026 00:22:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 000/305] 7.0.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260513153754.934923793@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260513153754.934923793@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DE6E53B656
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247041-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Action: no action

Hi Greg,

Am 13.05.2026 um 18:17 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 305 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

RC2 now builds without error, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities 
or regressions found.

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

