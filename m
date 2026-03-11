Return-Path: <stable+bounces-224641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEuAL/v8sGnCpQIAu9opvQ
	(envelope-from <stable+bounces-224641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:26:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660025C688
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8479E3110799
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 05:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517F32A3E1;
	Wed, 11 Mar 2026 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6eeUNmu"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3388299A94
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206776; cv=pass; b=E80vxIdJQx/wjaChr0SAi8MZsLW7MiQeuXcJHAQDaBmjIxRA9Y/xb4NdcZSQaWoXm+vTtWBtLm9ugYBCkTV+5QQ1TpM6N80PX0Mz7e6sAORWUdvOjzTJPY+nwcwwhHCaiiesyNyrET3XMkwQpAYINTPBtKbTXWhk8XzoYDjzQf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206776; c=relaxed/simple;
	bh=0v+xe3AN+mBw98yKPGRX6appTWeHt7TBIgEUAHtMt4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFTQ3gonMP8rW40mSTvDeBCiHVSGFJZaa9SgfAoiksasLy7vebRbtqVpOL3L/QWf3jkKyFPtCy9C49Uhq06/oyFKgjFLHw7XDO3whRfUxBRh2k2hieJ1Hpdk2T6qXPOG8HxdkamtYMVwUAYDbFf84JPl3o9/8THBeelyHdBq62I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6eeUNmu; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64caaacb9bcso13251213d50.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 22:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773206775; cv=none;
        d=google.com; s=arc-20240605;
        b=b1IjncQx/2ECyLpHrOY2zSh8exVzpNh17jDjtapNrrdrsVBlS+spiB2hPGwPBVV6NS
         /OOR/IjLivFNgVLuF9pvT1qnEcwnl0V4CStOZK9mygj+ar/ZGpEF/Fe7FdcpeBnHHw+4
         20S4zD5E6H97X04GhXtEe41Czu/po3IR189yqMpLsspeIgRs9jMNhQZENdg0Mu9rY8Ee
         f/QFJrQpmeyaXVffdxlL0wjNytcsB6PIYBuD1FJwtxPkf8HavWP1a30oWRTyPZzH34gw
         R14lPewE4qKAFkde+Q/0W5h4n6dy0ScScy5qoHqKtEu+iTw+e83RiZkyzSnf0gETcjjq
         crvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0aJbLZvpjGRAiKGJsIGIvgjpHquE1jdyy7HIfD7AM4=;
        fh=8QZwSlt/xFQWkZq9TqfSYSOLVTPw3YQf+s6A6UDpGkM=;
        b=YovPBx73HVVPqqyG/3F/fwXIDuiumV1HomsZ3EMgYd5nVK/sswi6OCFWz1mrE+L1ky
         /XYe7SiYg3rAHh0edF1tZJchtIBDD9EN/okdnQRpsyDJ6NB/dmb+8WWOOOQmnEhB/G2g
         S2/3945zT2GOfMvb7Dzku5xzX46G42X1zzoNLgfT4LbYpKyMw++VZugXpaYbPQhVBKMR
         uZ0aQQEbdlNTgX5mtGRXFoV7vfnPEbv0FnTbshF9Xx5x8kIniHJ6TFUFwj8yb5zOt1r3
         NWyCraJZppuix2BvBP4C5WRqwTJG2almpOMzsitVl42ZPQVzBIZTyPCYd6YQz/xbvMkN
         W/gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773206775; x=1773811575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0aJbLZvpjGRAiKGJsIGIvgjpHquE1jdyy7HIfD7AM4=;
        b=Q6eeUNmuiICu3AelSyLngi+s8hJD1oXfehEGTDWGGb9/Dg9YzIssRvzUcdmqpkNHy9
         Q7xXzOt7ZbRj0QlWNVR3BY1IepxYGLMCfPhXzjhZOHD0ohhKxKIJ+CI3MMqndUpdQgdl
         aUVzq3Jg5LwegjIHzSAXF8u+iGwLFQ/HFYokn1M/NxpF319acRy5iwASYd+mH2lZ+FSe
         OUtrsfI16Y1K3BZuKZM+h9gxq/wxc14bq2HaRdO2dv7BvjVCBCeMnnmOR2crfIfygvyb
         NU+5bLn7ubG/nqFWblUDeShZeNVUQKTlawMqo6rR4JzEIa+UbfZDIWHQf0LlGOIi+3gj
         FEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206775; x=1773811575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0aJbLZvpjGRAiKGJsIGIvgjpHquE1jdyy7HIfD7AM4=;
        b=rFOVcSbDASswfeecI1XRLc6ZuM3oWN4gu7Wi12mt+wryRpCC2LnErKRa7O6jzR31Dc
         YumqUg7xjkNNmzTX+8bRxwLiNhPXz9DEWRx1lciXc0vR5t49D3HE/GqB14O/mFPrdpja
         v10YZGzpnlwwKGxdBPKJbXy5bIJzlUfVuaWqeZabwqKnvlhjq33WxM9oN8zRmE80rzuL
         slCNjMIP3C8sQiuzlqSSP3uPShY5A9CZsTAETocRw2ufe8U4UPN1CthjK/fLI0wLePer
         NaPPFNMuok8CtfVIieQmn1NZ+BGANdtxzb+B2R/+Lk2pUucxCC51TQTkW23ZBgREwEKr
         pSLA==
X-Forwarded-Encrypted: i=1; AJvYcCWaJg/n5+RXz+7HjK6PibwxC5j7yDaGNS+QDhxD96K/FbrXCQStvSoc6al7qE1vDNxFG4LeWH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypiaBXfVSpBD69pGWK5OTKSY4qfWjCOa6wef4iAHw/H4iUUIR/
	ZEQuc9Q0RQVOmQW9N6T+Tw+3X7M3Ie37H5aA1hUsi0oQ/IgoddzKEE8e2N6Yip+ynIX7hDXyLBf
	foZz7AT/UEOKAkL0XxSqc/cpdGDCtIS0=
X-Gm-Gg: ATEYQzxcYmiasIwLj1cTZhb6cVJ0xbBcNsPj/glwGpMp2klR2xZ+MRxGNtM9bhKNbT1
	sksaIigOzmvkHP9u8jV6iSdIObBftWsz9imnTohz8RoiVjTWlAmmQsSjs+MR8bDgTuMdV6nDaAX
	NijifZUhL/gWaHz4F8etFEe60clRFDPaCHezQBbxcIWKwhbVbs9Adx/lHlwemjEzMJh5yaI7eNz
	XxUM3qtmindEK0jQXzQUnIGrxRMiGe1NwwvQKkEjrVic6PjivHv0T8llfRf7VjtnLUFXUEHQkGm
	rDT7vHpuUSSgaLPoAABUtE10aF0OrI7IozOcjefRO9zqba+5+Q==
X-Received: by 2002:a05:690e:e84:b0:64c:99d7:8d19 with SMTP id
 956f58d0204a3-64d656a83ccmr1048185d50.5.1773206774730; Tue, 10 Mar 2026
 22:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311051854.2584907-1-sprasad@microsoft.com>
In-Reply-To: <20260311051854.2584907-1-sprasad@microsoft.com>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Tue, 10 Mar 2026 22:26:03 -0700
X-Gm-Features: AaiRm50uaszDAA2-fVYx2yd83rE8HftvCEuttM7UuAGkgSoSOuXPE5Sn9J2W-tA
Message-ID: <CAGypqWzCfeckKxZs0KJuqoQMmHyfb_iJ+ObysO5-VFxGGVJwgw@mail.gmail.com>
Subject: Re: [PATCH] cifs: make default value of retrans as zero
To: nspmangalore@gmail.com
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.com, 
	bharathsm@microsoft.com, dhowells@redhat.com, 
	Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2660025C688
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224641-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharathsmhsk@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:19=E2=80=AFPM <nspmangalore@gmail.com> wrote:
>
> From: Shyam Prasad N <sprasad@microsoft.com>
>
> When retrans mount option was introduced, the default value was set
> as 1. However, in the light of some bugs that this has exposed recently
> we should change it to 0 and retain the old behaviour before this option
> was introduced.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---
>  fs/smb/client/fs_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> index 54090739535fb..a4a7c7eee038c 100644
> --- a/fs/smb/client/fs_context.c
> +++ b/fs/smb/client/fs_context.c
> @@ -1997,7 +1997,7 @@ int smb3_init_fs_context(struct fs_context *fc)
>         ctx->backupuid_specified =3D false; /* no backup intent for a use=
r */
>         ctx->backupgid_specified =3D false; /* no backup intent for a gro=
up */
>
> -       ctx->retrans =3D 1;
> +       ctx->retrans =3D 0;
>         ctx->reparse_type =3D CIFS_REPARSE_TYPE_DEFAULT;
>         ctx->symlink_type =3D CIFS_SYMLINK_TYPE_DEFAULT;
>         ctx->nonativesocket =3D 0;
> --
> 2.43.0

Thanks, Looks good to me.

