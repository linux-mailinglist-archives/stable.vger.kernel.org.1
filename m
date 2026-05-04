Return-Path: <stable+bounces-243891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHiHCA7d+Gk22gIAu9opvQ
	(envelope-from <stable+bounces-243891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:53:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9854C2358
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F29330055C4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224D13E3DBE;
	Mon,  4 May 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xl1No67z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C73E024B
	for <stable@vger.kernel.org>; Mon,  4 May 2026 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917191; cv=none; b=SbiwqKyq+sChsIUJ2gbey44CG3LfYcan8x2wnx2BFCXpERWIcEH9ylsedZyXmOyHVsMHCsqYarMGbVaNxdkHtmuw/IDQfkt2Dvu05x/NFJZM9IyDDhvxUGl9Y3mLtBFYfd9JKf6vmC2giGdXM3AeJvA+MllI4zfXPRi688m6JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917191; c=relaxed/simple;
	bh=A7zVJjk9p5b3yRu83h9R1sY5YYj6J5Nheuy0BQC5sws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMucoAuO4YOp/RyRWoHdpzYFYMSD3BPD4tbFlE+lvF2b+dpubDvpdAYBnLSTaWi6bIK5s7W14ZmLR7Lm1NdRNGrHj+3Bx8EdhdDLxSbh0gqXTyZRtTePkZm9G28m1KGG7hsY2+fWzeCdR1yD0p3/4OzN/C3RTPIhFHDFT3TarwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Xl1No67z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48909558b3aso46976325e9.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1777917189; x=1778521989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FL5be2Iglw/AASVY1DtldbmAqjumnN7JHWuDb6ACSFc=;
        b=Xl1No67z3AvFfwGijDlQhq8GoewoHEXrzYW+5Ygs6Xlm93k28lyM/G37rS3KeDDn8d
         GOYjMwI+ksBk0jwkPImmhGu3rrPX1t0Xpnw2tGicilvhgwdkqEBZHRrZQvXMQ+3l2hiK
         /EdAmWeyR405hUxgiw62e6KJpB/lwv/6MSfZEi6Eh1yjiMUFFh1hW/wfDu/uDijIiHAA
         tXN4DP3uxpWtQLsIZr62fwhQdPI7DJ0xPCztzyFws4ibdQ2ej66GSmpxUcwPrsh74OGL
         TeMN0I84ld1EaYddQBG3pN6FqePFL1ao2M/cwLGk35eHsfGT0Qekugzk8TC0rW0I2ViD
         cMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917189; x=1778521989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FL5be2Iglw/AASVY1DtldbmAqjumnN7JHWuDb6ACSFc=;
        b=KFmdY+cg1o0gWKyWlKAJqI14JLtoYLvmNaDFU5hEK5z8hwtnuIbI2wGRAIIMWU9uCC
         kQRWWGe7ceRoES8Ui5UMsJKMoKQTreTdMZefAMGTv2eVyF4ZmxWp3DTHh5TOWzz+I+H+
         B/D0B8zSsj4vVj6VzniXWQ6yD97EKKdu06yc50dbh8xpNyQ71XUMmKcT8OR8x1zFzuAF
         DMdPC8loBOJlgW3Q19g0ZbpzTfu7C1eHksEiCaxZ6R0WYrAWE310IvDHJsHfcd3gtnDJ
         A1UDmtA6/UFQ0KlPtIpW8edjG1hE7UH2rPCtu+yuUZ0eeeognJJ+F+pnTzZEdmULLcM2
         eKvw==
X-Forwarded-Encrypted: i=1; AFNElJ9/eH2/1LvG05XbW+7v1ZPyFqiCTpNFbT2UtJUI/uz4GIsza2z9qbNng+fzzxTNdbVGIvuR5Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BDMsYnCdLWxaVdGIwCeYyyLL4/FfiMfWDmxKFINb55XK1qHS
	tN8BuJYpx0g31Q8sbPDlXIuX9HM55ueivG7EeaEPKnnT8+NwuFCqass=
X-Gm-Gg: AeBDieu80Z53DoWd1Oo2uy7WJK+B7bsQGxjQ2ES8ly0qkWZdb/bVtHZy22XgbKgbAAD
	exzWuwWtEK13rJUbj/tSUNWrH0lgggGb6aThxyb4Drr+ZNou5+I7SEAFnttV5f2h9+/N2dy4+V+
	NnOahJktWAI24sbs+d3UWbaiaPl3uwDerbJwQneHcuNAsqHf1NTLdOeDoIXMW5HbL7yxm8HoIHZ
	EwyxCLvbBtwOqSYk6w3/c+/565CbimYXxz+KRmFYJXw7XJpkid1/t/vyKuvqQMVtEkiepXi9Bl1
	BnyjcFGTi6vTwpjmqMRnwwQMORuKwOa1yQ3Ft5Yc/WpDnzYCvbXyRN89UgxO+nBYuGwiVquoiTl
	EMrtrSBesKDX+pYfmlzBhUv7zpfSL/bp9CpDvi/VHqs8g5GpGR2Pl7Onc2PjZztb4XIPIGv98k9
	fevTkoi7BDw7X3t2+4qMYVJOZk04nlRz2sfhgaYYvAIvDDUbHLD8+ns6/NVzXrdqCiHk+VloML+
	19g+/W1ZozoBwfHTalX4pLx
X-Received: by 2002:a05:600c:8590:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48a986381b8mr130493075e9.9.1777917188670;
        Mon, 04 May 2026 10:53:08 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace33.dip0.t-ipconnect.de. [91.42.206.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d149e8a09sm425295e9.2.2026.05.04.10.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 10:53:08 -0700 (PDT)
Message-ID: <390906d7-225f-4d9c-b784-f4d7e52a1203@googlemail.com>
Date: Mon, 4 May 2026 19:53:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 000/307] 7.0.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260504135142.814938198@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A9854C2358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243891-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url]

Am 04.05.2026 um 15:48 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.4 release.
> There are 307 patches in this series, all will be posted as a response
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

