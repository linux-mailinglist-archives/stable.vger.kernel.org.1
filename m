Return-Path: <stable+bounces-253642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOmkJ1yAD2pdMwYAu9opvQ
	(envelope-from <stable+bounces-253642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 23:59:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C605AC410
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 23:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64E67302335A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD85E35AC16;
	Thu, 21 May 2026 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eUjIKRC6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FE351C2E
	for <stable@vger.kernel.org>; Thu, 21 May 2026 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400625; cv=none; b=P+XwTSZrbVgDnK7H+AwcxWP4V+QG2E47lAMN1zRB4BjRvF+I5rSTBvKHVJbh215qiFmQQt9yuwxRboSol751sXO8mJETPx65C9Nv1RfY1424G9AAmFUc1PPe7TbALm4f3PkZlFih9Y6AZyIOAXNcYFA85XTeNbX+r3+g9bgfogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400625; c=relaxed/simple;
	bh=r2BUZgk2Np+Scsj4X8RP/J60+Fp7770Dl1HSTOiDzHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfdEO5RijYeWnHIserx2QDiuhtzNlsi7/3OFXhTBp7gBjck/uw7RrcKh8kETJ/Pu17KYXh1CGlGFTFALAqZ3YwDpxfZvBvp74IYdZbnWtCL6EvKswocbIRwPUmHLrx5qpcT+WKmf/DEO8KU2goxNismCrlmKfIetBGRPSaWV74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eUjIKRC6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so7221645e9.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 14:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779400622; x=1780005422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLSU/8udiAk6jgR2mMglLiCQL8WPD5iNK8szBRkUXEo=;
        b=eUjIKRC6QLnfjnJqlolhuKrn3/rB7TdFIWIEokb08kE4lA9MA8qAWZPauLKXBCD+ps
         wQSMby2dPlGoRUhPw3x27nO+wX8rBZvlgoPnz42UbyRBSNNQn+yTE3EN5H2oNDKDwZ2Z
         MivuJUdosUPv0W0FaaxM1HDpDh5hlIgtugt/btmIIcFNg4dU7ncw8tvTGmIAwOlRxCEh
         pkInUH4WGFTqDi+WmsMhnQo/FRX0BfELIZ5JjMtGU4nLiYM4P/aL3lhygphwi3bPfSJ4
         p0x47L2xDGREmMrVkw+EMPa7dpkaLkkckLqnVLTomteFosgr19HPF3v9SWM91NLq8Myk
         cMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779400622; x=1780005422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLSU/8udiAk6jgR2mMglLiCQL8WPD5iNK8szBRkUXEo=;
        b=A45DO3vcc+uoS4VBARNaVhakvgNSrmi0zO8Cy7nwlCGVq3amh993WxrVAq33ewpXRt
         eXojlQJ5w4yl/mDmvFheF7nvzT1NHO5l3gw0bwrNKTBmG+KXDLFCBW/WPtSLk8FzRYUc
         WQGCBqQrAkmFHB3L9Knj/034ITT/fl5wIOfzJ6t5m0m5C9E4YocaKj/EWdi20ZnwvoMu
         ciZ6zTQgf3gKKWQYTOtrpIR5dNlRqjSopMz4PdJoh5o9XDHcQXhvv+BdND8CY1G3a4Cq
         DDxd5dZJ6yvZWXhpDHpt9oEJHS84uEHhJJFIFTR5sCYciwM+h32bYZp3W+eLxDbIea9W
         6Gxw==
X-Forwarded-Encrypted: i=1; AFNElJ8WICsxnzkndM26zwpLP2z+piC7FrwWuilnkx1cM3+7egSR49ABiq8yGFU59WATF4LTD8AgI4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1tzTfJtmoy7FDOjX95m9XwGL1DyF4k+8C0M1d5TCbZAosHV6
	FObptK4U+8Ir1vm8o4tB4J7X/QrG4IncEas70VEQ6MRmZ4zone485sw=
X-Gm-Gg: Acq92OGQR02toDQv16uTul4Hn1CqGHabOMgBjOwnyYmWhmY+p/fglby5oMN4BMAS9ml
	nN+kpfb43uaVNhTCl5F+rAh8QoIqQl/+IQ1CtNOlQ04KbtKM17r9r41riYk5ofDjsMd3DaRaT1L
	NavrJBc+syJbSQV5A/JfIJ7SKWWHuQe5D49mpmw6E/XfLdE5fNnF+aSgyBaAG8s7Fl2KUoJKOeg
	HQPRXUWpFoRpIyHVBQzJn7Z713DeJAvM0Xd9gWZIQoKwCSucc5u5sYQjk2HmueMllROhCwLA+D7
	njAcPRyBJPci5MzACAUjGhmYQMLqe/HQhdcixOO3mNAuzUL/LuJD2r4pqUH/y1wXr+Lh279zpKr
	JopyEdT+yRH1FFwh3AbUmU0sbE7q+fHdkFbHeTfOnkUuTy0jNByftXOfcn5xZk2S7CNkP+6pEcj
	m+6ScvT6h7lOwGd/PtKzF/HWKlZbVivqjzr8tc0B7t1X015985TaeRw0Id+H0VvChHIUs4B6pfN
	EI=
X-Received: by 2002:a05:600d:6446:20b0:48f:c649:e6fa with SMTP id 5b1f17b1804b1-49035f6841amr49593295e9.15.1779400622409;
        Thu, 21 May 2026 14:57:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb4ac3174sm123306f8f.17.2026.05.21.14.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 14:57:01 -0700 (PDT)
Message-ID: <e6e128a4-5dd9-43cc-ab87-b7132ef0a0a8@googlemail.com>
Date: Thu, 21 May 2026 23:57:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260520162058.573354582@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-253642-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 07C605AC410
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 20.05.2026 um 18:17 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.141 release.
> There are 508 patches in this series, all will be posted as a response
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

