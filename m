Return-Path: <stable+bounces-233730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TTLoB/On1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 02:57:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D03B5C8F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 02:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9377302978B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3DC2EE5FD;
	Wed,  8 Apr 2026 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDAV2IZV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B41A9F86
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609837; cv=none; b=iKI8DE+8ZR4e9v8pqHPZUV/jkvDfjW3yREGWp1uOJqtwjM+602spbqQcgf0uOkq+P48KcKCC8g9adJIziQZ0yQNPvnDbRx/qKXyJHql1gSorymnWO11E8wdpxacL2iNHMxMbLazmS2KJM4UF79JxknEBLTWvxaP1Nlm24kJcRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609837; c=relaxed/simple;
	bh=uQ+TqNYjj2ban4Movr6XJaLpqd31n9r91xO2kWZIp3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn0wJk+S58yMnhfpOBUfrso0KkP16btDwBp3z2uBGDjmt961aVfcPAJUVD7z8TDEEvvwO14lC6bECtXz3J/V9gMOv8ftMAbpmBi79jgEASNRTvv2bf9RxKPA7C4jHI7FBEUZxULYNFSA5QpzSyrYNtvKYE8Ka/+h+/fAY+68v1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oDAV2IZV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so963580466b.2
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775609833; x=1776214633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5rKSGvB1K6ewC2r9WIdW9NSO9RKEsD8le46kZJPi4I=;
        b=oDAV2IZVvRETA1xCp/hBnuB/YjSFHEQ/4xp99TheqtOROj9hwdZmwlh/zQmfyKYN+2
         1zUXlcSppDAt8pboqm53TtySTM00RPcDb2LZ4RzwVVoF5cKaV1/8SaomaTOqL/KapMER
         nGqWZxj3BBNzEAIW01pN6P5qmwpkGey8km4Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609833; x=1776214633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5rKSGvB1K6ewC2r9WIdW9NSO9RKEsD8le46kZJPi4I=;
        b=R3MuMt1jOpSNwOvmbKgCxGlcb2Eo/FMBgwZQJNoHk8N9fg7/maQNq3LmSkMxivte9N
         ews912WevKUv5TsRmnvPA1xy4YbMMnSF8S9Eqel4T6LTwF7pGBcMfDn156yZXKw/dJQ9
         RQKAW+A4oCSPHC1N+AlrgigPdOfQEfjDEe0tRUjkM1G5gOJQ97FxwpV3PK4fiX273WBw
         twnNCDjmfRGgOD7UXDuCvWV72QFvCWdSKPHbK1Gnl/n2Bh3RG2bqk6s5+/H1/Vt9Syhq
         UfogbGlZDAQFY6dL7plgFNg9TZmI8Aq081sryKvjLDXbwfc1KT5zM1WSgAr73b68WsJO
         JSDA==
X-Forwarded-Encrypted: i=1; AJvYcCUDSRvfRHBEt8rbmWkR6eHMgKCk4FKuwGdbcMymDy+zS/a1bTho40N55tgKohtKX47VGKbUPlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FM0cu42SKb4d2GwuQFcGzhxVh3zf8MYc9OUGwXc2SWyTcgPG
	jrGZmkr7n4sO6dgC4WpRpyMzHQwavIkFmDpaMNDOL4DY70yoWtZCS+7kzIgCup+TouPNtO6+z3S
	89+QDZw==
X-Gm-Gg: AeBDiesnC9smLyVH1aXexUOLLMVqCVVTCg95TTCeI88kaxfWymLLRTiMIehsKQXNWta
	wEll/LwKAaMmepD/G7ZZSm3i9BZrg7Vfio7Gay1MC8T4Zwx7Zh+5J4fPk9KvJX5KRnEIszfDLZw
	dJAp4T6ovv8Qi85hyb+YulGbQCW9EqcgjdFJGCnyRz05Fn0x/+Hakf5mFThqy1M/Ze29Nex1No4
	73jFbh3Jm5XTOLwn8Ovkogic2+WLYh1vQRTphLCf3YQQrC1+5JOOiK34f4TPcaszgTude9/sYo0
	1w7ouOHTjZ0qsn2kvjgJyHuwwh0th8Lx6YGKTCWsb72kivTEGEeikPzIfybpwrF7/WA3rzU5HrB
	MpFGFOkcAAVfDi0AljBnPLnROtoX79jF9jZGDLH5326hZclvb3E60FHTIB/wXGruym8/1mTDAYH
	Heh5P36yfTxRs+85M8uDVwPylBnGnp8hIeGM5VogdculnSnc2HadLrZutk+H+WsnKG9ci8KhoT
X-Received: by 2002:a17:907:a08:b0:b9c:5e58:7519 with SMTP id a640c23a62f3a-b9c67b5b311mr963250066b.47.1775609833267;
        Tue, 07 Apr 2026 17:57:13 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c9721c1sm624277166b.2.2026.04.07.17.57.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 17:57:12 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso3146420f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 17:57:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOt0yeLFJTNlRvIOWos/2ww1b/WLHQ1u5HaZJgcgYercs6jtD2RhV7ueXZ/OT4FVYDo+hYzDk=@vger.kernel.org
X-Received: by 2002:a05:6000:2313:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-43d2927bb89mr29559130f8f.11.1775609831471; Tue, 07 Apr 2026
 17:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407094156.2573027-1-johan@kernel.org> <20260407094156.2573027-2-johan@kernel.org>
In-Reply-To: <20260407094156.2573027-2-johan@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 Apr 2026 17:57:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsEiiquBWw8L0gy=k0PU7xoOyt=a-M3vcxQVXxvEG8QQ@mail.gmail.com>
X-Gm-Features: AQROBzBXrBbAeDSB0FEg_1dkY8fMsRTca5YG8qs3X6UgJfcvCwYltBxA4OxkBto
Message-ID: <CAD=FV=VsEiiquBWw8L0gy=k0PU7xoOyt=a-M3vcxQVXxvEG8QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: bq257xx: fix OF node reference imbalance
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233730-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,hotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 787D03B5C8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Apr 7, 2026 at 2:42=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
>
> Fix this by using the intended helper for reusing OF nodes.
>
> Fixes: 981dd162b635 ("regulator: bq257xx: Add bq257xx boost regulator dri=
ver")
> Cc: stable@vger.kernel.org      # 6.18
> Cc: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/regulator/bq257xx-regulator.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

