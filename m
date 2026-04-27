Return-Path: <stable+bounces-241259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIqnDusY72nO6QAAu9opvQ
	(envelope-from <stable+bounces-241259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:06:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441346EBAC
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 10:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA354302633C
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9F370D7B;
	Mon, 27 Apr 2026 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPaV857G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C913390C95
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277096; cv=none; b=sTznFy8GwO98kNBwHBAOLIkj3ok4CKnE0ZG/ZuKsORL7+YF+0iEOY/wEzxwbXOW2Cz1X9WesWtFm1iOQ/J0s83pNZmRCF2rjjqhaThrDlB3xNU763pHLrtlRt0kC3jD62tbErdmy4oLgvPDIx/kmdX/BVibrYT8F9O2rUUuxzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277096; c=relaxed/simple;
	bh=SoxWavg3tcenitwxVVzTqO3PbXn4Mwo01h1KGO0OEAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+fCX6k1O1AKIUjHdirwLNC7mabt503eLYcl2QZNdlafgKHZAw3LS0eroQtEYvvOiZqT5el+awRZSEfwJewQJThUh6SoCYUBf3HRUaWA/irOPCuCwty8feRWGuuc1vKxD7pdUxjd7omgZoR1y//wKrdAbtQ/gVSztpxLagApN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPaV857G; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d75312379so7091571f8f.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777277089; x=1777881889; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SoxWavg3tcenitwxVVzTqO3PbXn4Mwo01h1KGO0OEAo=;
        b=BPaV857GOX4dUxNzH4STD67wWSPT1s3W7LvUvZ4FVAMTOwWVh07gBqNHpM4Jks/pis
         olZXVj7x+gQFxNvO/3ON6tFEk3wf+Du9AzHlAcTh5jYbvzfEoGAeRyrM/beQaQ/7WJye
         UWaftpNPpSTXvJO8LnDDF2oChB6HaYqLM7UIo1imhSL9Ymx1BGO7qPnsNAFJXZN5sxgp
         CUqpJbqCODFC9Fl3yMFm11f2FsbmZ0a+em6SmRGhX35cRG7dMxXgmtTXuo8US7B9hPF3
         QCp12JayMS+xJDDR7XECgFb1A5Qx5oKEXlMLKR1pX6OH0qxa7u7/JTpmXDpFTX0GbwgR
         QAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277089; x=1777881889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoxWavg3tcenitwxVVzTqO3PbXn4Mwo01h1KGO0OEAo=;
        b=gDHhwcf6kLeC/2Ts4xQ7lnQTHl5VRCcnoeOen+Fz+IIP/sauLoBV8VqYjJi1fgj1dZ
         tSoIZuWLwhr0qkvkrYdUKuuKSLG7cSCgIxm2/ksm9lHovopMLpoARmDCMZ8a1ejY/Tks
         Kks4blsKJyrICPuCyiwFdNS4kLDHt1I2OUyJdgW717HqD9NpnDBln5YQD2ExSbq7MneU
         tLpuP4rnugzCcwd1DJPp4Zy05sWQ6JRCLLcgkzJ0ZU0KwMgMDGtaDKzTigvTRU8j48Rz
         U6TxsZVx3krg0Q2SH8uymt9rB8j5y6rIn1+kSPUiaThH5XSGKK3pat0bBoZ2mmgW2ww0
         U5ow==
X-Forwarded-Encrypted: i=1; AFNElJ89XkwE6wzQdkbHa+RmtWWqpplrUH6O4OvazrN0mTS112OxvmnV5Sk4iyT+9juBh/+BKQL2rjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Y68shvhXNK56ZKVlhb87EX2JRbQMAJMunxqBpzxZQLpdDTiT
	JGWHxhD6M3xknisUyZpZGwn0TBR9pAi5Jrp6SsZR98+damQitFG0jRhM
X-Gm-Gg: AeBDiev0+RNb8IF3pqb55NZ/w6BcZh+SGfon7MLinsgVj+0+ouzv+MR/Noqauqu4iDA
	xUH54S+yTI60Rs/e7BMUGRbuTPUrzXN1m+dPWUCJxmePE/k4uUFXscVuq07OKHamktWB3AL825I
	U6IzDj5pFpu8Miwjb/JYGs3tZ7KodJEZde4+/S9ndgQjnqKq34Umn0vASJbbWCbMEXurCaNLzZf
	WxmI8cJ+WRcFTliAVEX/qoWFmLp3QsNyJ6tsdrUyGMXxiN46c7p9SulbmVJERYxzoELltEqI6XM
	NcUMbhhlbdWL1ZgxCqKJ8VT4JAVhK86K4rv6IDaRSaud3kOAQ9YHlTRc1XRbUtJA3rlva/hpUbv
	FPxVZGEnq2vnXTIOrmAG90CzfGaNFRGMp2tMdCc5s/hAEj6IO21G/kDffRSYMOrF1U1wQ+ozJPO
	V/1qdAvSO/9wSpbdYctvL+bmsqzPPgE3DVsQpneJsIOFcNrTa1eVYpAbom
X-Received: by 2002:a05:6000:24c3:b0:43e:aa88:f1a8 with SMTP id ffacd0b85a97d-43fe4034446mr65155902f8f.6.1777277089022;
        Mon, 27 Apr 2026 01:04:49 -0700 (PDT)
Received: from vitor-nb.Home (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412e36ff8bsm29867065f8f.26.2026.04.27.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 01:04:48 -0700 (PDT)
Message-ID: <0e84e6534384707cc0e60c70b0b52615789e3df9.camel@gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: re-sync TIFS with genpd on resume
From: Vitor Soares <ivitro@gmail.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, stable@vger.kernel.org
Date: Mon, 27 Apr 2026 09:04:47 +0100
In-Reply-To: <20260427064939.3240057-2-ivitro@gmail.com>
References: <20260427064939.3240057-2-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8441346EBAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241259-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toradex.com:email]

On Mon, 2026-04-27 at 07:49 +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> When a device in a TI SCI power domain is on the wakeup path of a
> wakeup-capable child, the suspend path skips genpd_sync_power_off().
> No put_device is sent to TIFS and the domain's genpd status remains
> ON.
>=20
> TIFS powers off the hardware during deep sleep regardless, since it
> was never informed to keep the domain active. On resume, because the
> domain's genpd status is ON, no get_device is issued. The driver
> then accesses registers of a powered-off domain, causing a
> synchronous external abort (AXI bus error, ESR 0x96000010).
>=20
> Commit 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according
> to the HW state") exposed this. Before, domain status was initialized
> to OFF, so get_device was always issued on resume.
>=20
> Add a .resume hook that queries the domain's state from TIFS and
> re-syncs TIFS with get_device when genpd has it ON but TIFS has it
> OFF. The hook is only registered when the is_on op is available,
> since detection depends on it.
>=20
> Move ti_sci_pm_pd_is_on() earlier in the file so it is available to
> the resume hook.
>=20
> Fixes: 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according to =
the
> HW state")
> Cc: stable@vger.kernel.org=C2=A0# 6.18+
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Please ignore this patch, I sent the wrong branch by mistake.

The correct version is at:
https://lore.kernel.org/all/20260427074808.3244226-2-ivitro@gmail.com/

Sorry for the noise.

Thanks,
Vitor

