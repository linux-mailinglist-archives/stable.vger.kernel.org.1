Return-Path: <stable+bounces-225404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF0eJfrFtGlIswAAu9opvQ
	(envelope-from <stable+bounces-225404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 03:20:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40C28B616
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDC95303432D
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471111EBFE0;
	Sat, 14 Mar 2026 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKr6qUSF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB52AEE4
	for <stable@vger.kernel.org>; Sat, 14 Mar 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454840; cv=pass; b=aXfHIErAWogprIuybz82ijn8jXlco8RaO839HzIeW6rhL9glPF0VGfFwmHJGDSYC5LBGYZECU6/q5M8pmfT1Gh7aomja6H6pD/bjkIOXPUMzD69MgJbPkjM/q0SAygjlsShDG8XYgfjE7rdroif/WyIh8g6SuYv2tAeNKINqet0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454840; c=relaxed/simple;
	bh=dkdvt14/uh2hiuglWb2K5y94R1J8fmJqMRHUU6mPDXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZ8QWVFkmmSWZrOOrG4JPIeL4PgN4r3ADO5+VJ+fI0IPloEFfEkmr/S8K6P3sLbfIR7rlxGtKTcuBCk5+6Z9Kn9j+kukGhtUqFkuT5H3qQpVVUiEdhL/65rSFDbiCYuSnShZV6OOav0GhGcYc/pUdTuyHvM9zwdiFPaXkD5qjTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKr6qUSF; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso37116306d6.0
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 19:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773454838; cv=none;
        d=google.com; s=arc-20240605;
        b=GmCrfjZ1cYg++Gnu1yEh+Pc/npjBGah7Lwu5zgFhyO/XuvM9hiG+IjR/2uPqUt+9jm
         m4H5XsBdTX1pwboXXc0MiyPrBTu8DHv+qZKzUZC6/231fU5s8k+SEMt8Jsuoev8aqcaz
         +3UciQEgzVfOYHDgOjuyX3WnTjFuUC1hsIweDEQK5Fn9xgGKUnI5fEN2JTd+1zNeFZmd
         MyE7uZSxqtsiqhDh7IUGyMOPljce9CwEqICSqxI860XkHAr027wc1hwuSPmUDwRBsTSM
         aFkS/arCFv8KnWPXAUEA0kmx8tp5hfOMR/plQ3VpFnYpv4QWfsVWk2DGZPVV1PZ8paVQ
         fRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ditbEY4Rl2l5oC5HDC28rMAUb8wx4HWclIDbLpcmS2o=;
        fh=Vx4Pl91hInVT+poUEScKtu+l0dMRkYYmu84YDsXUsl0=;
        b=abVYwb9ryA/vy34F1VQ5bn3BzwFYeS93Zy0lV7cIbDSlOwmF3LBdktWhOZ1FWsemRm
         zRI+kzl0Hu9RX/xL61xxMmooHyPT8FA7PINHN41aVLWTq+KvSWNMLifNCV7WcX60oitz
         /WPsk9PqqvDmmX75DD9EWuS+SuPkqFqYNWmnwe+eCnEWlwME96O58fz59jujOZq3v7cx
         tSQx73+1krdiGD2gx7N8Vs0baF+22xeyiXuc4/bECylLgp39DiMslHC243I6G3Oc/Riz
         pyKV6B5he9xZPQenR93HT+IBKDLPPWPYCNKiYVkdwn0xQVST3hOmTOayeLzImns4bBfv
         jI3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773454838; x=1774059638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ditbEY4Rl2l5oC5HDC28rMAUb8wx4HWclIDbLpcmS2o=;
        b=FKr6qUSFLhAWV8gH3auF/8e80HgQTTuDykzPeR/oHTPLHwjvcjlsrb64xTT3Q9TZaG
         fEjPnsHlZESSOgkpEqcpQF3D1Uw4lSBKnnbAemXG47YdcGTIZx1/GnqsFyLjzGH+HBxS
         kRvXltBTEJ5RF4WpQsQcYpxbXwCafhuLD5LZoWtBvzjMnDWUh//wL4Ru5zgPPQ2xEQ0u
         Z/ul48V4EywAGagoz00zfHSSljh7wSOsaA6mHBlsJcDPjTqW22J6rSQdmXj8frbvXnjr
         T6rnJj+yY4qYai1525Ul6JJMm5twZ5UgQcqXHDE+Ywf6X1Lfwj2Z3+tgIaScRS4BbSwM
         nhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773454838; x=1774059638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ditbEY4Rl2l5oC5HDC28rMAUb8wx4HWclIDbLpcmS2o=;
        b=g+T9cV1EQeWQ2kEmLoIHzUvh/pKP2l8tiJItAVBh0qmEDGZEhY+SWdEYOdjQKazpKg
         IfG1XjNbLIUlcBlKTtPWRyQX0JxTXN8AYSQIRQZ9WMjeePIzMj2xmYFyKSR8/uNaGN2x
         wN+QBjwDDaUum9KJqwJOX2PngZjceL/rSooGq219Xm/jS4PxfxDEMy50wXEkjfWGMpHt
         0QzM7ENPiq9BwuwkdvDCgph4FF97QytpxDK6CDRLXlm4NUoQ6gbAGybbCAGLt4naLkLc
         WQCK9jHpbWSy5ViuG7yu+aB1GxZg7ZlMxYVd6CqFt6+ayx/aUTZlX3Nlu4UKwwIchOkG
         PxwA==
X-Forwarded-Encrypted: i=1; AJvYcCWSe/whcfwlBtqocrKynD070hI04TSzlZ+to20CnEf85/Cox0KW8Jp2NospR6S4FxthrS+zzNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEo+OEjkJj3Jsdih08IGukrXkuTY/Ea8i1zprs4DhRjy9ZsBtR
	/qbaTXA1OcZgKQv57njSYMu9nCUJwu4cDAjFIrg+mei6nxds1NGeQW9LmtRa7ea+YmK8tRVotJu
	jd9wUsipbzmQUgHr6TSfUHpsXiG8IlxY=
X-Gm-Gg: ATEYQzww7GKqM/tZXadJiJ/I76f0me6FoJVlouEBNZXUxTcgjMmLnstRw3lCa0sV1nr
	hoikVwFC4Hq7Pw0/4LRunmfS7xXGWYp2fI3NP7xH2n1rPvHIQ+gVudCkUFTSHzvcb7Vcmfsirdl
	e2Ifj0J1SXXlGjjpKfHvh0BGnwducwP4MiWJhU22Og/yKUPXEPipKSD5XksyIADSJcascY+A1/7
	Y30mBjnNY3/E16AM19XqNvW6lQl3C7RLo3oFcPy1Lj8sYYl0OEERav6RHAhHKtKvhTCgGcrNMsK
	3bWAJryLBtL0XyVe6Zxs2jjazZxsoK3s7YP2eJg1vtvbUurjsKmcuLhIyf3Pc2os8eNKWYcNMuT
	NhBYbxTTNjJ+AIaSWqQsw2r6KwgPpd7+H6dTSFd7Uo5o/4kUOVXHSCJMvmBXMpUBlB1SAfiwVfP
	j9Mcd26ki8ygiRiReiPu2j
X-Received: by 2002:a05:6214:daa:b0:899:fd8c:55c3 with SMTP id
 6a1803df08f44-89a81d5dc51mr84030196d6.22.1773454837743; Fri, 13 Mar 2026
 19:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313034027.933719-1-pc@manguebit.org>
In-Reply-To: <20260313034027.933719-1-pc@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Fri, 13 Mar 2026 21:20:26 -0500
X-Gm-Features: AaiRm52Dy-1e-FsV94mLe3dvkqcJC6jhGeQ2Y47QDtUq_0BpJcu23ZXgPmm-eRk
Message-ID: <CAH2r5msVE8d5DKM+E06n-LVVBOiJyRmJ_pfSD7Ksa7PTkZm60A@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix krb5 mount with username option
To: Paulo Alcantara <pc@manguebit.org>
Cc: Oscar Santos <ossantos@redhat.com>, David Howells <dhowells@redhat.com>, linux-cifs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225404-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1B40C28B616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

applied v2 of the patch to cifs-2.6.git for-next

good catch

On Thu, Mar 12, 2026 at 10:40=E2=80=AFPM Paulo Alcantara <pc@manguebit.org>=
 wrote:
>
> Customer reported that some of their krb5 mounts were failing against
> a single server as the client was trying to mount the shares with
> wrong credentials.  It turned out the client was reusing SMB session
> from first mount to try mounting the other shares, even though a
> different username=3D option had been specified to the other mounts.
>
> By using username mount option along with sec=3Dkrb5 to search for
> principals from keytab is supported by cifs.upcall(8) since
> cifs-utils-4.8.  So fix this by matching username mount option in
> match_session() even with Kerberos.
>
> For example, the second mount below should fail with -ENOKEY as there
> is no 'foobar' principal in keytab (/etc/krb5.keytab).  The client
> ends up reusing SMB session from first mount to perform the second
> one, which is wrong.
>
> ```
> $ ktutil
> ktutil:  add_entry -password -p testuser -k 1 -e aes256-cts
> Password for testuser@ZELDA.TEST:
> ktutil:  write_kt /etc/krb5.keytab
> ktutil:  quit
> $ klist -ke
> Keytab name: FILE:/etc/krb5.keytab
> KVNO Principal
>  ---- ----------------------------------------------------------------
>    1 testuser@ZELDA.TEST (aes256-cts-hmac-sha1-96)
> $ mount.cifs //w22-root2/scratch /mnt/1 -o sec=3Dkrb5,username=3Dtestuser
> $ mount.cifs //w22-root2/scratch /mnt/2 -o sec=3Dkrb5,username=3Dfoobar
> $ mount -t cifs | grep -Po 'username=3D\K\w+'
> testuser
> testuser
> ```
>
> Reported-by: Oscar Santos <ossantos@redhat.com>
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/connect.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 3bad2c5c523d..8573d5c5235b 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -1955,6 +1955,11 @@ static int match_session(struct cifs_ses *ses,
>         case Kerberos:
>                 if (!uid_eq(ctx->cred_uid, ses->cred_uid))
>                         return 0;
> +               if (ctx->username &&
> +                   (!ses->user_name ||
> +                    strncmp(ses->user_name, ctx->username,
> +                            CIFS_MAX_USERNAME_LEN)))
> +                       return 0;
>                 break;
>         case NTLMv2:
>         case RawNTLMSSP:
> --
> 2.53.0
>


--=20
Thanks,

Steve

