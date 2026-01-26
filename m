Return-Path: <stable+bounces-211525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNutOBEkd2mZcgEAu9opvQ
	(envelope-from <stable+bounces-211525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:21:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D185696
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 592FB3004227
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C393126A8;
	Mon, 26 Jan 2026 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BRaD5jjN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B12FF172
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769415689; cv=pass; b=LVTmHYzS+YmqFB7R6bXZqw+JyLm+48oD7eMUtrtdKbZERKhT+d0PQvC99O9Ezfu6MRvaPuSP9dWXkpfreIFUUhGDGsiKYSZYd2YJAEaxLPXFfx2AG15aramjR/ZYLAvwXJwr4QjHx3D6z9dLfYgvyjwTZKQgMnu6xw8q88T7aMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769415689; c=relaxed/simple;
	bh=+BNGC4WEVqbGClN8H/L9TcBFADyZIq1jBtEdLt96YSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIxTxoFi0Cewac/q+R4Bbxkj6Ln+LTjB15Im25x2zmjLUWSSnDkWfNvyIOH+fUdfijfXOblmbC35vZSgJc45FectvoewZYh4ghoK3yumkqsHsRCe2kc8krG6tAoy3gi7wPdaAXXmbudb3E2Y4JdLa3JacMjx0BLNdyKFnNZQIek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BRaD5jjN; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b886a249da3so36742466b.0
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 00:21:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769415684; cv=none;
        d=google.com; s=arc-20240605;
        b=LY8fUE1W/Tm4eW5Oyi66oacw8kAhAKtgnxFha28kmy7MMMMb6K3X4muIO+RgHQJQMR
         rVRhUao2FPGu05DzKSbfUPAnhnsFgaQ9JdyoUe6GD+jDaGrwQp8LWzlKvcbma4MQgXao
         rtD15KQd+S7wCLQ0o2WBnJih8/xe4JnVdurUBMRZxB+FStLz6z6FfqQckVdjfvFA25Ez
         Vyqq/W+S7BpbnqoHSMe6q9LNoxlXxetsHU8L3gdLMIQtVPUGdalBYgm3fPcKd9KMx6N1
         SZqjfYck1jwoZGcDgl89TD6NZuOtDe1eTvs4xTw2ttwwbv4Jf24Cla2iCZUGYieb6MuO
         4IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eG3ZppPTPtdXVcdYhPpP4n/OImRPF+Tu0E8qAIhhHrA=;
        fh=Cpyc3lJAIiFQWDbBUVqwQU7HmuWdrJS9O7bgfQicG4I=;
        b=TDLcGCSdCVwWQYsJoUOetKMtHYrK9GaBEyBCN3D1nnqfNOVW/VIYlVC73yT0TO4mLW
         TJv5kd7IRyK201vB3E4GyljptPeThlgqcSX6aDah1phNtygHu0Nb6E9rkWqP6TJnQf6e
         TVDOfcCVLSU/yqbU9bmIa+G7OsxFZA/UEhxaNziJFN9Re1tSU3R+rHP8cmtVOGuv7npT
         wGsv2ajB9ke+4dY7kCtJ4WiHtNbaeqdQpjoNIVzFV+B+StAo6BU+wELaWKQ5JtgFwu5k
         YIvtsKudKyHJMjUBQkuAY3gTidt/htF/FQDvUU5ZPgUyFwpIA/STnpmQZftX/27UIaEg
         nbmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1769415684; x=1770020484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eG3ZppPTPtdXVcdYhPpP4n/OImRPF+Tu0E8qAIhhHrA=;
        b=BRaD5jjNeKYINs1r1EUr6c9WZwqq6qVvmPWljYgJzgdG131FeeXhVqoY74dvf/W8DO
         PRiJoj85kHq2JccvxGXfgb2mT4QuoNDmRxfQDAYMd3dtqh2ZVauJOUJNun8Kq2aAXZt3
         L9BvJ/nmHcLM+4e/z9hmrJDjGKIw0BvCwDa2XqjIlyWaJ/m1yGhbiIgSXXA79lmcUIrY
         0hKOzebc4XqHs44KpJDY2TVxc0oxoIjnZ4XS5wQZ8MShqPoMfCADYWSMgu9woW2D56mr
         FLQyGGo53G0hKPpDjEFZ2uEvp1kL8HLjte3BMWYizRmg38LXD6w5GSzkCUTlE3PVmu0R
         N9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769415684; x=1770020484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eG3ZppPTPtdXVcdYhPpP4n/OImRPF+Tu0E8qAIhhHrA=;
        b=PGl1y+YvyMIItMyC68cFDWI9AoxXPg+E/nk/3EYVUCvoRd5MOJi8HuV3WRYW9ASTw5
         EQcnpCw0cajuB0F3n52mQmUByCpTCQ9oInX7KQIGnPdJAJt5t5/DylX8ukkFH1UBFAdG
         ccCY+NLny7cs3g3KhpO0Gazj4TeUMHkpjOLzTRCc8fI2kdFNDpg2pWKy9pntEsIr01mD
         w3kbv+0/CtRayn5uRUNXUJecC1HHZwDss9+rDHbaD6Jo/xqHLiG4QmNbGleJTILCKTBI
         GWw1WE7Tn8PDPZaQ4sLs9P783itPA0hD4RqcPEBW9y3G6Z49fXu4V4YAbOoQ/iFhYpqG
         26ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULlSQUPLrV+7oL8D+ptR9ioZCdYP3rmQtCLkWvDcIAH7oqoHGAeOjmwS5N+mNsXDsi7TwtwAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmjTfD/xupci/KTHB0SBow7hUfkv3usMaGXTwazS1MfQlkW4mf
	QcoeeTkXggU7Tpx0lfcul4o+XnawFj4bzR2MJTfSua3QCspCRBlJUvbQf3nH90jO/3cvKhQbS98
	8aVGHQ7+GtRKqe4cFoZqM7IqyKC/kBzBRYb0RFU6y/A==
X-Gm-Gg: AZuq6aKHvXIuib4vwP1AWf4jMQvd9NHcSIiYKIq7xIe1qtyolQVS4sfQEMfxDSBF4Lu
	XaMZcFDWo+ciC+UzJ/ltWDwbX/V8GwIxl/OU4r98XbwdglFWEJCKVQ8fhsyPOL6swzfhBPFvkMR
	ijPGV4TiSioiMVIG7NqPAgJ1x1wYs0rzEaAxGvuv4GAyZYMhRHDW4fljmeFezsH2mifMujTT7Gq
	8v2xEUQY9iQtgA/2H6UHH+tVzxZcL2rYFhCiksdKwsbwc/8U70SwxaHfMX+JrcY9uu+03uW0+hG
	3MB67Pe05SdBvzd0AhC4EYmVLz4A
X-Received: by 2002:a17:907:9815:b0:b86:f194:9ed5 with SMTP id
 a640c23a62f3a-b8d2e89ad90mr160498366b.1.1769415683602; Mon, 26 Jan 2026
 00:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120102456.25169-1-jinpu.wang@ionos.com> <ad63a8bf-410f-4b91-aa89-3963dadf87af@fnnas.com>
In-Reply-To: <ad63a8bf-410f-4b91-aa89-3963dadf87af@fnnas.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 26 Jan 2026 09:21:12 +0100
X-Gm-Features: AZwV_QhAKRF4wc3dvy-SsqLo7TFQAhS2khNRUxzM3lwuAcJgFOvRv00CwSTWBVY
Message-ID: <CAMGffEmMO59xc2DOVo2A4dat7Vm7N6E+tHH2ZM0GpVCD796mtw@mail.gmail.com>
Subject: Re: [PATCH] md/bitmap: fix GPF in write_page caused by resize race
To: yukuai@fnnas.com
Cc: song@kernel.org, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ionos.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinpu.wang@ionos.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4E8D185696
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 6:33=E2=80=AFAM Yu Kuai <yukuai@fnnas.com> wrote:
>
> =E5=9C=A8 2026/1/20 18:24, Jack Wang =E5=86=99=E9=81=93:
>
> > A General Protection Fault occurs in write_page() during array resize:
> > RIP: 0010:write_page+0x22b/0x3c0 [md_mod]
> >
> > This is a use-after-free race between bitmap_daemon_work() and
> > __bitmap_resize(). The daemon iterates over `bitmap->storage.filemap`
> > without locking, while the resize path frees that storage via
> > md_bitmap_file_unmap(). `quiesce()` does not stop the md thread,
> > allowing concurrent access to freed pages.
> >
> > Fix by holding `mddev->bitmap_info.mutex` during the bitmap update.
> >
> > Closes:https://lore.kernel.org/linux-raid/CAMGffE=3DMbfp=3D7xD_hYxXk1PA=
aCZNSEAVeQGKGy7YF9f2S4=3DNEA@mail.gmail.com/T/#u
> > Cc:stable@vger.kernel.org
> > Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
> > ---
> >   drivers/md/md-bitmap.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
>
> Applied with a fixtag:
>
> Fixes: d60b479d177a ("md/bitmap: add bitmap_resize function to allow
> bitmap resizing.")
>
> --
> Thansk,
> Kuai
Hi Kuai,

Thanks for applying the fix with the fixes tag.

Best,
Jinpu

