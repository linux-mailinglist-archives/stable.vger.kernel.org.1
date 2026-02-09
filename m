Return-Path: <stable+bounces-215569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJz1LR5UimlGJgAAu9opvQ
	(envelope-from <stable+bounces-215569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 22:39:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A2114DE6
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 22:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9A6C3018D62
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1426ED48;
	Mon,  9 Feb 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FzN2nUlV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29A2E9EC7
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770673179; cv=none; b=mJYvmc7m+Ahi8HW2UjzgteDOQouGtP6FriKKRHHOfJH5q1tOrQbiyCfaROLydD2tKaOmUSNEkVdljkT6mUSdKmh2WLL4GsXK30mOFo2xCzhQHsC8HRXF6FWFDpl04hV/gK+yVCCeeaQGBv+wAW99Mc8yBwHjKcKejh3DvFwXAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770673179; c=relaxed/simple;
	bh=1bdJ9a5hOo2hC7LXIuPxAu+2IpE7T9vXNdTP2NOjHDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlAs7tjqfGLlXaribXFdM/NfSm+atsPZ3qk7M9FRhCjog5ynh+SILnuWk3c+cneRrOFYDZTORfFFddYDmbZq4BQ56w2veMZ93YFyCCSKIeFzL9EWpN5vovcT5gcTkNZisSEwc4yRo1SxuYFL2UP8tAz1UqR4vcqehV2jiA1RAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FzN2nUlV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b885e8c6727so542133266b.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 13:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770673177; x=1771277977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06aZZ3LuZ+7cHgv/dVPUPB7t0TkKgbXYUSz+5ps7j2w=;
        b=FzN2nUlV4r7864pZ1xr3ZZyqWD8x/PHqxhef0rIsjgp1iUljaWtoXJeNIY4c0gVMUU
         LrQ8ti1A0zqNfD7OB7/YLJyPmCeW2vby48D8k8W75HyAjEBWGdBmyxwm9bW7+lI7fLPu
         leDCXPzZTZz34DQxI8noVirNUqg6yPXlzos+/XdyKBPp3+Uuh1TZoP5XnQGPi/T1r3BJ
         dSX139BmUyGzDMFt+Jk8YmPm3xlGSkYsOx4y+cFlcZQrkPR77uRzzS6LrdlPqxTNK3S+
         D+EuYAcNmpjZ2RsnUeuFnicOq3UJA9e6BUomVvx4VtNAwKHdObEaiEKneQGZxFkac/YE
         qjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770673177; x=1771277977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06aZZ3LuZ+7cHgv/dVPUPB7t0TkKgbXYUSz+5ps7j2w=;
        b=R2DFgii1hEMPFEeVuVJPRTW4hre7tA07sLy9JGIycCa9nsauS/4LFQ9BZ4NF3cQVYK
         JlmSOLkcCvufX1XWe/u3xMDLDEd84y+LTGP8xAYCClJgBXWJsxQQBogT29Qy21gmgq4l
         V3bRYwzBeQB2PzqCLQA1SA6ZFCT24O5Lx3LZgxhKjmGCJjPXAKVUkkiSeHAaFONRdU/g
         lcEVVePqQVy3oY5508P36EFFyWwtoiEruyhSlh/6es1WZznaUvdj/EYjAmpFd7eg0VTw
         zjWAZcySf072tZ6iKAloSh3HGWYS+Iiu1I6Jyf9LgQgICDGWCq8emUFmoC20MWvAsKx3
         emfA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Jy8C3O3+X+AvgcTlDYs6p0GXM7u5DVllySnIWfw3rz8PmR8O7CXvpLnpK7uXRbQwiM4obT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+wMcNuVmr7UO0voIGqtOiMrUcNl7WeRsCqCN5YXoZCfsTVbW
	UbxgY0SEtRBZsKFO4h+15ZebAu/14Rh0+rBausk/V82qNG6cPXip8L0=
X-Gm-Gg: AZuq6aL7DvKs9UT7/tOhQ9DH5wQGqef7hxZ8EYu95ISJSYnq8/rQclht1bvUlW10o5c
	2QE32+J4YmSjZS7LAPV84/X/b0/F8O4FZ4ukLFBhjcoEh8u22oKud68p9epPYhBZTddaL3NPqES
	59MwKwipLNWfznAoiFRwk3Q/yFpnkALosw+jvht194w8PVt+N/MvBV1FnBpVRojXyzuSwyoFfu2
	1YfmowjBC68Rf6IXIJKvrE7xSW8ZnwJNbZmUEKxsJ57xF6a28PmSJW1AGWwqrGuTwPBFSbh0hgX
	BKqI+IUTWoEn/wSGIJ9uElMLLDJbGeNZemzedYtym1uxVbYXTC0K+4+dvXqQd47Dc4dEVG8CDUR
	Q8dBCZHiAhnIuBdWksUyYNqG0j8yGlKn+L/cqCVOBbiBt/sWl3mL3W94nF9Z+U1dE4whVeaUnZk
	IuVWNxB+XQ2lavRE/uIL/mtarHdvLZW9yxXllhiFgq38G/dlA9yL/p1/kbvQE6qEA=
X-Received: by 2002:a17:907:9281:b0:b79:ea1b:f13d with SMTP id a640c23a62f3a-b8f510d4cf6mr12724766b.2.1770673176727;
        Mon, 09 Feb 2026 13:39:36 -0800 (PST)
Received: from [192.168.1.3] (p5b2b41e3.dip0.t-ipconnect.de. [91.43.65.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7e6577sm428005166b.30.2026.02.09.13.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 13:39:36 -0800 (PST)
Message-ID: <26d78bf6-870e-45df-9154-ee24a30d6653@googlemail.com>
Date: Mon, 9 Feb 2026 22:39:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/86] 6.6.124-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260209142304.770150175@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215569-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 336A2114DE6
X-Rspamd-Action: no action

Am 09.02.2026 um 15:23 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.124 release.
> There are 86 patches in this series, all will be posted as a response
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

