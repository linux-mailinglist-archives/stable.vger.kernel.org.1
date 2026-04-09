Return-Path: <stable+bounces-235319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB7AFDlL12k5MQgAu9opvQ
	(envelope-from <stable+bounces-235319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:46:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A03C6ACC
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2321E300908F
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40713346773;
	Thu,  9 Apr 2026 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nADR3CYc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF83090DE
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717172; cv=none; b=r4cz9/Dcgm3m9oJwVS8rC8M8uzugeDK8tNjK3ddRwnjAcVQ79b9i6HbRmBKh6wl7vYqBlZtlY6DazseDRvpRYD8HcUjvmEyH6RgUVEm5gXDnq0EMs5EEubwgFpE2vigpPZqOGK/6NrVROWRrh1vObMVvT86/E7sfSU8+0dzXxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717172; c=relaxed/simple;
	bh=AbeQZ6rUWFA9gZ2YX7LL909ATfLt1k0tZVS04LIVbHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3gMp7plnPqZYVVObRuhAe0/WBAFOjqxcMwPRimQGFms62C3K+FyduV2Ks6JhH3Xb7EDV6icPSZfa78G0zYMnD5HszmyJpXIaDIcMZJnESgTaqNaJDcRis2DwZN4xFU7ByDIz7BK5wwe2BBCrofN0H5TLmnKXMqPqxW+4PWwRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nADR3CYc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so6250165e9.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775717169; x=1776321969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnyQbQKBjyYXbB61Mzrd+iZB35C0pj6iNDpeLUpCeLA=;
        b=nADR3CYc2pSm2/RBLLCBjCIRUpoDCrzDTnSLhBwz7mVOLsTgE1UUT9N9sf+HSiPSUT
         i1icfgSDSwveTj8sn/Ipea+e1/NkYSAuwum10s+ZdjjahSs6+yagaGIU/U5+/GkuRvtL
         9v16wZ2LDnHW9kVX5Q7heocXG7/j4lOG/VNaNDibg9ESKWnrSExRWQ/2FU2OvXLi+W03
         S7TEljG4t8/KFmT8S3tiXBRIctqHx00uHHmJsG0GLxFGg5beccvCzXlRTrSEfu+GjVMg
         VHT00C2acuMa1XH1lgnI8/u1eKpI5i/cUTYd+WsMSFyVjf9EeFKKbZJGXVSSpmjOrc/p
         WqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775717169; x=1776321969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnyQbQKBjyYXbB61Mzrd+iZB35C0pj6iNDpeLUpCeLA=;
        b=YK1YssPTFRAUiE/T3lTARmFIzylVh4xIcZ4MavN82ZqRFWCYDYsa5uIPTZGSmShkhX
         KzZ7VJJBL9xSBX5mjZwCiB4rM/kBFYyxRJQgQiIXhnjlcXcpj5TRUaJX4LP2rd6WPcCx
         ae+Vs1vgq8m82AVPnG7FS22W9vF8Kq0YaMmH9dcK/74onZkPn0sPhSNTbe3CgXPpiUO4
         Hjdt0HTbJ7eOW76rMATJOsKy6UlGsyQtmmR6eEPGBWjACPrFdU6cmMRnQ1IDThhEPWc9
         4zCMvsXmZQ4tdRfIFiqhkf0WOqkwasY0aa2ou3ui/g89q9+2imH3ioyv0/SSSi/74wye
         7Qew==
X-Forwarded-Encrypted: i=1; AJvYcCUzySFSkDs0TvI5MkIxCEUy6JNqJOGVlAqsuIe4HEH3KPrZSXjNVtbBqrLAiHHA4cyEi2DiLNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxySqEQ8q8jdpIadSjlXdmCa1l3sw3b/4EayuqreU2AlhlbQ7I1
	tIIoZ7OJQHY5ZiGy6M33jQ3uuqlDd5mf25YKrltoLBZ95a2JCvRKrQg=
X-Gm-Gg: AeBDievtr3wC550z1JH/NIWhWKDkulISjDabZWMcb/sZT4Rx+pAGqEVKK/ieA3qzyDs
	wy8/k5nVgPurQCmZifxJVZJ9Dec33A2TViFcV6+Qt83/Yd1FqcWsQ3Azn8qnO0m/RdmCt2LyI/1
	0uo0W/loyFTIlvTULaloJaSUsNigpSw9W2bylfIYB90QV/P6mOPlz//nXjm1Qj0oJ+/7k5alzU7
	iBE19GHgo3zfJ+EaGaZ01cshjjV1AVsjfLNlZFINpI++Nq7tqxitG6dHY6ZpIDN+CEUXqtKWM32
	H92mEoijwgPy5DSAaVcZGn8UFIiMc3BqsRH8rqCEl6INvW8hmSqaJ5eIEG79OzNDhEkAvF0tWcI
	zXyNrRHr9oNEAW3JgaGo3iXk5jdY+2xpzdF5H6lFPBe/H1tCp4YoWtYhD3OqXvCtN3DMem7PqZX
	Qn1hieGHsAcB7EGDZx2sAeesDp+5ChA9cqlgJ8Uah3EQp7UwH9BfMjtJhe23rwDJqvqe4QQYTyw
	8w=
X-Received: by 2002:a05:600c:4f0d:b0:488:b187:d898 with SMTP id 5b1f17b1804b1-488b187d996mr209985355e9.14.1775717168957;
        Wed, 08 Apr 2026 23:46:08 -0700 (PDT)
Received: from [192.168.1.3] (p5b057c8b.dip0.t-ipconnect.de. [91.5.124.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd23058dsm49990515e9.13.2026.04.08.23.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 23:46:08 -0700 (PDT)
Message-ID: <80c1d385-b3ec-4960-b119-b5cb2b209d9b@googlemail.com>
Date: Thu, 9 Apr 2026 08:46:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/160] 6.6.134-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260408175913.177092714@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235319-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Queue-Id: E61A03C6ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 08.04.2026 um 20:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.134 release.
> There are 160 patches in this series, all will be posted as a response
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

