Return-Path: <stable+bounces-237930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMUIIct03mkqEgAAu9opvQ
	(envelope-from <stable+bounces-237930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:09:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C603FCDA8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1CE3013D45
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2652EC0B0;
	Tue, 14 Apr 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PbvobxTR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5732DA75C
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186518; cv=none; b=niZncXDWOpJDKtcuUd8hr3DRimwJQ1gCq2U4qjN7QFbNgtjKuMPhgteNzE5dMXblFwpa7wYVXsOfeuxi6m86Y9IOD38xQ95ZA2Unse1zvNV3utMMFmLt9FCdZ12I0EZ8hJFJAVCzGFJu5QPMSZn/5X6qiJHXkRYJwjVrxY09/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186518; c=relaxed/simple;
	bh=OP/OVI7CpjABgfPZIm/5UIMSYTQVF56moQLOB3pRF+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehs3AY3BYiTjWt+eVjhncs2DAGAwtBkBjAccan92OpV8RTq86wRdAZ8soISMjJ/7hiuY848UDLTOxnllrjYIi/nezf0xKHqeX/VQSQhk4Pc+7wsbN8MRR3l5hHYFpZzaB0SitpXivTD06kyulZbQdkG1iBCUVUSIxXxnvOoVBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PbvobxTR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a041eae5so43423885e9.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776186515; x=1776791315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClnSBgyPlKTv0h1k+yhtne+Q9CmigaF9v1JIRJbgCE0=;
        b=PbvobxTREdzBSSTXC0P5kbRp7Qi3TOwkbFdM0xrmnJM6KKvZDmsZoJT0SKOdidYyYH
         5MY0ms+Q+VBkCcqpi9Tbjh58Sm3t8gRLVPxqDUWuBVfZKFvAp6RJVjVT8OSz49K9GDyd
         K/KhgndAEECxOjZS2pQKUy0uaKk7uKJEY2lEVI17zPKvcEZw2qyBNWZO6o1VWpt410w6
         ljW/NRmTm8rXVOKgpkmIQEJuP+Cbi1kr0ih000i/BEy8FO8uwyxtq3MkzgXQFD0J/f1D
         41mBTrPDQZz98gFMCqcQMGw3fetl8e/8ti3A0AsREzmW/jwgDOHFY5Z9OXDAkBQDlQD7
         iypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186515; x=1776791315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClnSBgyPlKTv0h1k+yhtne+Q9CmigaF9v1JIRJbgCE0=;
        b=dvTs2lfijw/+8yXRzxlWvOohxp3oVOSSPbx/R17n4O0A5KWB1sdAU3/AVF3rg5zuma
         80u6hjukK9/DoCCgdSuUWLKHjdQ5z7Csi/I6jR0STyCQnh5iJqDRgeBHrmCT0BFJ8J7Q
         YFupF7gtptdw4zFLy7tdrT73rnLnlNt9W+vi5xZO3W9PIHdJC0lgUvEwgY529qEzvlMn
         8XmfHZ7/RycegIjcyGKJJzI1terpX/cUz4alLxvS/+qshGQHyGfK2qp6XdyNhNffXD1w
         ZzFStSZamWV35j9Q+hN0jlnpo+QfHOWEsUCcDI6BDpzFRf4VQLCsTNELHBK3kd8XfCne
         1jhw==
X-Forwarded-Encrypted: i=1; AFNElJ8lSUFreTIlDzyyuJoBxrT9xHaPwHCrylcQp7jO8pSuMe89+Nbr36VUdrEVv0KOBU/vOJr2d4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQG5w1WJTjVY7D4L9f4DVRwlprT5MfHf+6HXO6zxWR27JlTVpN
	jNG8aKTLHQ8HfrDpRISe/8AFUr2BF1pooJcvc3zJ/7l7PsXQQiAiof8=
X-Gm-Gg: AeBDiesgYm26WkaZIyxtD0bmXd7e4l34cykq7D7AMdg8ZaoE1BNSFQafoeRbsB+dzQV
	nY5eKt+1UPqwoD2HwD+TRGEP+x4xf0h1yxQTDuUo/5R3rCKYVF6mOwFQY71sNoLUroksSHcqLCs
	xkZIB1UH/TiSLKAZ4Mz6lfOlMTMgBJ4BAxPBYAwKkKiphjrZJqH83sHTeE3n8IrBwbZ2R/9rxHb
	VV3U5n08lyzqwm20VLE/EG9UZh2N4lZ4MHJ/m8BWP8Yz7p5GQ5Ni2DKuHKYHKH2LneGSEKlWpvH
	93N9wM1ptApoBUPm53dJHHDUTHHYqCXYSNUJK/IScbwijfw4GW2zxFvAdNQLFZK3XqyveuKY82H
	KE0yFWaXx0EdEYA7lAIIz4u1THb9SHQlbEG8wpV1oYKYCRJUCfjw6pg5uuOtPKjhEaRUNOOT/kO
	P3W1RUxdXEigyTXDbv70bSoqAtpMIAhgpDGdS5aapw1HvDp2i6qwkxWuJYiDe6c1ogrCvcqLHAD
	08=
X-Received: by 2002:a5d:5d83:0:b0:43d:50c:6f18 with SMTP id ffacd0b85a97d-43d64270334mr26098011f8f.11.1776186515163;
        Tue, 14 Apr 2026 10:08:35 -0700 (PDT)
Received: from [192.168.1.3] (p5b05757c.dip0.t-ipconnect.de. [91.5.117.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm44756685f8f.30.2026.04.14.10.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:08:34 -0700 (PDT)
Message-ID: <93076064-0987-4b5a-b151-f77880f43db1@googlemail.com>
Date: Tue, 14 Apr 2026 19:08:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155728.181580293@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237930-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Queue-Id: D1C603FCDA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 13.04.2026 um 17:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
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

