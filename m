Return-Path: <stable+bounces-253380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAFQBMkZDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-253380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:30:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C6599AF5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B91B30523DB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D236B076;
	Wed, 20 May 2026 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8J7pVIe"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB834C806
	for <stable@vger.kernel.org>; Wed, 20 May 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308996; cv=pass; b=WrTsSJiCcgzp7uc58Uuc3JELDuGdZJ0RE/Y7FNnalGlA/asvvI2ZI2LUrrm3qOV8utSzX9uUneqoqZLdUYQF2NJSqE5KmPx1mYO7l3MNw5qH4A+0Q/pctvyKV96hY5NAkbR0avJdfNrbdI08SRzPJT1y5gHT0Tsdgvzk32+k5I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308996; c=relaxed/simple;
	bh=2mdEwhE24eABiRfThApzhuU+jeBd9xCPHcbXwXI56Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9KZMtp+9hlP6a+NV+C0eDo5pSbMv1/VkAYuuQr7eWfLXkliCpjNloaQMEcSkl2jS6kIJwOwd+soJYk8sY6MJowiVPBv8bIDS2eP86MV5TUrrVTWg281tMolIwkte9YLiSuoOQQIaqkQrV5AoT3t5XkTseXfNZEqAdZ68ic1zuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8J7pVIe; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6579254f996so3463448d50.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 13:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779308994; cv=none;
        d=google.com; s=arc-20240605;
        b=A6bJ9af9CigW9CI72tS3P6nJpsUexzC6saCBI+lNzKeVUMmuiQccfA71qWt9nsYvkx
         YAGBKyvlU2TK7ap/o12dpJPWpzjD/FAP5BbT9V/UiZcYnhF3leR7IVcWs8jwm12UhuFc
         MRSr/5QRAq9ubTGsiHtt1+chiblkQegDVa5YTK9ZMMuQ8ZWGjCEjOPtwxw2VCjos99QM
         hYR3lwyDeo/VJKJUaMF+79K/lDRgzSTWycl5q+uqFiVaqY3zfIo5BR7bxT2/kStAkMyh
         PoL9/F/Oq+rMegQXWV7E5e8BsJdiXyvD+xoaSftPwJmcHEnulKzKqxMIT25W0KXfpS2a
         n48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ws+sa0HClBYmuVw+xadI1X6F1+ae3DzkcGPRrOSQ5jM=;
        fh=Af0/k2h2Uufn58iMpaQ/kQxls3T2lYiBW1fYvSBIN+s=;
        b=VY7A9bu9lzDc7Ki+fuMQJ1NS1G4mHR8V71ckgnhttqfvRRcLqTXfm0n8MqTHKPFOA+
         zIwDwA/rO32F8L03RLTPjy0duiwKmu+/3aGVoYweWDTesnwwXhaZNgJ721Q1fpd1EGhH
         CXw6LEmWbv1AFVlBbpDmyA5aSszBhumiVeoZ5rdYvh+e9UDmpef0ynfNEKPZb5tCGai7
         D0r2E1QBntFKKGmOZupuoqpDFzJ2XSyiPy2ZAQYTpkb2wCd3wcdOhqhAUQ8ZeFxZy8xz
         Lamit/8quiILNgJzCGnRiJ6wNB8AKg3QzgiSwz6pkPDoSlt261+uV5AilnkUktR08eVD
         7ZUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308994; x=1779913794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws+sa0HClBYmuVw+xadI1X6F1+ae3DzkcGPRrOSQ5jM=;
        b=U8J7pVIeZ0SZh4XnCoGUHL8kqYdoXp+Qr/eMPo9w6Ok54e0yvuRFDUlE6TSmTbVTBu
         4vgdAWdkbfva7YQ6OQzNUb2gELp9/0AEawY0lkumV56Hj/8j+M2djCPmrAmbOaMsYKuu
         dovxA9xeWLowPNjxeFHfQEsGJ7hzU3Sekm7dhR7JZeVBF2ZN59IAIb+/h60MkUJRB34k
         0bbzJzgfDCVG5acnvh6NQatON9KZrddqqNYDSRMICsFcaY1BSeuzv2iVRUcBDr5Uq1ZI
         aJtyknPIiA+uPj3B6YTqBCYXGcH6svamspNzYNBboK7RQB1Scv9rAuDW5A8nynqEXhoI
         P8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308994; x=1779913794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ws+sa0HClBYmuVw+xadI1X6F1+ae3DzkcGPRrOSQ5jM=;
        b=mwNzxFK84zilljZDsDsgzSBXp+mpFxLo78NGLrJLICJThakEyJ2T7Fc+pBFwDODqPJ
         8dNJgNMCWYIkVM0KuDJIPdVQYn/zRRrV3gJkEC9V9htWuGcLEUJruG7XHXYLEwO/FK9X
         RpGV49UjOCCHgQURbQwE5Jmfe0bxECPMn/qhqq3uvU8s2f/TgSZDUljpMLefVFMzRPhN
         EBAGvqsqH2mvtC3slyP0jUMC/2GpPFxUyzvt8ohs3rgRRaKapPzTTWJYtQKBgP+EXPT+
         w4dvIleTSxE1B1L1MVw4TWpE8+wVAD4eGqRI0W6JbpMeZulsGAPvREXJ7I+m2ZFZXmF7
         4XHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BKiardAHkv4/x+BXuZDtKaBq41O9fwmbPCqj9dsZZL+Ic8jmq+vm99X9BnzDY+Eln/VfKNKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXQu9EUOzoiXxdblWIIT0Zn5QjoXwrbIjwZeVOBUfum65Suc/
	ZLszHyK0Ay5Q7vA93PMB7UF4hUnj9YjWEKbodzMq907oxfwwYNJeDHTwn/f0zS0IsU3pWr9CIVg
	4Q0PXS8e/5gZKORWVir+wuIuxeNCX/fw=
