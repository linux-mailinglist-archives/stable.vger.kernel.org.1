Return-Path: <stable+bounces-244195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE95BDgI+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:09:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A54CFFAF
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F882301B51F
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D930480DC9;
	Tue,  5 May 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooEfWaus"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09004480974
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993612; cv=pass; b=Y+MyzijpfkzZngroQl0Buz5LQV7/njcYiVEKKwOjpq/iEcaRG3SAo28oH1vMZyczEqWZxkOuLP8S8TVVKwIUKo4eHjFqjTMlijCX4AkqkfwFbeGhnd+BgaORNlf0a/3SZHjrevJUj0Cdrb4vJGuR8TTGdBuyGIpomiSkbUhyrF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993612; c=relaxed/simple;
	bh=UgdKY8d8Awk7EzEPYnWw+mH/FjQ5RVCE8hCcibnZ9lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF7OYuzkHcuXheHx7sXWuva7AXhGKXtcCFpR7y6k9BUV0pFTQcJyIFfa79XnGiKr8UDwvtZzE682YO/azevvbny59F2CtDZ2hzA4D36njzOTiYDcWdk0TafI0GUiD7myMvGiRIog26ArwXrtksjuYyH4RmN6/qj1wQGgZvOJ9QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooEfWaus; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c305f381eso4302786d50.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777993610; cv=none;
        d=google.com; s=arc-20240605;
        b=MwtdZeW9L/aX6yOlswPYp8Pw55O0IZ0OKTP70efaq10XUuF78WPuvOeq0/3EUfev5c
         jqeQP/LUQjKqte3s74diF4voLcjr4ja/8pGO1Qnnw8/XG37+Xq2y8UaK0+wCAUYm1tiV
         P3RCr8aaLbD6+fPXGrgoUNp+IhbR1GKD+gJOZCCpIHKURDHyIPLW0pAAGwizgYG1puDB
         tCHkMNre7wn1nuZ8TMdcaEHwUZd9OLA83SsT+yZrCfBZKl4d4aXoj5Lfe+JfRIxa8CiS
         ZKhvhbgvRsT6luavWEkvr+dpFmj6qZjBpy8/WtXpVcfJ2dU7wOYX2yD1teNoPslbr/Vz
         oxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KK+EABlJQnSkksMiTnYsqKc8DTcxDUuzT52kDsQHSVs=;
        fh=l0fiXfb9eFM6meL1iDGeR/sRgSbKJpPxmqfZjF9lLEI=;
        b=WgBa4ox0XGK949xALy4AoEp9gxPwiZyd1T/SObz9YsQ3Gqa4yVnW1S/gQfncl6YqKd
         8YSihCg+KhMmiWNkefeaCDWsq/exkW6B1klH0uAamYYPHCLoDQ89Kt+cNO9Ynj+CeTHE
         iHg5dGwLUSGyJmtRm9FAAVPAYKZ6F9JQQZuhe9xYsL4Sww5+odzOnk+8yFcMzt5bkgfe
         lAtgAX1KNXTuWHr/8m25laK8on9G1GizGbHm+z7psA/feDnSaYwc2EuY96lWVnuwSNHR
         hnxRFZUNa9wYwZe2Egx9hpEER+KW/aZTUIusGNOa47Zrs1ZpGn+RSeBzVAc0FYfQkH86
         3h1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993610; x=1778598410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK+EABlJQnSkksMiTnYsqKc8DTcxDUuzT52kDsQHSVs=;
        b=ooEfWausCilWZq3ni80VJbO5QWANJ6vonPxQfKk6q6MhcIiFqUf0lwMLgKcSjhMwSq
         bsXsBOZL1JHqjKgZS3Sf7SVdF4oBd326N15H+zMuDjwCN9iLJaYAstCTsKOzuTjmWEXN
         7mAi7CUiKPWhK9H2hnxwb9f7UT82b1l1xo8UrkHpJ4XusvHyVg5WIKQRuEdtnEAI3aiw
         4Rbs9C2+HwRY+9JqekCDr8yj7VbpQWRgTB0mABl+suvDo+2lqFWuX02PpWWsjexK6HTp
         AgyHAebY1f7sOmtsb9QlUicetRZdF1tV3I9kpJDIUKb/4sfB+wP7e8WWV5XRApbKwB7E
         RpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993610; x=1778598410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KK+EABlJQnSkksMiTnYsqKc8DTcxDUuzT52kDsQHSVs=;
        b=jGdy2WPSeoui/qj8sUhKWPrPpOyS3EYTJ1R9gQM4sxyeuWVPB5+ahhmKtB/AE8Nwm9
         JUyoUMDoB551JVHg42wDqV6HQ2MlVTf5wfICE9+PqM060uAsMS/ABiQRQmmTkjcfWH3l
         W/EaQ66xg089ufXS1FW1eoEbDMO2zTDpVU4PWmdx+2ckRUbzPgkdkJV4QyCn7yNUKbId
         z2GCV4Ngz525C9e3apISkO06tItf+6pzNpQ/tSg+9AKh4Hxsl1myZl/xV1LnP1NbNzKf
         mqktOdkT7ey1Lb8H2m4zFphzB8P811M5xJVhgarf4EtszrS28/a4Tc7vHmv7q0d6kBpR
         NQpw==
