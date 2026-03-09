Return-Path: <stable+bounces-223630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGizK6bBrmmRIgIAu9opvQ
	(envelope-from <stable+bounces-223630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:48:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A35239241
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EC70305DED0
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58E3ACA5F;
	Mon,  9 Mar 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkPschPx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AE38B7AB
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060254; cv=pass; b=WWfXgFaQlH2zyT9VfqXegvV1ZPMpigLUmgQxZskI/Nh9c+85Yyd/e1wRKp6zXNyz+YOGNj8vIYLBKdPh3zpTHA5ID/eVSf/w9YFqBPjyHelnk4fBY3IrmyzVnBYjSqJU8sW6sqk00V0QXaxI0Zha0Q9y08q8UnfM7qVGnwHHkpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060254; c=relaxed/simple;
	bh=ghZjzPATcHPOBiNLTfUQLB6Q/MiIhtQ6K37tFegJD7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4dASbPFVUz2VJyUWDzoFoq2lvCB+Mo+OtxqvHQU1vUfrOEiM6KqXv68FF031NfyW+6Jovs/7LpUYQCH18xdAQHFA7U6QaMH92ZBH7X1hE+hhBsswz4Ygk5iQU1iTjZ27eELWghxk2uFmz+0T7Us3VoVWmEcePrSVeaAhl/L8AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkPschPx; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b93698bb57aso539175666b.0
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 05:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773060251; cv=none;
        d=google.com; s=arc-20240605;
        b=bbnC9Vr77uol6YR/v7rWqaFvXSeh6IrroksVeqw7g9qxc5d4HjJrmGanKwM7jgaX81
         tzQHnuCOoPggoVp/SFcEXgWiTwPqDQpZvH7LzQIYm3pzYCbQmBMUplnwgaB2f9fjvxES
         KpXGdJwB4UeCgEiD6wCmlqNNUGBUWtzF4zULQy3CmuRhdd4HcN0ETssMWicGrhIOxMdS
         5n4la7FXzhhR961qvhjCdCeHjXfc+PweOhF3h7m89w0ogilxqcHrbn1kjFVXIAFFRgJT
         TFWvrCBmFnsM374cVg5+j1sXEuTLVKXnonMRSXVZAkhqfDPYJIHY1KySlJOUnBOVw3FN
         +8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Z7S/QO4us3YQsSc9qxuM/DMfpNt7mt8YV2bewLgj9A=;
        fh=xLU8K8bmgo0dRr+WmR6s8KpCeBhCcDJn15pQyxiDMX0=;
        b=BLVW19rlmtyKXeUEeDbmDgRUAMIxnT5behEdbJeRmkGjyD5cpJZHRSBCIjPpyu5zcy
         3XOZ8ESbwKm2wZArSVVoR04yBf9zQRtXWYji6XZQRvHtzLg8mEYqpCDLoBV8D5Gtq/EB
         jVAjks07b8JgPKMUtp4Lw0va34FWMIgkM+icVMifB1HOQ16zBHn5vq6v4WzRuxJnWRpN
         9T/sNN8j1S4Va3LlUGKBE1xMX/IGMQ7jccRHzS1CaT1HneBumLLiidwOAa+KlBfQdg3O
         FM0SWsXYWKwZhCpgM+419lh78JCdf5H71y7CLvGRL9bkvN3bEh0FfS6DtmMdhLxbgrwr
         RrPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773060251; x=1773665051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z7S/QO4us3YQsSc9qxuM/DMfpNt7mt8YV2bewLgj9A=;
        b=ZkPschPxPe9rWmETB7ab4f1atPm/wTSezLvi2dDIGhriytZGIp4iqJWvL4l9rvTAmL
         469mKn8C3GyPdK9F5UYk0hh9cv6Zni92PmXSNQTkB0ERWMLaYXx7g4sNi2dKaX+yqtSV
         SqRDlpB9fv3lGWfLXgFgLn2SWqcdCOVahWrd4OVK1iiFArnki73ytsLrJ7Obo3N5ZEqg
         HK2dOp1FAOrVBMllwjxTxyn7Lu5SDQsBDm2vNOYDRarWr5F5x9t3UUd3yez5FdvGFo5h
         Fd9S6tke+O5IlIMFXRmVcun3WNgirtsJDEV+Op3JHfKKWSVBCqMLFuNXljsAkYjtw0vt
         b8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773060251; x=1773665051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Z7S/QO4us3YQsSc9qxuM/DMfpNt7mt8YV2bewLgj9A=;
        b=fCAZd7C9G0rOPoZApgmXrSmoMnc+c0kovELMMSGRXCda/sZ5yAni3RE/bK00wsCpRV
         HppbzhVl9y/dLYuqiFhH0ZI5ekgPhgo1qjI3wM+j1YyFgex9gdLFvcnHDx19Ruic/8bW
         3FGL4CVZYJZ0ax9aFx6tNPPJK2IfciTUNukKVFHnG6y2qTfrd1lAQOTwdTVsGQ1vOR4R
         boTS6MoUSLvkSaqfx7gxYpNio3MJ3b5YQew8IuER9v1sMkXp/cuLkMQ7DaAr6roUkSoy
         rBFI9+qRkrFi37/thAPhOLLLi+iUZ5Cgpq5o/BkLjJwzlyYubIihzflDB8gYGZp+jnGU
         iUKA==
X-Forwarded-Encrypted: i=1; AJvYcCXLEYbiW25X/V2aHXkgP7maXgmz40DLbwHr1rM3DjX3jdu084RvKsQD1LgH5fhoiAZ+3SGLE0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hPHMT90gjjMQKqyk4HQGtEnX9ylgqcnRmlsllkmmUiC3VI/V
	zm6fEENU/jCMbKrSl9f03FYgjG4t7Er+1p7P0/8GEhnkrQDeWm/dITFRFfZXumy/jkIOlYBdJC5
	RhBtBu4+lKup8zX8TWH59qeVP6eG2NUg=
X-Gm-Gg: ATEYQzwZwYKR2Vc+vU5Cx/M7UTZzTEZ48TmEVSTyErFp1ZOO4dvhC7MYZoUns3/BxUS
	89DDNwooBTI355eIdFzbFMeEQ9lNbEE+Vs/3TK73cE4E8T1JU6rIitHQ1/09op3GwwGoBPnKMFw
	ixdvLeOs/t9Ms0fE6nsyA3AT4c0XtEWCkBhwgZGlbZGotW/yJAq2C0oEU2xuA2gGKyskpU+6m6F
	8pLhobRxFEpp2vaV0sAneZWxcwOPtpKesJatTiHeUzSpVZkZasrHynLnCu0rFZrvr8ZnkNVpol2
	Sjw5tQ==
X-Received: by 2002:a17:907:d20:b0:b94:827:c561 with SMTP id
 a640c23a62f3a-b940885921dmr839250966b.4.1773060250251; Mon, 09 Mar 2026
 05:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309103049.22169-1-bharathsm@microsoft.com>
In-Reply-To: <20260309103049.22169-1-bharathsm@microsoft.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Mon, 9 Mar 2026 18:13:58 +0530
X-Gm-Features: AaiRm51MeZGB42U6Of-ndj1kWrLWpw3HUpD40MPwjn4ioQmPFdZ8A2eaEwskY-Y
Message-ID: <CANT5p=rzJ2czo1dFE2+oF6tM7z7u5aZKXJHqCn3OBtpMaHBwFg@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix in-place encryption corruption in SMB2_write()
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, dhowells@redhat.com, 
	sprasad@microsoft.com, pc@manguebit.com, ematsumiya@suse.de, 
	henrique.carvalho@suse.com, bharathsm@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 59A35239241
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223630-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,microsoft.com,manguebit.com,suse.de,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 4:02=E2=80=AFPM Bharath SM <bharathsm.hsk@gmail.com>=
 wrote:
>
> SMB2_write() places write payload in iov[1..n] as part of rq_iov.
> smb3_init_transform_rq() pointer-shares rq_iov, so crypt_message()
> encrypts iov[1] in-place, replacing the original plaintext with
> ciphertext. On a replayable error, the retry sends the same iov[1]
> which now contains ciphertext instead of the original data,
> resulting in corruption.
>
> The corruption is most likely to be observed when connections are
> unstable, as reconnects trigger write retries that re-send the
> already-encrypted data.
>
> This affects SFU mknod, MF symlinks, etc. On kernels before
> 6.10 (prior to the netfs conversion), sync writes also used
> this path and were similarly affected. The async write path
> wasn't unaffected as it uses rq_iter which gets deep-copied.
>
> Fix by moving the write payload into rq_iter via iov_iter_kvec(),
> so smb3_init_transform_rq() deep-copies it before encryption.
>
> Cc: stable@vger.kernel.org #6.3+
> Signed-off-by: Bharath SM <bharathsm@microsoft.com>
> ---
>  fs/smb/client/smb2pdu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index c43ca74e8704..5188218c25be 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -5307,7 +5307,10 @@ SMB2_write(const unsigned int xid, struct cifs_io_=
parms *io_parms,
>
>         memset(&rqst, 0, sizeof(struct smb_rqst));
>         rqst.rq_iov =3D iov;
> -       rqst.rq_nvec =3D n_vec + 1;
> +       /* iov[0] is the SMB header; move payload to rq_iter for encrypti=
on safety */
> +       rqst.rq_nvec =3D 1;
> +       iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
> +                     io_parms->length);
>
>         if (retries) {
>                 /* Back-off before retry */
> --
> 2.48.1
>
>

Looks good to me.

--=20
Regards,
Shyam