X-Gm-Gg: Acq92OEetCOPXrqBAxFOSigALGZ9OozOC/xGE+hDYisz819k3+3RCuIDfW3/e1kDP6e
	WaXnhdJ4fncu1gK0Rkvzje98ETb3K9PjMELfcsnlXYcUNeRXXZ5yLTf703M2Y9v5m+zPkOgf+7e
	/7tkI470+x7W0T5OWjU/b+gpi0UWuHtJu7fEcM1JAIoW2f3DZEKdUH9niZ4EQM4sHtNmZ+kCL/f
	sVCYrjhvdjElbR0/Qb7vDorSZzOPpxdvU6OqaES0celbOnyDHnOAoD+RlTRc5Qn+QbHY3VrxNB6
	XjAM9BuYRHqPhL4lOywtUQzT9P5vHFSi8HmNfCVSAW0OvnVCHUyrE47dQyB9hBXek3JG4w==
X-Received: by 2002:a05:690e:1589:20b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-65e228a2c9amr21082573d50.56.1779308993693; Wed, 20 May 2026
 13:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516181504.3076260-1-safa.karakus@secunnix.com> <20260520200611.3033410-1-oss@fourdim.xyz>
In-Reply-To: <20260520200611.3033410-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 16:29:42 -0400
X-Gm-Features: AVHnY4KMuvWdpmpM56Pu18YgWCfyzyGBUIJd9SAsA-NcEhvdrWQaxJ3T0X-7F60
Message-ID: <CABBYNZJiCTJrde9rYT=NQAk_RUv=ugeAUPnRg6vsjvU5hW4NqQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org, safa.karakus@secunnix.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253380-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,fourdim.xyz:email]
X-Rspamd-Queue-Id: 7D1C6599AF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Siwei,

On Wed, May 20, 2026 at 4:06=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> l2cap_chan_close() removes the channel from conn->chan_l, which
> must be done under conn->lock.  cleanup_listen() runs under the
> parent sk_lock, so acquiring conn->lock would invert the
> established conn->lock -> chan->lock -> sk_lock order.
>
> Instead of calling l2cap_chan_close() directly, schedule
> l2cap_chan_timeout with delay 0 to close the channel
> asynchronously.  The timeout handler already acquires conn->lock
> and chan->lock in the correct order.
>
> The timer is only armed when chan->conn is still set: if it is
> already NULL, l2cap_conn_del() has already processed this channel
> (l2cap_chan_del + l2cap_sock_teardown_cb + l2cap_sock_close_cb),
> so there is nothing left to do.  If l2cap_conn_del() races in
> after the timer is armed, __clear_chan_timer() inside
> l2cap_chan_del() cancels it; if the timer has already fired, the
> handler returns harmlessly because chan->conn was cleared.
>
> Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  net/bluetooth/l2cap_sock.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 4ed745a9c2cf..025329636353 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1512,6 +1512,10 @@ static void l2cap_sock_cleanup_listen(struct sock =
*parent)
>          * pin it (hold_unless_zero() additionally skips a chan already p=
ast
>          * its last reference).  We then drop the sk lock before taking
>          * chan->lock, so sk and chan locks are never held together.
> +        *
> +        * Since we cannot call l2cap_chan_close() without conn->lock,
> +        * schedule l2cap_chan_timeout to close the channel; it already
> +        * acquires conn->lock -> chan->lock in the correct order.
>          */
>         while ((sk =3D bt_accept_dequeue(parent, NULL))) {
>                 struct l2cap_chan *chan;
> @@ -1529,14 +1533,12 @@ static void l2cap_sock_cleanup_listen(struct sock=
 *parent)
>                        state_to_string(chan->state));
>
>                 l2cap_chan_lock(chan);
> -               __clear_chan_timer(chan);
> -               l2cap_chan_close(chan, ECONNRESET);
> -               /* l2cap_conn_del() may already have killed this socket
> -                * (it sets SOCK_DEAD); skip the duplicate to avoid a
> -                * double sock_put()/l2cap_chan_put().
> +               /* Since we cannot call l2cap_chan_close() without
> +                * conn->lock, schedule its timer to trigger the close
> +                * and cleanup of this channel.
>                  */
> -               if (!sock_flag(sk, SOCK_DEAD))
> -                       l2cap_sock_kill(sk);
> +               if (chan->conn)
> +                       __set_chan_timer(chan, 0);

Great that seems a lot easier to understand than the previous changes.
I just don't quite follow why you are removing SOCK_DEAD handling with
this?

>                 l2cap_chan_unlock(chan);
>
>                 l2cap_chan_put(chan);
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz

