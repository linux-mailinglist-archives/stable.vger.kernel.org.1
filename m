Return-Path: <stable+bounces-249395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE9xMz55C2rPIAUAu9opvQ
	(envelope-from <stable+bounces-249395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 22:40:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339945737BE
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B5F43022F83
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDFB3932E4;
	Mon, 18 May 2026 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpd3nf3C"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9189384223
	for <stable@vger.kernel.org>; Mon, 18 May 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136690; cv=pass; b=cy6YIL0MBb7DpGFcLFDgHgR95yH396BqxO4thm3SQnpJQXV/CjOYYpUS3DLKV6JUlVgQ4rGhGwL0Njhd28jtKxxjilH69KN0O5eFVzWdhrjrJGmk/egChbGkc4zIul0ieFQk7u4SFadxtbHlfBldyf44JF50GftMxkgUb5a+CLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136690; c=relaxed/simple;
	bh=lkOULuQbXuPv/kXgjumTZDY2A2U6HNDqTBg7wLDDuWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMe5OAfozQV8AghhBsrLAiyjmX0PpqWsMvSVq8tOh0llyz8WaNtET5BwsUkpU9CGrVqQhTfVVZe57ygcRk4Sp31B4riAWZ+frI6pok9fIncOT1xCTZ+vpLF8tCMOlRCInsQ1+brZWorCSZyJnIHE1sSX/mm6f7ciz2y7176qXdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpd3nf3C; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c7a459105so2923363d50.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 13:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779136688; cv=none;
        d=google.com; s=arc-20240605;
        b=lrB9ukZWZ3LCRdxlWhPZQwUUOAnry+PjL9bDr2a9aagj9HrazVN/LIIKWpJHSt0KoW
         KOyLR2LBzpXDSSV5McUkMdIqjd+Cy92pJzg8J9hPE8F9sNee6rRkl+jXWzIuEoovFCG6
         YD+ag1NID1ZqsS3getZMRhekmQcTEx3vtz64IRJqBjKOUfIMcmPng8cWdkUSFkQHccQ5
         ozOnlmPbcaz5sdL079nP75CROLsFzoC6TJJkw2LEEA6f84wRnMhjxG7h3rzC3cSpUv2a
         e33CFN3ao4me8woA0+nmEFIq+aWMYRiPUGoL8le/9dR8LBKPD+NeQTfnKQ3vJwWG1+hY
         d65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pia0gWpXc6Y4Sib1fFoVK5T2yrWShp0Db9uHVgX/Xl4=;
        fh=3z+OfqLCaKTrFRMOf0akRKuvxsQRsH/2/EyIYd5PK0U=;
        b=IFi9CyxScF99t6tBTcF2RdNOr6ekfVGHTmEI0y6aS41EzUtLO2EcmI2VbxMn42MT6T
         BLhI2qJemnzqctxjIHASzc5os/atH/o0ziI2YNax2wxCTFIFv/hbRGf6W4qtrHhtixb1
         Grxks/xlHrN+HDpumHkQFFrPVp3nttGreD9ipcb8oRlKkIrGJuxyytitVT8JRO1Dr9+Y
         X6Qpx8uKuPt6NUbrqmUXTikORyvlUAac29xQ5txtE1fny0GS89ooeHTDNRVRkAfLtdok
         f4DSBKUBFfIzHaSaIrxh4opWDMTyidKc2JPRZq/E4bcQbPHB0Ln8qgzOkfj1X8U9tMar
         YfRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779136688; x=1779741488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pia0gWpXc6Y4Sib1fFoVK5T2yrWShp0Db9uHVgX/Xl4=;
        b=bpd3nf3Cvd2+FTkP884g4fYZXnjV3+vAluOVoF8qTO/altJdvLmTt5eHRZ0xRqRE+Z
         VbsOSgLXNpFYN4/DXnXihrBewE21uxi8vQ+sWFGIWY23I1I8uNK6Hl3r3iVXPp5hEX/n
         4zvsWIf31bB4TYGnJjfmR29IrqtNpR4CreIFg+jZlcJkHgb34Eb8He06WR3tVt9mLAMr
         P5kUQ6gsIqjcHvAZPZzLXiosDrYXLAXjL76DwJGqBz7nOwePBe/a7HQ6/o4PJwPhmo/n
         dt++u9UR36ED2swS8+HP1UeqtA6lMxjEO4uK44GV8FdWhwKjelKEqDYeSnjVQWl7tLv5
         W8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136688; x=1779741488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pia0gWpXc6Y4Sib1fFoVK5T2yrWShp0Db9uHVgX/Xl4=;
        b=h6Yysq0qMj5mf7OHB6qW3oGW72qE5Tp1RrgeMDsdU6hltR5lYyn5W62X1Td/R+Qzdt
         EZMTeulJQAeYq77rG92A4aLGJg3ZiLQRykKlik+c+pHK7YL3aUKMqjwav+bgzOevsYuf
         PN0Z/zXkrCKeSO3Ka78IDmRCbk6CGPJd5hWM3r/E1ohX4BVks1uU+ivHdR5gwICml2tU
         HqOIAk+ZsKmslyNFfnzUd2WkasmOrnZeR21hdA6jNXGDkZ8fhQDsUOamBAXWPo2LTgDC
         qU6/yQKUUksV4IlwhDQZysefiIRKdeovCuAsYairvevUEQJzQM8EYh6mZ/ArgeY410IU
         XSDA==
X-Forwarded-Encrypted: i=1; AFNElJ/MP/2E4oSSKd5kQw6YX4JS3/mrBYiVSp2fqwcPd4MG4YWoUtZCGOjNFqfUwuqDG9Wc1aL9Fgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nx/I92VGIYRclwrwUGPdfHhKCsgMU5c5pgJk06NdKfhzUoJr
	L7Q1XpbxfzCSDBtk4IS2g2rAf+ZPTfLw7nOrZrkkq0NDM2GRUidRIV6KgvbYa2OWr0sAtAStwZ3
	Xw2TuDmZDK6SLJvpt8bkZnHOhq86JfO0=
X-Gm-Gg: Acq92OHUpedn0qspkRcSt8oaQNfQt1es9ebkVVDUkkrLowoYaYHe+Azg8XTg0D0L1V3
	HmwXdZL8wDkDyerhJPNKXMYQyzQCbm30nKoynfa0UMvZXq8dpDTP0NRIa30V7XyT821jIX+APBk
	o4SYejf1owS4fvlloBgY1JrMwlejL1AohHRCSHgsaSPxsb2jwEJMEdYsf55J6XJE3IOS/RPNn3t
	n4yFlg707fkzATZqUI7d8cKV/SHLHgJx+USr8NE582D5pNl2arSPL4DNt7oKw6TRMphOmLBxT38
	95/3i6BRpyx1FR31V+o0RKO6Gre2NIN233FPQkXf2yPTp2m9aqGropP7geHnZWhYpUsDElpQqM6
	29g==
X-Received: by 2002:a05:690e:1444:b0:65c:27dc:4a64 with SMTP id
 956f58d0204a3-65e0afea987mr17033770d50.3.1779136687833; Mon, 18 May 2026
 13:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517145417.31910-1-meatuni001@gmail.com>
In-Reply-To: <20260517145417.31910-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 16:37:56 -0400
X-Gm-Features: AVHnY4KGFMjZR3VGGye6YVkW1CljH3DfkRbzH2PUROr47mgV_JlPleT-b4haKFg
Message-ID: <CABBYNZLcs4zagQ289T8HmCoFRJc2KYt2naU9PeZFirWAiYhsBA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org, johan.hedberg@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-249395-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 339945737BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Muhammad,

On Sun, May 17, 2026 at 10:55=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> smp_cmd_keypress_notify() accesses the received payload as
> struct smp_cmd_keypress_notify without verifying that skb->len
> contains enough data.
>
> smp_sig_channel() removes the opcode byte before dispatching to
> command handlers, so a SMP_CMD_KEYPRESS_NOTIFY packet without a
> payload leaves skb->len equal to zero on entry to the handler,
> causing a 1-byte out-of-bounds read from the heap.
>
> Add a length check before accessing the payload and return
> SMP_INVALID_PARAMS when the packet is too short, matching the
> pattern used by other SMP command handlers.
>
> Fixes: 1408bb6efb04 ("Bluetooth: Add dummy handler for LE SC keypress not=
ification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  net/bluetooth/smp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 98f1da4f5..4c98e2a3a 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2932,6 +2932,9 @@ static int smp_cmd_keypress_notify(struct l2cap_con=
n *conn,
>  {
>         struct smp_cmd_keypress_notify *kp =3D (void *) skb->data;

Perhaps we should stop assigning it directly and instead just use
`skb_pull_data`, which performs bounds checks on its own.

> +       if (skb->len < sizeof(*kp))
> +               return SMP_INVALID_PARAMS;

I suggested we add a bt_dev_warn_ratelimit with something like "Too
small packet: skb->len %u < %u" to make debugging easier.

> +
>         bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
>
>         return 0;
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz

