Return-Path: <stable+bounces-235378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIEqBhSO12mtPggAu9opvQ
	(envelope-from <stable+bounces-235378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:31:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1683C9AE9
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8730B3009F0F
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4F63B95FF;
	Thu,  9 Apr 2026 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7OvAGze"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54043C141F
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734288; cv=pass; b=Z50oV5liHpql25QBDdPZRpG5kUFiYIH01/wmWuZpoDc4qhFxQNaA79plUMwK8Sy80eaKdZ/gdbuK4olM4lsAQWvTMNchO4gQqLTjyJCEu5NOLuYgXIXiP4UUgz+pAxkb6tZqo6MZBgca1TEW1QH3O5WX/qDUCI3zZwco23ZgHYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734288; c=relaxed/simple;
	bh=wV74ewI1AhRdJklJxevMEZCQNqPAxKMh+kZTlh12Gm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syj54whulSF+T/9jBtgtzCdN+lh72fjo+OUhDdCrtE984bahigkE8ha6g5z18ns2XOToTuIr5f8Dj6J9DBi/mZQxCdJWYptXRI5s9K7DZ0Bcy26bTd/KSCmneyl3kVWeCRUUyNCjoIu8IDk38nC6J3jxJBCjjOwcFqbOpCRaVYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7OvAGze; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso665306eec.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 04:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775734284; cv=none;
        d=google.com; s=arc-20240605;
        b=V/BFYyObSCqrHGfUJy66SqCnup6MGu1MU8B8fALucctLa1L59Bu2xSJo8TeRS8Y5iL
         BFBl4ISoorcm+SwgQWFK5U45l6kPFpHBhEP0dLOkTx+TQs4dPuOdRF/xeLZgZ7O1rN+4
         LUwswI8cCcNzlvDnVLUu/Jz6UoNMZSyJ2RbkvZaSOepuT4uwq27zu+W0tyEdhwE9mMbe
         fd+1Ri27RQWG9/A3dbp1e1NjaHbBr2HaX1EbMS3rA+m5UrnaIC1TFHXvMw1rotbIO3TS
         mZ3gQuSicUU/amBTxUs1ItsB15bKUPCTZaOm72ndIXcjzcMx7fmibAYwhlf934OgXIC3
         OZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wV74ewI1AhRdJklJxevMEZCQNqPAxKMh+kZTlh12Gm8=;
        fh=FaF36JYwqPzVi1PNzXixBawYXsnAHfQ/N1lULyMydqw=;
        b=KIvAO1B9U+cgBeMINDwjxtkNxsM8gMQTRbRgarKGrNLjASZVCUKlypt2JI3BAsEGqM
         2w9irkhCtnuM3kIW6U5rr7O+2u+pFHRE4nJ9C0Yf3TKFVW0Xxko7/ycXkae1Mm1OZtp4
         py8O26jXEm8sZeI1twGRkkLzWYMQkW/QCz9x3zTQ+EBjGOcm20xRqYuz0CAFexGBK2oG
         fsfBZmJ42Jk/xNkg/NkgyIBJ8giGgn5gkmVTaB4haHOankF1lybW9sqoCN8PhtvaQ2zW
         eVyxpRbM7LciAtJbNKEmJKBOcVkWpkM3LOBSYuJiG+CNDdXkEV4GjCRyPFZHU1AGQ3Lx
         Cu1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775734284; x=1776339084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wV74ewI1AhRdJklJxevMEZCQNqPAxKMh+kZTlh12Gm8=;
        b=A7OvAGze0SEWLpZpxTCGIYXmWlV7blVFMYVngeaKWFAFLjMwFNiC9L/xJtLiyrTzOP
         Egt+PHVxD3VWi7CYco4R57im3OV6yeQkiUmTmSs6o67j0eoDXEAQ9W6U7A68NMWc67bK
         3tZ3OHnP/S2iYen//zhFVAUaf44T9FKKnaCRVdqlWSbi7aJxLeMuOGU7G3Q41xhlkzUs
         kZLp22G/XG9gKlaCp5X9WmTIsYwdwc2ci0l8WUvvAggqaC0RpzPSWuBZ+4Zvcth5nyJy
         4hc9tJJFJokMSb5p9MesT/d4qmltzEozgkbMDZgm0FDBSGYAhKDZKCO5B7060bdHR73X
         5nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734284; x=1776339084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV74ewI1AhRdJklJxevMEZCQNqPAxKMh+kZTlh12Gm8=;
        b=ciqu/NNvUNBLVnhaD3T+mQUWp2DBqpck2icR/Z5+QRoZtPMHp+XDOPSU0AcYP50F44
         hp/75eHz0bVxMV3teG1427yA5RBaqEJcXJs6h54S0vveIvJjOzXJ+aMi3nWKLkr8XQki
         5mUz+2RGQCmCL5yRiMqRMZeAgNQ7kP1N5/soneYr7As8zapYy9vOQzQrSkdkDufEcxUD
         METsmgM1zuNVfKx6RE/Qwua+7jba2Cl4azAU/5VbavUofThiqVyjDU8dt1VAT9OxkXAO
         ngLIQF8oRM3/xPOPrVdpEjGwIOuW2RD4KTWZnlz0zLFmmu4pLevkMPAzxnMNrWIkIOb+
         V+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnmJe5VkWj2aQGjuFjH1RtgV4+gFzWnTM6RwpbmDlPKYYBpo/mujUYrLMiK7ScOX3KfvtmhZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWeCjaGEQQd0K5nKTYF1wQQm0ntz3NbkrDmAVfUcoeeGkhcPS
	ESHun/QGhYBroOp4/vTB9NccpG+H9yDwgcZdeulLLmkPodebCcp0NifHJKd74sTaJscXqnbEYQn
	2ztcTIbx1v8O9OJm2/2jLfxDkk556mO0=
X-Gm-Gg: AeBDiesBqTYUfx6n/ZD4h0e9jNN0W+ksDw+w6fQ/uSY+z44T8yugMTGWB8gdo/1HfXa
	7SdJ4lrK+yl26zbcmXlzcVpqbsytFQlkIg54i1XiNAcJUzx5djt2O02LB8tLva25792ZwJgo9de
	Jfo+Mx+YYEYp1UB3M2EfWHtQSNjmHS/P6xr3qVSmXtNQu2NTLzbvF0SpWjo2/+QS/JEDmQrn96S
	e8ncY/2qaQjE3EyiwLoDRwhNMtTTXzdHluQ028vGY/S0v5msb23hipb/+7q4rXgMxJc7TwZw/6W
	xylniPaYEyiSdH7xQnvaTAa2fHPjxqbt92dY92baDDz0H6CEj3yXC7iYwTLEGx8Ga8s955uZXvN
	5zlrrFifbkqd8ccvH0lEolYVkyiGFrApP9YrkOY7Jr3/H2eUYaCoD2NBy3VDaRaqCX4q/0iy8/L
	8KVcqis5DjhBUCoPUgvgQ=
X-Received: by 2002:a05:7300:c01b:10b0:2d4:94cc:eebb with SMTP id
 5a478bee46e88-2d494ccf578mr627616eec.13.1775734283480; Thu, 09 Apr 2026
 04:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409091742.514769762@linuxfoundation.org> <730e7298-6f6d-4247-bc92-e0cd13cf725c@gmx.de>
In-Reply-To: <730e7298-6f6d-4247-bc92-e0cd13cf725c@gmx.de>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 9 Apr 2026 13:31:10 +0200
X-Gm-Features: AQROBzDXiQ8uJ66Y2fn0dPowu8wZs_w69umFSn694qikBRlmA5wCFnGzCFIwabo
Message-ID: <CADo9pHgh6_sFzjS-fAYfhzWzf3BM7ujmAGQFpbNU7LJQ5+VZWg@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc2 review
To: Ronald Warsow <rwarsow@gmx.de>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235378-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email,archlinux.org:url,archboot.com:url,gigabyte.com:url]
X-Rspamd-Queue-Id: 8D1683C9AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den tors 9 apr. 2026 kl 12:55 skrev Ronald Warsow <rwarsow@gmx.de>:
>
> Hi
>
> no regressions here on x86_64 (Intel 11th Gen. CPU)
>
> Thanks
>
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
>

