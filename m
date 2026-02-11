Return-Path: <stable+bounces-215745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A+QCEcFjGkeewAAu9opvQ
	(envelope-from <stable+bounces-215745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:27:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4212134C
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F623020EC1
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682C2F6586;
	Wed, 11 Feb 2026 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="fXakRn41"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C611469D
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770784066; cv=none; b=AcqUSLEgejaFHxMzKhh3l7S6yi06Vy+yswCD27BVOPmqYxJIexloCUQt/ahj5M3Y2CZY+ITIIxhVzuFYytfsP2luIs6lgIN+uFP3s44tPxZUR2muM5J35h+pu5o1tub/Um1aEGA1u0aKtdkVikytGO2QIMyTTfxpb+qIiXYFUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770784066; c=relaxed/simple;
	bh=1Oox2N3vRWYyin4SRGWACclv3TTOaPpbMsBdikA6HI4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MukQPyPkC106ZrfEUDGl0Q/4xdnEtTHJD4BzSC1e+FpPgeNMxzPiH7L9lixT0yFBjPXmP78SeOWcni5rEn2nN48Z/K0fH5jaD/GrXqDgRiVIt6V28oetoIfxu5TNl82S11kHe7nVEKK1T7UX7J+QokK9jCiELxtxtdGSgrx679E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=fXakRn41; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8220bd582ddso1005591b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 20:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1770784065; x=1771388865; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PeYqAY30/4J7IMO4lbtZzU5S6d2pdo/JpCQlPo26gq8=;
        b=fXakRn41bsgG9mbTtPHhr2s30sxC/Yaw1EfdS1NVsa5xZ93Uh8wl1eK+lgo/GrXRJ2
         FlTyB4Qj1B7w8JBLqUyio34w5NgB9dBzOSTIaFFNUBOK/oossEqfXi34cCzZzjNHWIYu
         6MSiXUQjxf7SJGkU02Sh7OXw0bOy2nu6m9VXEKpcxR+ImRwPtVAJqlXyzRpYLXDClhHz
         Gxh9/WuSmHANZrzI9hzfmFLq2jcFLt5nvMnm7c8CdQ6YqEJ+BoVzwtOsApLwWZljNM0A
         xIkAUkPxVGHeqU7sDHrMZbMqBItZssvbOoRdJd7L4VwkLkAsUNAeqGBSIwAP29oqPAS0
         VSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770784065; x=1771388865;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeYqAY30/4J7IMO4lbtZzU5S6d2pdo/JpCQlPo26gq8=;
        b=CNW8oHNYXxUYLdeKxsF8AdD5LjFPAkip/oGzVnUNt5PNCql18EEIKZPRTc3r8AuLzY
         G143tRcJyf878VHLkFsHzwUqwNEq45uBBIyxxhSuHCXWwgnEfKNW5kA0XsBFOf4BmKNx
         OyADB3HhuPwPjm5TfEXAyvIn2Z8+jwwNGzltttpMJAl16tU6D/wXOxxBf3fgUosiXUUO
         jxBCpUALIc+Ur1S3Ip7STQPWrambJmsbEueU4zp+5gF2NHSSsP2A/1CGZJmOqpQ45VJz
         MGQia0jmnVGNpWAh7j8ZOyayddcJId4cJH5g8kTlopzX8bJA5eG8/hFO8TdrkZO6mbSx
         834g==
X-Forwarded-Encrypted: i=1; AJvYcCXYUBZ3FXEZskxIw6wJQhT7t7fH62FUMJ5M91xjxJ3ATBFvisZdJxqPA2cEv2fAlj7LZ8kq/eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAEIp28eo6l5jkmuO77Q0JKShIHGExSfYQ5c+/9ZEjpEdqICS
	H65PcdczOysCVnCphJOYGQMJBT7zJxlPLESH8pe04TglRMU7DW+FfYYFwaGPG+qjoQo=
X-Gm-Gg: AZuq6aJGuYk9lYVGIHckHqICCZG8Bf3Qsbq8mX3OzCjyG0MME3CkfhXbSaHAQRNYrX7
	hbqi77ZbaQ1jbAFq9YpHbYro8pSDzI55xEpyQh7XuVo9LLGaMY2GaI8z0tWh5Tv4Dy/JheI3vRh
	IYduarVFaOP6Cmx0YdCpB1Kz10W2CwTXgGX5IG1t19P3KJSYT5nhIh6o2z8If5huz5IxDBcuP9O
	T6X12gaFyQwBvoEzuPmaz/6Gzmakq/n7MrHDajdFuelISyGdSVpXYWhQOFdy9xjKmjLcT5Uhc9V
	rtMZC1I1Te89wGaxymXBE49ZlhbStDumm83TXGZyMv52p928tP1U3gc1RYrOB9IjPrQ9x9vaiAu
	l3beZuAql9UuFf1l44oWUPpI1gT2vpbrXl0I0ZjVozVQJtljvLaTU4uaV/mEpzDKiBMnYOWxpz4
	P7N08EuXwrQ+hh88H3l3dLm+Gu3ls40V7XnOih3kGBq0S+wyjGhoCzhsD5lcA+Rey312rOofxvo
	e1WoQ==
X-Received: by 2002:a05:6a21:e0a7:b0:38d:f6d7:963d with SMTP id adf61e73a8af0-393ad36bbe5mr16564490637.57.1770784065039;
        Tue, 10 Feb 2026 20:27:45 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9da655sm598657a91.6.2026.02.10.20.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 20:27:44 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>,
	"'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com> <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com> <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com> <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com> <3395ad0b-425e-40f5-844c-627cff471353@oracle.com> <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com> <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com> <005401dc9638$b3e2ea40$1ba8bec0$@telus.net> <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk> <29b3287e-0a08-4648-9e54-32889c99b1e3@arm.com> <ioyakugzog4uecwugy4b5ysxdimvh7qtosainou37rwp5bpoks@5csx6sn7ziso> <946c9ff1-a0cf-4faa-aeb9-405f89121b81@arm.com>
In-Reply-To: <946c9ff1-a0cf-4faa-aeb9-405f89121b81@arm.com>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Tue, 10 Feb 2026 20:27:47 -0800
Message-ID: <001f01dc9b0e$c6e89150$54b9b3f0$@telus.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIGJdMaf/4M855ptbp1U7uUSdSxOwCgaPhQAgSxF3QCdRKf4wD6zBBnAsuKJa4A5XOx7gIlm1O2AkVayRsCE2qbpgFyo9r5Adk03yy0jU4TIA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[telus.net:+];
	TAGGED_FROM(0.00)[bounces-215745-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBC4212134C
X-Rspamd-Action: no action

On 2026.02.10 00:57 Christian Loehle wrote:
> On 2/10/26 08:02, Sergey Senozhatsky wrote:
>> On (26/02/05 07:15), Christian Loehle wrote:
>> [..]
>>> @Doug given this is on Chromebooks base=84.5 and revert=59.5 doesn't necessarily mean
>>> 29.6% decrease in system performance in a traditional throughput sense.
>>> The "benchmark" might me measuring dropped frames, user input latency or what have you.
>>> Nonetheless @Sergey do feel free to expand.
>> 
>> I'm not on the performance team and I don't define those metrics, so
>> I can't really comment.  But frame drops during Google Docs scrolling,
>> for instance, or typing is a user visible regression, that people tend
>> to notice.
>
> Yeah I guess that was my point already, i.e. it isn't implausible that
> e.g. a frequency reduction from 2.2GHz to 2.0GHz (-10%) might result in
> double the number of dropped frames (= score reduction of 50%).
> Everything just an example but don't be thrown off by the 29.6% reduction in
> score and expect to go looking for -29.6% cpu frequency (like you would expect
> for many purely cpubound benchmarks).

Thanks for the inputs. Agreed.
In my defense, I was just attempting to extract whatever I could from
the very limited data we had.

... Doug



