Return-Path: <stable+bounces-227584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BliBCSBvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:17:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D802DE710
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 057943001FF9
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CA3CF037;
	Fri, 20 Mar 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocitt93n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FB3A5425
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027040; cv=pass; b=Ko2I0mrSy+S4f9x7sqOp3hHQh8tloV3JRrB05n5957vDQIjBCWC2boroYdHtYmKrDqnP/aTBFkAOI64f8RJ1wohzlxGPaDdc270U/sY7Wu5k9MG+mQaNya+4BnEkvYLXkg6jqykSOBcIAFoF/hJ1LToaVB27q570diG/GEb77jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027040; c=relaxed/simple;
	bh=iNhZ2wMLyGc08p9SXAlItmThExJu1Q8bjF+bH96yuFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqgwibQfiC7Gk/U4yAYgODBMY4yHuXXpxYgwM9jA5bBrYP3yre4c5U4OmQ9qLjV58ay4jc2zW+kL9vwnc50cdT/rtsj5qerW9rI81IhSiF9VOSnXXzC4M70u/5+xmHKM22LrMEqcJV6VPmour8Dkqa0OjyOn0FchWCpDZpxkBIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocitt93n; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso7049785e9.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 10:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027038; cv=none;
        d=google.com; s=arc-20240605;
        b=EJP+8qZSTvxOmdSfQONtE9UV9WFgbrCdyez28QASR3qXrtLdPVkAuN70s7FyrY0f2E
         pK7d6ySjq1NCkxNSAy1Lw8TuFFKskLiHeRz2aDUqQOCQeAE2ad38OCXCbtV7302yrDPD
         67CZq2EVKPTE6T8pLAad+uF9ILvMzV3q9AGJFY1TROoUvas4G+7RDDytZrXuOb+LxC7A
         gPS+56VbHFPFlq+BBlgsKpxsT3fm7ouOw6cIYJQ3/9cdPO97XIh/DBGr4yJ0rQxR8eAh
         sziLD8hczPyyeu0wvuGkOY20HaRaaz1DXV6YkajOGmw0U2rvfD9e1LCH8uB2Cq+dHYZr
         rdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QhFtNfGXo+sAGRLOrajRrqZfKQSgiwD114zY0m+OvzU=;
        fh=Wt7z/AfZpiJci+xZ9Sh+nxqm4ZO1eoTn41SJyVafSRE=;
        b=kWPGrpDXnDKr6B1vUPp1N/jUFyZcnDRx6p5k2cU+GwWe2jcHlxMlDX9lbdM6Yb4BHQ
         C7mu+aYn0BYlpYKncoxuxClCypJnT4Sz0iF1U0UOQRfDD1efkunF7jkI+9tR02Q1hZ8F
         OykSUbhwEi7kJQ/6OUcETUBPao/sc7hckN952Yznq5T7asWaovpIbjS7bbX0vIkRby6K
         OcoKzTeKuT0rHE9vfz0w67h8vOrhv3H1rBCQzafXYrUnDMcnJ1bKNyTCuD0dpq8Fv4rN
         p8Dosm8IQGPXJ+Z1BeG6dRoQac2IeeFO4/DXRlY5j1gYg3hp+dTBjQ5d7FDp+D8Ap1eV
         7pcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027038; x=1774631838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhFtNfGXo+sAGRLOrajRrqZfKQSgiwD114zY0m+OvzU=;
        b=Ocitt93nTekwtDlqSu9wGP7rLIndoAGKkmWfTlOFMTHPGG45iJv52WPscJc56gggMY
         z67W2IXR0E5sM3BI+WBhqawHnAc0BeQ8fxx7jGmDv+5RVWbmVj/Zi2aGGhumlRqPRWIp
         4vJpn/u7lcmmlUZX3UBC/B8sIdBia3VCRCtrjsEdPNqgBarletLb6ApclowK26mhspnM
         xEZi1fPQSStcbrY4NkFtmlj24IiT6mbQ4a+54d9gEKnhXCnJk5QCNHe8tRly+Drvyl46
         f9pXLS8me+QoMhbxBxp3DcHGSNnah6/dJdOgM9V6ogvQWaW04QzapuCbtw1GsC593nMB
         DxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027038; x=1774631838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhFtNfGXo+sAGRLOrajRrqZfKQSgiwD114zY0m+OvzU=;
        b=Cp6y2srMEBft7CTphDHmyLOkaTadCnuFgo7JmpY86RlgdX9UXCFZQgYwhgu1UZFyQe
         /Ku7bTWTKWc3F50TdQ3yz3CZNFWMRaRMwhFO9rXnNPamEm5PQez/+Awj2Rn6+VWp1T2r
         xGrsMdqjsFh9BMY90eRT9TEfCKVz9oygZ+fGXHSliFDUJw63PyzB6BAGJY3CTupDXhFR
         oXFvqsWrCgQOe+HAlXaxplVbDB8GFCTtPahWqwgbXyhC2Njbf5SyN5C1kqf+heRVFfPd
         pdCqrXMLSLzjH6IH3A8gPpd7zwWqbyGH+C+ofowAjHTFBu3RHaH63VrRVfqITqQc0h6g
         VxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHu0hfBcvjHdhYG1+37dMVnwBEvz9ODAYLxuvZo66MCzUyzbKb8e1u0x6C1rB+4Z8mSYL2kQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvv53BF08/P6bmD9tQ7pY0mBAQEHaX7BO4VdCDVu3eKn7mMSw
	PY1uh50FsqkCqOjTQucNLczb8UxTARK4H5WGZ+icur9Eo6fQ13E8BRnZBlwH0OtZNqI0sDjBQra
	P9kRYnQ6szW4fDnmahxXqZ0MilrlSnfE=
