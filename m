Return-Path: <stable+bounces-241447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFx5By3a72m/GwEAu9opvQ
	(envelope-from <stable+bounces-241447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 23:50:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C0B47AF1B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 23:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 153AC30036D3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F037CD50;
	Mon, 27 Apr 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LgA9DS71"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5A3845B7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326561; cv=none; b=aBT+0dXkZBP4Fv/Qz4cwdfYWpl19n0aw5XKmeN2oKadxp4CtBX/sqi8gMfVut/Y272+vE0yu0pJPhVQEn6cOp1FJwbEma/GFI+fmmq+hoGtTmAeWrOjd9uElLUFrAh3PU16hgzR+85RnIOlqhN42z+clsruJ6d8irT0BkHGSxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326561; c=relaxed/simple;
	bh=opXTbmDYqzBTDG3YhcZlvjGYATMyF2JGQEexbQQGiDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYebEraGUOeVLUX2cFXtK08+1uj3+MMdMDDzPeoAM+kxDzttcHkea9TdtqtPFHC6qOhbn7kGZ2kOVReKHjT5N3nhDyrjrx/WCeG9c8kTerro0Qo6LnpCgLYZAccbHO6EFe6Q0XfAlOvxI3Imwqh4E8PnX7Ipgg6DPaWiZFwAzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LgA9DS71; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so15420093a12.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777326557; x=1777931357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opXTbmDYqzBTDG3YhcZlvjGYATMyF2JGQEexbQQGiDA=;
        b=LgA9DS71X6qza2cnIU6ST+2uYcbzJ0KAWSxG2jE6Din5p7oJPn6vGpweHB4scA5Fyi
         Z9TmLwxbbdd/vxlF9poIQP42ug0FF2GTORR8IFETvUrLfB01+BlFrusm7ThbJMLcQ3JU
         ov4rxKx8ugf91nQG4l2G5iyOXbjpm/1r0qb+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326557; x=1777931357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opXTbmDYqzBTDG3YhcZlvjGYATMyF2JGQEexbQQGiDA=;
        b=JwxCKGu1a9tsdZlxNMCCEek2q14MWLnCM0LaBfaxV8BcwfTEkxIsRcXU7MKIbe//i/
         WJmcYpjlKGUPV4E4OzlQyJVApMXM0lqP3JHrTQc9w2ePMvifn/QQ7qghmznVfTPBBEka
         kcf2mYh3jfpoRH2EPFp/NkACKta4y/AVuv8cIXWY+FYt4MHY7FhwdosdN/KnSV6XSI7U
         fDWNGcPpCw5unAk4dOC8zRqVXNGJeM00m+KhqnrFoJJ1G4xxZuAjRTHiXZRwezsuD1pT
         7r5Li+bs9psAnYPZGOJAUQy9AvmP9J8B2xfRHlpCNXhiOQPskLbLa62W19OiaQrER+75
         RxSA==
X-Forwarded-Encrypted: i=1; AFNElJ/Agq6PkBNnJMvcg6xScALFNsPL4l4vp9/hxeKo9tr49WEf9UEIy3uVC7Lkq08UgJjcMgi48fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/U05yQ5jsiqAlAl8+LZ3nPzk9Y0WQP+/6GAaN8/dlCRL4ZLdA
	E6tZ+8Ca2LUWfdlSqEIYGqg+AoWwHlmdT/zOF2T7jlBL6cOVp4mpISPSqXuMxX/jo7A2AyghKm3
	jWVHC9ngb
X-Gm-Gg: AeBDiesryjctMvcsqGn/lOKR8Y592MEitutOXryDDGPHnfZW+AONRsBcxPYQzQ8z+DL
	YRgGMEOeiDRI/xs/6Dibnrci6I70M0RA72zqtDdNUnU00t5WSXmNxSCVB98zxQuvOPpPcsr47yc
	yeSwZownknWZJpZg22mYSjjl7ysLmyvDMQHm02LxE/FuhwJWaV8KwDaEVglELYE0CBD98v3vGMr
	M/eK4I5NiZk0joXycFL92IGDhvKPi5G2t3U0sKvkPyk3coU4qH3f0YuAoOi08iZIc5OlJovhj6f
	YJ0XLH3ryVKRZl5v+LMmrSPX5pdbHCMEpolNYHUiLvrZFuxpfu1r25Dc6g33nr7IxhHRHcsiaAq
	z+RAOMlgqzXZPdhHfrmJ4/N1/wrmUggUMcRAMjFLq/cP7K17IPAAOozOulS3Km8tcPgkPCROutx
	hEkiBjM7bwG8RjcCAHsnPDuthFa6yBkHUXlO09qDsyx9/5tPglkjRNcYFvaoeA4wU4DA20gIgZ
X-Received: by 2002:a17:906:fe02:b0:b9d:ed9a:5f30 with SMTP id a640c23a62f3a-bb804c267c8mr27054166b.48.1777326557178;
        Mon, 27 Apr 2026 14:49:17 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80bba0addsm9361766b.50.2026.04.27.14.49.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:49:16 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so9620135f8f.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 14:49:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9iJfhWt2BHIM5UTpVASSgJvIFCIJpIkItKnbm0nv2dIPKM7rBts/BMax8bEk9WtyeMFGPU6ow=@vger.kernel.org
X-Received: by 2002:a05:6000:2c01:b0:43d:773d:78ff with SMTP id
 ffacd0b85a97d-4464a1684bdmr820884f8f.27.1777326556029; Mon, 27 Apr 2026
 14:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026042714-catcher-manly-e588@gregkh>
In-Reply-To: <2026042714-catcher-manly-e588@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 27 Apr 2026 14:49:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XrdRQGGtvhZNj0N2W1FXhAAcQ0jwrjnd1G4YpYo0+1yg@mail.gmail.com>
X-Gm-Features: AVHnY4It-2rSkg1iiSNH7GR0MZ0lndpyfkIj1Q9v7xzLeXW89McFhVLE5n37KuI
Message-ID: <CAD=FV=XrdRQGGtvhZNj0N2W1FXhAAcQ0jwrjnd1G4YpYo0+1yg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] device property: Make modifications of
 fwnode "flags" thread" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, broonie@kernel.org, dakr@kernel.org, 
	rafael@kernel.org, saravanak@kernel.org, wsa+renesas@sang-engineering.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 85C0B47AF1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-241447-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim,gregkh:email,linuxfoundation.org:email]

Hi,

On Mon, Apr 27, 2026 at 9:40=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x f72e77c33e4b5657af35125e75bab249256030f3
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042714-=
catcher-manly-e588@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

OK, these should be sent out all the way down to 5.15. In each case, I
didn't boot test but did confirm that "allmodconfig" passes across a
number of architectures and also did code inspection.

If anyone happens to be reviewing, the 5.15 is the one that had the
most major changes when backporting since a lot of the code touching
these flags wasn't there yet or looked slightly different.

-Doug

