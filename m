Return-Path: <stable+bounces-243882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GxkOrzP+Glr1AIAu9opvQ
	(envelope-from <stable+bounces-243882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:56:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 545104C1A7C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB6D63026AB2
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C13E3D87;
	Mon,  4 May 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Kiv9IDdQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2533E0233
	for <stable@vger.kernel.org>; Mon,  4 May 2026 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913591; cv=none; b=mA7z6SncLzivic6Zp6aitmgLTEmJ0xVNafOVClx98Lx0J2NJ3t+imiBPMcG1afEef3y+3mM4U18Y0NPuryCVBFWTQN3oquhxsG8gkYPpSfSXs8fuAx474lORqniu2RLZ79eeLnzYCL3MS0P2GAVYJDRt5IPo4pV9OlJS0s3+aPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913591; c=relaxed/simple;
	bh=VvoTMuBC6NabAMOjcL5+KrfCtlrzYsEb/kwkobz/TJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LITaDZZJ0tHQ6LdFEHBkddIBUpmlwjnyzfIWNb7S/Si9ikixYYxMGIgBbDQk6vl9arfSV/I0mgSfHIbDlQdAdEhJwSS3OcDNiy0Cx15pAKD8n7aP6hwh4tLw/p6ZK3uD9amhvOv+ud/iBQ6MrKCUAF+4dod34LCJ4S6NV/QA88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Kiv9IDdQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48896199cbaso38598705e9.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1777913588; x=1778518388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cq1UVChEUo34oLEdykFyKbSvPVU5W9ODBCkDev8EMiQ=;
        b=Kiv9IDdQcQVShbEjJsnCLh0HnlEst57ZpGlYa7p+p8L3ZHeFDVEN+qo05bi2gOfjhH
         6808GZx9rl8wbDU3Jn4uLTZUcB3BWiCd6tyDS/iKaaeTyNvAEeZMNm+9DaY5VSMV84W4
         iP+QE4pfdHQmwLknvhDPJTQ6bkiuf7MEPDwUWiNE0sFeYGyuOOQO3YRGdCg/jMccMkss
         Gu0YFMrgQZU3VwUxoGdRLmMLh+e36WT2B+sS+dhx078ITUiq7mSMRYXPe3V1IPfJEFsb
         nwj/uRPdvpJZc1Z2PG7KKBrbXcmUBeTARo9e9MUSRB0VSb4N07cEYcVNNSoJf0LvSgiY
         gxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777913588; x=1778518388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cq1UVChEUo34oLEdykFyKbSvPVU5W9ODBCkDev8EMiQ=;
        b=VeU32WjlxKbgLq/fKyk4Mm1AgDbVMn8nxYZLtBZh/cmS8GxIu02PXanhgECnxmLODa
         GgywIJPsgeYW8+uflMAAtBfYvSeRz0KiOxQJ6Fj/3hRGmdWjfsuapxiqBRTMPPDGUJCC
         wRkK7Cp4HI8AQu8Fh3PDZyKyeF1iw6GsTomIx0hpsEyvQa3l7Hu0k5vXlISXIdhYnHHn
         PK5K+/XEs/ZTLPUXMJz6Oxc2U3H5m2M4/OAriPCji0a6QI+Vc+sF3oRYSpU+dnbGOUOY
         cMHZSXwNqHJumhysfzuvNpSds748x8W/QnfGlzlb9jkAsDoXPPkza3363lLjecRWlygy
         z5kQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZMMemibgWao0fGK2Jsgxaf/8fbmo7E0Y7hfSQoHiZSagYvlFdCbKYh8wO67HUFTphPzLk4s8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0U7AkXQaTydxNk2npCy9L5t2T5hVqR7Tdn9GxjBMHADTPE/Bz
	joEiDBAWK399RP3aYeiLBmkZIyNESABn5auYoMlgPHoI+VfucCQrkYY=
X-Gm-Gg: AeBDietQDXA798OjucXW+UoOosDIvGAYaTHYKFkGRXr/e9rO1EidP6OHpXJ2VzPTCAD
	bwcK0R6qP+9GJ7YgUJR/v2W+y5gpWGviKQ8ZneoT4gZtn/cOEjat7ClpC3CifdSlQcShFZtICfd
	Cb48Pg5LCaFOi43nEQd/d3CyWRvuEQuARQK3yvUUxCGZGkGlvy/aEZ3VSmVRGtA9LD38uakbj4k
	4QMcF79MI+Kl5UkWIzuGa8FAJ5ej6fuEukliTRWsgy/couc+z33cvbezVNtBEtfTI7qZKYdcGVn
	T61BU4NgdVg1TIGJhSPhreLzu2WWwvROi27D1SIMLd6SPUt0jOEgcmewXFgXtHWK8h1nz5NWKsP
	tuU2NIBAt4e+JvMbFV8QtHWxrsAcp7B8naL6E3sMvwmgKS8gla8K9vG8VG3TfSiVwLkmB3s9AXx
	u5uaOdV8PazT+pVdPdvq52s+haLak6eAWsaE/BnvANVe8nnPdvUd5KBbCex/w+uriPUmRJApvOF
	tNPiAISZPrcYg==
X-Received: by 2002:a05:600c:5303:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48a9852c5c0mr190080195e9.5.1777913587969;
        Mon, 04 May 2026 09:53:07 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace33.dip0.t-ipconnect.de. [91.42.206.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm118466215e9.2.2026.05.04.09.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 09:53:07 -0700 (PDT)
Message-ID: <58125764-0397-4b11-939d-605a30e4055e@googlemail.com>
Date: Mon, 4 May 2026 18:53:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/275] 6.18.27-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260504135142.929052779@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 545104C1A7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243882-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url,mailvelope.com:url]

Am 04.05.2026 um 15:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.27 release.
> There are 275 patches in this series, all will be posted as a response
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

