Return-Path: <stable+bounces-269996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7bEdMUveQ2rekgoAu9opvQ
	(envelope-from <stable+bounces-269996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 17:18:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3BE6E5DA3
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 17:18:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269996-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269996-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B20A43030E97
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4370234404E;
	Tue, 30 Jun 2026 15:18:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536853502A8
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:18:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832711; cv=none; b=NYHsNHDaTWE8HKPUmVSznhOlgjLYdJ3tMW4Nhi5bCq7mtyrJMXMGplD7kjTWmxedXA85CQWhydDFOCwRwDmxcpiupWQtgVDeVtXBqkcyTRkYZ5WBBVowWZGvJWWGls6n8wZlQfZp+tkbZc1D58Bwwms5G7EnSRA8mtvU/8q/4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832711; c=relaxed/simple;
	bh=N/Zi+rWJkX+vGnzQXQfq1XW3GIG775X83OLKitFptWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVYKHBkcHi2N6VT+9HQsa8AncDcmuz50MftADNIuAEIQDjs3OM9KVuliXnTf3owyQ/jbQqZEAbxau5AugHkqOPBL5qD1hJFhp6sIw0S8pcqUdS3oEJ69QxEj4RawD07DmlAtTMphsMARVV+kRUHBIj/H19bsPii3TetV0TRCkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c0868ca8738so735442866b.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832708; x=1783437508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/KBEaRwzQxEmv419xD4ZZ9bpbQPWDLZFF8bQ7NEZ/M=;
        b=nyDgTghmDQk2ChSMj5NJzLbkn+szJLbsCI9SqjcD1wYsCr0fgwRgyfRx1u5pxqQuPz
         w8E35uiCfsdVlIdRwUfyp6C7F4KhuMIaP88IAbN3eoEMBwXbs+51bOC312ctMPjpPSNF
         G5k958hBCfvqP82F5cidhWuum6WENF4zIERQMxSEhPbOtOqcb5waYOzrW5/vMohqPEiQ
         2uTIqRcsOuI3Loct6jo9aJyo3mfFv7TsyN4Ua5g3GQs2Uub+z2aBj7+HVQFjXslaB2/l
         +3YUd3uspzniYENG81t9PD/x/7Kf+eGIxC3jDgUW2o9muoWm21dINEgD3HegVMCq1vKg
         GIVw==
X-Forwarded-Encrypted: i=1; AHgh+RpleuzCXFA6/RBc7AVGxoaNdSmmachToU9rjpTcvMSBpg20Od6OAVdvl6fMQ9Bp7wdyEMro97E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/ViL/aLS9UlGVS9fIy7uqCJkPdQR/k21X7LcV+WUF17GL4TR
	6jDNzcXYUpY4Go63N+G8cOc0XK4ywv//IZty7sr3b224+4Wyvfm/nt88BwZDPkJ2lRA=
X-Gm-Gg: AfdE7cnuV3T9pU8lcfmtLJyAClU4DM6nwiuCfUlDRWqo1vcjsIKF6VyZMaGJam4Eh1J
	W0QFjfUYkayi/M5LHvShEIz23l5syTJItJvWlC6HxeAohcjkPaQ2axBJp+qFOhdRT2N06G+YDCr
	nrLUeoJw2MlaIGMpIdinPuDsX71duRXr1CDJBZMTt9VaBX1VEJRgUXgi7bH00YX7zF+ukYHU3I+
	D8B+QWoZPiVJVXH5kDeE8M5Xh7qtQBdK1kix3k3fShX2Bvh7mBah6w6p8K+8RuQZ9ueYbk1bv9b
	V8xTNLCd2TAX/uFluHAt5BWQZGNJ6p6IT973S0XdrdYAX3AzVPQ4mFlz6lnRgtGdfHEkoCYHhXg
	Mca3bS+C3sPNEELjNJ3znKFB/28iMiQGDRYCSP/YODufQLB0FdXEkYFak9uj5P4LtrffiakzXfr
	S1GGwdFrRR01R7bTEX8rZPojXnQURBYuEzve9uYPdBqRHX4NoWRw==
X-Received: by 2002:a17:906:4fd0:b0:c12:3e8e:2ac1 with SMTP id a640c23a62f3a-c12982ad2bcmr51898766b.51.1782832707556;
        Tue, 30 Jun 2026 08:18:27 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0cc2asm146367366b.33.2026.06.30.08.18.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:18:26 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697edb1bf6eso6765190a12.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:18:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoeYw7d7btzchjzjI3jQbDERKBh4tOCQAsOLOr2jylR6/gzeNW1xhz3ud4xi5r0eiJTVM4CYk8=@vger.kernel.org
X-Received: by 2002:a05:6402:4490:b0:698:48c4:361c with SMTP id
 4fb4d7f45d1cf-6988786091fmr817966a12.28.1782832706307; Tue, 30 Jun 2026
 08:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-panhandle-ashy-70c6abf84d59@spud>
In-Reply-To: <20260513-panhandle-ashy-70c6abf84d59@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 17:18:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXnkeantjtoMg+3unfP8ZSeG+7K+EGkn48=BEi_RWENwg@mail.gmail.com>
X-Gm-Features: AVVi8Cc1NkuZmAxV303oD2tKXfYtzTdOGchmD-0yx3VkueavnJtU938JZF73YgY
Message-ID: <CAMuHMdXnkeantjtoMg+3unfP8ZSeG+7K+EGkn48=BEi_RWENwg@mail.gmail.com>
Subject: Re: [PATCH v1] rtc: mpfs: fix counter upload completion condition
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
	stable@vger.kernel.org, Valentina.FernandezAlanis@microchip.com, 
	Daire McNamara <daire.mcnamara@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269996-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:linux-riscv@lists.infradead.org,m:conor.dooley@microchip.com,m:stable@vger.kernel.org,m:Valentina.FernandezAlanis@microchip.com,m:daire.mcnamara@microchip.com,m:alexandre.belloni@bootlin.com,m:linux-rtc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F3BE6E5DA3

Hi Conor,

On Wed, 13 May 2026 at 20:04, Conor Dooley <conor@kernel.org> wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The condition that needs to be checked for upload completion is the
> UPLOAD bit in the completion register going low. The original iterations
> of this driver used a do-while and this was converted to a
> read_poll_timeout() during upstreaming without the condition being
> inverted as it should have been.
>
> I suspect that this went unnoticed until now because a) the first read
> was done when the bit was still set, immediately completing the
> read_poll_timeout() and b) because the RTC doesn't hold time when power
> is removed from the SoC reducing its utility (I for one keep it
> disabled). If my first suspicion was true when the driver was
> upstreamed, it's not true any longer though, hence the detection of the
> problem.
>
> Fixes: 0b31d703598dc ("rtc: Add driver for Microchip PolarFire SoC")
> CC: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Thanks, this landed as commit 9792ff8afa9017fe ("rtc: mpfs: fix counter
upload completion condition") in v7.2-rc1, and finally the endless
stream of:

    mpfs_rtc 20124000.rtc: timed out uploading time to rtc

is gone!

And no, it didn't go unnoticed, at least not for me, but you couldn't
reproduce it reliably before:
https://lore.kernel.org/bce2ca405ef96b1363fd1370887409d9e8468422.1660659437.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

