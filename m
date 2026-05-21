Return-Path: <stable+bounces-253630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIIxIpVaD2qcJQYAu9opvQ
	(envelope-from <stable+bounces-253630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:18:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40385AB67F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1A233022C0C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E625403EA8;
	Thu, 21 May 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU714It1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08339403EB9
	for <stable@vger.kernel.org>; Thu, 21 May 2026 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779391050; cv=pass; b=rdYxCdv+3Bqx4lDUeD/4BgYduUYKBT5pGyos/oba++5El95fmjkvBaWiv1bnaFDm1LU1kk1goUH9GQ9W0mijpm9QguHGHDcon6Z+6gDF2D4/r5r9t15yAChmswIYNarH27zmffVESK3Fus9sW/qsBijVTsHjQw8adXCJzGgp4NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779391050; c=relaxed/simple;
	bh=avZX3uaG2c7Uv702o7AD1LUF0gJS7cKO12BHK/dtcxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lj3TV0ErAze014XAK+C3Vx3NtrKiPVDXYn7Cz42Q8n+cLpkiU4d0ga6aHkwIn9p/daHrAhz0ozC+EFW+jsjgmieajY2wTopp1bQj2H4eN6gwu0mf8lvJBc4mK9w0XauqXB1lLxbeNS+OohGgECHqqeCIv8r9k7YD8lhy7zChZvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU714It1; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d7b4da91dso371211eaf.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 12:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779391043; cv=none;
        d=google.com; s=arc-20240605;
        b=eBHMHvDSHww9BZtJCDBfMr4F3Psyj1WaypggoNncfXodGbKEiH5iWxp7PEVlWv7zdC
         o/B0PqavS74XX/9zjTQE+3WlZJM9rVJlCUxSo51hDbP+HcUAkLrXrBLpTtsVwTG8ZqvC
         ZRe+ufgHfaoasCNcgruSoGlZWN2Ta64xr9YPaEIh3TMNmaVKClCZQiMN5eoU6A2o9Vr7
         4/ZIi0kK9+oau1scoKJvZcpue77kajaQaBPjTHHIyBJOsf+MMq31YRaKShmP17u3Jl41
         qGhEdtuN9ps91K6iLydkOK93vwpTJuWQ4J4M0P+PPHjrtAijChgGyQywaNLdYPTokOlz
         b9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Psa/lQoTTRPZtMLybHq88OczoU1x2/XGuUNQUf2u8bk=;
        fh=Q6qsW9ZQc4S/2wLwoUu8xMcuPvgzVp9ndfow27vgZeo=;
        b=g1TYp9jNwh2h/pd1vk2oq5JUCgLMCuX5UsnOTaXgT05uq3MScd9VfJPRkEIJsopGOA
         pvZYQeeupB2sUIelOWJndzpaLbza+fsiQ3Je1v5iCh4xfn9MAFRxxmR40QlCemEYqQKD
         5tfDfxeTCf80depcL8BEIa8o9ULvzckunYN092uOpdlZvnsrYU+DWDRS9ehBjuehYJ3f
         bI2rm8ibRKkxYJO4lkjBe0bx417Xa6HU7P3xCys2mNeGOOIsrkv2hRa9t+52otFlMX1s
         SmAWll8pQAVntaYVrPUUwm62jDtsWkTDNmgDNFxaGKup13gr81gfi1tO9yUnUIx55g03
         BXhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779391043; x=1779995843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Psa/lQoTTRPZtMLybHq88OczoU1x2/XGuUNQUf2u8bk=;
        b=UU714It1K9cW3oJh8wbU4+AR78RoF9p2w1//ZVK1rKbMDx/c9nDfQMxP0R26N86Tv0
         0uwGbSCw5uaTQEuY+Vb/ULTm21WAqqxJ4xRRTYspYv+gsGncs0jhwRDlM2ZCGoi8we6q
         rTBimFeEvYFQp9mbEYhZzwzTmyV3krNT5C+trPwgukQexe8LUhk3dI+kmDULPk7ruXgP
         YXvvKNtZcOh+capJDsG6zjKyoG5umfNGpKqBqo57hdpeFglMKtLWjJU8aScsN3DpeVb4
         fJUFwVKZiWViqvT2ZJD0ifG9Js4EoCFyghTvtqJYV4rl/wa/72u9irtsnmE5KUtCntR7
         cKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391043; x=1779995843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psa/lQoTTRPZtMLybHq88OczoU1x2/XGuUNQUf2u8bk=;
        b=VktT0FgWEGGywhlj4+HXp36jr+O9LNxOVgGJ7Au1cFQLXWd4Di+qu4RcZlm8ZKpbSQ
         wHBbRdsIYm2Pc19wivxvz8gYi/o0A+x1wqwrbHiLa4+EalLDBLtYIRPLbdupYI13lNGx
         0yfWSB9fV2IEujbIrjHvaJqSIMt6PTVaX4SBCkMwAhpAvSjN41IwhRpP/NHil7kDIZcG
         erAVT9V/p2wNiRsBWmZ9zZJ4tdajGHmtW8Gsbt7FZ1N8LIyouFOT8DU+XbFZV8oCRxPs
         z4i98P6Dlo/wrZ9gi0e0PmF5HZidlIH25vZs5V5gsAkpRexdjTaBh8MHTMKvyBXsNVYh
         Fouw==
X-Forwarded-Encrypted: i=1; AFNElJ8Hfs+zAOe17lZ8XywNFV3N5f2KY9ujD4vVWO7BKX1YxKJfAG29Y5TLY+B/KhBt7fKBS7wiS7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNt4hwzaUOWO4D06tawdtQjqPy+K9zlOJG6JpCAh+qSvvMV59
	Hh0ajiGOuFEZhCCrxGrusSOsrIgM9owb6SR2RlvCtvGcJ7u0N1uYEUxdotVkxeCx46xHzBHMejj
	s8Pj3RZiMIxu8iS8YqUsQKGD9VA0LlngAym9nV4vn
X-Gm-Gg: Acq92OGMC+zqmWXyjIDRTCBdgohQREyJVGoG35s9+21PjpMPHGH2zfchqj2r6qNMnXJ
	S5XE69SES6+iJWS3LhVfQPGyPnVKgAFxM4OWNHLWxSS7zavNC4Dw8/9rHDRcjg+Blpb+BjWyeI/
	4kcFjx20exhV6PITf7SUf+6uSfa1qsmMIEAKLPvePyiHifvKfzO4PMem1vrFBKyc8atJnGUOYRg
	0A401xd1vSCagHXykqqygqViRJ09ukLpQ1PpfKIcUM0ZnbAO/KTPcJbzBQHA5rpd/YqHA7yd/Bl
	8DKSEb8ie0tycPng
X-Received: by 2002:a05:6820:3098:b0:694:8bfa:7819 with SMTP id
 006d021491bc7-69d7eb7713fmr382844eaf.13.1779391043364; Thu, 21 May 2026
 12:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
 <20260518160836.29876-1-rochan.avlur@gmail.com> <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Rochan Avlur <rochan.avlur@gmail.com>
Date: Thu, 21 May 2026 12:16:46 -0700
X-Gm-Features: AVHnY4IaRzsnxbLw2sxucfs2mozFVBFtKemPMfMPvR7vptvaaVQZoKq-_NIPIlM
Message-ID: <CALbtPkUOh6seU3eBo63_D_soq5CTLh+aROXvBxEM=Y03OzPoHw@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: preserve benign secondary entries during rename
 and move
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>, "rochan.avlur@skydio.com" <rochan.avlur@skydio.com>, 
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253630-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rochanavlur@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A40385AB67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I think we can do this by passing old_es and num_extra_entries to
> exfat_init_ext_entry() and set new_es in the following order.
>
> exfat_init_ext_entry()
> {
>         // 1. set file entry
>         // 2. set stream extension entry
>         // 3. New step: copy benign secondary entries to the tail of new_es
>         // 4. set name entries
> }
>
> > +       /*
> > +        * Relocate when the old slot is too small, or when extra
> > +        * entries exist and the name entry count changes.
> > +        */
> > +       if (old_es.num_entries < num_total_entries ||
> > +           (num_extra_entries && num_old_name_entries != num_new_name_entries)) {
>
> If the above implementation is followed, this change is not needed.

Thanks for the review. The separate exfat_copy_trailing_entries() was
unnecessarily complex, and integrating the benign entry copy into
exfat_init_ext_entry() is cleaner.

> This change will cause the rename operation to fail due to no space, even if
> filename is shortened, when the partition is full.

Good catch. I'll send a v4 with these changes.

