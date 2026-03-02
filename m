Return-Path: <stable+bounces-222697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kProLNvvpWlLHwAAu9opvQ
	(envelope-from <stable+bounces-222697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:15:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9391DF351
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 21:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863A030C9DD6
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F4E47ECD3;
	Mon,  2 Mar 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jKWfhWvi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47B47ECC9
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482354; cv=none; b=oKuyOWYA/st6CriedzeiFc+ztlvyYjl9udP3WCeeCSBkmK87CKq9e54bIkD/NWqup3d02N+jHebGzB9nzcV/OAdNQ+KPADJAbbYSgtBhQmOMWnsOOaE0+P7qNc+J17RReeCYmD3kBKmySY3iV5ivY8f93NNcJ6Cx+9HUMOerUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482354; c=relaxed/simple;
	bh=nkQ4TOdKqe2grQHh2rFu9FQJAR+Mk8lyoYODT+K9MrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUbuKnyFX0KexQObMmj2hb9lYItHfTzafAaxBtDoEn8bPjZEngdc6+N8g/qcSV19aKdG5+VzSeNXTM0CsipQ1yXcTgkHdfP+yu0IOahtwl3bbvb8WLEbxWsbTSfT1Ys1uUTV4+6xAgIm21WKpJ3zteThhoISkYRLbR54U19HQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jKWfhWvi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439baf33150so873918f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 12:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772482350; x=1773087150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CT6M+zIrjfi806RKghyF+8bSKG3Upd80TvSyvE6FN3M=;
        b=jKWfhWvi9GyEAGWvD7XdXDhEylMaDn+A3zfQby2x6nWj3Vki/sz7/V0VpPTTDMdwuZ
         Q/cgDY1jNswn+Kfa3MEMf3hBbVI9/g1szGwGC2q2itZm2Vl/afmpAPuuYko+b5Qyql1f
         X2GxxLhi7p9dgPCcNLqyNHHHSiaHuuJt19OCM5HaDPfT8/q9uR0A1bl2pYKf4Fe8PLp6
         FSdB68A3eOpl/4FZAStsHtbBcYIUh+EBXZM0wVZ2ImF/4SI8RdziD5xSUFbnoSY62Y0A
         dZtIKe6zztdmv+/e9At0AWWQEd+hYsM/C8GlMVxDMarnM5ZM674j2tLsA7zdefl6KXn8
         qIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772482350; x=1773087150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CT6M+zIrjfi806RKghyF+8bSKG3Upd80TvSyvE6FN3M=;
        b=IgI0CZj0obA31x98IO8IsA3/5Bq3/KkYkZgE1J8HXrz53800/qwdpx6egnhbOJ+gZg
         NgyE5ErHu8H9mWhNWHY7PA3DXSJQnzwmNvJZiT2/KmxRoAV1YqPtam3q5uYvxqvBdyKr
         iOsx+9oGrlLISMuzL7msepYorqxRmvqcNtLDZSsY/udlkJoZVYAcWHcuFUkavTJl9+Vu
         YYkkKfwWiiG7kexK3X9SD2ANaEBvxRY2+gOFcYkrOIZFzEGdDlqvoLlgJoG1myoQ0+x8
         ssRFYRadblxl1gzy5DAQYa5ssU1jFLCGdgbRgdmeZauAv6WaPqOR7buRKPvt/pnnd6pH
         Myfw==
X-Forwarded-Encrypted: i=1; AJvYcCUvP6yQRdbDUMmA8I3ClMFgYdukYyc3crUq8fS1DMMW5kcCfyCf+Ej6Mj3UrcmJjrbePJ2tI18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKriISuY/EwuvvMgw4Pg9r0Leanf6oDp3egUWi2TGDmtKMKLWg
	dr1xOatFNTc1OAP27c6KEUk+OMewFO1xbZ3MAVURMkQ1+5fpP63eQN8=
X-Gm-Gg: ATEYQzwQ9GUN7IjMNhpwKwMinkxHXFTD1xHSRxi/UyFpLKz+5mCum1JvSTuwr2xsXF0
	8KoT7SPmQF/bujycR3uufMb56qoLD1P6K+CFYKSJrlM3kq9jr/qVZfiwlVBVEFN+MhTxgaUuTFA
	74LihFXpbNBXl883yGG6yavLnoR3bwZUDaPcphTqVDzxOyY0wnUIKBDBS0Q9XVHed1EIonF8xr2
	NGLGfNaWX2tV6dzb6+q946GhUlGyZ3Ww/ImTu2e6/LpQ7plNKcqy5eWQCvs/1+Hl/SEfn1RdStl
	JoXTIPDeK3GCIJMj3HMcR5vOtVodFeKTwepwd2perBvwOayZRhYeJqfWgj3IVQjSkKnBlsuHb5d
	A2yc9qPOcn/MounTG60afcYUNJCZpcBHpDwjV0Taal/cAH0EIzDcleM8aaiHYy/GlYB2bG9LJUv
	xPgm+XK+x+VmBba42dqnHT28kOwR5kmZORerNFCRCOB7/WpseXrPowhkXoHBLcZwW7NWg20yt6I
	7GTKikBAyI1
X-Received: by 2002:a05:6000:26cc:b0:437:7300:eb1c with SMTP id ffacd0b85a97d-439972042b7mr31329041f8f.26.1772482349654;
        Mon, 02 Mar 2026 12:12:29 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abded86esm19125732f8f.6.2026.03.02.12.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 12:12:29 -0800 (PST)
Message-ID: <2f3484dd-2259-4a7c-8798-0c38f9dff22f@googlemail.com>
Date: Mon, 2 Mar 2026 21:12:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Content-Language: de-DE
To: Brett A C Sheffield <bacs@librecast.net>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160943.2522184-1-sashal@kernel.org>
 <66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com> <aaXNiwFkUEy8SaTm@laps>
 <abe2fb5f-61b3-4597-b27b-c6c61f5efc7d@googlemail.com>
 <aaXpH1EiNugoQwaD@auntie>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <aaXpH1EiNugoQwaD@auntie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E9391DF351
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222697-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,oracle.com,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailvelope.com:url,peters-netzplatz.de:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Am 02.03.2026 um 20:46 schrieb Brett A C Sheffield:
[...]
> TBH it would make life a *lot* easier if RCs were properly tagged as such.
I agree, and I've always wondered why it's not being done this way.

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

