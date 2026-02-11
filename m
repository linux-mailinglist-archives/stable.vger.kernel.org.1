Return-Path: <stable+bounces-215744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJSUCDUFjGkeewAAu9opvQ
	(envelope-from <stable+bounces-215744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:27:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77A121334
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC3A33010806
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90521D3E4;
	Wed, 11 Feb 2026 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="DmZcyD9n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85879200C2
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770784046; cv=none; b=VEfOpa73Ha936CCt26C0tIoYouX1n7s43TtOI+EAgMQd4dykgkA7GlG0rdQcO2MTppSLvVQlVKoWVhFyPS6Jys4y9QOSKm1iarEn+0EYOuthZB5+zVHrneGRQG+g9U/F8aF2J1nPzqono8SpKOai3OTTwwVZ//I5ZxU2B0yHP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770784046; c=relaxed/simple;
	bh=ctYRc6IQmyw8kkjADeluG5xqM4651u5wz/4mBqGyCDA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=o66VJxr5WCS35l0tcXFFTBMcjdQRj1Z9WnWbCyyVC9vWmdeOQvPFpxBS8pu9cu4OGKgnxGOckKdAbLuUOXHyD1LzhHhtrbPtmUytYKPQgAHc0E0iv0oawBiVm0yDmqzUoqeWX0pHBZUWhg/LobsdOEBZOKAK6Rj11mElTInyqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=DmZcyD9n; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82458495219so1972511b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 20:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1770784045; x=1771388845; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPgL6cTcdzjcSZk5uioHvoUh0Uu6gXCMmy+bURP7FMw=;
        b=DmZcyD9nQygWaOR/5zs0t7HtQ0VToopDUPDvTo4WHbRvJKh37fHXuGFKuDuJxqotXt
         ZYL9DrWEkL5um3iLHCVUPhe4J/revlnc/m3cTxIDZGeZROPhTAQxuVkhTTBvu+ZIcli/
         sQoM6OqlNpV8+EXvW+7HilSekg964OJmrtuT6AcECmdtys35HFLEXP0nJODHIHBU5Fph
         QTfLaJwhi7nccMPu41Id5Vi8Kh17Mk/DKazbcsPzY/pP4O60bO/ph7qqMAyhj7t5hZBg
         5Dhb37L1YJ/UEFrhsYgKF3OuAm9dLPXv0SXAoWLGJ6r1lgxfuFXiQ/jACDjtzYM4V2tn
         Ou0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770784045; x=1771388845;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPgL6cTcdzjcSZk5uioHvoUh0Uu6gXCMmy+bURP7FMw=;
        b=KIy8ZhKIJV3PvJa9KYSjOI+G/re7M/HjPqj1VE7zBCSxTY60R+gbYrSrn9EZQNCU7E
         ief2gqVObc9xA/zS/0QDCLGav5G94+ZuhPvdhBVJzIZkxVcI1fZ9OOUYnzjAoAYrdwyk
         W2z5dSy7DHFR+R8VYgrczgKVGQ0GX5RkzyiWGz5TTqAGtxbXEyTg2jb3uZT4pFg7v1kI
         RxHOaY/o0Fnpmd9fj+PhyOxooFQi+J14AJ0eRlkxmuoW2OXBS1N/BffZGUh3ioMZohqb
         cYLxZGB+JpcGAibhGGfFRgqPcHe5NrnZ3XBQGJyQWVmw8MAheQznK8A4MQd4C2TaulDF
         +sPA==
X-Forwarded-Encrypted: i=1; AJvYcCUbT6/lcwYlq239jrs5E4CLqNnjE8oLTfwUZfWb9D+BfC/S6zsGyItiFDDLKXGrrqE7COHdKEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygLq4bIpqEyv3DOfXGnojS7lIu7lfJznSONgTOvDq+O6C11rQI
	uCVkCiCCdChacOQIY7fRcVcUO/ypDYnVGT6e07CYXcH+LP/2I1638gBOgbfSlSurN/g=
X-Gm-Gg: AZuq6aLr0e7F/XNFs5QOyA31RQAoaInGaG80qMAJPy+lONuXSO8D9hjppqU6/gZRwQ7
	EG5BIOWVLUL+b0Ms7yb9plSITPdCYhWZtBrhKdMwjq+AZRFHhSEJ+cRagKpD+uCGjw+TliMfiIP
	vDC1hxd0EY2u8W7YEavtvIN7nZZJDK+zbG0xkj2TDb7dS47RowpDHdhE3IGsTjLcVMttPKV21uV
	fVEhquxSthZPTtzW8BGGdXAh0AgFXjqEQikhxX45osNu5ejMr6vZIIoIoA8JFBvWiTy3c2flme/
	QHjuiIoAizkIpYrXsCAY/0aZLN+Q81wZCboKNrSx10qKKgzASOK2ttg6B/xj8bGJEcZcOYX0DId
	qecMFd64B/P6ODrnlvyO1+41hySraF4aAPD6f8pJxqwoYWDMIiMowGGZ5Uyi1j7SXVwT588gLAB
	foxioP+XwcAWcb+15d0emzOHeGu5O3kjRQak5pQuT02l5PNZcgBl4Y5GXX5IaW0Zg5iNg=
X-Received: by 2002:a05:6a20:2593:b0:35d:5d40:6d78 with SMTP id adf61e73a8af0-394323c1b69mr791736637.46.1770784044804;
        Tue, 10 Feb 2026 20:27:24 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e7d8eb9sm671636a91.1.2026.02.10.20.27.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 20:27:24 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com> <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com> <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com> <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com> <3395ad0b-425e-40f5-844c-627cff471353@oracle.com> <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com> <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com> <005401dc9638$b3e2ea40$1ba8bec0$@telus.net> <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk> <006e01dc965e$d82c33e0$88849ba0$@telus.net> <4a3hybz6es2vwav3xlug437zhgsrvwy23ughzpslve57ifaeoj@5uue6jb24osk>
In-Reply-To: <4a3hybz6es2vwav3xlug437zhgsrvwy23ughzpslve57ifaeoj@5uue6jb24osk>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Tue, 10 Feb 2026 20:27:27 -0800
Message-ID: <001e01dc9b0e$bad71ee0$30855ca0$@telus.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIGJdMaf/4M855ptbp1U7uUSdSxOwCgaPhQAgSxF3QCdRKf4wD6zBBnAsuKJa4A5XOx7gIlm1O2AkVayRsB9fXYlgIfLOLLtJegAMA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[telus.net:+];
	TAGGED_FROM(0.00)[bounces-215744-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E77A121334
X-Rspamd-Action: no action

On 2026.02.10 01:17 Sergey Senozhatsky wrote:
> On (26/02/04 21:18), Doug Smythies wrote:
>> 
>>> (I'll need some help with instructions/etc.)
>> 
>> From your turbostat data from October you are using the intel_pstate
>> CPU frequency scaling driver and the powersave CPU frequency scaling governor
>> and HWP enabled. Also your maximum CPU frequency is 3,300 MHz.
>> 
>> To limit the maximum CPU frequency to around 2,200 MHz do:
>> 
>> echo 67 |sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
>
> So I only set max_perf_pct
>
> echo 67 |sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
>
> and re-ran the test:
>
> revert: 72.5
> base:   82.5
>
> // as before "revert" means revert of "cpuidle: menu: Avoid discarding useful
> // information", while base means that the patch is applied.
>
> Please find turbostat logs attached.

Than you for doing the test.

So now the turbostat data shows that the processor never gets anywhere
near any throttling threshold, eliminating it form consideration.

... Doug



