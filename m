Return-Path: <stable+bounces-222470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JauDJgRYpGn8eQUAu9opvQ
	(envelope-from <stable+bounces-222470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 16:15:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A561D05BD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 16:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02D9300A395
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4AC2F39C2;
	Sun,  1 Mar 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ABqs4Ep1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A13358AE
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378111; cv=none; b=rwzsT/RKiAdhSBuYdymrM1jG0zDTX6qCpLfPVWPTBV7UKMOAMqJXgn+liDJCu1CwIeUC18RAGy+n5g202zxcS5sKsD1CeyNqntsXUitda5IXa7GD81TtJQs20UDvDlOsp+oME4m4Y7bBBbfooPbqx2FicQImuwvXp0ML+wKcKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378111; c=relaxed/simple;
	bh=cwO9tOE+8MirhEpgXP8lGH0Ktq2Yc4e3jnAjyAWdFzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6Ln+QGo1eY1VXBgu9T6jbx9SMzvOW0ahUOLKMTjL5uJito3x/qVUKrAStkZXnqEuIqutzLkPFAPotik9mCaFP+BpHM6GfhcsLA8iQ6hbTIfht6sxEP5ZNlBPn0ZOQmiorxdzEo/MHw9C0/1DKY3tHJzFXzcKEz91ScoLudlc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ABqs4Ep1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4399851b14bso2526106f8f.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772378107; x=1772982907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1G8+Os9t+BqCaUX3Sxcb5l9IVynJwal1EkLjI/4S8g=;
        b=ABqs4Ep1ORX18L17d9FIroS0y/cA9gwO1JMTwvmOrTVlZUSYRYiF3IQF6O0C9VgbOl
         kSt13skLxNO3+U67QOfrn5oRjsACLXDk7/azPzxEpKXDj5KyCZfp0uQ6FpGfYIK6t76e
         PfFeYlu+jlNvnobXlsjJlGWO8V5Ev8U7piCY/5sa1iHIJv7bMU65U/9bDtzonB3D3TYi
         xd9VTrz45wBE0Mo0xR0gKxtZrlXQ/VGUepb8BCame1biKW5atqmBPGlwtWaWQyz50IZP
         Dr2fmrUvT910etY5R4r3SlF3IRzF9o1T0UWW/ue8ci+I7b+1GyseWjE5hCCsk0rcp40o
         xQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378107; x=1772982907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1G8+Os9t+BqCaUX3Sxcb5l9IVynJwal1EkLjI/4S8g=;
        b=BUskbsGqg4qtTaSjzB+IO2JvpZV/wX/Y04iXMenFDAobNPIDLVOc9ueHb9DR+QpLJr
         9hVc0PWGNzb0QZhz/loKaG4l3CJ98Bpoan8SZttUdwjGg0YPT46MVZ7pLBGoQqAgz1Il
         XZDceo0+fIRH7b6i5tvroW5vmtzRGwS08VLV4lHy3ioOkHdOrFJmNTpmT0xvaHMorA6P
         FdcOhUVlq7W0CxX3KkFKZc81wZPHUWi83kAaBVAdtEZ4Zwp91BR04KS1sifJ6J7SEG8s
         bjN6c0IVoQmWjk8aKjmdwoe2HkMi7esVta7edfvz6wyErjCWm6pxBbwNxxn4bkF2xdfs
         7e+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXm0kWRFtvndlqLKS1QeSI9bVBcPyuChMi5JvR3RyaYZ4beXGiPWaAhv1YadSPtjcgs21mV40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKc+xHPbQ1MTRyrqHUYYxXhjjkL38v4Ere/dNHknulCHRsr9YQ
	6KMe/LjHpsFb5ZduBfaSgEyR45XDyevdtt7CU6X97sBRs8JP77/vcjQ=
X-Gm-Gg: ATEYQzyJ2FwA338kMKgPWQCQ1kN4+2d5GJDBNF7mFELfk8cV5BtIBNN7sFSyc5B2D0O
	zkTZ0b01+QVp++TrrCF2YokTMs4ZjSX3IFcXNZF4+tVnEvosyxFMA/Bruv6qxgUr8nlmcUcM35I
	1kYv9GpgRITgrtUSy4UAh6lM8RfyvdJjUeQOZsV/TuGtotZRW9eGA7xucvWxZQvRXIcrFsriJmY
	EQgOzByRwbT1yz0KJTDHB985rQdLjwIHl+B5jKQRag40y6UPVtqOzJqhIyGJ7+mzbPd5soyFyM/
	HZsWPq/dde1EEVeASek/9HJN8U3THFvqTnAkjtyv/5ACo0zXoCMj/xPrwd10dT/1LG+2vzVJD99
	viTGjr8XAwuUnJWKh1SSjzUeOdkmIMv7u6RcsBcqsuUSe7hyljgW0Yim9hzLET/SBD7X2FifrTA
	dtBkoXhJr3v/mYkh9UOEaqx/NdzIYrpf8BVXsBjAlgGEA8qsvZYZ5gets+Mn0NXa3W/hWOLangP
	ec=
X-Received: by 2002:a05:6000:220c:b0:439:ac8f:5db7 with SMTP id ffacd0b85a97d-439ac8f61afmr6264905f8f.9.1772378106539;
        Sun, 01 Mar 2026 07:15:06 -0800 (PST)
Received: from [192.168.1.3] (p5b2b446c.dip0.t-ipconnect.de. [91.43.68.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60e40fsm21128269f8f.7.2026.03.01.07.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 07:15:05 -0800 (PST)
Message-ID: <055deed0-4b00-422e-8afb-5c3e577a6046@googlemail.com>
Date: Sun, 1 Mar 2026 16:15:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
To: Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 patches@lists.linux.dev, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, achill@achill.org,
 sr@sladewatkins.com
References: <20260228173244.1509663-1-sashal@kernel.org>
 <aaQriDS9IOr6tI4x@sirena.co.uk>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <aaQriDS9IOr6tI4x@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-222470-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim]
X-Rspamd-Queue-Id: E6A561D05BD
X-Rspamd-Action: no action

Am 01.03.2026 um 13:05 schrieb Mark Brown:
[...]
> I've previously noted that releasing -rcs on a Friday afternoon isn't
> good for ensuring coverage (this was what happened with 6.19.2 and
> related releases...), the same is also true for releasing them on a
> Saturday with a deadline that's very early on Monday for a lot of the
> world.

I second that, and would like to suggest that when a stable RC release is done on a Friday afternoon or even on a 
Saturday, it would be better to extend the response deadline until Tuesday afternoon, so that people who want to help 
with testing have a chance to do so without having to "sacrifice" weekend/family time.


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

