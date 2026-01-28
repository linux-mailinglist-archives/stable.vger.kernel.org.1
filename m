Return-Path: <stable+bounces-211959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDA2O4j2eWkE1QEAu9opvQ
	(envelope-from <stable+bounces-211959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:44:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49358A0B8C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F24D305A219
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85734DCD2;
	Wed, 28 Jan 2026 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs8SPQ5B"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC719265CC2
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599998; cv=pass; b=Mororb6CpajmdlCCkONiFsnh2F5irVLVndaqxq2sHuoA7xeVpxQnGrUyz8727IruKyFWnH4R6uUlHeMHpgSbUeZfRs246RjVV6riKJwQnlq21DvkjYQfW+fL+zUqJG0CkWID7iYTpjrUVb0JS87wC08tx0g5kZqGJNV1a4V9DyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599998; c=relaxed/simple;
	bh=Jf9IV6TjsFbzC+hVKkIFHMb0l2+PLFOAjMrCEqOCULM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poXw/ZHmQxTQWZN8eo2M22sNviHz6u0yawEErrIgvotwFSKkp7Y+aB75KwvAfI0qyiE0p/dFd+ZKYKyZHD0dW2p4thwS2wQzBzolsXThqH42Yczi3DiFdRbadGczV9JKu2FjQNgIl/0InC5ncDOMJEsG6S/PjX2kfo3L3fA4DDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs8SPQ5B; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso9572296a12.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 03:33:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769599995; cv=none;
        d=google.com; s=arc-20240605;
        b=kDBxgZ+KreSkIVdtq/FGX0mwGKoPrFegO0kwag0CVVs3TzEE83rCMVV+Blt7yQY0gK
         Q6z32v5qnqZqCYS3UJE5hCXV5/I3MEVJqNeyiQ+3O2XK1O51muQT7Y8BAYH2qdb6+vQw
         LfrpGlnaGZobzi/zRk/L1NkaszbmfZZr69eNiABCE+llGmOA8PGbx+B4sC6qmnbom7gU
         9HG3034Ar0d5i9rI2CVMb4wL1DDMBH2IeBCWldnIypeFqFUlt79rAq/CiG0ShJhTp2Xz
         gxNy9szZHpF0lgulLJadVQMZs50aLqa5v6K4V0BdIKiakJuLsLGhbF8wD324KcsuAZsA
         CLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EmhMCmoAszEPdr+9RsUaeg+95/4OhviuV3/o+ZwYf4I=;
        fh=LQh7eZJoyUQiYPRM1UTl9WsbkHvJWeYg96aT9BGxH8Q=;
        b=FiX041ZN+nfHmVwDsxaeWVU4zIdHTOpe2qIovjIRFK2o4k8dFdjmVt3WN3pTTSfPd3
         nWlfSbN5Kj6eDtwjfgETdvou7uTWtcqMAvmPJ5QOPgVlCdYqmMBpfAJ9r/qDdYLjHE3t
         4mOMW1UQfRIrIrviV86j6ZqLq5R40VGPhqN8sXZF0SBrpTl97Zrmw/vifQUrl9k56xUy
         UABUkJORwXKqzYfZErKCLeQ13mFjj+bPeVJjSlQHHv12FSxdZ0lTZTcYsKNCmJciAaVx
         gmpC5XAN7Fut4WSXBzTzZR6B7KSPENW0rXBDLMv4upnUnLbWiK5jKmZHKxCGLzHGr3c6
         tESg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599995; x=1770204795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmhMCmoAszEPdr+9RsUaeg+95/4OhviuV3/o+ZwYf4I=;
        b=bs8SPQ5BV6MpUYg7rnUafPEcyNbupwakg1HhjOkqfbKtbwlAXaWW3JLsYmGNO/CkZS
         rXquAhE2M+CYdUWGxNR9KjhWvsIsJUFMP02NJQZgavyX8qwaOfpjQe13hoIVjus/rwRM
         0SbHKKLHFO94ENC3olrOQ6bKK99qe8stEcvYMUnL6+UOnpZ7NCady8GMrO91ELGxOd69
         EPRz0CdOE4TE/tKEDDztVVyAf1poFRQNdDXDz5pdto0co4vgb/p/1FWBPwHF+ZRUmPeN
         xFwU11lsNfXU9TU4ecK/fnRfr0CXZX/zA2gcU8E2CQlPqD+10Mo+gJC8s9LAFQOhXPsq
         hDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599995; x=1770204795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmhMCmoAszEPdr+9RsUaeg+95/4OhviuV3/o+ZwYf4I=;
        b=AX/IIItCNhPWbbxe2nkj86Nq1QONmU2K0Nl6l/HmCjDSpQiIhk6bVznDVI2TnL6LVs
         r/hC0aGdqKNzuP6/l2CZpN7J7tzESj5cO1nPZ2aOMS7NiV7H2J5f+EARjk3ZDhBuSFFw
         CO6/qGolSijZTdhVctzo27qCJVjkFoL7FeIQdEVjKw6aKFYNx+EM65CRvSWQzHIujr2U
         ejhxdrQ2NnIfs1NgNo4dB/f+lrfic95PSKH9DhnBW1rOttymOyojkymaSaDaXXA/oapK
         qoKtrFRoJxEu1gadwPMy73KbNBwy3xn5Vb11+pUpsEnZRTQFmmEuw7p2qypDHMKPFYcT
         3kRg==
X-Forwarded-Encrypted: i=1; AJvYcCXr7Ch37j5e/bxDYGkccdMVDivrEMyLDKTWfrBmt4YC9PMgYdzf3gKS4J/a9W/aQcCtS0oVRuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1uYBvKrsQZ9arU8vww/lM/zgQdYHbIG39eaCxRe3Jsmd/Gd6
	SA1AClQbjzj8NTTIiRRGuNNoPPw7oLRqREuhdLkaV83pAIhbZ49F5Fi4/iNU/de6CZrsXnL9kAv
	T2eRKnJ+DYs2kgVN8E88zKy0rIX5vEoY=
X-Gm-Gg: AZuq6aIC5VWpci3PvdEhAGJxWWwqzc/4u2LIW78BAZp3eRissgCEVrZszKHgoyYQG2G
	Yfm1mclG9udRqyeUSYOUVEUirpAI5Av1JbuPnT0tI8fsVRugdumbkVakIxWRb0DCPg4c8z+fH1o
	g46eDta1JhewFHN3ldNzFF9IDvL4I7QiyJl+V6etIynqi8JElQwJHHgVbuKUVo2/QRdGrDhfJYX
	6vjpiVoZ1y2gRUVOqCx5y1hg5KwnlPncbnQXds+e+YQiX/VOqbmI64pXNbAvtZ//QsAGingvdwf
	9sCm
X-Received: by 2002:a17:906:d542:b0:b4f:e12e:aa24 with SMTP id
 a640c23a62f3a-b8dab305bd6mr352887766b.22.1769599994921; Wed, 28 Jan 2026
 03:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127160128.243441-1-henrique.carvalho@suse.com>
In-Reply-To: <20260127160128.243441-1-henrique.carvalho@suse.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Wed, 28 Jan 2026 17:03:03 +0530
X-Gm-Features: AZwV_QgvuJK7L9ge-yU4KMaAK4rVyD9Lbxz2KZDznUMwa1RPPx8swzPg55Nxj4I
Message-ID: <CANT5p=q8trAvAMwVOczAuet2qFV_m0w9a9PJdJEtPhAsf5DGsQ@mail.gmail.com>
Subject: Re: [PATCH v2] smb: client: split cached_fid bitfields to avoid
 shared-byte RMW races
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	ematsumiya@suse.de, linux-cifs@vger.kernel.org, stable@vger.kernel.org, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211959-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 49358A0B8C
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 9:39=E2=80=AFPM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> is_open, has_lease and on_list are stored in the same bitfield byte in
> struct cached_fid but are updated in different code paths that may run
> concurrently. Bitfield assignments generate byte read=E2=80=93modify=E2=
=80=93write
> operations (e.g. `orb $mask, addr` on x86_64), so updating one flag can
> restore stale values of the others.
>
> A possible interleaving is:
>     CPU1: load old byte (has_lease=3D1, on_list=3D1)
>     CPU2: clear both flags (store 0)
>     CPU1: RMW store (old | IS_OPEN) -> reintroduces cleared bits
>
> To avoid this class of races, convert these flags to separate bool
> fields.
>
> Cc: stable@vger.kernel.org
> Fixes: ebe98f1447bbc ("cifs: enable caching of directories for which a le=
ase is held")
> Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
> v1 -> v2: Add Fixes: and Cc: stable tags
>
>  fs/smb/client/cached_dir.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
> index 1e383db7c3374..5091bf45345e8 100644
> --- a/fs/smb/client/cached_dir.h
> +++ b/fs/smb/client/cached_dir.h
> @@ -36,10 +36,10 @@ struct cached_fid {
>         struct list_head entry;
>         struct cached_fids *cfids;
>         const char *path;
> -       bool has_lease:1;
> -       bool is_open:1;
> -       bool on_list:1;
> -       bool file_all_info_is_valid:1;
> +       bool has_lease;
> +       bool is_open;
> +       bool on_list;
> +       bool file_all_info_is_valid;
>         unsigned long time; /* jiffies of when lease was taken */
>         unsigned long last_access_time; /* jiffies of when last accessed =
*/
>         struct kref refcount;
> --
> 2.52.0
>
>

Does making them as separate bool fields ensure that compiler does not
optimize them into bitfields anyway?
Ideally, we want to protect these fields with a mutex / spinlock,
which doesn't leave us suspect to such issues.

--=20
Regards,
Shyam

