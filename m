Return-Path: <stable+bounces-242172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DYPEqqO82kQ5AEAu9opvQ
	(envelope-from <stable+bounces-242172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:17:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE814A6411
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 495B1301158F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0413630B1;
	Thu, 30 Apr 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CovOWcW8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EDC3D7D97
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569444; cv=pass; b=EIppUELTxJQy5LsIdvj9wQhp/e0kqroNWFt7z5TSQ/PynP4+XkEqN4qJMeDt2H7l2iISyYG+ZcGLJqPeMlsq93ZkHYdUdy0r+A+07SWuhqBgAT8+SQ9AlZGDie1LSiLfxF8+wqgZRRjkfJBVbkbRVMeFrVxLFBeDyv73pz3hUtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569444; c=relaxed/simple;
	bh=xmlUvms7jbdQ6jObUvE2V4NxlxV71FYkVh2c+YJ28h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTW8l8F0+qGMaeKYXPLUHoIMkQ6dUlcwyCp3GxUscN7svDuLRAThcfXmGe9QdIA5g3UngDsZ7XdIw9Zz4zybAJjfFRlQ1cvly1i0C7zU8R1ODe1XZZdGqgZ+pDzWkVUR/lrtU332tlf8PseIIhHk/N0HdfyDUsDOCq6Yz9bcJWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CovOWcW8; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651bc83e74aso1091867d50.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777569441; cv=none;
        d=google.com; s=arc-20240605;
        b=bij3BcjavhRWbDVmdW5mIjUqp3kbOtKdZbJznPctnoTDkVEOpGxub0L5vtBmNGB67y
         6cYEAXlmGXkCSkkGrdNtAAaEXYC2JUUOYPhbqL8V4+42eA6pv+bGCd1oaYLo00qh0gjZ
         vYbaVroca3z8hSgEgPd8qqXvV8wmBPFsDZP4HzuAu+uwu0/xPxwgzRk8Op3j9q3z5RMc
         6QQLh7G85JlQgES1oM4YcJDoB/1/TAeW/AlJkknHYRSLlCg1sY+NC+GGYkq2sfiC75KW
         vcE+cHSswQAP8Fm0mOK+tSzbYXzXX59VVTHgkZwrRaYeV1XvnCfIu0SiiVu5HWWDFcKc
         i5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ha0rgF4Ilfcxptzl06v51LwEiI+VXaaWgoLeb5OWN3Y=;
        fh=ZBZ/uaJVAqZoXyTv8qPPR+zROhPSqjXb62LMKd8PBzs=;
        b=lPWICSaBr0M26hjOVlcAw89Co1xbpcPvQJ1aqSWIaImCuBTV1PRJLu2VJPZoeXySPw
         IPjZNWMIdF1PHCswNBXZ0yRIebKaalX7Dxantqbjctzw9QdJjgqsB5BjwS0AxeU/nQMt
         dcm8vmhuvMsf2DQTsYkBNVMhi52prGAMN3P6f0JbI/ZXYIMpC0VdNNrg5X3Wle8oO9vK
         DYeOVg4UsnoLTpNjd3rDdEy2sAjoYzjxYGiUbEfsNUMft2vRz9veiiDk3lMXrfxwdj89
         ect9KLtzHbdFsWY2PXJHxToAY1+ddi/v4AGI2uJXoQVREnfm2ktIhJUwkSQH1r0NgPv/
         IMkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569441; x=1778174241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha0rgF4Ilfcxptzl06v51LwEiI+VXaaWgoLeb5OWN3Y=;
        b=CovOWcW84jC7RWp25i3JqCHXWAfcsLdoImUZzkhgQZvmJ9y5dpxbYGvN0rNwPM63+f
         +veDO8LEEcAyo9S0VeimHSkUrtXQ53TRYfj6NRY9DgNh2HfE0YZaoADl8mdZ1q157OLb
         EE9tolFr6VhWI8JwMwzWbJkbcfmrCvtEQsbJdsANcR2mW9l0jyhS/dP3ER8Mq1ngr4EB
         sqbVr4VceyRZxDBaWYn6f1owoHXldBeArBch3imT1hOGaVBaLP4aWXzC2DcMXmp8OqXD
         4C4f+haECdZDG1ao04BVhKEvGjsXmYJgEIG9uyYWxPDVGEVKkz+GRYFaS3HvHcyQkFy2
         oQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569441; x=1778174241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ha0rgF4Ilfcxptzl06v51LwEiI+VXaaWgoLeb5OWN3Y=;
        b=DFMH2t8Vp9jMSHNBuRPtFe/PDaA+BzZQ8px+RlzGhDduepbRh/o+3rO2sbwrCSyWNv
         j8cyt4YQEEtnHgS/gAgzhOSvETu/8I9n/2Fyl+mbObSwY2tI4zrPEjuEGG9UAM3hlLN9
         teyUkUGiQy2a3bY73YNAyhSyJTduTjb1B/tlS8tonhXFYKCasWd1qxvnWZwArnDEYmRF
         8XIwYSMic87VYiqehvFwOwSx2yQ1YV6QpcPVptLhcAptgiyUkDTorAJ6oOe0iWPhppYo
         kt8M13crdTU16U/kKP/q5jDiIe4PLhq5FStV73jteFDMTkmNOtiSREb158eD+fm1kxDK
         Vlqg==
X-Forwarded-Encrypted: i=1; AFNElJ9fnI1ArDE7N2uVZuMwTNOezpSKoLrafG5oAXq7MMvA0qLzkFusjvuicCOLUCljXjSQiw5T7iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1w6/9D8KC9dpTVrjLIhdLbjNiGhkVC2mLf6nheUr7qDyfMtg
	U79qsV8vytyeMV0pvKcn3js6B1WQaHt/39bQ69f3fO6Xma+vB6XbcTEivE/zFwfBRSuBbavV4xz
	+cq9QW1a84C1wjWnVsxhVwCMcyEokk5eR64yQy+c=
X-Gm-Gg: AeBDiesSuh4IR5tJIofIgzlPK4CtbBHSW+ME+VxIjrWWWEYus2lEvqFXUB+qvG8WHkD
	VhEq4oRsDyC4HfxTbgIMzKoqRKeahUbroboufIugf07tFTsUUn/nC91gzo1th4LT3C5B867VlkE
	LOaHyR5zswe2bHBZoPRPWpCKoWzoT39cjcxk7OYWSKncfJrhZjm+bTEHhAmiWvGcYwVdjvKcuE0
	Hw54gYyg9H50r+0yqCin58L+e3tp7b5syaJXI1d71Qpx+DMnCHFucrrGH/zxs2VkwqPLwTg4M2l
	F6u77SU4Nf3vwoV8b9/p1yo9+NQYbtpyuXpI9EIdEdSMbpT91pLRGFrgVWccaEMs8GlwNSqU/Xu
	UJjyP
X-Received: by 2002:a53:db4e:0:b0:657:8b53:bd42 with SMTP id
 956f58d0204a3-65c18dda124mr2437866d50.34.1777569441287; Thu, 30 Apr 2026
 10:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Apr 2026 13:17:09 -0400
X-Gm-Features: AVHnY4JApx891aGHP7nLh5SQa3vkfZx1uBEMocpDau9aHtZE1upWH-Epuj2FbSA
Message-ID: <CABBYNZL4P1HkA_FMFkBu0Ou-qi1a6Atv3ae-U32r2U1JgkOe1A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: l2cap: fix UAF race in l2cap_sock_cleanup_listen
To: =?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8FE814A6411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242172-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Safa,

On Tue, Apr 28, 2026 at 7:30=E2=80=AFPM Safa Karaku=C5=9F <safa.karakus@sec=
unnix.com> wrote:
>
> l2cap_sock_cleanup_listen() dequeues child sockets via
> bt_accept_dequeue() without holding a reference on the returned sk.
> A concurrent HCI disconnect can trigger l2cap_conn_del() on CPU1
> which, while holding chan->lock, calls:
>
>   teardown_cb  -> sock_set_flag(sk, SOCK_ZAPPED)
>   close_cb     -> l2cap_sock_kill(sk) -> sock_put(sk) -> kfree(sk)
>
> all before CPU0 has a chance to acquire chan->lock.  CPU0 then calls
> l2cap_chan_lock() on the now-freed sk's chan (already safe because
> l2cap_chan_hold() was called first) but subsequently passes the freed
> sk pointer to l2cap_sock_kill(), causing a use-after-free read on
> sk->sk_flags and sk->sk_socket.
>
> Fix by calling sock_hold() immediately after bt_accept_dequeue() to
> prevent kfree(sk) from racing with our traversal.  After acquiring
> chan->lock, check SOCK_DEAD: if l2cap_conn_del() already invoked
> l2cap_sock_kill() (which sets SOCK_DEAD), skip the duplicate call to
> avoid a double sock_put().  Drop the extra reference with sock_put()
> at the end of each loop iteration.
>
> Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Cre=
dit Based Mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Safa Karakus<safa.karakus@secunnix.com>
> ---
>  net/bluetooth/l2cap_sock.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 71e8c1b45..4475d3377 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1477,7 +1477,15 @@ static void l2cap_sock_cleanup_listen(struct sock =
*parent)
>
>         /* Close not yet accepted channels */
>         while ((sk =3D bt_accept_dequeue(parent, NULL))) {
> -               struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> +               struct l2cap_chan *chan;
> +
> +               /* Hold sk across the chan->lock acquisition window.
> +                * A concurrent l2cap_conn_del() can call l2cap_sock_kill=
(sk)
> +                * -> kfree(sk) inside chan->lock before we acquire it,
> +                * leaving a dangling pointer.
> +                */
> +               sock_hold(sk);
> +               chan =3D l2cap_pi(sk)->chan;
>
>                 BT_DBG("child chan %p state %s", chan,
>                        state_to_string(chan->state));
> @@ -1487,10 +1495,16 @@ static void l2cap_sock_cleanup_listen(struct sock=
 *parent)
>
>                 __clear_chan_timer(chan);
>                 l2cap_chan_close(chan, ECONNRESET);
> -               l2cap_sock_kill(sk);
> +               /* l2cap_conn_del() may have already called l2cap_sock_ki=
ll()
> +                * (setting SOCK_DEAD); skip the duplicate to avoid a
> +                * double sock_put().
> +                */
> +               if (!sock_flag(sk, SOCK_DEAD))
> +                       l2cap_sock_kill(sk);
>
>                 l2cap_chan_unlock(chan);
>                 l2cap_chan_put(chan);
> +               sock_put(sk);
>         }
>  }
>
> --
> 2.34.1

sashiko flags 2 critical flaws with these changes:

https://sashiko.dev/#/patchset/AS8P250MB079109F82C16BEDC4F9FE584EB372%40AS8=
P250MB0791.EURP250.PROD.OUTLOOK.COM

--=20
Luiz Augusto von Dentz

