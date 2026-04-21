Return-Path: <stable+bounces-240174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM88DaOD52m+9gEAu9opvQ
	(envelope-from <stable+bounces-240174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:03:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D372D43BB64
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 466843039566
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F73D6CDA;
	Tue, 21 Apr 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5w8ECvy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D563D6CBD
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779946; cv=pass; b=blvBaQ1MR7L+KMj+PqCEwbE8AJLD6o6ZgYkA0WskMXUsGrnEyTi4rHqwzTf78k9q2Fsuv/7G3lPzrCG4ELrzFi6aKK+tUgjSxqth4PVKMgCQiAi4IL/Bn4/mLaSVn13x0dERL9FDwJueZxTnYRLfX74d+c7yVD6/yR8luv6vD0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779946; c=relaxed/simple;
	bh=vngFtp9AeLG5ds+k0SkthlclKPw8RLFOUhDs4uq8AdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgWC1kEGzOtIEKDaYH1LieZzQaYkMwVoulJo3Jn6XM7lZGfDiVn3AiBQvTVCVYzd1cR6ojvMD9kmVco+cZeVy1qYy6cvRaMV4dlLQvZHfduU02YKe7JNo8ArFcO7StC2fGz0fhN0xPlHVGcQF5EujH8SIRmEkE14MG8Ck0jQLGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5w8ECvy; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79ea87af213so73305817b3.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776779944; cv=none;
        d=google.com; s=arc-20240605;
        b=DKKtFKHuFwLUrkcN9pqegL7x2ylzwsW2ef0lF3HBmHo1tNi4vhPQUJtEnRYs8o+yZ0
         Sv3PrFHo3Cg1Ad5brlQDREYrWmND6tpfIplmB5wGiFXgUvuf3jp2jHJ1ksPXnLl7DeWW
         x4Ms0oHT1xRkwoitIKZj71Ug8XbQ3eeTc/nN1/hjXFu3ICBhD4hN3sEHrSzPhPoDdLN+
         ITVg13FKpPFMVnrcMBua7dbwgXofQ6KW03PyUGCF6MBmmGmgzX65AGLBIAy7LxxTh1Co
         NOs2Junz5jsIa6U4O3CSTr23lARtfQ/FxRIcjt3f/UT1GR50JIs/BUTXyu6j5UzpeIGI
         +gbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=roxDXwIduMjQJK6VmEDL4k1Le+y/IZce1Pjw2/5KXLg=;
        fh=R5/UAEoP1ZNEcybvBF/18yddngSi02paIrrs29jqgwA=;
        b=TPH+IWUA3j5VwssTufs+0rYIDn0hf2w4bZnivWJGEYOOfFfC8lcSrtrkaKiyQe3YYm
         pxbD/IL7AIUiC81fa460Ej3NTkT926RvDjUXaEqnWl4DHlQvkYtXNqbIfb0VWvZ9rfiU
         9Bay/p9meyxgenIGwe4mnidFJVKfaTinTJx/YlnFd8DwrZIoKs1zZQyq0XTZDua6o/D3
         TNNYvTWYC0oELARwPAeu6rwK1lkJDwupf56XexwGMSw+3UI+FBI1f60cQPndo/c/u+HK
         fUhAKj8U7/qUdpX3XNwT6Zjv1u7itMNodwTWPUeaRiUVmZqDPmOE37cTQUb4nj2ObKXy
         X6DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779944; x=1777384744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roxDXwIduMjQJK6VmEDL4k1Le+y/IZce1Pjw2/5KXLg=;
        b=N5w8ECvy2V78SnDZyE65AxRxQ+2IP4PQu1m0O+hM/olwhUGAuRgcT0poXCmmP8OG68
         MycuysDNIjEgR0F0ioGwSrPfeF8vgoiyMpfjWc/wsCCXbPfYOVEde92sCf4QRjXPJLOW
         W0BOIsNEg38+R/cTk9eLCKJa4uYHR9iSZ8doScgcYDauzeHSaV7BFDgYXSnz/VYKA6cD
         /G+uzf4No/uYtlnolyHEqaIwsjjqs8BAG5JAUPkoxlu93LuJjsIIRx9WJ5J7uHJF0dIZ
         Ug/6B3K7Z9xsgEKDW2G0Ttp5ga8PAGNgbyXmejK73h7TmT9XVchE7Gx5PJ5sVQWvoo73
         zeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779944; x=1777384744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=roxDXwIduMjQJK6VmEDL4k1Le+y/IZce1Pjw2/5KXLg=;
        b=M0wXhnRdqedqVCFR/774PvgD0o4n0F2QjlHHRCDAtN66XglhDLaga6PnC1ZTVeXuQF
         lDM4OX6ZqAUtKG3thT2Cn+isJCKfqRd3IGWYi7mwtR288klYxosHrcCmw/7sRiZz93HA
         hcTybuz7LTVMopwlZYnm396XDNGqJraFQmbylj8hRqQK/79MDjpp5PLe0orRGcFxU3dh
         Z/+InZgryf1QiRgN5bhUdX1JRGr1I+8nDxqx6hqafujclLy/Uj9/pLwPqH1qopLymy8j
         GERVS2i6wgzH289ZIozG9MD7E+FICJkPA2IbgsJ9i1NYfDEqKIDNWmAnMiRws0MZd45N
         rFSA==
X-Forwarded-Encrypted: i=1; AFNElJ8r2pMYtWvn+IT225Vatloqpz7P2FxHzbSrI/ifVL16PCc80IK6riHcIoSRecRnUNpAVY9nraU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJbaiDcDAmAMfL/VhaRooPWJSoU1rIH6oz7TRR0lV4z9VAhU4
	Yc8IH0TSXkGoBH9S3tvx6bSb2/5yox/XhHAKTkkMM0TnpKDbgwLDaQEFMmiuUVY+w/KXOJiT6kX
	ZLj6E8RXqyCjAMv+msOQ2hNaKVzDjCtA=
X-Gm-Gg: AeBDievGWqMk4xX3TJHOK/iQ7yOCSvp7doeXf58SCE6EwT66YCSqz7uOyTmt0IK0TQD
	/LjdiI1lPxzkJWTgqHugHZPkDhKzo9VW5F6OI2f6YQvAG6RVtLf2AlaRwuWqp6n375jyS71GRKz
	15AGNWSPso9aH67hrmxLWeopAffQqIpOzLSBWcoMXNRvaSmzdQgg8BfDHAYuseNHo30MPtbA/Gd
	0btB/RAtAcCifWX41GAWzsdCsU/4UfU54pN9hnEcqBlXXCWK91XDNoNKvzdZAuG0ebhnla8fSFw
	vDAqGOrkDJzRsyPgyqgDzi6Za8UknCotUab1CCVcr9s7RYjcMQ==
X-Received: by 2002:a05:690e:1384:b0:64a:ce57:cac4 with SMTP id
 956f58d0204a3-65311b20b91mr13031091d50.24.1776779944292; Tue, 21 Apr 2026
 06:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421063955.99164-1-sprasad@microsoft.com>
In-Reply-To: <20260421063955.99164-1-sprasad@microsoft.com>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Tue, 21 Apr 2026 06:58:53 -0700
X-Gm-Features: AQROBzCyLVN1vX3c5odyoOOK8vJQAPPhS4kSDQE94UmW0F0hKsRss-X2OtJFJks
Message-ID: <CAGypqWxMLSdPhpGcomCeokiRXFR5kb+CQGNON7bsUiOPfswLKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] cifs: change_conf needs to be called for session setup
To: nspmangalore@gmail.com
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.org, 
	bharathsm@microsoft.com, dhowells@redhat.com, henrique.carvalho@suse.com, 
	ematsumiya@suse.de, Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240174-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharathsmhsk@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D372D43BB64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:40=E2=80=AFPM <nspmangalore@gmail.com> wrote:
>
> From: Shyam Prasad N <sprasad@microsoft.com>
>
> Today we skip calling change_conf for negotiates and session setup
> requests. This can be a problem for mchan as the immediate next call
> after session setup could be due to an I/O that is made on the
> mount point. For single channel, this is not a problem as
> there will be several calls after setting up session.
>
> This change enforces calling change_conf for the last session setup
> response, so that echoes and oplocks are not disabled before the
> first request to the server. So if that first request is an open,
> it does not need to disable requesting leases.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---
>  fs/smb/client/smb2ops.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 509fcea28a429..3625030d1912f 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -111,10 +111,19 @@ smb2_add_credits(struct TCP_Server_Info *server,
>                                       cifs_trace_rw_credits_zero_in_fligh=
t);
>         }
>         server->in_flight--;
> +
> +       /*
> +        * Rebalance credits when an op drains in_flight. For session set=
up,
> +        * do this only when the server actually granted positive credits=
 (>2) so a
> +        * newly established secondary channel can reserve echo/oplock cr=
edits.
> +        */
>         if (server->in_flight =3D=3D 0 &&
>            ((optype & CIFS_OP_MASK) !=3D CIFS_NEG_OP) &&
>            ((optype & CIFS_OP_MASK) !=3D CIFS_SESS_OP))
>                 rc =3D change_conf(server);
> +       else if (server->in_flight =3D=3D 0 &&
> +                ((optype & CIFS_OP_MASK) =3D=3D CIFS_SESS_OP) && add > 2=
)
> +               rc =3D change_conf(server);
>         /*
>          * Sometimes server returns 0 credits on oplock break ack - we ne=
ed to
>          * rebalance credits in this case.
> --
I think it would be good to add a comment explaining why the ' add >
2' threshold is chosen
here and the assumption that the final session setup response SMB
server returns '>2' credits.

Otherwise, Changes look good to me.

