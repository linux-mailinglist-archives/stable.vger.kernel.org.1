Return-Path: <stable+bounces-237772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMnUIMEK3mnRmQkAu9opvQ
	(envelope-from <stable+bounces-237772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:37:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E778A3F8076
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900C030E4C6D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E73C342A;
	Tue, 14 Apr 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dOqiH3KE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9D3C13F9
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159051; cv=none; b=d5nBM+PKQ9PA1YMWYOv0z9j1BunPWkUv4GB4JFTTSz8AKkxhnfvoOI7oqczbIO7fTYcT6cbtMTlsMeCVMKPScDgd1NVitW2mlmDZo2WdeDzl5NSPoxtKbsMR//Lo0H4GLDSCqvGGAHdbj8vD00BwOZwt1o1SzUruA/oYANkkFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159051; c=relaxed/simple;
	bh=uqOESQ4voGFI6L6rlvosXujbAWM1bCcUHKcASu6iGgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAWJLGxKvtGX3DPYthNfKONIa9cfNHEaE1q1imxq/rPsAS7NGBouLN+gDOgU6zZ0u15sSYe6Xriz7R81moYmASp/AKKSMTj65Oc1iz0ojDTCKe8wx8C2+7q41H88UKf0ByoJ+fdCJKit3PK4pRt+LilqtyrJFCYBtBIU82LLLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dOqiH3KE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso83647455e9.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776159048; x=1776763848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2HeO3cXP7an/0r0tpwKnzN8RJZ4Ea05CvLrKgmWj0A=;
        b=dOqiH3KEX+gwYZ0GcGmRhChMugn6mNsLJVTmTqomH8Q8CLvmJGVAmKdfPMROD0rR0G
         t2svFNqtMtr/1UB4AZko+DSbikLSSoQzp7YMY7eapEfJOC6//dcIH1NnjzY2EbZmleaZ
         XddjsKkdx9QRy/A8RpYuRe4zWw7kfXhmEkDqSO5Gi8shDVWOyDom6pvI3vDKzJ38BUo0
         tmZC4gvh5KON93wcf8WYVGW6xT5KjP6A4H+EEMMfcUD25GyR5Q7I88e8WN14psnijj42
         5IZVBI4XMdHaEG6pt0zzKhA4cLZHh02H12biEPoIZY7mfCi2J/VkFqgY/XjvgQRTSbsB
         9ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159048; x=1776763848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2HeO3cXP7an/0r0tpwKnzN8RJZ4Ea05CvLrKgmWj0A=;
        b=nrjsKHe2eFcpWW7lYbV74wr4z0cTL+QqFtQ6heICrTgQpxBhcgfKmjlPMuFv0OOncm
         IYNfaMQFKw9teHUSrY9aCHRb2/71yp6llOquiP0N0EoGorZpVpRonFOcJifiwkdzbp51
         Ars0+ZebgRDnbfUzjXCuiZpBbZjTeV0WznnVXy0oFk+o+BybRBw0Xoqfe6VQRsMEgm1o
         K/n1o8SWdt34xafD7EJVQulavO6JVm6f/rBagcj4bvnescP5aQycYoyIXZ8Mn18cUDbO
         h2ZL1qeMcQwtBxnFvOG2kHB2EnfS+tOLRTjLlQ1bHPRMWFNZElES0WpoUa5y9d1YBMRJ
         +/rQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qPV8YaDo1/vTwniIac2n4FXU64/3E4TicOL1NSY+GWtzBMmHfxccksf9DmY6UVKoo49SJPUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nnJI6L3lF75N+/9hwBDmfUrRG0qW4/rSnuxJCl7B8W9q2u1I
	NgZYYRGzAw0YN9EJDJkN66iBpnYMXivGU2lhfdGOGoF8PuiZe4K31dM=
X-Gm-Gg: AeBDietPaAz3xgbbfezas1FVbdAXHMilN5yG92cz3KHdliCBz7odvSnYw4inLwpMjaM
	ZgCxSN16q/MzoV7+5kamijroMda9e0CuGiCzX/tgSZoW5+Qdd+VaqxKvjfWYO9hkY8e8V6Ii2lG
	ZM0Tg6NxSR6FbXWa/X48nIySzDCXAPOfXmQrfTtQXmKZ2QCkshgLfykvzxyxogEK3q+tuBYxjMS
	uaKOrmAAXzIRKbPwdRXPvTBBJrt5bocLPsArqJ/3/LymVSos6zWOAA9GEJG9YIRBhjYFEWwxEEJ
	uVHINyUZ+pKYRBUtVbJgZwZ5pTHm/z2eM7hSYh/ZgLY3HVfrpLXxwn9xJh541WiVXIFclCQlL0L
	jAYdfiQMGI6imyzoQjJsjEvEE/d917HVjN/n3unmXySvGt023b0NHidXPTRFRmPS1t7UQACXsNq
	C5/PbHM/Zyev5sviiFzJPu05qwqOPpoNwRs9JZPzV3WY0huWJv287Irh7LL+V/QYvUY9+4dWpe4
	bw=
X-Received: by 2002:a05:600c:3150:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-488d67f4c4dmr253156735e9.13.1776159048090;
        Tue, 14 Apr 2026 02:30:48 -0700 (PDT)
Received: from [192.168.1.3] (p5b05757c.dip0.t-ipconnect.de. [91.5.117.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d683e54fsm115353265e9.23.2026.04.14.02.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:30:47 -0700 (PDT)
Message-ID: <9b41afa7-01b5-466a-93db-635d552af16a@googlemail.com>
Date: Tue, 14 Apr 2026 11:30:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/50] 6.6.135-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155724.497323914@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237772-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: E778A3F8076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 13.04.2026 um 18:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.135 release.
> There are 50 patches in this series, all will be posted as a response
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

