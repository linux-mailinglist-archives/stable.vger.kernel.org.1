Return-Path: <stable+bounces-253808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L4zJGptEGqgXAYAu9opvQ
	(envelope-from <stable+bounces-253808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:51:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58D5B67B0
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1806307D8E0
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF643635D;
	Fri, 22 May 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwfIscAF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86399349CF0
	for <stable@vger.kernel.org>; Fri, 22 May 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460964; cv=pass; b=XC+pASb/iIxz5TeAfQMWWPNPdes7y30h0j2Q37uQcUlWzjdDkiNGv2tCoYOzsZyAd+DR+8XRrZcYFXzDab0640B1m7rf7PpQWmujFAbdjmvJgHkB+es9s6Ohj9bmueAmFLCZb+1nLF1yMx57UxLWE2dJUTpa1GNanTVGxbDbXKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460964; c=relaxed/simple;
	bh=4WQ0zojNlovj8actFOIa+b2y7t+Kdrs79Zv4ubTvYmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwnqMHwV+IN/lAR9N4++gyIyJgsuq8gqeoZvimf5shpiU6oTnakHqT/7VCj5bCMUxZI9Ux4shO8iN5QDWHi+PBzLuucXTqN1kmNRUDwLXKIzSJBOGEiw08oo5IPbOo9iJPN9wGjXmWPgA3kEHuVnTmne61Y81/XGUx2Yjoy58fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwfIscAF; arc=pass smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so7082763e87.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 07:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779460962; cv=none;
        d=google.com; s=arc-20240605;
        b=Rge5judRyuIgrdHHfyzz7kzHHKRH+5b7DT2A4icYWJEG/3kIV+NaeKcuZtwDibQFe/
         /jFm6lOrAtv+83Fm3vRB80H67qaZF8UdMQgZ02VBW2rskUxBz5AC/nagndeA2V+ZiVAg
         VPj5X5cB0O3Gl70ELies783a22zQEDTJgCXLVynPeXK3UUlO17iLaLbkoLvfZN/0e6JG
         kxh+/uoIJGids0IthmHlOAK1U1bDGMzcaZeG1YjxWH4fTNaC/CKuEzENXNqrIedNkRWD
         VMPxReriPmTdSZahnHbpoPr8dJiEEF1WuSF6EgqvcfShB8+2RWHlSUYGotQPEVuR7XfX
         b5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WQ0zojNlovj8actFOIa+b2y7t+Kdrs79Zv4ubTvYmg=;
        fh=FW0IsTmzLxtYdW9o7YLiD30EiYdRygGv9zqR0KPWZpE=;
        b=KvDOQzu/VueYovsZRshsx9rmVbULASvqmGnjS68a5tmlfdHcQz0gIYyCcu9vpMb0yI
         kacnmxb0zYFO6+9uvc1WuePhXki5He15ZQaoNQ2exSSo3u3grb6YJXzlEKVKD0wgsj5J
         uOsWLnzItOytNfMA8bjTqZaFsrQe0pNgy8m5F2zj7jKDVvsjX/iLgeduYSavpwR7rfoF
         0hLh8pf18rlxCrVRxpDNKJJW1iXb+OO8YPEP/c/4VTaQy8hfR/Luwsqj80+MjknnEmST
         AmcLYah61+q2ZGvqmjfTJVi7HM7uSeGQgpLkm5Bc4TAxWwAE+vSS7DJApEVDvqk3xMnx
         NFJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779460962; x=1780065762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WQ0zojNlovj8actFOIa+b2y7t+Kdrs79Zv4ubTvYmg=;
        b=KwfIscAF0SBVVcFSZ31UUXfYpqur49PAluOKqtQyuKQM2+tIX5JnfOM5sFRd9fV9gU
         VV00Ut1waIMK3AQfUOsjBfHmR4YtA6KMiQ1o5Xbr+7bN2ksMg2XOMhiIIQFF3gNk/D69
         /eAa6NZCZWra9sxFksYL5b2wXr6N0Ig3KBoy4JDe3w1tATpn0IsnhazWwNPC0d5YJGj6
         seU2gM4Epug1tBlohpaRbdbOB74tvRASJ2zkxKd+1Y+E3PVnk3LG0HFKTtz1NmRIci5Y
         Zx0T7FTO7y9HEwKoNfZnIweSqjlzSVzWzOCTNYl6Q2JFVf3Ug2iPl0p7hD9Y1uG8O9jZ
         jTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779460962; x=1780065762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4WQ0zojNlovj8actFOIa+b2y7t+Kdrs79Zv4ubTvYmg=;
        b=AHJCZRRr7NccURnysTKl2akEbSyqxp9XZId6UD7nS8RwtTjyMxy3WooXuXKCNUnNUu
         QhjS4vL7Tyvx2ScVUDx+NHz8GSDaOZb9SxsFrEu8+yfCjm8jyeeNnwRh68nwFmtTo11w
         u3Zl4ZJ8IoSMgG9pJtEKrfcJqtWUex85f+8XOB848GgKL5I1rhnjlTO/G2xddP7egypi
         oq4vxz96kcS5wsIa37RGLz146oAIzijmh2JRQM6wFUeVD1Het7RHStJ/nYmOjHmZnCOt
         W0Xt3NwfA24NRfSp3/pShn4TiYYz6U6zD4A6cu2CsYRQxIVPrwbW6viV77S5ZQqBqRub
         Vs4A==
X-Forwarded-Encrypted: i=1; AFNElJ+MGfTCJIfVQxjjb29e/bXVZNiMrXK+QS0F11aiMtXro5krLItk97GSi0pHAU+tfK6GwtRrtcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rHqj0SRNHkSPCdxx0WvdyHeKLqXPnS9kl9vZYLgmIPOxa+rY
	UWtLmJZBo3JoMg6o+4+Dr5DruN8XhgmqmTHPR6eXissFVzC5JHgon6KfNHUHmsJnGzl9e4eZYOh
	yLQbZqMb06YG+gP1cXkrt/TIakwSCiKA=
X-Gm-Gg: Acq92OF4LdqQN0DWi707XbDw2yvF9BiYbft505ELy1NToo11TeqsuEZ97tUhjES4UYD
	x3O7Hsbx4sQnpLYM96UT5dv2vqAhvN9YjkokSk4gMDDHnXDJwGA6h+AwAa70L0TxgtSz7Pb3DYh
	ignopgZ/cuARC9/iYEgqoXpADbTCMmxNviPTITGa+RpBqkflUK4OsWqcdLZjwIQHaFglVLw5AGe
	h4n+E5Jd11Dtb4Jn2vxiJFby8OSh0IbtzjxLxwjdsCUJISwTfRI3NMKiMIO20qYbmGsHzaiWkF5
	tm0RPNP6boEpSbvGPa3I
X-Received: by 2002:a05:6512:2349:b0:5aa:106b:45e5 with SMTP id
 2adb3069b0e04-5aa3230f6f4mr1707893e87.0.1779460961419; Fri, 22 May 2026
 07:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522101621.927034-1-johan@kernel.org> <CAB7XQsFYZcNssaxjYYoBm4ROgFAAYHYOKXWzFs2YK4cLiYF0Qg@mail.gmail.com>
 <ahBoIngkuYZ-__QA@hovoldconsulting.com>
In-Reply-To: <ahBoIngkuYZ-__QA@hovoldconsulting.com>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Fri, 22 May 2026 22:42:28 +0800
X-Gm-Features: AVHnY4J4ZNzDXAIPG3CnV51Uy8t2SP_8h8xVFK7JMWLA9NVGioxlJnoJglCqk5M
Message-ID: <CAB7XQsH+VsFF9zxNKGRDJ=-_n3_JaJWhp9Mho5P1xzUQVB2KqA@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: cypress_m8: fix memory corruption with small endpoint
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253808-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0D58D5B67B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johan,

> Sorry if it wasn't clear but my patch isn't meant to replace yours as it
> fixes a separate issue (introduced by the same commit).

Sorry for the misunderstanding regarding the intent of your patch.

> I'm hoping you can send me a v2 of your fix.
>
> Johan

I=E2=80=99ll work on a v2 of my fix and send it as soon as possible.

Thanks a lot for your guidance.

Best regards,
Zhang Cen

