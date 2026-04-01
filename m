Return-Path: <stable+bounces-232693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBLjHzmszGnNVAYAu9opvQ
	(envelope-from <stable+bounces-232693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 07:25:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B7374E09
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 07:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7249C301DF74
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 05:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29337F744;
	Wed,  1 Apr 2026 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Pg41CzKL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB52337BA1
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021110; cv=none; b=H6j9wiFbCVgpnbjpI4p0S+2/JwjBq/AbntkisDY/9UQez7zlJgSH1SV572b5wUIfqqiqruNSNGRW28LJKSCnHJoMeG08DYKiTdEQkh31jNkkinP9nq1S4lKafa7PAwhjPprBUoRdSE/wVrmgbSuwN18rzRXcf06IKw8E9PA5r20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021110; c=relaxed/simple;
	bh=mPOkvhBm+3qBPW5ESLd17mxXryn+8LaX+fwIs4v0bTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z28rh+iQv+bUtnJ3QdNeQWRNa3ue7rgX/JBzuhZJQF80Tt+KDXv3T8dXIp1rJskNLpMnZRDBAMT7bZDVD9iTc0gs4K/tADnwc67NLSHqtW5cwkGOgp7o8R7xOnfrszLkYU4RlMftMBNHAYs/MFdr2DN1dyAApcyIXH2VsmtXjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Pg41CzKL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so3213222f8f.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 22:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775021108; x=1775625908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uq+oX1D4A8za2quMJgs8dN6OHnBRay6++qyZCC4PMCw=;
        b=Pg41CzKLzGq/c7cj2ErZptKy7OfGJy7MZ36tBX/dZhs31tBN8ph0lLmoZSZFE/kuDB
         AfclmcSctBkt1BFXoSmEREn9xUd219iIRXO1aKMqgIzZShGj0zcmwOzvoiOv/IUjtRNU
         bjUMWBUYtKScQzhkSYz6H6x7xgMP6ha2ggUNROyDbKt5osr51sdzvZK812ph7SdygF75
         /J0DMPe+37SC3MwMq1b/LhXmioB7x47h5hAwtQwNgkInQdZ8kW+Lnx1gr1Zd9imxro2f
         zjkEALB20DNqX8MwuVUO6rBigh4ivoFG3r0DrUQigDIGZoWemjCZBx2cimmot4ncAWfd
         Wnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021108; x=1775625908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq+oX1D4A8za2quMJgs8dN6OHnBRay6++qyZCC4PMCw=;
        b=WtF+uCOi+qjlT+ZphF6dYyrTegNDezXrz5k+JriUIvYTVJpnWwU97GEqeWwY5HeZTu
         KoR4SJMYs5SIl9A0FCB7Oh4qcoaXpHmBzyoS0zcKWjj7wY4/vNkag5aEFBI5MWwRmHTr
         Ax8zPvGWXPWAkt3eYoN5prTSt8WYgYcDPfXjbtgqKg1ngx4G7TD8Xz+Kv6skvGgFKN8s
         UqTlUxhHivBwkhQp38F1hIZiigkt/dOGZTAD1UuuMiocCJPakVMu27RX780violPFP9j
         0eg4njoqW96bDJmZ/LHNgI3uE+kzFnpbSIkL4Rz5NOgFlF6BM4oor9ty5N3XOVU0+3/J
         m2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmrShCkUgNLckWwVwkjy3uUOJ4gz6Ev8/ZmF9jn6Cj9d3D9eR9hD7jJLZveidsmSEerwtxoaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2mS+Dems2uAQcArDnEJye1+CTm5jb2iO5DetGiC0QO/MGBlR
	mP3haSX9nqc4Ec4DT04DRh7yhR0JryDOkeifqC1thpQS0t8D1BCmwog=
X-Gm-Gg: ATEYQzwR5rrzvy1KcHiei75v2wpgeH0Zzl3Lm2KIOQY57nmyMxPGbZK6QquqJgoTZb/
	Ngt4CdvphbSdh9ig8nXgMCcxJmOBK0W+yfGy9BFVjLQ8yyDl2ep3Cw9EIsbwhVfSm4M6DNNuBU2
	W9r2x69lblBEEmvu7iqMSZYKmrhF35XTR0GSuWVlAnISsepMLyu68N+z0TlqVOdlUvW3oiN8PQy
	2xOp+BBzVmrOQNqwDKT8RfAZEwB3tBohkPI2qmXsuccMj4ncgeIauyNM1gOJRopHydQRN4lYAC4
	2fR1Q3cNpxvfw9h8YfxerAPNVuf+cjSXQMfV6gQjn9XXx0xClDMPOzjDFjI0SEudJ5DDg6hKsFC
	NV/+Dz6eHVF58qzSFml41gA+24Pmunz02494h1BtgFOaRhqAhJv0LfTN4XwPoDg6fl+gaKD76Vb
	ytiP8BYvK6FCEppIIyn9fi61fGa3CbsMUg/YltBGzeFtrStzG38qF4z46DwHjRUGfP9kNg8BTFW
	g==
X-Received: by 2002:a05:6000:2307:b0:439:c299:4d8f with SMTP id ffacd0b85a97d-43d150ab9f6mr3833908f8f.17.1775021107783;
        Tue, 31 Mar 2026 22:25:07 -0700 (PDT)
Received: from [192.168.1.3] (p5b057048.dip0.t-ipconnect.de. [91.5.112.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf1db08e6sm46557659f8f.0.2026.03.31.22.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 22:25:07 -0700 (PDT)
Message-ID: <fc84377e-7cde-4260-8655-20009be4cb82@googlemail.com>
Date: Wed, 1 Apr 2026 07:25:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/309] 6.18.21-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260331161753.468533260@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-232693-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 141B7374E09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 31.03.2026 um 18:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.21 release.
> There are 309 patches in this series, all will be posted as a response
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

