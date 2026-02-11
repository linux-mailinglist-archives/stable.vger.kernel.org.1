Return-Path: <stable+bounces-215781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO1EDaJdjGmWlwAAu9opvQ
	(envelope-from <stable+bounces-215781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:44:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D71E1238CE
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5F273009980
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F11369980;
	Wed, 11 Feb 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="LaSez/N1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7183382CF
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806684; cv=pass; b=aBvzDIDrQB1AodvzEw3VdZsPlPkfYx6q6faOX0qDZX7eAXjdOYHL6SiK9lY5HiVYBfVUCALK6IlkShLMwkmfRYZP7yx0IFKZeOf5IRTAWZAjPlyZKO+00Ap9ALys8TDeJpP/PjtVt8hYDQ3FHxMvYIl2y3Jvh45NpMsFlCeHNBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806684; c=relaxed/simple;
	bh=mtlu9MpQ1hhLBZzWmpb7kK1vRZJt2u+rMplAD5OWtRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o96csybek20SYAIeOX1F15BLmhLMwj4ChnheRNzh8Pp+/SvZXaccqS7S/BieIBW0+9e9ri5SbjQLEdKUsL54CDU4wSKEb7VqPWLcYlXd3+6AuTUflUPxg28wtVG0IGUuD6b1GioTl/PZ3td3iSU6oYRHowot/3JDDCAgTuTm2OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=LaSez/N1; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b884d5c787bso835342366b.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 02:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806682; cv=none;
        d=google.com; s=arc-20240605;
        b=imXCxYbKAlRcvDLF8z6dMDLK8lgeEtD16bt25YebrAhCDXoHzgBDt6+V+NiYwTGoWR
         fpOiLm/k3VJtcx4UsG3r7R08/qQhfhX4kXnS0tp0SU0DgL5ZDKdofMvxt6P7wRI+akfz
         9eTvnwrJOV5ZJm0Ea47F31oySyNxTqkqMRDssMr5UkdT0P5KDNLYJgHJfKI2BmXNBdQN
         v2IcJiUirW+WckwuhAlnLI3Z3yDLnjSE+16W111Y9I8D7i6WIhRjjg2JNBWj5Sq8RXWq
         fzrgDemakQMDcD7E0LpAbwiwy/GOLM50mFpI9caQccNlkC2tELsEUdRYHOy1n5vjCI43
         lfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mtlu9MpQ1hhLBZzWmpb7kK1vRZJt2u+rMplAD5OWtRU=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=JQLAFsgXwbR2woO2bVsuIbjzleiVgAbglWnhmwW1pWSZ4rPSgnO9GK2asKIxgqkaR2
         qZeShHEXy5LrRsWMO4Y6miKBIV5FPwAi0GnuCJVf4e4fp6HgEsbwyTQ47X5U2Niv7AIf
         hxDjKwkwWSgIINtEA1gm3xq79AhGChV4iad+U8vndY0nyExHZ4a2kJFapLRXkuMqc3j7
         b7xGR1Zz/kKVAdWYwq/oG6ofUefaXs3EVaYrrx6DRGqXnWHVuiDmtTqBlq3OonIMJoVO
         I9eU3VYk7K9GLGgsjr44UeZFPreObJVE0CMYK/QZc8ZfabnwLrmGYsCf+CQo/cqWWP4m
         0PsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770806682; x=1771411482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mtlu9MpQ1hhLBZzWmpb7kK1vRZJt2u+rMplAD5OWtRU=;
        b=LaSez/N10Aw2V1ZVumHAHmXi/eqOCe74e8dw/n04Z+Bo9tuQdw71+MflEK1E9WT13/
         m3oqtFlE1vkCdW5HDizXvB+ZXyYbIgt7ecFNcdwflR+ZQ9soxlyodiznOKgS8BLNGs6R
         +NSGmkLn0myMm6eQTHKF7m3YBt4n2BsRmai6awBi8oMs3+oKDNw37uIMSb+AALajCOmK
         4yjuiX5t1THE+oesDLDUwMdhNuTUK7nnPE2bBrd/R2piZ2uu0ERGFTwWrJbsnr+zrGPw
         LFoFARP1Ni+u0i1xhw//fUA7uZ0mH5QFY1T5m6hUfOSvHsjGIrzUI21iUnTyBb4i1QbZ
         m5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770806682; x=1771411482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtlu9MpQ1hhLBZzWmpb7kK1vRZJt2u+rMplAD5OWtRU=;
        b=n4qa6dBaRclZL2MlqzPVAG57WMmUaM0R4RYHQP1p07AaCxpBRePJpyydQjqzgTvtXi
         1VDyRxnwOLvQgCf4hCpmYyhA/MnVBXVZgySUPDJ2DwPos4NiCpnTV1cjPf24IExKdg+A
         GwljTLRF0nqdkUOsvuwL/zi7azSNY00pz+611Xq6nwxKioU1P6pu1CDm16LDHjh1vfXN
         7KWCyKjFGJetmYYsiLbLfNDHEot+QZHVCS38nDLnGb0TBSU26Aka51m1CumKv1VwgMR6
         anhQl2BiRFRJXp4mqmHAod8PHA0yhbbYismKlyFnPcJZQmTlXzr7DU2rDqgYfCAkrJBW
         jtfg==
X-Gm-Message-State: AOJu0Yx6Tmzp00lOZK5uFBBep2Sj3QLQtVMJHMy8QWOkjRVBe+8J/Pti
	DMgL+ojqXd2b50N6G5PA7pf9hzD+wbyeqhYU/3Y188SNNRBCqvog3bDi30ONqZfM2VwLv1oGeDU
	ssZzThuK/HfkxWs3l1lNylSYgFFYCd1X7oNNTIFCEHQ==
X-Gm-Gg: AZuq6aJq1Da0X0Izzb+4YOUjEmRITX6SvMrbQRgCqNH46JMzCm/p4rOW05C+DogQk/n
	Y9+YdMo/JdWt0u9CsNb9KWMM9LwIAfdc3rj8ApOtIWgR6Qry3ueEV7pKU6jTm63/tCgH+ND3tH5
	PhC+qtvLNLmFJzbXoYR6F4HhGadEIt2KF+5RcB7AvyzORmSncoMdG8IEbn0i2Y5A9cJofxM1zAY
	jJkFmF8/qzbsGy2oIUT6k8wlxkt6yr2qEmmYwmYycsrbAlTq69oEneOi6KqBeEOffsTb9ar0D1h
	bYszkWyUbCF4hzhuvPL63t6RC01JXed/xmtIaxXIjch0aHuI2t7vb6X7x91PadrxAH5ZQw==
X-Received: by 2002:a17:907:a48:b0:b88:241e:693c with SMTP id
 a640c23a62f3a-b8f6ae081d7mr134624666b.31.1770806681803; Wed, 11 Feb 2026
 02:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142301.830618238@linuxfoundation.org>
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 11 Feb 2026 16:14:04 +0530
X-Gm-Features: AZwV_QiEZUEWPEdbX0Yo4rOTeqmaCXLXOT15bWK5DWP6YdgDfcDx_p2lsMTdb8w
Message-ID: <CAG=yYw=vQ1in+roO99RY2+KRM_0PV1sv787_cLSvLHry7uCXeA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/75] 5.15.200-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	TAGGED_FROM(0.00)[bounces-215781-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,rajagiritech.edu.in:email]
X-Rspamd-Queue-Id: 9D71E1238CE
X-Rspamd-Action: no action

 hello,

No typical dmesg regression.


Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology
.

