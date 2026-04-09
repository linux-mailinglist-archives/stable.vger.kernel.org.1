Return-Path: <stable+bounces-235489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP5OEyP012llVAgAu9opvQ
	(envelope-from <stable+bounces-235489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:46:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8C3CED22
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17E083005AAE
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC05F2EBB89;
	Thu,  9 Apr 2026 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bb9BGzUt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F92F6184
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760414; cv=none; b=W/QDf/VggMLWOuYaEjgHONW3amckYGLWldbBLUXphqKWRkWnLoQpkEgTrJxigjvlWLiOAMmXwq4YIam5i4H6WpyMuiiM6vWrtDL7mhRmJ6HQYcbR0ZD3nO4y35zLBeZv9cxqi8swBINyFCwh7AhI+h49FMAKcNMVo00eWraP/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760414; c=relaxed/simple;
	bh=Ll2cYNSurmcQ/xPp+b0595+mrK4QQ2K6GED4D3S5iXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWEZv0QnDlrUtlMPUtE0Eueg595tkJZvuHKwyPU6QJb6jtkbpZwqf94Wmr92//DqCOZWGtT6y63IEIYCiiGHXnKOl/7PlN7y9IUfiazrBzSB8jEeBakKk5QsBNh/mrg64KFjthE+X9kxYKesBXce2TjFeKZ9y1iKUBuYyIQEsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bb9BGzUt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso13362515e9.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775760412; x=1776365212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdehATieYkaKSLIfg4VjWZqFBB7R/NoRCYylVzGq9dc=;
        b=bb9BGzUtLPQ/6Iw3R2gj/wThHvQkTjN3b+nfnwjW1eRRreWvzc7HI8/16J/2zMN7RG
         PihAXlTTwx+7Xre9OwsrP2E41RrXlZ/WIAir5+H5Grb2wCQGQs0vTzcS5racIwiC2Feu
         +SfKnjgZ6tVuQg9ledhyFtd7RJlFHeV5W1QlB3zuv4ZFRDXZ1l7tnD9qesAgpSmbkfop
         QNE0su65XFY/s2AGSv/NiT5Chgk+S1Ph4vgYLD5SXDZ6EduiP98zd6ZJpttaxvZbhuts
         5kyqSL4E56kpSi44zFTDYMWWRF65HMYYWS1I1fDB4qpO+fKGBeinKIuoJUcnjIOuYIMz
         iyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760412; x=1776365212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdehATieYkaKSLIfg4VjWZqFBB7R/NoRCYylVzGq9dc=;
        b=dtf85CQK3sYdBbdSjvyKGrBrBwyIk639h4Vsgy2cmo3I6BPbJgXs2TB04XAxu0SUkB
         e4dbOxu2SYYYl7g4cVB/XT8FXbFYi1SiC6JA6rcRXpNGBzz4wf3yxkCk97ub6++DCTds
         +7LSJgCkaDcUXmR/ycoJ/e9wyZYSqrSnQtrR7f/i+ecFag2Kyaaa4IO4TarUFQ2tCtfd
         VQdVTDu+W+j5EtUQjip7UDa699uWKK7r0t9S+bXdw5SHdrtHgfu1+PSZZ8TfMQNwh8Lg
         3VtiuX/xdyuVLhOdwEYqpMmUhWKeWkZABgKwmNYbFYRceLjiuxp1pIS4J7MV2un5OcQu
         E55w==
X-Forwarded-Encrypted: i=1; AJvYcCVGe7o9+ZniR/YD+atKXkY28H+87XOsJvNuXASc+rCOeXU++NJCi383RwqA1my8epWFTcdBJx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygUYPk2lECY1EobdA8en2F1C+SqRCVpmXTsVFzDv3GkEN2gJtf
	5sAdCsDv8vRAKhsLfWLy0fiucS4Q3hyk5Zp/6vJt9jenzR9LmK7s78HSZIxP
X-Gm-Gg: AeBDievoBKiuJmxlyTAbpmjxWOdvReFNNdmG4zTMLzRD2Wkpu00oVQYaFK7/Nr5tIHJ
	bwSlqbt4QmQzRqjfVqZPPu2wjif6hPTjCRyLn+bsLi/eORQQo4LtNDIezO0A5AmknzBa1QYtCtp
	BhZVhL1p05G0zYZqYhKLw9QO66bTnflqJEE5RYzFhVDPUR1IL1qhZKBgt935e1E5XHSx1v28sDX
	vDWFKOE0mOHKFQKOuj27o6lqvR7LhK3oRJfEJu28bGK1eazOpdrdwp3US2Lv/m2slcL571GY687
	ffnDLG6x18DiuMa8DIkgUBchwAUOVjTwwS+qjnORYTo6X6FVkr3iT+sXNlYVhwGX2GX1dA75prg
	csgRk/JcB0t4b7M7WfblqbG6jOO0MEKHmgALbw+XjaOcpWgQKXnSr3j1uAukNdWjqvTQvtGrB9E
	StCNZayHkplYUDObZOizvyfyM7gK9Ui4RZqMK9d3KOQF5gxu697vkT1mQxbsN0HqmQUwm0cGlOC
	D/pdVPmwk5bHA==
X-Received: by 2002:a05:6000:144b:b0:43d:1e2f:bdac with SMTP id ffacd0b85a97d-43d642dd680mr257188f8f.49.1775760411756;
        Thu, 09 Apr 2026 11:46:51 -0700 (PDT)
Received: from [192.168.1.3] (p5b057c8b.dip0.t-ipconnect.de. [91.5.124.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm925283f8f.12.2026.04.09.11.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:46:51 -0700 (PDT)
Message-ID: <9658fee9-1608-4fa0-aad7-ff54ce6435c9@googlemail.com>
Date: Thu, 9 Apr 2026 20:46:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/241] 6.12.81-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260409091733.126574279@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260409091733.126574279@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235489-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6D8C3CED22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 09.04.2026 um 11:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 241 patches in this series, all will be posted as a response
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

