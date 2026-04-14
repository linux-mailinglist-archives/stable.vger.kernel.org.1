Return-Path: <stable+bounces-237982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 95cWMxzP3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:34:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45E3FF0CD
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 303E43025417
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558A3BF69E;
	Tue, 14 Apr 2026 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DDY0XHn5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A23B8BA5
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209687; cv=none; b=kyK9sXzIRYnJzRoA3frQX14PSCMynSzwUae1kkch0zQweusjbnM6t3D2f6+mo70xW7PM579MBUSoNLR9eZ2rK+50+nn92rWuSo5FDTH3bimm+LucBkezLbYloXGWNrQOxQgFE5+CXRSdvtNGBlSnxYjx3NxDDY42kozHPDF2oH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209687; c=relaxed/simple;
	bh=yJp7aLhCR8Chv9hmeAJXbuIdN2vuZdLwlw+EP3zRKoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJM9fKspA9DeN0vaelFT1YOoubs//0MfLKUns5dSNhyLwTvvhx0yffznbQIqihgA/6eNuTK1FrVjJ9Phx94a+fy/A9l4f0OsQCcLodw6t4j24poXiD+FVGgq0Mf231WQ+Gnxvafv4jKdn3M3t6fVIbBeCIfpzNCBsGw15PoUlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DDY0XHn5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488afb0427eso74567815e9.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776209684; x=1776814484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfiA+tA6Qcia0ueG4XnnPpFxZvTCuq8kSK+6Z9YaNfk=;
        b=DDY0XHn5ttpTsb/1E2Qc2giXzrvyhL3xJ4OT9hc+8oFqKWqG0qdGylrKzfmod5Vmx9
         lhH8PNnJHhCGOTrdWOxXdKtlr+vWpMp7Ng9Xb+/A7Jl+UYq3S0bNhB5/Z/pI5mjS92QH
         fMt8Hi3hN/4++UXuNamIpgCD1Q7h878fgu2x6icAPj6+eNJpPn5clG8us4dFihNWLVTi
         iOCTRigGGUelkyUjYKmfB64Vtz4ym0yQWoCzYbD/JdFko1YsXfTK+352fEgNLpoq9fCZ
         PDne75v2GxKHdALEPNSA9kuhFrXM19rbJIBy3bnqaDFjvW4DLgIeGNZiM5r+qDizjXF/
         aMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776209684; x=1776814484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfiA+tA6Qcia0ueG4XnnPpFxZvTCuq8kSK+6Z9YaNfk=;
        b=CWR61J2rp/0DP98seiI4UdiVYPKxnuIbzSXFZMmrhCyETKRdqwU2lxsOQlPjljWe0k
         vKlvYX9CQr5H1Jm6yneVNmoIhodpvU0C8yKqVKlSfZ0/CWNISQzY/RX8YD0OhHg6FagF
         05adwAJ0CMiykp2rk4PicIusFBPSm2zylP6ijoc+pkjfDBmfpxwHmOgTovBjNez9F9Td
         oZI/uj2pcoolnshXXgmm1IShhboQQ36Cc+NinMWVNf4ocpvFFrWc6rhw1Mt1xX+g/bil
         N56y0Db5zkTylPrIvLOgXVMo8uEg1nbDh41oJHnUnvd3NWAOph20131tB4zWhuSgISp0
         LJ/w==
X-Forwarded-Encrypted: i=1; AFNElJ/XDvbT8oymlkg+p+3GU6eH2r1jkFWQlLaohEyKG3e8/BCLyZea8wjjnfa39u+hxahj53ISSfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBNr56Xl7RTAUzMUKrE+qOcNnAAxHoFhsYaas3tR7uEmEXR0j
	ORYdVCD6FsiZmcH6hWv0de4qwV/pZGs6wlsoFkFJbBch/m9azKk8/mA=
X-Gm-Gg: AeBDieuKvUvjLlFtorI7CiJRovzcdx6A+T2qABMx3PphP7oip4uRTTFSagt//BPiy8V
	GGTHOBhSsS9LCgb+xBCUZZajEw+LfdXkATzwXUm5qvuOHD8qsvRyHSC9lVKkwmpoBX8VbVcYQGc
	oEJD7vGd5svhOPG+61l7srquZhte0GjzObBDPalSlpiE1QNlO82/6ufP2Ro3m5I+NEC9TD2NTLL
	wI8OGeUt7nAiB3VqKarCPWmSAThvk8N2mIa9oeEBJxBJwldOKcC73h5Wi7DxdXqQDm1z2nzDvRm
	5dI65R/MaJ4qNuka6fwh/Kb2W4c7WN4lYZeEhPfLZ6Q9ZsU3mk8yPqN6rnVjahnwQFA0FeO8PbY
	Fk0hgOnB3z4FfCwfmrhcQ5D7jM+gsJ8WIxQm9FJzZFCdobuThZA4RbdnPqAAc1GlGwi0DQfZL/T
	i9acWscKVAm/jjSspJMKcHzwysAUzhKYo9PObTFw5Y/IjUGhyXrFLDmg+mmvD1bjWDL23n8sPVT
	UM=
X-Received: by 2002:a05:600c:a311:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488d68607fbmr198294105e9.20.1776209683835;
        Tue, 14 Apr 2026 16:34:43 -0700 (PDT)
Received: from [192.168.1.3] (p5b05757c.dip0.t-ipconnect.de. [91.5.117.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm145522895e9.5.2026.04.14.16.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 16:34:43 -0700 (PDT)
Message-ID: <0065c1f2-d670-44fe-b9dc-9770adae54c9@googlemail.com>
Date: Wed, 15 Apr 2026 01:34:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 00/86] 6.19.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155731.568515178@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237982-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url]
X-Rspamd-Queue-Id: 5D45E3FF0CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 13.04.2026 um 17:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.13 release.
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

