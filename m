Return-Path: <stable+bounces-267730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0xkzA5RDOWo8pgcAu9opvQ
	(envelope-from <stable+bounces-267730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:15:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 968176B03C5
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:15:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="h5/7help";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267730-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267730-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36BA9300764F
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D563B83E8;
	Mon, 22 Jun 2026 14:13:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4232C35AC01
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:13:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137581; cv=pass; b=GxYFovi8FcDTCecr4LfHKXeIYJUmQwOyDR0vHyKjvpp1IEkJ+H0BHdWEjM4GaIrzgZrjcOgoOHQCVNoDaT4zE61GwZQAYexwmcJB6ZNMaa6dw7Qn/+B95MTeVR6c0PuhA3xrDatz9NmC6lueV1a8kwgArnhJ5oss1rMPwifx9s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137581; c=relaxed/simple;
	bh=h3DXxfjnoRBKb9Q5qIM0GACEbU2bDotjEwDf6nGdF/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnVL0HqMSQcULICaMpO+SH0/daw6hpW6sBkC+R2rfyDkB32EWJGxKNL7tQvVFl1NWctWwGaZvz5hSJKYe/c0Kvvf9ZIwH6vC943RkOiz1b2MIWSg+ZEMMaFw82+JAKewKpPf5G+xy5mSaojQd9VKrxw4SNX+PspHMDwxcaTtKDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5/7help; arc=pass smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c892935bcdeso1735866a12.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 07:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782137579; cv=none;
        d=google.com; s=arc-20240605;
        b=G+dHwWXaGTNlOzFSpsFSKrm857TOh/LaFueee4OyOkZ37/ykIIWHsoPb38BcNYG0SN
         URkSyy4IGMMtLnzWzsJvlgdohPulZTusHCUnv8/Ay7EMh32EAU6FeYEoT1i2qjf7EGzE
         pUNvGGD1Ksrwr5QNuQ+jp0zDZyaZBUXVsV4qnaeyaGA1xR7B4WGSBHlDnPOE/avVFRdk
         9v2e6D0q4rFFwgXPHgZLwgVcXjdVQZxkpbIS05Rhg+Hn7LTveqnHN7SNGybsycbC+kAM
         OWXu3QeWOKIHEKkCb1I+49UzFLQJkGUn/EDUKcaEusWrEpsWxngTrA1sTVRSJ7tfkffi
         PYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2WqLWQyMsQEzVUJqDlsxo34QmoBE3Oqy9iS0ZLJYAM=;
        fh=DXcK4uwFZpsCw1o0UhgYNae7RpjY9CtSY0RWmFPwJNc=;
        b=SLMGHMcZr78xz8bn024zGcCjZawJZuX+61FmFFSTOOS8yLH9nkBkvgGq3YzXrwbBM5
         1JZf3g9hefvuTHqYYno0foNirtKDMxwWNOxmcAMRxSCJ7QyeRkzErL0P4I67FbcfetdH
         USiTSaxEaBHfx9x+KVWwi8pnkabQDwl2+Hi8nuI3m8xl8AWwx0NVrQZdBOVqe5dpPED4
         CTADTpgMzJLlP43sUZLDhY7aKpKTMbGAF1nQP6GIwxVvCKvXWe2wedpUYoo58S5oeGqE
         drdr9Ws/xSK1tNjCTobc0p5tJsi/fe+WvNprHcd2vL+U/1Y/YOCk8bnzCxKyu1reWoFM
         jd3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782137579; x=1782742379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2WqLWQyMsQEzVUJqDlsxo34QmoBE3Oqy9iS0ZLJYAM=;
        b=h5/7helpBcsWdizArN7vpk9kNZpuUfwmxvYDnFl1rPUYnFiaXdoieDzZc3yckXQUs1
         2GczrL0bZyiF8bTeZKG0eaSh/IqgCBg8YPwevxvh+5q9KPME201/rg065CYZ5rPuTMcb
         rKR1xBgdFcD9lgqqdYOuiQl/1LbDd6+2MoowURG1U9bAcHkQb15mH1t+seqcEkPvJq8W
         m/yxzLzptFaUzEEsxwWo7szJSDAnksYNH/DoSxP0qerXe1CXJmVH+MOPTH+culT0F0dh
         p1EhckCXVh7XmALkxMHWu0MThfgOvFSyKlD6j3MSAYC6l4bh3nuoSK63KaJJZTT4TMLJ
         NFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782137579; x=1782742379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M2WqLWQyMsQEzVUJqDlsxo34QmoBE3Oqy9iS0ZLJYAM=;
        b=W3fJ7qj/Qikd0r+pfKiZVzFgp1/8BiOOspf4daYqrRzNQiT5AbUqm/AktCuPLYIZYF
         JSbDekuZPXnDi98gsc3E/aVfma6cUu1UpRqTc+Xis65ICRSES0YNbAzeZrcUTNz7Qc5A
         20QPl+MoEAWr6K0cfSJiENznFhueROw15Rbuh4eZdZQ7/mA/YVbxM3tChf0V+C35f2b5
         nwsI0bT/+XqVBIQqWg81MxHcEXSdMLIBOFV/lhBM3Hxm/i1YathB+DCkegQS24rtZoUT
         1jTrPxiV52lXLoJhVg+AaRAdbLEy7ILJDYKKnZTaguchb7FRzyY4czrB7QqdcZkaFUis
         i/Yw==
X-Forwarded-Encrypted: i=1; AFNElJ/tqOkMwNAQthU3kaCcdtJzRLcTijqb7+tGkTx9pSaWCUAN1ZmC/+tcyo85QndKPNJ1lCOtCTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaSek7QOycaMOLRbCuE/bJlm3HXs7FFLV89rq6uXug5AoH509
	IdLuriJhqe5NhdvedmJqYymRuvrwbMfRYu01NpkcZJtJY0snD/VmkyaXMZAOumzHV1VtXrCPu1o
	C3YStwG/Gyinzc23s2HcFhsrqwNmoadY=
X-Gm-Gg: AfdE7cmjra5YcoXhN+Ei8n3ylzo/kUXxb3tiNYXePL0tvMJKUZXu/ih6K+ipa4RcZlR
	6HoKV6x9Vk+/0y0Z9uC/feilUXZ135TJZG21YF3MhVKEP7j0mfmY+9/j1MXQ7k8uT8i9qYViub2
	+pTNDrRz2ma6HK8eftkLr6e1+uBUVFFE5iElDlt/UnrKxPCEWx8GudNUDk7Ab963vW9codaTEx2
	5t53KBPjS2mrjY6Yka9q1MXNJn6sk4cMFZ+EGa9spN4+CEeLOUt50JzTfbdMV7VJzCFZyc7
X-Received: by 2002:a05:6a20:c99a:b0:3b4:65ac:e2e6 with SMTP id
 adf61e73a8af0-3bb35b6e77amr16196992637.36.1782137579386; Mon, 22 Jun 2026
 07:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com>
In-Reply-To: <20260618232149.1780219-1-tristmd@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 10:12:46 -0400
X-Gm-Features: AVVi8CemQ0t_rTSck1wS9CobbvsEmXex-9Y2SukK4wkFUT5aXCPPWsw3QZQQIHA
Message-ID: <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:paul@paul-moore.com,m:omosnace@redhat.com,m:richard_c_haines@btinternet.com,m:selinux@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267730-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[stephensmalleywork@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[paul-moore.com,redhat.com,btinternet.com,vger.kernel.org,talencesecurity.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 968176B03C5

On Thu, Jun 18, 2026 at 7:21=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> selinux_sctp_bind_connect() reads sk->sk_socket and passes it to
> selinux_socket_bind() or selinux_socket_connect_helper() without
> checking for NULL.  When an SCTP ASCONF chunk is processed in softirq
> context on a socket that has been concurrently closed, sock_orphan()
> will have already set sk->sk_socket to NULL.  The subsequent
> dereference of sock->sk at offset 0x18 triggers a kernel panic.
>
> Add a NULL check on sk->sk_socket before use.

Is this sufficient, or can the sk_socket be freed under us after the assign=
ment?
Do different callers of this hook provide different guarantees
regarding sk_socket or are they all the same?

>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  security/selinux/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c8..e45588563caa 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5717,6 +5717,9 @@ static int selinux_sctp_bind_connect(struct sock *s=
k, int optname,
>
>         /* Process one or more addresses that may be IPv4 or IPv6 */
>         sock =3D sk->sk_socket;
> +       if (!sock)
> +               return -ECONNRESET;
> +
>         addr_buf =3D address;
>
>         while (walk_size < addrlen) {
> --
> 2.47.3
>

