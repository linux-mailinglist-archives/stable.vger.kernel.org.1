Return-Path: <stable+bounces-267235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TNqvBkRXNGpyVQYAu9opvQ
	(envelope-from <stable+bounces-267235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A398E6A299A
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 22:38:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=DLTPt9nx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267235-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267235-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 200FF3010644
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FA3403FD;
	Thu, 18 Jun 2026 20:38:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAC343887
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:38:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815103; cv=pass; b=Y6doQ6NWLJ0vBo3A70ID5tqMHJhDbz6hSLfp3cvKyqfrni39QcJls12wXnc06x1MJXqvgpcxiMXqIqwtOz3sMJjXm5/Baf4KtqHmdNiJmbRNvgHjJoepnq0K40zG7SjFDP6riXJn+nqWfZptZ3mdqNyh9pMHCGwi545VYyRKK1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815103; c=relaxed/simple;
	bh=7WSTUoGHGrU/6/+nLs4z71POiUf/UjAJqb690o5xC68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqx7aC+Zq+ZNWJMMMVcZjhozorXajFF6WGWUzmuRiZblNkIH9khsEwKYCgP9fjTysm1//sdkRChVDoTrIXoxnd/upWMcCJMh6wWgNhj6WCvXuRmZuO01q37s6VCIYTNwOmFhwxOg4IeUYbepywWD4Z93P2Wfd8LScAhJcrZiSbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DLTPt9nx; arc=pass smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bed19623d6eso200865766b.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781815101; cv=none;
        d=google.com; s=arc-20240605;
        b=MCQDfRxwhdz4WEqsVI66iSsVTsEKjs+Z81NFoJnG5BWM/HI24nSsA1QF81sI0oqYGV
         IFqsKMRiVCT8toPij4atc2GnUq8ArLeZA95a/M0whZqAmloW0ARWrbIULq2qiYJoavYt
         x3N4J2gJYcEd1vzcTd0Da/mOLHQ0qcHE4PC6liOHRQ4aGnXcsArplwR5tQIvRmvyxw8F
         orVqD5A4VLOLKFWLmMf+WsyqnG59r8H56Uhy4azsR+f1TddNefKNf9fP8JUWOm6lL7j3
         CkJsM2L5HOvW3EKwveOmMBHg+5xlrlLtluJ6kc07sOWWShT6mUwJk7kuuBKowDZZAwz3
         q/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xm8cRsJgKhleptk7QWvSZD4pMUhWO0W5LdjrkZ/1NSw=;
        fh=kcWNCAgGPaMQNRZIfH+9w3DfOLenvpfaQ1hebd93nOs=;
        b=IB5Rg3W44AHpyJIr+rdS01c2NPG04doBAqC5nBxnmzvC7Jh+gNRmYQAI9xXDTYeegc
         LByUkysOkSlwijiEKD7mI3JWd224YK+RoDV09r4+h+8DaYNIQcacyjG8IlIYtROihnyO
         uZGmi50RJ8sqZbPTGrq6e8w+6uz0oKUBsvxlzSgWAvSxlSCRXskgHLzxxMR0ruc+8m3R
         F2P6CciOJzfRu4mQyPgK9wz2TL4cJBbGcLeuZVtk+p4uExVRT5n/RXhWvT5sQLwBzMQw
         Cykyt/txdr+5ScItWbp4V8FhlHP2d6FTLxd/+zWxoCxANDNh5DSPP5fG2xhssN1VE7C3
         H+bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781815101; x=1782419901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm8cRsJgKhleptk7QWvSZD4pMUhWO0W5LdjrkZ/1NSw=;
        b=DLTPt9nxRjNosNQCi2ORG4nGjhY9X1PJfYxMWLcnYB3Trmpj6k+8tW5sjtUfwGJtqR
         j/J3ElFc+ThwsSY0k7d8k6XdFAg7t5BOJHz93xTUS81ZuN6feCQNSE+tbyF+sI8G8qm7
         U2QcqwqwOvaXQGSZbgmWKQBAaShZEd04MxWpz8OgZygqfM4xTxm+3lwbCdn/RzpmA6vs
         tBd4ZyKirPK6snLyZIdOELMyGjwdwZ8tHLaScHMwoFNbKD+Sj8pzlVPfUrWxArsgkCr6
         xRQBMjnyldhck6rBXu7S63A7NFtmslvUWAYMLAwbbQqMpt2jxqdBY2srcDKVE66f2S5V
         l/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815101; x=1782419901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xm8cRsJgKhleptk7QWvSZD4pMUhWO0W5LdjrkZ/1NSw=;
        b=lvyFlckgaGesUqKEzMnx/UicrnejjRFSXRHF1oipWaUCJLZihA5YRSa5seckehfdeb
         1FiAWx+PYM9IFOezBKWPunZWsz2ro5w8WHHeKRvfcI+oECbcA6vHeYNY8sfULG3GdPtk
         e820WnAZlfSbIAYn/KsoG4RtYeiPV4jJifl5zZkCS12IqFrL7wbEfZLIfWzo33L0eCc7
         7cQ2qVANrWtByMMJ3tQmcevZMSiOUMVHNNcWTlyoRXUdhVe/9FxHLXQhRGTIg6aY+pAj
         IgqZ4tGTgymqAHgspGCPz1r4oc9sE41doNeCWh9I969svRkSN7MF0oNkrlCnYw3XM4sB
         nCZw==
X-Forwarded-Encrypted: i=1; AFNElJ/FZ8JRoqjEjvCsjnt64JR6m/JCXdW+SsXlvd0TTqR1TC+cFOdEFA2Rr4iQsH3iH3+Ye6wwZz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYyrB3hK683qbCq96IkIIAaBAu+eC11lr0UZCx2B6nRDw4HGE
	9zSiDphQFEJnpuQyMJPVoXk2XWJOqgIrEBhgXgF7GIy/3+OXfKQvh6ubEcM20UtQJkXpEdEsqB/
	w2R6+VmZTOxwb8n8PJMjtbOpi3qA+UlTJtN5Tp4+R3A==
X-Gm-Gg: AfdE7cnlQtPa1pR0SHhySqWphXqLpDQI3fwKZPVoZCeDcwNoSV/U2YPd2GXmRsThFp8
	MMcNRe9AjmcHyLYO8kCr0nXfr3BQ2mGQ0D0712KfcPjigh8TqBumct3qHgs5lNXJ/GBSF4gKuPk
	Dor6CpAGYPDSS1Egy4YgSwdvT6OmSoqpDzfN8Rge/XoZCPcOBoivzFJQRQv9EUYGPOoLI2t43aU
	ITmxrHr1Sn4sZHUmzOcBS5kFc+9kaErMzriBgW/cVQpHRVcR2qbkFxY9/M0UEnV8E+lqE1lKqpe
	A1CV+3V2iSkPNgS9OrXBNK1CTpMxjA==
X-Received: by 2002:a17:907:1b21:b0:bd1:fe8f:59ab with SMTP id
 a640c23a62f3a-c097b38990emr40815566b.23.1781815100536; Thu, 18 Jun 2026
 13:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203438.667881-1-henrique.carvalho@suse.com>
In-Reply-To: <20260618203438.667881-1-henrique.carvalho@suse.com>
From: Henrique Carvalho <henrique.carvalho@suse.com>
Date: Thu, 18 Jun 2026 17:37:44 -0300
X-Gm-Features: AVVi8CdBZ_E0i9YbxKFz2PoQTR3SZ1g0hIyOIDRZ6GXVcGF09H8qjCXH4cZ5BRY
Message-ID: <CALihoepb4m4xVDKN1-x-5Kr7nSwHJufS+_KYsdWoRYvad65vvA@mail.gmail.com>
Subject: Re: [PATCH 1/6] smb: client: fix double-free in SMB2_open() replay
To: sfrench@samba.org
Cc: pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	tom@talpey.com, bharathsm@microsoft.com, ematsumiya@suse.de, 
	linux-cifs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267235-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:ematsumiya@suse.de,m:linux-cifs@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,suse.com:dkim,suse.com:email,suse.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A398E6A299A

Just one note:

If free_rsp_buf() took int *resp_buftype and did *resp_buftype =3D
CIFS_NO_BUFFER after freeing, this whole bug class would be impossible
AFAICS. This could be the fix, but it requires more changes.

On Thu, Jun 18, 2026 at 5:34=E2=80=AFPM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> A response-bearing attempt can return a replayable error and free its
> response buffer. If SMB2_open_init() fails before the next send, cleanup
> retains the previous buffer type and frees that response again.
>
> Reset response bookkeeping before each attempt to prevent the stale free.
>
> Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay =
flag set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
> ---
>  fs/smb/client/smb2pdu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 318559cd00db..4d6a989748f9 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -3305,6 +3305,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_=
parms *oparms, __le16 *path,
>
>  replay_again:
>         /* reinitialize for possible replay */
> +       resp_buftype =3D CIFS_NO_BUFFER;
> +       memset(&rsp_iov, 0, sizeof(rsp_iov));
>         flags =3D 0;
>         server =3D cifs_pick_channel(ses);
>         oparms->replay =3D !!(retries);
> --
> 2.54.0
>

