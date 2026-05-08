Return-Path: <stable+bounces-244659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JSZeHzdP/WnsaQAAu9opvQ
	(envelope-from <stable+bounces-244659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:49:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E594F0ED4
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD0A830316D0
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989E329CB57;
	Fri,  8 May 2026 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDIPWXri"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048052517AC
	for <stable@vger.kernel.org>; Fri,  8 May 2026 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208563; cv=pass; b=q633jFMdurDFbT5vPJzO4txcRy+06eIXgPxvSu5Ura2vZq6qHa4nJJPH49NtZ7x7pJLrgwgOhS8ZXvY8oqETgRL4Qru6R5HBc2nIP264q/oE3M5FbaF5ci2TLv4X4FCG7e+Hnlm+7bfr+onfcLHLfyGcBSJKxeqKGmFkwiWRuVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208563; c=relaxed/simple;
	bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdoOYQZTgkI5od0LlrPf/zUv/4IDZ0eQZpjyHjpoeVN4l4VikrGgmh5C/0FHuP8RA7RVu01hP4eUTanw4B7isRW/3AinCSXCXpOXvaW0r9dirEWa6Xj46ASNd1EGutDjI+M96Bn27ScWpPs61VaSbZmKvRH40rY1gpnC1MIERfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDIPWXri; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acaec91c6bso708386d6.2
        for <stable@vger.kernel.org>; Thu, 07 May 2026 19:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778208559; cv=none;
        d=google.com; s=arc-20240605;
        b=QuhNvnTTxy+8O0Er6TRWlm6yf1DwDM2/o21/ZgvUCyzeASzGXNrtSZrOZ2ybUTnE+u
         +l5a4GPk3RLCu5ZJSHPTqXqSyntotmW7zxbGZPlTF6u8UwntsxB8pxR3AJrzK/4hSZ04
         lJX6N8TFkxzIQF+TlpFq1OFpIn6rVLGghdymSBgPwfxI8ePZFCkwPY35f1ngWSBJsgKr
         icLOPQ2tvQEC1CB2wAczGWBD0zjzM5xIvOzmrYPnww3AtXLwcHg3imFBRCR7pn5PCHpN
         wVbNjGansledkm9a3oR1yBqxSWhDGmUXEUsBMkUkvL4YNmTyXDoHEiAxG733aBavrVxS
         vBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
        fh=gJkGxMH3T1+cNijfeamAmZ747FXaQuTJkDZSAclti+s=;
        b=VXSryLad/MLa9aokbTuOJCaG7bV9Ij86Z2lqpRa7ZEGSq1benTKfMC3KJTnu6Ej9fo
         gos6+2yIge7X18+smdW76cDqUt1q7D0YLzwuS3hVGcankUfJJE4kp6fEjYKRtKTF3dnb
         qzNcaIbQZedbYyP2sWp/OV0Wfbc13tLlwrKNTRxSxCkMU7pjuQJZ797aT6f4+3aHnRbR
         TwjhAavSHHbEU0xMB2Q2goq5uCH7b4NJsIClL8mxCBQ9us+k7QiLXm7jqx2711s6CcuP
         us0KGeFy1gJSL4zp0XnP5vxNmlA68yq+ActBbngGKPbo4LrKXnsyEx6impeyTBa5iAH/
         XKcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778208559; x=1778813359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
        b=YDIPWXriG5BzJ7Qs+RDR3hpC3vGMiQoVNZupWRSm1RIMM090/b/mXE+9YeASWD0KC0
         M64hjX0TpSCkf54hRp3mWqcQaJkGUkLqrBEfxwan8Ao/dWNI/fEEYnMK4vU4NiMfzMzs
         HpmaO99kk4pv1vVBqm9diAuZFhmIpEKCR/fuh+gp3WonJe8C2BDHVwPGaUg1WO6kPpse
         M6s0ai0AoJlx8RdrGd34ZWrxqadb/hx+Ju6vtM3KTgRM4S30c5PONsq5iiQx0fxKmXYi
         IEzh5MKuzsp6NrRNUsHM29lLsvqUnj2tPbQqYlzKZch4V+6m+i+hWpIebMG0nDqv07mA
         mN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778208559; x=1778813359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7N4yyfJb/a6KstxZcHf9OEwA9PiX53CJe03YotniMU=;
        b=nMS9IGyhaXxkmkQIADI6KaHoVHvbr+SOLHEnUB/fnt8PhdMiP6MIpKrJAwDMR1bjVg
         nti6G8huM5zJznCQH9rhXUIxtMVV/ctoVbFh6kJtzDkVAhnv2Opx2izBniAqCrKPqYib
         AeOYv1QWbWX4ZuFOnysBscrTXLQkKAafKumlsLLlDAD4ZZGNhKF6ZaoimhXks+gp8sEE
         3CS6unDQ+lvNIMsg8gKJA6ZbvjB+lm11iYs17gKy35kFB2OSBa2l3HJ4bLhdH7mPaJtJ
         swSjrIxXuSA3BK3aqCel423ueCMPR+vX+cduHYAFkbR2Fy7/6wVkoxuf2MDgiEYcgml4
         /sIw==
X-Forwarded-Encrypted: i=1; AFNElJ+LBCKoxJ7/08PGvgowPNJdK1oGG9OS/O4ji+JZkBJldpIYiB+0AVndM2d/PWC7XXfga7KLHac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Ist8biBZF8o/o6WpBiIePtyITMeVHta2IkPJPECFU2ZS2rp+
	fxf/vj/h8gPCeBkpKgTRrPiLHBKVrDupSDf0JmQMbEjFaMe9IcYBUo/Q9WFFoIIsLw6S7gmvoIG
	iyohomBDpUwC8alJcdi0bgJrhoxl4V3w=
X-Gm-Gg: Acq92OGR1SCmfXnl8bwkV3JLDld/SjqB1y/gjqFBUkpRpLCud3e0b/UFunQ2JI/Pd1u
	ZUnydAzgiJ2l2QSKO6JwadH96c4FOJOuKyoi5Pi0XmgxqTqbiCDfdB9+hEy/wgtEpylFwqM4VJb
	N78IcH2W+8eT6MKbvQV0SNxX1D6+TQF9pPit0KFIW2DFZfMtFwzV0BtuiqBFLK0SKL4TpvM+i8E
	M2hfhOTKwI5JQNfJfqObTcZ6tEkbaYCEvoGx89HzF9JjMH0U4j+EUyIuPAs+oOBBd68xMIVaL3e
	HqK0xbO/vi5YAdRMQfTS4JdkMl+d+EEv1TUmuM96k8/YBBfz8PsYKI7t3F5J1eltBZQSWBcW1aL
	rCt2jmQc=
X-Received: by 2002:a05:6214:19c5:b0:8ac:a205:f118 with SMTP id
 6a1803df08f44-8bc462028c9mr117592396d6.8.1778208559255; Thu, 07 May 2026
 19:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507233748.327004-1-aaron1esau@gmail.com> <af1K4d8cxGOvlJxY@gondor.apana.org.au>
In-Reply-To: <af1K4d8cxGOvlJxY@gondor.apana.org.au>
From: Aaron Esau <aaron1esau@gmail.com>
Date: Thu, 7 May 2026 21:49:08 -0500
X-Gm-Features: AVHnY4LhR7RMGGpnWHlWBULBtuXHcvG_1OCmZcim96NpoSF4yVzYSeKu9cq309g
Message-ID: <CADucPGTSNG3m=v9HuyZ=qr_-Qycccc9jjKU5K7O3LrHdEXgRaA@mail.gmail.com>
Subject: Re: [PATCH] crypto: acomp - fix dst-folio branch setting src instead
 of dst in acomp_virt_to_sg
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 15E594F0ED4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244659-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Herbert,

The patch was generated against v6.15-rc6 (82f2b0b97). The buggy line
is at crypto/acompress.c:240 in that tag, and the index hash
f7a3fbe54 matched (I just checked again).

Could you double-check?

Thanks,
Aaron

