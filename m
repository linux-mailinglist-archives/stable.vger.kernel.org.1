Return-Path: <stable+bounces-219671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKnWJVUqn2kOZQQAu9opvQ
	(envelope-from <stable+bounces-219671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:59:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC7119B171
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2406B3024108
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED63D9023;
	Wed, 25 Feb 2026 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NHqe1u0W"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B83D9046
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038712; cv=none; b=N2FMj14bc7BIxpd8bZW/okY1QQW51RrVnnyh4jCay3pzHVGu1AsQkLIJ9Q4n8dl4SnNTyY2Jldtu08Ey/MF4neva13yZVaq5XnTQ5SjT0nKFl6BiQzjFYocKeV2r8uZRRzwzn1dK6t2q7aCfY5MVbxX0V2S0t7QMYpcxPMCywlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038712; c=relaxed/simple;
	bh=MPZj6d8tDA660ZXNc3dCctZm3BOXuAwPYlWP399YCOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mae8d1+0jIc9UTjSoCeJ03eCtPJ15PpKgs3vbeu8a7ZbYF7YMqvjEp/47xAp4ec1DLUumZlKWJWXW4/DsCZ36U7za6CYjF4tnyjQMv1fdBeJHWnoagHIKVTPQpjxgpNxzqM1Btk5hlB13sYZQP/kMs4ADbJ+b6fRHTs/GqlN6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NHqe1u0W; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-437711e9195so4721263f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772038709; x=1772643509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdNiUMU9QKcWtNtjAAfn1ZTauNiVB8odRXvslJDHQbk=;
        b=NHqe1u0WbwcTDz0a6UhdCjIEeJEs7dOl/foLL6gI5xgdbrfqyJLxaGkyVUI1NuCxzd
         zt0PE2wszvQiyUogMJf/uTa8J4clYnle9HbBZ0Kc1uRYiQgHWNtBUoZ4iMimoLm6Smxy
         MG6UsBSI4F65L1lw9NhMqmtyaL/uvR9qrZYgHBL+WP1plyYn0syZhPj6dRqxftQgwE3k
         gMdNXVGLkDus6md9aW2X/F2E3QXVWc5nTfO0+8b+X73v9fLQ0CjVGIWw2SOijcXYHyDa
         3EUWeOV08huap3SeLmUJT9DwSlSWMYpS0pSp00KFakB3IWrmnXzCtqm3i161z4xOsOa6
         py1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772038709; x=1772643509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdNiUMU9QKcWtNtjAAfn1ZTauNiVB8odRXvslJDHQbk=;
        b=G7TGAF9mvDJHw9iObwznvGa85TgDRr7SXp982+i40E0qLBM5VaxuY5p6Hz7SX/qLJh
         dXVlveHKgVY4lmsPJXkCCKYXl5/rHGXDG99eUbr4KcTtxe+CEIz5bfD2ez2fo3Pldy6X
         6c6QiZcpbhO/OpOGPqR0HLzRsKssviT9Qms5YM4WT/+CxtnUse04TQp5aMI3z1nxe2T3
         br1N4qWDZ0cRKM10le1cg3D6bSNOa0MZO2KNk9WyprLomqLM6Gq184dn6NfzqOEJgaf7
         JLWV+pUtofh3jx7YaEaOeyZuWSMP1nUzD3WmjQq1Cv/bt5UwXWz/lKk2hZX2dNV/nLdf
         18dg==
X-Forwarded-Encrypted: i=1; AJvYcCXKK4fCqj136IdH9cF3opFvzb/i34/cgAe5TG06VCZwlfe8ire2dGhEWDep7FKDURmrM3EaFfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2Yc0b8CnStsYRvmqcveEME7bgSux4/6HB0+KNr3kQqIMwuVT
	BAbE8vU1N64PYmp3JTUOX/1MrW9oEvLCnh9CgNoBaKXma7pJwvxSiBA=
X-Gm-Gg: ATEYQzzbOpPVietdYEBsPr7YA2OBGjuHU5MLqjB7t98Qoeac0iSE/uB5gs3BFgS85cl
	ImzkM0V/icTGfPKYTwSzaABKgNyUxklQYLUpC/3F9c/K1TyN5ev0rOH0e3QLN0NmfkXXqvv+W+O
	ZJUTJ/O+092VlYtCP9T2FFihklidFltKH6iJr4DzgCNKbgV6XWA5A5W5QoTfvuqeaewN47rOHNe
	YLWp1y5H7fx7Y/gd0nArH8QZJEU8xo/XbuMrpCFLZYp1MS3s0bxiDsMEn3uwes5TfwR116ie2hl
	gIAG/fYw22onlJzo7pJb6uyQKkltCa58pNJeguf3rwS11Wbs8Ib5apPim1H4zlqzoRes2ITfVbS
	ZzpFtAEHreKIQ+kK1I2b0uw7iRCVk70fpLjOK57/2qpzU6k1jUmWssSowFBk48MALEqqZxsIZx6
	r/v08Hlo6HxHRAVIfvg8FzT13grehf2ZXhnGaHACMSnF03d5pxDuOSc/Zea97TpwecFy30yEBp4
	K8=
X-Received: by 2002:a05:6000:2403:b0:431:752:671e with SMTP id ffacd0b85a97d-4396f173e6bmr25394941f8f.15.1772038708688;
        Wed, 25 Feb 2026 08:58:28 -0800 (PST)
Received: from [192.168.1.3] (p5b2b47ea.dip0.t-ipconnect.de. [91.43.71.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43995056115sm1197256f8f.14.2026.02.25.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 08:58:27 -0800 (PST)
Message-ID: <3f9b7040-f8f0-4179-a76e-98c78c01733a@googlemail.com>
Date: Wed, 25 Feb 2026 17:58:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260225151847.709818960@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260225151847.709818960@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219671-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailvelope.com:url,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: ADC7119B171
X-Rspamd-Action: no action

Am 25.02.2026 um 16:51 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.14 release.
> There are 641 patches in this series, all will be posted as a response
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

