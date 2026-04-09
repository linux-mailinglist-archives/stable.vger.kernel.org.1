Return-Path: <stable+bounces-235478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE6RL7Xu12kbUwgAu9opvQ
	(envelope-from <stable+bounces-235478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:23:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0043CEA6A
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9DDF300AB1A
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4319250C06;
	Thu,  9 Apr 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sGgw4EZv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B198204C3B
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759024; cv=none; b=BE5E3YSA+BySllYCSEKvJu0I3ki1cnqtyh84XEe4RI1X8cSdbNlArUu2d2tNjIOOGKiuH5tqhRqZWrq98Pwsbow4vV2uJwc1BQsghJMmu/IQNovLCHocqVOoLfdSWFS0geIe3SLmkqSpFoNB4I6Fjc9NpcdhSf00JA2KeF6+w6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759024; c=relaxed/simple;
	bh=oeq7s0lhK0zhzYr0w1Zc7cxEboofJvFkcR2pUaOGPIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4LCTgbnKsV3C5ec/5TIs3KjH2TLVaSDSEvAd8lJNaS7sQvjceyzf8ibMRaweAVxf4A5Kj2tTJljx4Zq0e6yaTGwLnpMgFQ3sWtWpHBbxZBnCTYI6+FKWmYWwu2ZlGiZshTDOcDwHk0WMmr66D+uQJB4m8Qent/q4FhdRAIZZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=sGgw4EZv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso1206452f8f.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775759022; x=1776363822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBLtaC6G4hdKof7b+8a+fEjdvMltx5E+JMG1/EbDAis=;
        b=sGgw4EZvehcs8uAKh3Mx8BU2mXjZkyogQeP8i5nZabvVlHsSRbd5L9QJ/4cBm/SD2f
         fZJxsPlEhNUbO2ihiTMHKKPS4Q5W2uZSIU2tr0dQO4SoZ/LGIHUIxP2BVQgS69qIjUC6
         UiLPcBAISHnvK85YZCUZc1gkepP2Gp/WpQ/l48Exmq6qoKZIDdRp+nzVI4xEt/mXHvJY
         XlDlaUdqnzifWY7+noWFWiPa+AS7QgsV82ZohajXqZtxxjHHz5KE82/618nn56w18iqe
         HGq5QiJhQleUeemOCfHONNAzD8dc3YqiROPG1865EvIjlyM9jFDAMrQLBSA9Yn+AvZhg
         J7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759022; x=1776363822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBLtaC6G4hdKof7b+8a+fEjdvMltx5E+JMG1/EbDAis=;
        b=jbeOE8a1yQSmI4UZHfYJRpPo33CpACRi78N3XtCuUDMXYkA5qAD4pdWgD83KZ3ixrq
         AzqFIez5uIBIK/OHXOy4xtkR8yVxUaKVnVy08TOepnqRFbQWvyGKigyZNmLExLwOupyY
         DHuPNl9gcnVURsNq+V7ahwQkUcEFvoGDSL/FghB2dfvvLUWFUCO2ksIfAhJGfX3zx8bM
         XX0YozR8KNyP6nO/aSegWhKnzfkmixcp9dWatWpSWQAw/1Wt/7wT4mVqx8mF/azVUX6p
         QUAJEfEPzhB3cBNi//5HcrJ5S3T7xdTTVZWDRhMoMVsboSgZrwgVeGHkW5ol0KYBhSaL
         W4cA==
X-Forwarded-Encrypted: i=1; AJvYcCXubdBW+oVIRMPwp3pTBqiuDbL4pGYxxKHR5Dv8I9uMtLDZ6s2Kzeb6Ti4SXhDriOJ7aJLgNxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznzhf9oTH1PoaO1HvnuPXPoO0nTPwUbPwwJXosuqcTXMCMXcLk
	5FvwGIPda7BZfpUScBJb+/a72Ciq4GN/rz6G5HCRwe3wrgwiOE81Z5Y=
X-Gm-Gg: AeBDieuWqx3tE7lXmWnozhyHF5kPlo45sG+joTt4TcW+QF/TG9XjWHTdmQXu+b8Ki1s
	JcUGfOhas1UoZQqe72cwvkqtci2UFg2o70ehF55vt8D/Kj41+487onbuI58SpqG/c5WUHEnkuUa
	6U7yThU9oBVbc0S8+cOOdzAnpyF9Pjn5222Fua2QZuKJtGrJ4Q7WUdIWTDlF2Gp4S7wM/zcKYhS
	axpoyKxwkjwjsprLR3TTIg9WezLqHUPEKdkhmRRTqNEx2JI88o3anQBa5qEUo3K2ppHiAuEVurl
	ekVYPv7wj4CspkqxuKoMGIsZ0zqxWBahpLR9y3iTHipllx+uxq3Qqadtg3J/64pu0WpiROciQsK
	yRJkkN3in4EFr4Inp0st9LaPqQwpYevAFM7j8FoCEOxS/OwHtRfOEmjgPVwiuscBB3lpn6ltGDx
	2YAnG/noXHq2jDDV8fBs49zNNRCVCnif/y0d67cXq4TyJOfpm5cfYy+tWKnnfIVJSYbG1MeppJQ
	08=
X-Received: by 2002:a5d:64c7:0:b0:43c:fbde:310f with SMTP id ffacd0b85a97d-43d642d35d2mr162108f8f.36.1775759021651;
        Thu, 09 Apr 2026 11:23:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b057c8b.dip0.t-ipconnect.de. [91.5.124.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec27fsm721122f8f.11.2026.04.09.11.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:23:41 -0700 (PDT)
Message-ID: <14ab480a-d974-48b1-bc1b-2f2b16dabc3d@googlemail.com>
Date: Thu, 9 Apr 2026 20:23:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260409091742.514769762@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260409091742.514769762@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235478-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 2F0043CEA6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 09.04.2026 um 11:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
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

