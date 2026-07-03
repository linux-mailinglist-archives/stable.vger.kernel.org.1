Return-Path: <stable+bounces-271793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BXpdHiTCR2pUewAAu9opvQ
	(envelope-from <stable+bounces-271793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:07:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE0B7033F7
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:07:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b=pZTcmage;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271793-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271793-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6297C301DC74
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D4C2D9792;
	Fri,  3 Jul 2026 14:03:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E33C5552
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087425; cv=none; b=ehMgWxNm2BTSRa9TPadk7WNXClAfS577k8uVfAsVDuG4ikyv5c/IEeFHMQqzzVxjUWqwILlPNZXjLkKri2PqlO9eiM3YV5qlJQma9BRnwVFzlDVeTwpSg/Y5NQsw0zJdxfBdHVS1f3HxBzBoxrJoXSLSOwL8PUsEkpaiQ9RBZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087425; c=relaxed/simple;
	bh=xnzH+vuckVgYEMUW/aaupycIFd7DntCShzqjz5PWgvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq2rGVqnOgE2jn6mlcQEm8KuAKAtQhRCrU9KVYCIafpDDcVfKjZkObU4Hv9UKcb2SjvrL5pIwYBYamvnIJqit/fqcYMKcxlABraQeoocdhI8bzdAgrWpidWCPiaCTV95wL980uIq+mgs2cesLieagGvZ7lJChIfJOMlRqQXDDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=pZTcmage; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-461edb387ddso692852f8f.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783087422; x=1783692222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bCpo2PK0VLzQh0dhhWPe7XdS+pSwNhWFcM7edGtLuS8=;
        b=pZTcmage/tjD2xoAW201R2frlF6zxFnatM5U4zruMwbaofW6QfKvlLqfJWs2YKp4Ji
         UvLvTzGekNBa3LGlaIGAP8G3umR5Kli/5ij7Psv6gjpkqC6gtpooFzgFXIBG+GD3txtk
         R+gRESH/g1ZoJ/x7Db6bfcDATB7813EEGLlEbA6w/6/hwjO9Oz1JjEpZqIG/FH+glSz/
         V90dMsmjDXYcvWzwH35gQd+kTZXrlmZ6Kfe9eQX9WXUJqexQKoQUcPo7ng1nahoY7w0R
         UPq5hQrcj/nQ3Qaaa9wOeY84L7glCwNuB6vOKb4yfs4UwBKYY8etO3DO+6eVfp7XxA6k
         kxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783087422; x=1783692222;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCpo2PK0VLzQh0dhhWPe7XdS+pSwNhWFcM7edGtLuS8=;
        b=nIrARzE9i7SXgPe/0I2Kb+xqDesiIXUcJFo9PwfhOj5+TdEycAH9oq3Gjtes2RQWDT
         YG5pzLQ4Y0RdwkA1dxfYXOE7HQBAkycKpimpqSho/UD9Nlh5XR1VciGjw8NSX1qwY8uV
         Yo8qeGGzk/wCDgFnoUPNQquv1MQ+EbG128Y3dVdBonp1XalKI4zYRQpTmr3owshWd8C+
         WB8xntuDJZzYmqyyZmEExfDtwX/V3sJpZHTeQcA+GwDu8ujURmjfu75odotnFsqGg3by
         8zIZZlHG2c2hr97X3WmA0+wZ83UowJ+w58UK4xDAhZFtbboCHYn2ebF0tnfFhDDdPhZB
         bKmA==
X-Forwarded-Encrypted: i=1; AHgh+RpELoZvAIuoXFdaOV/Og3hYhQROEs7Z2cj6qtDAeZa1FgCLrNWfk4YQtE9CEK4aMZtvz1X5dVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3VzP33BHgUinnjuOJnIt9QLMPWf4N3c+7M5yV1xr4j5M6+7V
	g0N50um9c3ErUbw2KxHryEsylkHYsJOzvEWQmU5fUXmQk1cP+A9aIao=
X-Gm-Gg: AfdE7cnnwCXBWfIsj3WcyrGPPs1Es1Ao32TZ+kDyDTcj16OImc3DW6CwIAlEqeez+Rs
	ryg199PDaJpOxPnJ9auVP+35tTxenZ7c3mtV1ifk3o7WBrLxmdquHsNwjD1K7txD/KxE5mWYeIX
	i6leolLKtIu2j3oTONu3rIb8BB5hDzKSIq2ngn36CBcGSXjLQ7hOx6sqtVvetjFwiesyYux+P9P
	gLQh6CMs9IFwaKguEWzUXWDlXtelsM2WwWLuAJ2opS3P9470gSeHEV/zUhwAd0fTHNCYnY1D4yp
	q2QCFey803PeNDo8/YB08dj1WR+Sy0Z4fpeyACUGLDoaM/uVnJOR6by3UZbmaUoqRyTOjMxk2wV
	ytL8u8hyvQaEnHx+FdcpXzKbrcwNtdT5SJ+7rZfQyZemkTWlAd9Mj6tsFDQGGT4mVzv7Lf/DkNx
	cAijtBflDfE4iTmS+b+Usot1nHW1LTGRXKtWp/HDzQI0WPAaOmxSqqA9Gh7N7DXV8=
X-Received: by 2002:a5d:448e:0:b0:473:f4c3:4d51 with SMTP id ffacd0b85a97d-477b16c934cmr11380382f8f.43.1783087422162;
        Fri, 03 Jul 2026 07:03:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b474a.dip0.t-ipconnect.de. [91.43.71.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4a15sm18054654f8f.14.2026.07.03.07.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 07:03:41 -0700 (PDT)
Message-ID: <fb64edaa-bd6d-42ea-83c0-61e0de7e90b4@googlemail.com>
Date: Fri, 3 Jul 2026 16:03:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260703072822.817328079@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	TAGGED_FROM(0.00)[bounces-271793-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailvelope.com:url,googlemail.com:mid,googlemail.com:dkim,vger.kernel.org:from_smtp,peters-netzplatz.de:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EE0B7033F7

Am 03.07.2026 um 09:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or 
regressions found.

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

