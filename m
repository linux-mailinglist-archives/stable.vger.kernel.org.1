Return-Path: <stable+bounces-233481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBsMA2Fb1GlhtQcAu9opvQ
	(envelope-from <stable+bounces-233481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:18:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1003A8A49
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59F86304C13E
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 01:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860951E5B63;
	Tue,  7 Apr 2026 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="FwGj8Nfu"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AC1D514E
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524657; cv=pass; b=VrDxyvucLIKVWx52N+9HQRv/UiJfdxMQnQm/cEaUWFmMgySaLDRiD198HKDsZZDGcatwt8HCYLPcATIjGeAKdJNPfps9LTCvzmCwp8fuir5tlrYsmJ7HsJE39g2QgNbHhxfMAWtrYNbgfyainHMYtalwrVF1DiorX6VO/ArVxSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524657; c=relaxed/simple;
	bh=czqVJ9cz7Ktw9imH5A5AFq07K7or30oW1/Cb5IOvfOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSvoHU0mrr6ylbVdSARnbnzQ3QHXTnIgpZ15VlgAitlJqK//fC4Q0Rv9aVxswHU6WT/HAXA6hE70ut0cJbxcttxdzUFE90NnRZCdxafu1TMwoWzQL57LIu1HeJyZK0FxI9HpQ3/lagJzncpYe2owtFH78KSANV9aU20ZZttfxwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=FwGj8Nfu; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79d991c7b6aso39526887b3.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 18:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775524655; cv=none;
        d=google.com; s=arc-20240605;
        b=cj+csMDzOTl676C7P9R6J/jLTkQJDCC/J8fHPmqjCTxWUdc+klrve9TZRxGPaPjLH4
         XSfQXCIoWaenykQLbVOeFT6eqHS4JLrkVWsqTKrxUZH2wOqTb+N2mJrS1qjwUMoDn33z
         LXfYuZ4WBCftO4GHh/G92R6ei+0Yf7h5FdtyTH/5NBuQKtATQ9Y4HY/0ibEG0lLS3EAH
         3iPB67LC6bx5TJXvCRtrSyMc2qtHSdwZFxVXRAeUoKrHWcTEV/5hwRndP2ILUq+TZHu5
         Dyspf7hlGZdThxyXNApFy5s5iQ0Y368mLYFIixdVoBTGAdmFeCfMpt3aJw3IY166BYze
         E1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VJT/iwQLEn+40200OWlfNgjmYGPm0JSSw/wJxedFMI0=;
        fh=sdBxyzPwKnfv110CHDkQuRCxtt2OeTr3uBJt3hqgA8o=;
        b=BdmkqeLWqN6F6TCSzxzE3rz8j27rgSq69Hd/XdGLL1wVS5FpwJtc2GcoJDYL39yTlx
         ZrEaf5L+NzDUssG+Xj+HyYjYAe8Z54H821iAAExGenixKCGMXU7RErNhypIubu2bO2lZ
         Spdj01OzRyGWP9bAx3dxKpxn4zcdxe/I6b9I4jAIiVEfpCbszzc1AIVowIju9AfdY5/o
         +x2VZFR7BWNW/qgfzoomwQpOQwcLWUP3i1u+va0r+3wXliNzgYD88viDX8SfAYuU+lQK
         tfkEcLmqFYBayAvUea3haj67jbAf4Mm/S6n/tvGAE5hHRGBhYvgZzQAsrxgTSvbPpBtP
         BbAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775524655; x=1776129455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJT/iwQLEn+40200OWlfNgjmYGPm0JSSw/wJxedFMI0=;
        b=FwGj8NfutOVHwlxjFWqRdjXMfz+Umhc/CB94VsUA+AGR6+pSwe/eu1Uji5Svdy6XkY
         h7v1+7EGq5omlcxj0B4ZEop5A+tUKTegfKrJrxI3NhgqgUwmZgyLIUJfP13Feo8X7NnV
         7Czdmoa/MeslMLmx3ulfLQ9dH+NAaIL/fQxXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775524655; x=1776129455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJT/iwQLEn+40200OWlfNgjmYGPm0JSSw/wJxedFMI0=;
        b=TNW29XZZT99RI1oLwgqI6CxgXqFxrVo8FwDWj87cUACzXNFGGqxWLbs7FlSYKWxfr2
         xTTzVEGTSXhvalVXu390IajCR/m9uDzuoR3VYxILjG7GLJyE+ejLuIGGZ/bsDwG4r/2a
         cMlj59AcTjhX/30NOBJhc23DfsWX8buqi77SUaXQC8xroyD3Df/IXGk1Su9fEVfsakl9
         aGWFoaHV3P2vlE/R95wEst5oaBYstAW1KUdRSicTrwjKQxVm6R9Cbc4IckrQxq2jFHxC
         fV2SHf2x2XS2X1vLsl1wGVc3X61to5YDXyYNPqqnO7KstqNglDl13/xZC/0ayR1dkLxE
         t5fA==
X-Forwarded-Encrypted: i=1; AJvYcCUA0a9FXQpomNzoZzFUc3Y8DnajBzzB1C5CeFliTSBCfi2VB9DuOMqO2Vwk4KfzvaSXiVHrRHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXngNj0heRZBIlycURH91CylwKSODUgqFprGM/ARQ641bqIvXY
	AwLwaa32ri7TvAjIxBO8a/R3BKMLrp+KHeQdI+btv68+UWZ3mro3gNKajldn/sWpSe7KPrcY8Wh
	jmw/12akquZdanIPVohWQVVMA0WNFsheTDm9wiavpWQ==
X-Gm-Gg: AeBDieu7MQcN1XEqsFjrNGerjwo4K91LmEGq8YdUQe1Qa5MXX5/v8++s1e3sbLGKqai
	y2vNUHLd+s9I092EqabImUC+P6+sCuSkLy6W1fQ8DcxH6W6Z8KiOAGiVZ5Sx8cdvuTrEIGXMntl
	+gU6NYGD+5TuRh49ej7FHRQKlOMoiEt1VR9oMSJ/TsePMUE8EJVmPaQj3q37m5YGb8WpB7DAypk
	kemMVPQt1JQyBKKM67pmpqjsMqWU4wpp/+Wz4yThLZlIBJH6qAVoRAm3h+XvKsakWUaAbZ6Sk+N
	HnpuAGM9pooMNP5FmEQF36N8IX98jsrg/U0NFCeGHIygaEG1sTuQ4oilidjZjvTF8LuqCaXg7Oh
	we338kp+sjsxVqvNN8MTJKa5VYffbCVlafxPNzJnmfhGFOnZex/1XoTQWEXIymrI=
X-Received: by 2002:a05:690c:6d84:b0:7a1:dbab:93e5 with SMTP id
 00721157ae682-7a4d2ff20eamr147191477b3.2.1775524655240; Mon, 06 Apr 2026
 18:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca>
In-Reply-To: <20260407011210.GM2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 18:17:24 -0700
X-Gm-Features: AQROBzA83tto2liL_v4antfrma0fo1MHacGEkseVIBd3rayyTAcOUj5whgCNcpo
Message-ID: <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233481-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ziepe.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openai.com:dkim]
X-Rspamd-Queue-Id: 6F1003A8A49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
>
> > io_pagetable *iopt, unsigned long start,
> >                 unmapped_bytes +=3D area_last - area_first + 1;
> >
> >                 down_write(&iopt->iova_rwsem);
> > +
> > +               /* Do not reconsider things already unmapped in case of
> > +                * concurrent allocation */
> > +               start =3D area_last + 1;
>
> area_last can be ULONG_MAX so this literally overflows to 0. It is why
> I formed the suggestion I gave as I did
>
Yes, in which case the  if (start < area_last) that follows will catch
it. Are you suggesting I compare against ULONG_MAX instead?
> Jason