X-Forwarded-Encrypted: i=1; AFNElJ+pYDjIMcEwyE0K85+PTsem28D7JK/aZUSa4Dy2oHbdNQzFwCoO1WcMyDxQCXPc2zaGfJ1hkcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhpM9dyr/KMSXIjJ3GFOYfBtAeeN+aSC4YTYNxSQLNGCnH1b6
	D7ocfKHCqWxum5HR8ICLFcIFf26RehDBwBLRcNqghn5DV8D/Fi+/ZLLzYnMn7tFFEPG18HfG0lk
	GJdh5etc0HpvOG8sfIFDTZn6ORGebFDY=
X-Gm-Gg: AeBDieuI6SvrmmZvE1qHihkdsK7eKaubZUmrxIwc/7P9wQLQfmYHhkixmcVnFUvXaKn
	9FvcqulNvk0RyuCFfZRfTBXm2UPEzFMcNZGNlA+KPB/tjMYljWMNYMfHp5cMoVbHPSQZRLYlNLD
	H+hr9MhO54D5YYTNKGsv6nXaBZKQ84iBira4Kx4vZw0WAB+BMvvVF2prqXDNIGFbmoO80cDADTt
	4IECmaFmel7/81qpXEqWxBBFej93vzM9XaKif7KqAqBP+vu+94Rl2NoDS5/tUaNIgxk7CpHKLu3
	fu8h+6lWlSYjznHMobZdhVRAfFzunbRP6c8NWiseU35Lgn0Ayei6Cswga/sHQwPo6J3Db7BhUw/
	T3St587j3OiLPm1g=
X-Received: by 2002:a53:ac87:0:b0:65c:6d4d:a22c with SMTP id
 956f58d0204a3-65c6d4da3c8mr2433242d50.43.1777993609746; Tue, 05 May 2026
 08:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
In-Reply-To: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 May 2026 11:06:38 -0400
X-Gm-Features: AVHnY4I2JDyebrVZDyH6RpVPaaCOfJJfQHEg5lVnURoN9r-n09T7ubKx3gMkKxU
Message-ID: <CABBYNZLzyh7a7sZ+0U4DAq8TB6e6=WdNrfKrxGXMqnYAMT0KnA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()
To: Jann Horn <jannh@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A89A54CFFAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244195-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url]

Hi Jann,

On Mon, May 4, 2026 at 11:11=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> Use lock_sock() to guard against bt_accept_poll() racing with concurrent
> close(accept()), which can lead to UAF:
>
> task 1           task 2
> =3D=3D=3D=3D=3D=3D           =3D=3D=3D=3D=3D=3D
>                  __x64_sys_poll
>                    __se_sys_poll
>                      __do_sys_poll
>                        do_sys_poll
>                          do_poll
>                            do_pollfd
>                              vfs_poll
>                                sock_poll
>                                  bt_sock_poll
>                                    bt_accept_poll
>                                      [read ->accept_q next pointer]
> __x64_sys_accept
>   __se_sys_accept
>     __do_sys_accept
>       __sys_accept4
>         __sys_accept4_file
>           do_accept
>             l2cap_sock_accept
>               bt_accept_dequeue
>                 bt_accept_unlink
>                   [removes new socket from ->accept_q]
> __x64_sys_close
>   __se_sys_close
>     __do_sys_close
>       fput_close_sync
>         __fput
>           sock_close
>             __sock_release
>               l2cap_sock_release
>                 l2cap_sock_kill
>                   sock_put
>                     sk_free
>                       __sk_free
>                         sk_destruct
>                           __sk_destruct
>                             [frees new socket]
>                                      [UAF read of ->sk_state]
>
> This UAF only leads to incorrect reads, it does not corrupt memory; it is=
 a
> fairly tight race window; I believe every race attempt requires an
> incoming bluetooth connection; and the leaked data is limited.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  net/bluetooth/af_bluetooth.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 33d053d63407..d24897167838 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -521,13 +521,17 @@ static inline __poll_t bt_accept_poll(struct sock *=
parent)
>         struct bt_sock *s, *n;
>         struct sock *sk;
>
> +       lock_sock(parent);
>         list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q=
) {
>                 sk =3D (struct sock *)s;
>                 if (sk->sk_state =3D=3D BT_CONNECTED ||
>                     (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &=
&
> -                    sk->sk_state =3D=3D BT_CONNECT2))
> +                    sk->sk_state =3D=3D BT_CONNECT2)) {
> +                       release_sock(parent);
>                         return EPOLLIN | EPOLLRDNORM;
> +               }
>         }
> +       release_sock(parent);

There is the following comments though:

https://sashiko.dev/#/patchset/20260504-bluetooth-accept-uaf-fix-v1-1-1ca63=
c0efadd%40google.com

I'm not really sure if likes for the poll are supposed to be done
lockless, if they are, we cannot use lock_sock here and will likely
need to rework accept_q so it doesn't contain deferred sks, as those
shouldn't be considered ready for acceptance.

>         return 0;
>  }
>
> ---
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> change-id: 20260504-bluetooth-accept-uaf-fix-df393cbda114
>
> --
> Jann Horn <jannh@google.com>
>


--=20
Luiz Augusto von Dentz