X-Gm-Gg: ATEYQzxeYf8fh1YGaL62DOAf692wh2Y9W6Ce0ZplnOFLloe7CYhuz+WBnxsWB0FD3Ol
	Wdfuqnty0UrQAJNjkGMthUYVprjL7cmMQi+jnA5jQ1S7/aU3YVmZ3LA2NTJsk4+wxCMwgQU3qDv
	JEwXykK504nuviIBm2tfFUTRSf8qGpmwhOZxGnlTiGx/O40NP2ZAp7IPSLcv6iSv23qhB2FVaPF
	f6LrEDPyb0yk/JoWkqegsw4eNC99sewrlKTkXlNBWSQQcq9/e5fKhE6mWvsvw/nkpn0OwJguHCh
	7dZl9GqurV9Q5PCUS36vydmEMJoMF6iXvRzICaKlY/44eWYlFA0fe9DrNPGMksaW1HMeTw==
X-Received: by 2002:a05:600c:8583:b0:485:3f1c:d8a1 with SMTP id
 5b1f17b1804b1-486fedb9631mr50339565e9.9.1774027037490; Fri, 20 Mar 2026
 10:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313-mali-ivc-fixes-v7-0-v1-0-cb0714cd1279@ideasonboard.com>
In-Reply-To: <20260313-mali-ivc-fixes-v7-0-v1-0-cb0714cd1279@ideasonboard.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 20 Mar 2026 17:16:51 +0000
X-Gm-Features: AaiRm50l-VieBOYlOBaF8d8MPJDUaDBpjbsbBE5CsWPetMD5LTkW9QNd0OxiFpg
Message-ID: <CA+V-a8t0pskENYNhBiYCk=NtU7w9J1wr3TMtH2GQm_bz_-8thw@mail.gmail.com>
Subject: Re: [PATCH 0/7] media: renesas: rzv2h-ivc: Fix concurrent job scheduling
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, 
	=?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <barnabas.pocze@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>, 
	Daniel Scally <dan.scally+renesas@ideasonboard.com>, stable@vger.kernel.org, 
	=?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <barnabas.pocze+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227584-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,cisco,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: B3D802DE710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jacopo,

Thank you for the patches.

On Fri, Mar 13, 2026 at 11:14=E2=80=AFAM Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> We have been exercizing the RZ/V2H(P) IVC block quite intensly these
> last two months.
>
> Here it is a collection of fixes and improvements to the driver.
>
> The first 4 patches in the series address a few registers writes that
> do not respect the documentation.
>
> The 5th and 6th patches fixes concurrent access to the list of queued
> buffers and fix a WARN() visible under heavy system load conditions
> caused by concurrent buffer transfers.
>
> The last patch is actually up for discussion. It is my opinion that the
> trouble of setting up a workqueue item is not justified by the
> relatively small amount of work that has to be carried out in interrupt
> context. In any case, there shouldn't be any functional change
> introduced by this patch.
>
> Patch #7 makes patch #6 reduntant: if we use direct function
> calls, then the issue of concurrently running workqueue items cannot
> happen. However, I actually think patch #6 has value regardless as it
> makes the code more robust.
>
> Signed-off-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>
> ---
> Barnab=C3=A1s P=C5=91cze (4):
>       media: rzv2h-ivc: Fix AXIRX_VBLANK register write
>       media: rzv2h-ivc: Write AXIRX_PIXFMT once
>       media: rzv2h-ivc: Fix FM_STOP register write
>       media: rzv2h-ivc: Fix concurrent buffer list access
>
> Daniel Scally (1):
>       media: rzv2h-ivc: Revise default VBLANK formula
>
> Jacopo Mondi (2):
>       media: rzv2h-ivc: Avoid double job scheduling
>       media: rzv2h-ivc: Replace workqueue with direct function call
>
Tested the patches on RZ/V2H EVK with IMX708 sensor on next-20260319.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #
On RZ/V2H EVK

Cheers,
Prabhakar

