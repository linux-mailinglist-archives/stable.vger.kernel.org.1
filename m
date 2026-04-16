Return-Path: <stable+bounces-238315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JNXB+Do4GlInQAAu9opvQ
	(envelope-from <stable+bounces-238315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:49:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA140F28A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DA273044648
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE923C2788;
	Thu, 16 Apr 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzcjVm97"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A22388E71
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347225; cv=pass; b=tz+a862PhNGy9O2LhhAqqwUZtuw5aBB6baP1nkqz4XHdtbQTsweRT6QzPVHA5qrONsINlN3km+vr6c3nlwxRN99hQapK36xUPcAK+D1KvVIy6BV5Hg/K2fSDXTVZbt4jZcVLxX7GiCp3SLXfaWz5Z3o6tuSkFbDBvRgbp6X1JsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347225; c=relaxed/simple;
	bh=uwqwZWO4cytEM0TWMFqBfKh8P6MuYsz1R5OR8hxVdb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPmQIw0emua4RLu8nKfNtoG5+XKwp4IWDcenYrsz/hCqVHPBnyRm1M+hAeuGpbQ3dEnwtnRaNDGRb1I8Ot2KrAqXrpLXrvceC0EQVC39arjVUZEE4u8Ew3hW1LD6w0R335+7q6rKgsY41zDXpBwb9MX1gZixzbDeOG/MsupfQs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzcjVm97; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso5122121b3a.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 06:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776347224; cv=none;
        d=google.com; s=arc-20240605;
        b=WQRHpOh5kg7KxIGNVGvTFfRP0QQBGPlBMpWHSGvTKx/NJpPU9rzDLufGYslqPtPSnW
         +F/FtmRuTXSI3IorBk5qNJiw/KEH1hXQMpP2MTKp1eqtP1eLv2t8UdlvSbHZDuCqrrYB
         Yx2HLrCRwCVM2wry0Xm8B2mhmvQwqp+Vo7R5gYx4MgVfs8uDDN1mfIjni2PaeQNtFAo9
         dF9b1E3MnMwGmtcREExIXKYoieubA0GJfIdtdzLRNAYmgydPiPpgYPnLaFbCEQ/y1Nuc
         jaMweLnraVdZbsdFyU5VmhOoWrjUYAkaO5pRni7so4ARf8X85rGIvgtKk8wsq9PgL3YU
         o+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        fh=Oy03nKmmqdUeNO/AjDcQsVuUKZB8m0sBv/MXJer1J9E=;
        b=D2HGa7gdz+rP9SwDAHkpyHvqqEERADYRjj1cqsplT1AQmQd2OtjUkynE3vT1Ne9ueR
         pHR+bbmUrKrNF9oDEytAX0zxKVWri4ryT/g6nh6o0WZ08uxKUgbGqPzZ3jP0wLXXIy4C
         BZFsYStNBRnw6uA57lmBAo9rBFu2uLM4IUBiM3u85fj5J0RCilGIESbklY0m+1llOKvH
         RjghX12I/+3Zhr+I91VX/30FO6RxGHGXCYa7p8HW3kYi2UEHoX0zSV06hnvs36L8tMij
         +GQMfKJdxpV7HVpemMqxbXZsbXHe4vNS2kW3ON42fGZaCCnVgT9cFbef2akynJcqRQWK
         /MmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776347223; x=1776952023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        b=FzcjVm970lX5qxpetuut7rZiMR7msZ+WXtf722TG66J108ewgaOmFkbma8556ma62C
         2Ti1HAj0GqJ1oDXOCflTosqvz4lFvqkkOZjDmzXoV9832LeC8YZl49DR0gq77QvAU93S
         BrMlwFOCg31yz68c0xq05Thi/c11EXbDnuP8ybn2YIIoC25C3ewzIk6aMO3qemC/UKji
         PY/D7IbwEA7kI3zS6Vfq8m/YIzZK4ZL+7NRj9/OFyfbMAROlMLQP+/Y1VtSXm6XgYfib
         abCd8tpP7qMHvJ1GtcsAAsY/4qS7svLNV2LAucN3bET4jZQbAxySS189PzjjdnKh+VfU
         b3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347223; x=1776952023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        b=B5+qpLVvuwqJ2XEZTj3Jbfh9rFzF7PccAsE8G22HOJ0i8KACUVirYe1qONZmkb/IE0
         km781If0MTa+5DsugYRH6wX+NHXPtBGOc6mSL5uCdElfdt6rgbqqPAbE5Msb8nX9mu74
         M2D2pK4UF3ClEKiK4CgfPr2R+xMMC7qCGpjGv7wbw1ocyulCiF00672Im4KMjaEZZ44x
         CzHXCpLD2tSm+yE2hQwTaQiyY91pecrJDHH/5iStGyjP1F3n8t9LptI7ONzxikziLvFC
         FAK/0+OHItZKGJ20AX9aLViRXXgYueJoSCZk29wW/DQpt7jkPCCTrCzorbq1YPsoGbbx
         2ODA==
X-Forwarded-Encrypted: i=1; AFNElJ/H1L0ic2ZLPE5sfMEwN08W6iaac4BZIXyOIcgNRUabe41Vm/Gx4d0ydRMkdwrmK4qwkmz3ovA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+G4cAybBhLj0ksB/Rsu+eO4EsWlPF0wzn3goelx2Kbunkwjtp
	qy6QTig14zthUxoBJXuJ9lR+L97/6dV/eFhz2BLLG59fzUBl70qlIAspVlgv4yMHqgDoFd/KQrg
	Ew3OZvpnoNZVJBUpZCczPp/06K+IBTYc=
X-Gm-Gg: AeBDiet+6Ja52eA98dv86hlr9uUFby+hX7GQ62UbP4nqpIYV2OmmW+3ZIWfUSp3t6SA
	T9GAM9hVscXpw9KGSOK4kfGYz4Ka3X1NfqoKJEn1RMHMn2W8nJjT0tFkH/KJ/7/j06EOOKkWefc
	1z+8xPdeN0t/BFXhaoExIYkc+BQtcIoR4b/wP1r6960kqpzLRTRgGtrDnEENh9p8nnuj9swEN9a
	zwcYQONTgnFYFwS3Q/EgpZIhhDLNG1mbS6K64BvAK1zl2SQVgJH9o4EmQc3LsTd2Elu0UcID4A1
	i7aEzxLp5R1UUSS3DLdHBZ09ibuxE+iGdYNs0x28C1rH+3OMy9tr71+oaAQOpVk7NZiE5sj2RWo
	nCT8rtgpOAown0/NmXSnZc2GlKAwBaao/ypuaNvTOWkZaXPb/gJo=
X-Received: by 2002:a05:6a00:2392:b0:82f:250b:9f16 with SMTP id
 d2e1a72fcca58-82f250ba2a1mr20854005b3a.28.1776347223559; Thu, 16 Apr 2026
 06:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416031903.1447072-1-michael.bommarito@gmail.com>
In-Reply-To: <20260416031903.1447072-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 16 Apr 2026 09:46:51 -0400
X-Gm-Features: AQROBzBXABVaL19OQLFi-BeVpvoNvRQFkcBHonub7TDUeEKdTffXEx0BwEBOtCs
Message-ID: <CADvbK_d_T++kjJ1U3g8RZRM8AUTHsrqD47Y3EuB3wZQTxeZ6Fg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238315-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BDDA140F28A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:19=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
> buffer is large enough for the peer AUTH chunk list with
>
>     if (len < num_chunks)
>             return -EINVAL;
>
> but then writes num_chunks bytes to p->gauth_chunks, which lives
> at offset offsetof(struct sctp_authchunks, gauth_chunks) =3D=3D 8
> inside optval.  The check is missing the sizeof(struct
> sctp_authchunks) =3D 8-byte header.  When the caller supplies
> len =3D=3D num_chunks (for any num_chunks > 0) the test passes but
> copy_to_user() writes sizeof(struct sctp_authchunks) =3D 8 bytes
> past the declared buffer.
>
> The sibling function sctp_getsockopt_local_auth_chunks() at the
> next line already has the correct check:
>
>     if (len < sizeof(struct sctp_authchunks) + num_chunks)
>             return -EINVAL;
>
> Align the peer variant with its sibling.
>
> Reproducer confirms on v7.0-13-generic: an unprivileged userspace
> caller that opens a loopback SCTP association with AUTH enabled,
> queries num_chunks with a short optval, then issues the real
> getsockopt with len =3D=3D num_chunks and sentinel bytes painted past
> the buffer observes those sentinel bytes overwritten with the
> peer's AUTH chunk type.  The bytes written are under the peer's
> control but land in the caller's own userspace; this is not a
> kernel memory corruption, but it is a kernel-side contract
> violation that can silently corrupt adjacent userspace data.
>
> Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.=
")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 05fb00c9c335..f5d442753dc9 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7033,7 +7033,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct =
sock *sk, int len,
>
>         /* See if the user provided enough room for all the data */
>         num_chunks =3D ntohs(ch->param_hdr.length) - sizeof(struct sctp_p=
aramhdr);
> -       if (len < num_chunks)
> +       if (len < sizeof(struct sctp_authchunks) + num_chunks)
>                 return -EINVAL;
>
>         if (copy_to_user(to, ch->chunks, num_chunks))
> --
> 2.53.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

