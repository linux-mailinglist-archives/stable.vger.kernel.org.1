Return-Path: <stable+bounces-230003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAwMC2KUwWnuTwQAu9opvQ
	(envelope-from <stable+bounces-230003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:28:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BE42FC41D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 096853014FCF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B23C1978;
	Mon, 23 Mar 2026 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BwDmV2CU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AB3C1418
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294108; cv=none; b=RTGOJSIZlD8XshucGm7Yd7zzOE1XkN8TzT7pdIZbab14hDkjaBUeyKpjpY6UsYOkWf2rdXSJmVdBcPnciZfneoX/7m9ycPk8+jpqOnicUiBPaqQRYirWnp7gehnDX6mKkbWXkmdZ/Ov1TcFx0DxQgcP9PvkcThdVyp2sHKF7oZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294108; c=relaxed/simple;
	bh=xJkPJYdDUmNvUwpMUL3/o1l6cJngLLwX2yIRH0OCIkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYZ0GovdDKXXYCL4YuxitM7+tmxJlafwjXd6/FH2SvHKga1UOwnIeRd6YSypnmZZKcrjyQvBMTVhIOoclvcqwRvPsoxXaJXGa2O4wBMxMHpOsNLMhs/v+HCitbvDrgcwiG9YnJeM8n2hNh+PV+Soj6M9lxY6AkbD+eKXoa8OhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BwDmV2CU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so27811725e9.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774294101; x=1774898901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QjcEhhpVpHayU32njnxg8fd4KueGGWdq5rqYLKunqk=;
        b=BwDmV2CU8IE3Pgw7IdNgJ4dt2jrLf77kGZj01intIcto7jWOAxjBhD04A2ktGUJ8Rc
         4IeurZovcVxJo2/4X0LSn7vAquS6DcGOxgaHVniwmnlufgiR0OG5QgAErA0VL2z0YJ44
         3gcV9cqs3LXXoukXNfTsTYg8DXT/rRxHQigA1/1MDwfAbUM7ZDKhBvsx/tNVL9zhyujT
         zuKWZSpEbGP8Lb9rouu5rozXyzNYNme9gflT9o6T38b2HbUIabMztGgWJ8oPyRJUIySA
         EhJDrijimRQL0kb+yZuLtM86mB1Yogg4KDn3mvQgSM39qjNOnp+98DA5SQMCCJpVJJzV
         I6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294101; x=1774898901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QjcEhhpVpHayU32njnxg8fd4KueGGWdq5rqYLKunqk=;
        b=YPaASTZshp+hEDR7ftEok0QQVLKnGN7v2f3KvFyQTxy2JJHB9rb+PN3ic8miMae/u1
         ApuDVX3hovxX0eZ6F4RPhBaSXaesVXRxYq1TDYngcM3lhBZCOCeQKG2B+ir6ru2N6Psg
         KubDv6glXHphUS4aWegQKYOY4CGlKwBF9PGU8wgPbvngCeGTLPUT+OuzKtBtLGzw+VRW
         H1WhDZUZwLG44Qhp5mAH/1rduZx3SMrow3zCsVkW0/Mw2cpNx338an/VNvHd6esmTF49
         vXaFm/bB+skSTuuX59AfwVJc8CAwpo7bIprN9tz1Vbgv+VV2mic1SNtipSMhYXTE1WF9
         DCVA==
X-Forwarded-Encrypted: i=1; AJvYcCVqWuUKLp3aSzVxyBDMoIux+Gvx3k+wt/Zwatl3s4Q260c8GTwguzQjiPo4CE4gUljk8m71zIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wDAWh/QAweUTc84L83BLfNRK4RYG74ZeSPD6pazASCb7kblV
	rfjF4RN3tI5A11Mt0UaNez0+5Vx/ZQOQMqiobusKwYItsk6SVmnD+Ew=
X-Gm-Gg: ATEYQzzWCPGVX+L2uIYXUEwXGuzAEU747l1yqGykqo8F6v/MT6IjareHggUfCUEkNE1
	h4HNb/tVrZTpgmswDajxBTp+yPuxyIIK+pVX/czXNNZS1Lvgnr+IEABnOBfR+Gs3xgkb8cX1SkT
	+WOz1q5vXIv14+9cA3/EO8C7Hqt8mMl/d0iL5v4+9bhGNNSni1+q8C6Thod+VJStKc83vrQhMQP
	R+ju0UaZNg7matZ8LJPXns+y4CgiTHinSJAm2Bd4vw5oJHUAQBUQwGPuHo+f8eRaz84zQevdLXB
	3Lke4CzfxN3wSE/gQZyhyGBEGNTahDkaM9HpSzj8w4FTmwXx1NpIt2qI7Pks+aIUUZ76PM9Ueut
	e8BjKPALkeoE1QQkX1IeDItqPwwrKhO/kKFTuYEEPPhm0BnfhMhqGweOgNdlGzMo4EDvp86GVyX
	9B0RG2jw4euXBsh5NtiEyEH7QUeqwGlPGXMUz9VUdag//3+8WAGmnP6D8qMN8vdvKIU1U4cw673
	g==
X-Received: by 2002:a05:600c:4e8e:b0:485:f1d1:8f29 with SMTP id 5b1f17b1804b1-486fedaae27mr182451855e9.2.1774294101272;
        Mon, 23 Mar 2026 12:28:21 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b444d.dip0.t-ipconnect.de. [91.43.68.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700658441sm416491825e9.4.2026.03.23.12.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 12:28:20 -0700 (PDT)
Message-ID: <44c8f132-cbb5-4178-bdcc-b9368fb88817@googlemail.com>
Date: Mon, 23 Mar 2026 20:28:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260323134504.575022936@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-230003-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: C4BE42FC41D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 23.03.2026 um 14:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
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

