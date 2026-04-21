Return-Path: <stable+bounces-240190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKhaCHGX52mp+AEAu9opvQ
	(envelope-from <stable+bounces-240190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:27:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6B43CBB8
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2861301C5FE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26673D905F;
	Tue, 21 Apr 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL8sndUb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7B3D891F
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785205; cv=pass; b=Z79zLEcXODuvxq3+AZTnkYtynLx5w4BykIV+fF7dWRQAGacY3ZVhnx1iA5BZbyRGFC8gdtVlCgh1eNPLWg9XDWJUuePWlH9qVlMYk5su+Ij+cRok5j2+3lE2rAXT2hF91wZ9wQNpK9X+lI64DUftuHK5WNrxnvmJ1NLRoQEkB+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785205; c=relaxed/simple;
	bh=yPHRahqtUOMV/Hb4WJF5/YBWLujURcb0PRjmy2lESXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOOK+t8cUA6oUUu+r7CGQVOvQjJjO8ZamdAzoQuitz8tHBP2x8s6PcZ1bFeVqn+Ar6JcAyG8FACWAb7NdOvzgd+5+VeuvRUg6UEmDILMZmsX2DhsXKrDWt6hxRuPSyYv0UmnuEtQmC3AxIScsV+IrCm06kzTg/uRIPgb9b0qfGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL8sndUb; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65005a8840dso3777379d50.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776785202; cv=none;
        d=google.com; s=arc-20240605;
        b=P/iUtGXFL8sd1CEhExpEEEDBDSovwT/0v0+tWCg2kqJkHX77z3lI2d3SQjZ6ojWEhC
         RPr6slkf4xXqLjvxmpQYqDKpiKEIaiCzGGuRWuYJQhgi5RvuAPwKKs4xdj1Avui0ksFt
         45dyXf5YsbWSmzK88cs7Ivi2cM0yNzkBCN1vtcqTS2qgjJtO06W654bkXkNhRhEAvO0G
         9p4S6KHs45O0ZTjSWCtD7l7xxYnXMyfqvulgUsx31aiqaZRmbEtGc/nTDO+wm68UU/Dj
         vSNEdOKbilhNpY55O5vz6Xmp1ZugHbqta1IsydjTPthgp9Qm5l5Fa6eaWZsvz344CCO7
         E86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gq4JGCjbD0peb76RqIvyQzPZR38TXeWbvqiNZavVYoE=;
        fh=IBbr98MFrc+OjzjBTfEIUuHjCDEEYv22un9rkATwMG0=;
        b=BpZ/NNVv6PYw1oqjyluQmaQbE4AkC+FL04TGmwN8zItXGzYnNGeIogiaAqkJ1YnHqx
         5N1+2kvRvaSOXiSCgYAcYr921EE9whdTG4/ZGUzGLqzMc7OXM125nsK3qxzsbreRSY7B
         oFtlfZg0XR5KiRCk+bK4lXfLifvhWs6/l0WKRdzl9/bxAHISDnYLz7mmnK60KeSVOZgv
         zdZNxA1SukSGeApkZNwuDzWFwn3IaTafTySnTIB20f89edoCN9xsk5s607+AZb4L1oaR
         4of02KJ08kUjGwk19BnOogaKQYjC9K8LY3RC6ooLfdsm2UhPIjQP9PazZFCEA3b+zITX
         F7gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776785202; x=1777390002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq4JGCjbD0peb76RqIvyQzPZR38TXeWbvqiNZavVYoE=;
        b=AL8sndUbEqJnN4LtUsy2isXmtUjPFDsLa5TuM8Gors5ID7DiX+UGK9uQcVAQOLc5+L
         onW/sFTq0TQrFXRlGmisbruq7iwSUxVmW0azZ5JE1vrXHpTklGCpBqRSDFEW8LoFV/Wg
         nM9uFV30p9KCt1FYXLm4bXS+26lhUMjvEM2SNmvJNwwsc3w4HM+bFhPx9vCb3IPSyLhR
         We5pwxSPKgsaFxeYgprlJ2RKLMSxJvZMSyZSqJ65E2qNv7C4vdHVkOR0j+ckK61zqCgn
         B6jAE125sP8UneibGwCr/NezMLtVBUyrGe4hCEa46IH15Pc9ktqG5WQmFlxiCzS3wGj4
         cEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785202; x=1777390002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gq4JGCjbD0peb76RqIvyQzPZR38TXeWbvqiNZavVYoE=;
        b=hhuwD2Z52EiYg4O5fr7coPM/kzeaGGC7eMu5h0J0sr0hR6CaYO/rMNxiBIbVLtDGma
         qWpApBb+WR+xcaXmP4HGgtVUJJM658h4yKkFbysaF5AHmNq79YVBXz6cMTGFpxBG7u5V
         AFQXJCyfJbPYkR1P1QF98u+ZXuB+jVrkH6FNCz/T5RrDgIExY01CIwhWD0Cdde5zZNcS
         F62dqTq4CnTDmW5Ja/W68pcfpqgkXhJT6OvJ2QBgFNnVvOD3n5Ce0tqn39WAFPdTM3yI
         YeF90GRhd8cl5LJ4qjYwojvDHr1esEJ7PATLmDXmYN1AY/zRtDtEpdqXmdNp0tSG0vZz
         TuoA==
X-Forwarded-Encrypted: i=1; AFNElJ+TRPFgvSAnjSylI1h2HGfVU8OfoJ/GHkgd/bq7v2eq3wHxmZaaSCss7Wy4E/qhz4bd190raiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XTUlKyv0fpKSvnJ+8p3Wa/r4TlGlKtq3F3rfZe2MArXF8013
	PgX3nIOzTrWMCNOg9SoyS3xSEpsF5CqDyOS5rgVTig1CFWOlln7Xbyd7O0OzLv0DpRI1rTGhRib
	E6QEWJg8w8X+30VW1b9YL55DJ51UTS14=
X-Gm-Gg: AeBDies46wJ5guGFd+VbJ6IugHiAwMNvgWIeWJTY/6JjFLcxUKlkkF49BIT2OcnW0ZE
	pRVnTK3OVhunKBSf+7KWXC7OxZfdpxwa6aOzdbTF4kMz30WDAhJuGbjucnVnVpmDJA0CScnUraJ
	coDrVYZhNFEcN7l1tp0yuvgnLFJ0wQT94yFzrYHHo/BhBmrTnsMUzFHcODWXOUuL1ooGqteX0gf
	EBgkBymtDjmeOTADVqSlLNiTNHexQmyFyk1euVWaA9YssiUpumjpWlZC3RfP2HR12p3KKXhX3du
	WeW/IRRzace/c66AG69ZhFF6qauTqeJkbAwVc7cbkcuSKFUU1Q==
X-Received: by 2002:a05:690e:1688:b0:651:bcd7:709e with SMTP id
 956f58d0204a3-65310a71a81mr16767427d50.46.1776785201788; Tue, 21 Apr 2026
 08:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421063955.99164-1-sprasad@microsoft.com> <20260421063955.99164-2-sprasad@microsoft.com>
In-Reply-To: <20260421063955.99164-2-sprasad@microsoft.com>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Tue, 21 Apr 2026 08:26:30 -0700
X-Gm-Features: AQROBzCohKFBLFtob7mlCVxxtoiPObLo3LCBJqTRkUUEkaO51_Su7hdh5BVHQMc
Message-ID: <CAGypqWzrOmR6rUimbBJa9qJ-=+KJFzccMjere9dX=KwWeDFe+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] cifs: abort open_cached_dir if we don't request leases
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
	TAGGED_FROM(0.00)[bounces-240190-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: BCA6B43CBB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:40=E2=80=AFPM <nspmangalore@gmail.com> wrote:
>
> From: Shyam Prasad N <sprasad@microsoft.com>
>
> It is possible that SMB2_open_init may not set lease context based
> on the requested oplock level. This can happen when leases have been
> temporarily or permanently disabled. When this happens, we will have
> open_cached_dir making an open without lease context and the response
> will anyway be rejected by open_cached_dir (thereby forcing a close to
> discard this open). That's unnecessary two round-trips to the server.
>
> This change adds a check before making the open request to the server
> to make sure that SMB2_open_init did add the expected lease context
> to the open in open_cached_dir.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---
>  fs/smb/client/cached_dir.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index 04bb95091f498..e9917e5204b00 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -286,6 +286,13 @@ int open_cached_dir(unsigned int xid, struct cifs_tc=
on *tcon,
>                             &rqst[0], &oplock, &oparms, utf16_path);
>         if (rc)
>                 goto oshr_free;
> +
> +       if (oplock !=3D SMB2_OPLOCK_LEVEL_II) {
> +               rc =3D -EINVAL;
> +               cifs_dbg(FYI, "unexpected oplock level %d for cached dire=
ctory\n", oplock);
Should we reword the log from "'unexpected' oplock level for cached
directory" to something like
lease not available for cached dir.? Considering  the client itself
might be disabling oplock temporarily.
"unexpected" might look misleading.

> +               goto oshr_free;
> +       }
> +
>         smb2_set_next_command(tcon, &rqst[0]);
>
>         memset(&qi_iov, 0, sizeof(qi_iov));

Other than the above minor comment, Changes look good to me.
Reviewed-by: Bharath SM <bharathsm@microsoft.com>

