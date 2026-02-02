Return-Path: <stable+bounces-213094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IILSIYXggGleCAMAu9opvQ
	(envelope-from <stable+bounces-213094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:36:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98329CFA6C
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAEEE30028F2
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79306385510;
	Mon,  2 Feb 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKHwVSpf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07294304BB8
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053760; cv=none; b=pkyQfKENgjwOo2ASmT8MJJuZHVi+giwCTCEQUcmzPtBu0DHFcRZier6aS2gFCMC3xDfU0f86sPxpdThgKX+zP5UXMmNyD4933q0bG/1h4jH7a9usACXdJbPOBVo/IYNJJoaOc7Tg5bDXkNTmJogqvZoGgWgEJFdmMe9Rwok4mOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053760; c=relaxed/simple;
	bh=mb25RumFzg5Dx/tWYIYWH4IWaYjutzcv4xNthKAATJ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=asnmnmM5DpntWOcBidREmJmRn1VDmd1ThD1ZIWaxnpA7pKvop28OfkNPca6TtRKPN7E0MUQwsTXhf2R/ygzUzGAS1RPOyQz4X7T7bnC39MKxj8UoGrtkNWuHM9aWqpCjb/1gsJZjwEqQCgc1GB4r9DWR+vcZEkqX+Or9VfZQopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKHwVSpf; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-948bb4fdf3eso231308241.3
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770053758; x=1770658558; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG/1PYAXWKIrgLyAGPIOCcgkQWDRD4EftEQ3/HZGKk0=;
        b=NKHwVSpfy9u1KTSFt3y0KkrIk8KcO85y5EIuELEd6lEtKO7xDlUDLrJYzVDHFNKO1W
         gsgUlHPqkZ5TEko5aax7evUAMzKu+xYhBqGjlEuVxS8fRcNhtJLgnJ6mbVJlnl2+/3Yh
         kOa5aTztKH/cTcj8vNeIt9/5lKSfr1ZTs46xT7XhuvHyePZQThcSy9cW4WLcYnsxSgw7
         pnnz8yggWYZCIbSpGZjoXtrnT7VCodvQySazVFeo2uWKIZwH5RmA5DICpmzCS/FU8lCW
         HqWQk8gJI7zXnS+DGApZ0jCSMdkoi9a7hydDJCd3IjwpvYVt5AVaFqKH8+zHIylmhdF8
         6GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053758; x=1770658558;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tG/1PYAXWKIrgLyAGPIOCcgkQWDRD4EftEQ3/HZGKk0=;
        b=WsUZHyPKY4imFgjqr4M3Nxrcv4jmfUvoNRRkPMZT3lproKs19TmfjvlVIio1hQOggx
         5AxqqCYpM39d5VqdRphM7T/Kz5YRET/MQKwvtecZLAg77LgsWV1MrnEufRcCzboou+o8
         RnORWflLIG0g8mZpKvQqUwbqptY+U9gKwhnpvz73+yKcXNTpNY8S7eSl4UIxHI+lJa+X
         Wvt534k+nOD2aCar2TryeKduErd7GJLpA5r1dW/VNWUvvQprzcrswZ3Tq0WTgBhLljLy
         3TWF/c2j55lXl5LNPVXa0NdXbHGzs9rLXPvRgiwR4ZgVeeMCq5XprYXmLUrL1ochT83M
         uQPw==
X-Forwarded-Encrypted: i=1; AJvYcCXjmS91FSpaAp/KB0TjS1cPtda6cUCIIXF0O5tkWPZsvrbiuvsb1w2q25rRebjkp04NAHlIyI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQHaD3UJwVbeWRCp1UNXOO/7+SnPyVE7+7hCb2y9iqzZV6fzL
	Ez3h3ThVET+/oP9EFg581f/rJ2LF3/AQbtygmrUhaYpwHKQL0yxniHe7
X-Gm-Gg: AZuq6aLoEp2+1EbXASf2+fyB4TS0GuqTojdWGF1CchweQ5tS/hghaWjoe/uR/pcF0Na
	4gHKGX5NMp2lErA01KgqHaOsyEJkM3xuDsA6tJ9sdZPRJtv1OpxZx/4uOZOPPz7n752Cd/J0rTU
	Am+SpPFdg4wA2TofR8LJo5fjFskKzL7uN1b/ci+ywl8zOMwNHxHBo1BrrFPERN718R+6mdTc9Kc
	sVgrTN5GHHzckR8TKoyOxl5jk8fcy6Cejlur+gUg2kO6RgaafH6HJZz8WRD1FJUKXP0faWd5Aam
	pWqGmimYOCr87lYpzNfgHyP7xGeGnD15Zd+DjEd3e96RdiSCoozAb4BpLfV6v+z8pli77OJoJT7
	sB4rIwMZ55wxoGbf4lSJ70/424qn/CwrDgpfwNTcsNrV8NCLAaYCA3HnpVNixbLIE9aE/2POK2W
	snnQ==
X-Received: by 2002:a05:6102:1611:b0:5f5:503e:c76d with SMTP id ada2fe7eead31-5f8e23760b2mr3398571137.4.1770053756470;
        Mon, 02 Feb 2026 09:35:56 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f734c8ed1esm4642256137.6.2026.02.02.09.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 12:35:49 -0500
Message-Id: <DG4NOQRW8MOE.25YALP6C6UTWZ@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Mario Limonciello" <mario.limonciello@amd.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Hans de Goede"
 <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Olexa Bilaniuk" <obilaniu@gmail.com>,
 <Dell.Client.Kernel@dell.com>
Subject: Re: [PATCH] platform/x86: dell-wmi: Add audio/mic mute key codes
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260201-mute-keys-v1-1-825e786732fc@gmail.com>
 <9bbeae98-279d-4b8f-bc52-f535851f497d@amd.com>
In-Reply-To: <9bbeae98-279d-4b8f-bc52-f535851f497d@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213094-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,dell.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,srcf.ucam.org,kernel.org,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuurtb@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98329CFA6C
X-Rspamd-Action: no action

On Mon Feb 2, 2026 at 9:17 AM -05, Mario Limonciello wrote:
> On 2/1/26 10:37 PM, Kurt Borja wrote:
>> Add audio/mic mute key codes found in some Alienware devices.
>>=20
>> Cc: stable@vger.kernel.org
>> Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
>> Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>   drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
>>   1 file changed, 3 insertions(+)
>
> Make sure that you include Dell.Client.Kernel@dell.com in case they have=
=20
> any comments.
>
> I added them to CC.

Hi Mario,

Thanks, I'll add it.

--=20
Thanks,
 ~ Kurt

