Return-Path: <stable+bounces-222398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGEvJAawo2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:18:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0191CE615
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AC65307D60A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B330595C;
	Sun,  1 Mar 2026 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g0GRIQno"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AD3019DC
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772333197; cv=none; b=crSvCzHNmUXqby0XXTuNhQNtC0M9d3AzDLKAi+/SKwse3YcXoO9e9cqyDozi8tTD7h3+MADLcDjZklvu5kQBBj+tqKfYtvCYC1xYl6kS92SnBCG7NT4d6z8QTt0/8ZcYt45jQtDsPFu6qwXMunpDiYOD3qmBdPak4aE01m6AZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772333197; c=relaxed/simple;
	bh=no5Kl79qBHlskgJixUUH8IL9x8RELPu06giLQfu/fsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlRSlj4RMpQBRKoD/zLIH5Qq+2TpJEaHdyBzRzUqvLEB0rgLAGgJUXk9yzJNHsv30pYsMkI+dCbSXhVVaoQxnuH62qthlKlzn9puCkL3fB0vsiC99hb5bfNBQLyoT9l9sBHQ0ikA9oHyy83n/g4PSjcaUKMoJi19nOQktB+2Qpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=g0GRIQno; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439af7d77f0so319712f8f.0
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 18:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772333194; x=1772937994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=990rgNafF4SkuRw2Mfccvvcy/96hM7lSZyKlDDeK7/4=;
        b=g0GRIQnoICRVhWc2apCrCjNeRfElx3Z/ACllRD4o0L+BcvNebD5cVUc9c3JsW3UoXw
         3J6cgpLD8+KsQihqZB4JLEFc+s/70ju2OvoYOi/ck6pf23q7Jdy9Ifz/+QIEJTodgewW
         em9SmkuuF/DC1ikxTpeFJmDC+HMv4Qujhyd0+K5Wss/Kb3gY3YVJehVlztvn4fJztkAN
         1wkegEzXJ8jsIVAHROYYVrFGxKYgTLDXdLKnljcLeHGZb6zFBLQU9iVhIDQoyXC1aTDP
         LFJjryBBa25MOpQt+RdOuoWwC0McPEch/58IBNCJFuQ/IH2tuciiPQoUtPssW+e6BY7R
         gIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772333194; x=1772937994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=990rgNafF4SkuRw2Mfccvvcy/96hM7lSZyKlDDeK7/4=;
        b=FoFWOWzrkpCen0oqjF1c/jhZy6ok7NDo6enlAwJMqKzUIOkItTadVlb4ngnKv5th0M
         VTJv93WhASfZ24winYaO+cI2Q88+ewIn/ADZE3zEb5Z/YdEuIieS5yOtZiLy2npS52uK
         h0MtxpWybJZ0iz8u3ynURtT5voVuZ7pjP/WKRIZ5XnNuPCqZ2YzIiJwdSFJnS6IRj/Iu
         oTK/Ql5x0iEMeYrpStykT7jTS/UQcvGOvtsCmeUlV+cPUz/yBE79HIjo98qN0ZlbnBE7
         J1IIIPV2yfa1YwnG43xSSOHy65Y71sTNtMSGEiw3VmtXo354PXyMbyiPGiYHf6mC4J4Y
         jfag==
X-Forwarded-Encrypted: i=1; AJvYcCVLi144j96e1Jmhas8i1R2uILwI2QjKPKcbvop4eMbePE4/AIfMLguNkSFDLWxXdjEjvra/eCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaamGUpXPkHBPJU4HQgkTEzwBjgUuTTlQgJjAYKNISFUP219f
	+yOPQTlJXkPim2HUM+hxmcx0twsxKDRAOvIK+H233eI6gJV3wIFYEfA=
X-Gm-Gg: ATEYQzwMr/RlY9gTQxV15n+wRf50N7xa5Kuaj1GUMkXY6Gy5VYYFXxMpIQF5tPiBtqP
	2QfTFSm544bErGe+K7aZjXC5hBgg4Q4bFdAlD4Q4xGGIFX9bbLwrj58nF3YiIdR8kugWQGRoY84
	zWV7Njsnr92Nhorca8QLwTdabEz9Cm/lxuFVzPRZpd+vCbcCajaYRhkfgTMbB8GT2coM0yljjR9
	1dgDYA7NarTuRm+bilNLLMplzmVUml4Vg/t38Cl9xuB7SyIgvzQpmLvomlpw4iWmVs7gxZzwA1h
	SryGEhy4iWzLHHDrcL90Aln4Ty9A5drL+HHXyQQkA/lrfrkwHDSxv09uL2ETPFfeaBZj8ecyDMP
	d+7BYd9jQhYMTMbKB+03+3OGEvJSAfim1mzUEF0Ct6IlqukH6bdoUXQ7vmezsezNr+Sc/8tpLn5
	6TOWo6bDGdUxNv1TkLlzX5FlTKowuyWcrBx/tZKkuHzilEKiieKx2HMi5W/fkG49dvZql49LEdj
	Biw
X-Received: by 2002:a05:6000:144d:b0:435:bcbe:d104 with SMTP id ffacd0b85a97d-4399de1f29fmr14234769f8f.34.1772333194152;
        Sat, 28 Feb 2026 18:46:34 -0800 (PST)
Received: from [192.168.1.3] (p5b2acadf.dip0.t-ipconnect.de. [91.42.202.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c7645b9sm16211510f8f.27.2026.02.28.18.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 18:46:33 -0800 (PST)
Message-ID: <fe1a069e-f10f-41a6-b864-c6abcab54445@googlemail.com>
Date: Sun, 1 Mar 2026 03:46:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228173244.1509663-1-sashal@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-222398-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: EF0191CE615
X-Rspamd-Action: no action

Am 28.02.2026 um 18:18 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 844 patches in this series, all will be posted as a response
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

