Return-Path: <stable+bounces-261931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mrtVCEzXJWo9MgIAu9opvQ
	(envelope-from <stable+bounces-261931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 22:40:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDF651852
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 22:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b=AaUB8ISA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261931-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261931-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89C593004274
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30832D0DE;
	Sun,  7 Jun 2026 20:40:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3231F99D
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 20:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780864840; cv=none; b=ejJVEu7RB3CxnmLVEVQvXmXYQo3cpl08afyW74mO8dqOZVB4ZrLS+TOL5JOuRBLaQ0tBCLmSG4hOuXp3OwiTDn361K7L4kC3p7UtBDmi7hoa6iYFmp25tyQmRjjbiZS/U+f4NzPjovhnAU8ilIhHXFJIXmr+xwyGygn58tHUaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780864840; c=relaxed/simple;
	bh=HgnHsq88qifEGEQ1MQ7Nxat32gA04kFpA+A6gHJ9QW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHcvYqcdlONcFCCT1X0NSijoab3r0GH6qemt2D0np25pAthVh5Xq8lLbdrWS0Kh6lx84d6X8aVoE9kOkUNbODdjPjnOXTUg5xBcFihtsxvnKrE7RHEtvDHse0SDsh817ypWfAU+x0c5EGtIzb9L1GeqhHcZlz8zrugf2LymZIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AaUB8ISA; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso27494305e9.3
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780864838; x=1781469638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+J8fOsUcoDtpPxz2eR0HSOnaetwdRdpVEzm7oNXLqR8=;
        b=AaUB8ISAOKpslFKONT7eSUZqB1+yucF9b0HtlqfW99w0rcRMGrNnce7AjYd4469Qed
         XeGMc7llsgNAPiEcb4CnaMnpy6+uADn50FTi6tI+NzBWOZhT/tPxo99Lq5DbMSIt9D1Z
         Ag1kpeHbCfuGVE/8HV2OeFAhG7geVRD6CLtR1kTv5E6sjTT/7C4QLFb9XM+jUooSpRkh
         prHAEFHSNw9iRvqntgZM61uCFjwttunESEjzg5+3m4bs5bg5JMf8TUop3ZDwRTAsNj/s
         pzS3MS1XajTLxmG+GqejlBqswxDdRNFqu5F1Qf7XKMZa9LYm/9dsosmvoAJ0Pm+deTGR
         PUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780864838; x=1781469638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J8fOsUcoDtpPxz2eR0HSOnaetwdRdpVEzm7oNXLqR8=;
        b=owZJiKcveDRAkKd+MoUnIgO0rhXsILLf0eob9iAUWuSHe8svVndJTeO2wbnM9Vx3YL
         q8B7oNgPglNon46lE43Qrheh1cKBtwGsSV8vRgDrn4W0sGz2APiyl+iojku6DXRKvOWK
         DAfBoYJsS9net9e9/8Ylji0HSPnJIRFyQtenU88384ZhfdOX2Jc+cDuIrgh9W17q/ZtQ
         5PPp7vIe47DJ2sZnQXukyTkKhBr6oeS0P2y0ZmZdrBPlBUZaz7MgoqtUP5EEJpvSI5rr
         t59dBBMX7tC3svSkiYP5JEy4UVxmboMPq4V2ahBRexB6dFeWdl8a7YqkpS26i2nxIHzX
         M4Sw==
X-Forwarded-Encrypted: i=1; AFNElJ/ree6RnHY+71Kxf8OrDHVWZusrIKfvML+owVDWc72tYPIPaL0lL/TA4euKGd63o8vxXYkOs1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhsRkxs7IlDJ2rHbN2QSNFl7o0g+wGRaFVf1FgW6I2GfVgYj0o
	d4kksw0GZGv2XExFR1m2ajNfQraxaKaVPXNiM5fDbPBx47nZk9knrhI=
X-Gm-Gg: Acq92OHHnECLatS7oMXBohNYTizd26I9e37h9PEdEikbJlBFBkw6jEW2hbiHFVnacoK
	eoBfQPuvtfDUViJ9xvW7VgS9bom6S45Kf8x80X542/K7urum5kyuG631lfV34YUhuwBs7bvTMfK
	JZHZwfZUuS6/IaIoFVopXYeojCrOb//xGOG8xpRJw/WLzmsW/wxHQZn0Vz89amZZsMxigTZQOwz
	kdmwow0hNLiuNXnaQLf4TJwWp2xJB7oI6l2VW/8OFKMe3TVi/ZsDxqBrVkaQWelC6tbsFa7LsyH
	M4Fzh1CeEJP5FCPHHeO5tKNIyo83qr/VOaNdTFdtqg+2ebVZSIXjUIrLvWGZ+VaWkb+9HKj+25s
	Hyp1taSw7QVunv7sBBqkVwWRopCRUOD8ptSmmGyeLxHmJw1NWnHo+AWwiY83hvhmgTWzSTcfKLs
	ufWBlrCgZoePi32dIm115ocJMFdLU5jBFykfjwBMymymBiMG2YIYDFNITgDGhBpQtFYeR6hL8Bv
	euXLtn1PUpusxjaPVFn7PQk
X-Received: by 2002:a05:600c:468c:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490c257c3c8mr223173665e9.12.1780864837985;
        Sun, 07 Jun 2026 13:40:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b48d7.dip0.t-ipconnect.de. [91.43.72.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c15cesm339829555e9.5.2026.06.07.13.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 13:40:37 -0700 (PDT)
Message-ID: <7f75dd58-2680-4d9b-855f-65792dd89082@googlemail.com>
Date: Sun, 7 Jun 2026 22:40:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/315] 6.18.35-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260607095727.528828913@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-261931-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82CDF651852

Am 07.06.2026 um 11:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.35 release.
> There are 315 patches in this series, all will be posted as a response
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

