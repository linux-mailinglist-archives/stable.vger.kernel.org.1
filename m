Return-Path: <stable+bounces-215740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGpgC/QCjGnIegAAu9opvQ
	(envelope-from <stable+bounces-215740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:17:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A09B121244
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7D25300E68A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B421134A78F;
	Wed, 11 Feb 2026 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="LxmY+naO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5ED226CFE
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783469; cv=none; b=FXBZrsxwceJOmJ2iPrbRIxHc+zQOlGfSd4FjOTMt/6tZT9FyHkOCbLv4dDwWJB9Z8yRxu1EHCL0++x0RmlHN8i7NjxM1ctHxbvJBAUWFGJzN6TEo4ylABznec3oLaH5/W6loUP59Rv+sF+49HJZLFk4Dy2fNs2XlDHEDEszuBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783469; c=relaxed/simple;
	bh=PuQCat+yNbRiDGeWvgI2+IxsXXUEUakR8EKgqsPeSoI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZrrj97wkqXcgsoO8CZx7K3uNQTa2osTBVnKmfqQoPTIYDA01FtrTIVXkVTjNetjvXlZG5sBWophuF2vKr/4E2K9YBz4BdcVsUSjGsp9Eozr3IwRPiHTth4lAbuALmnR1+SmPCoao0dTBMv77QstiCGNoXZogR2QS7+TK4Vofyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=LxmY+naO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a79998d35aso45573925ad.0
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 20:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1770783468; x=1771388268; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuQCat+yNbRiDGeWvgI2+IxsXXUEUakR8EKgqsPeSoI=;
        b=LxmY+naODDsqe3gZkoy6WgalBWdrLtIBKctoXdB5brqatA333/y/v/kSoSV2fSqTCN
         MGRE1in2TtYct37VelpaGGbq6tzL5/SVTRzKZvIsREOu033soq6HvyCS4r2Uwu/RpgLV
         S4Uquu8E8huXXoI0ZO5aoUaFTR0aqqRe7EpqoLZrcGc440u6WGDcahp2HZ/gp19M44mo
         ccl2WcsKeT2WoEmBj+MtdNub7tz+0QvYOi1FvzGNE14xK936TBX5roJ8VtKVkkbb8xfB
         sSDOBdXI150g8Xxh5SI73zfBPJSqB3TCoMTgsRq5TOgPmjgH6j6Iiszo3/O0Fci1P0S/
         a0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783468; x=1771388268;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuQCat+yNbRiDGeWvgI2+IxsXXUEUakR8EKgqsPeSoI=;
        b=a9xy0wUTDWo7+1umz7MsuydrXRPzzQMhWnPqZkXf3E6kdzN3SGYx5pjuX4fGsXzOMV
         da79C+fYiec064t6QKPSskyps/f8WyWIwmYTguUy5RZuB2qlXEHYWCdxW+PZOCd1SwTJ
         j7NxeX3OZrJdhxnIsTUDxa40fIEjY1Eten+6ZJdy7mDhRc+fGJQkn4MhAh6D2mhra4E5
         qpZur54jMXxHQIYz7hEaFAjV9aIVVpQwGGBoOIT8kopnxS405fd8v8jE3DaEoR4nXWQ6
         76HDyTow61+bY1KVlfmWlMWKYvXI17vDrAbA0AOgQFXoJUFtk5IfqITYurGr51Ohvt3V
         JoSg==
X-Forwarded-Encrypted: i=1; AJvYcCV4cHuRX02+LUK8TYtuCJHNA70TL95eHsR9g+hnsgP8NmgaBZ78vowfhs9/op8AN4xkWnTzDYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyosepdGLPAf5+TS7Huxk9z32L6Otsay3LL8cjFcpVkxDBwlrHa
	lIpAIQGlJ/HsFoOTIy62hnXPQqzjeIuM5RDLDv0pSzp/9N6rGVjTEWo+zb9KPO/N7Zg=
X-Gm-Gg: AZuq6aKbaeKZsfdfZE92mo//F8lfdiHbHIdVNc0MfETbTLSRW5XZpF80l6nTCjfR5MV
	W6gEVIrEPOvpERNnm8K6ZeBxde4iAtI/1sytTszxWAN3qfgUTMjjB7ZF+ivIfVW0MA3+QOyVFV0
	kGzfM04Rfu66kRooRvM7kIAA3EieeR1FYFJAIusimCUVhxsB1iFufzjmIPotfMF3rAYORvGReRj
	IC07mnrllu1UcrxhvMXs3U12RvWyWSxVcG43JyizV9OGgWoQmBU3OvTGBoRJE1DszOZ95/juaL8
	gy517YkcXyDqYv89PUb3kZDxP+/zf3mJVFG9RibfUEq1Wx6cEIhhR0xAF06Zdo4DGuY5wKo6e0F
	BNaNt2P1D49N0CRHeYxNYkrFVKbUTVwIxPcKDlMAlVJ3qwSez5JBIDLx2f7CB+K7iDXNhSw9ZWM
	HfG+Yez+cNbV0HuRKx67sRe467fHi7FQvWANuXVr8U/b5z9W3+/MnoNnh/w4+/Th/SZ/Y=
X-Received: by 2002:a17:902:ce82:b0:297:cf96:45bd with SMTP id d9443c01a7336-2ab29cb9cb4mr9608735ad.19.1770783467792;
        Tue, 10 Feb 2026 20:17:47 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986edecsm6410425ad.22.2026.02.10.20.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 20:17:47 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Xueqin Luo'" <luoxueqin@kylinos.cn>,
	<christian.loehle@arm.com>,
	<daniel.lezcano@linaro.org>,
	<gregkh@linuxfoundation.org>,
	<harshvardhan.j.jha@oracle.com>,
	<linux-pm@vger.kernel.org>,
	<sashal@kernel.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <006601dc965c$afe30280$0fa90780$@telus.net> <20260210093321.71876-1-luoxueqin@kylinos.cn> <67clm4sqv5cbqxjhjoyn4eodwocc2jm6piwky6cyv4zncfrp7p@izdkjc5db37j> <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com> <ba2bwuhcua2zakojk2wcksyxol76o7lmmceaunls4436gqh4ry@ys3mpganxhwy>
In-Reply-To: <ba2bwuhcua2zakojk2wcksyxol76o7lmmceaunls4436gqh4ry@ys3mpganxhwy>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Tue, 10 Feb 2026 20:17:50 -0800
Message-ID: <001b01dc9b0d$62e27280$28a75780$@telus.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHR7wO/JX5ylMBngEY9dRbzh1sTOQJs4mJRAbvJU1kA/AGrfADxq7xetWGIViA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[telus.net:+];
	TAGGED_FROM(0.00)[bounces-215740-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A09B121244
X-Rspamd-Action: no action

On 2026.02.10 17:34 Sergey Senozhatsky wrote:
> On (26/02/10 15:24), Rafael J. Wysocki wrote:
>> On Tue, Feb 10, 2026 at 11:04=E2=80=AFAM Sergey Senozhatsky wrote:
>>> On (26/02/10 17:33), Xueqin Luo wrote:
>>>>
>>>> In addition to the cpuidle statistics, measured system idle power =
is
>>>> about 2W higher when this commit is applied.
>>>>
>>>
>>> We also noticed shorted battery life on some of the affected =
laptops.
>>=20
>> Was the difference significant?
>
> I think I saw up to "5.16% regression in perf.minutes_battery_life"

Note: I get a fair bit of noise on my idle tests of recent.

For what it's worth: On my test computer I got:

kernel 6.19-rc8 and with reapply.

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.

CPU frequency scaling driver: intel_pstate.
CPU frequency scaling governor: powersave.
HWP: enabled.
idle governor menu.

Git Branch "doug"

3856f38e5bb9 (HEAD -> doug) Reapply "cpuidle: menu: Avoid discarding =
useful information"
18f7fcd5e69a (tag: v6.19-rc8) Linux 6.19-rc8

Processor Package Power:

average reapply: 140 minutes: 1.783028571
average rc8: 512 minutes: 1.656212891
7.65% more power



