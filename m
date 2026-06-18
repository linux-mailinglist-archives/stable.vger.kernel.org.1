Return-Path: <stable+bounces-267284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xF0zHZN9NGoVZgYAu9opvQ
	(envelope-from <stable+bounces-267284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 01:21:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E96A3113
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 01:21:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z03oyUMX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267284-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267284-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7F353043586
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BA1347533;
	Thu, 18 Jun 2026 23:21:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE03385AA
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 23:21:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824912; cv=pass; b=YuHinBZ7SNJU1fvr1X5PjhPnfJ3RaQUbKUJCE5i/4x6GxxIlEUDdWfx7jLz4nLduWm+vKyO7BO6UVEWTyto+sC5hL1F1MQvU+N+I/pLqhBf04cjwJ4Foi3+/hMsqTKWBvK8Vm7Nff8FTAEbZ2q9Q5neepCf6rGRPlgt0537fA18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824912; c=relaxed/simple;
	bh=ce7+7YVBK5mb1J1lThyUA/OeHQ6mPK8XAghbGOc/sDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJH3qfx0XXD5KhbQqjfvSODUUAVQ6hBTX+eOCUAM1URmTSUePKbB7rJJ3X9/KJQKxnLJk7F+oqkZEZmaq7Njbm7+mSyRZkwzTUqSjgP+ODzxrMa2q/Ny+gHQW0ymHboS01Nx81KhcdPLm7zC1W03cZ6rbOGSLXEleEWLXeliObI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z03oyUMX; arc=pass smtp.client-ip=209.85.222.172
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9157ec935c5so224657685a.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781824910; cv=none;
        d=google.com; s=arc-20240605;
        b=YI6XGo/By35/Ezix+n+bkesAw+0kYCnRudCyYm7Vpy8MZzk7BtG+h8qkgYz2WdYY6C
         f5lRV+DL1eBFBqFZ8ptF5K3wQTFNI0N7N9TMBwiZjq7eTL6WyoUUrB3Sy9G6dMzk4XPg
         b1ebb0wiZkLW/w+TFzye0Q+d6MUQnhIv1NiZGUjQgEkLUk8IsjtXTlhwHxmQTQ97FSl4
         eM7Va/YJKgkmauUTo+Oy0ypyI/ntLvJaSwh45+BGgg3oqQQwgGpjNuzs5DEF0Nhwxh+N
         OPwTIx+lgnuhLJq50gH+q8M9NY9BrZ5gVxpIhKhQj5NfdTxZ0b9OH7QDeDwUSRYE5RQt
         lBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VRC/6Xjju81rcRtghBQZKowgyZuVVUJEp1YIosE2KkU=;
        fh=IfthCF31KwhQBvS58fbc56eADKFA3PIrl3O4fRhp91o=;
        b=XFRqdQmeDkZWF/hEk4RSzZgK8xKRba8bVPHhVgEarveeObid8kRg6TKyBCQiXVP9hO
         C7oxUTlUuM34moZmI4AaKfjKNgordDAwk243ESiSJLFMzFpQx8EBYVqhg/18ODw3IS2J
         QP+4r1o8DC437lks0JAEToHs4/qHH0SPXtXGNFcreKzqkxGrS+RCUKh3KxDPijy2uqcU
         gNj9WdA7gaMBVj5Jq57fwCg4TGPFzcLjKM5Dvl0xhyK9NYJRLkLe2OiegX1PUdo8qrnr
         FRTEqRudUxEFO2xQZgSdEoZJLszFGbhEE2O8Fm961YsYx1f9YMxTZn9t3x8gVeMFdgTW
         nX6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824910; x=1782429710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRC/6Xjju81rcRtghBQZKowgyZuVVUJEp1YIosE2KkU=;
        b=Z03oyUMXQkBB8JtdCsQ47x5bzdwYe/ptvI4on+xwVpt3kaZi8V6/g65geJYUoGpXEP
         lHDmElZkNJ/zGoX1jRkkvZY7HDjRHI/xmlsY6JKT/axhd8JC3Pfzg5T6jGRf1p81veL2
         dAZJTewxA6ZtK4P5XW1NLTJvcPoQ7L0d+GxHQOOdW8896fSiu3hIUk4RGnoHqJNXdyzO
         +4L0B5JET3KyLJHqncUplDwgzfK/EOmPJAl1J5RP+EYloXhDrDuJRX3qQEpf2ForYCW4
         7WPeBEf5tkVeUBPc8T07SEW0uJc1OS1y4SvbJOQCY+mznxdpfzXMZ7Lidv56cEWfktIH
         Psow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824910; x=1782429710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRC/6Xjju81rcRtghBQZKowgyZuVVUJEp1YIosE2KkU=;
        b=U1n0AfvPnajm53U1Um1Dy8p8ajEyLzGsGKcm3/Z2ZKTAWEyk1xTD9r/3+yRqtrn7n1
         oMXhaf73GdZptYHJQ5MTy+XaXLGP3wiNWxbtBR2hAYlNavwDZtQJrYlNT48DUsXuzFc6
         0ENJRWzYeLORovQ3IabZJqoz+a8+T0SfFfPHRt3zrxQbpm/u0odw0II5l1c5cYNPsEbP
         gwvQFsMndOsNuDuCpd3IbsGWPnZ8G7tVjnoHbcmTw3+ronfAaXmfEF7uXAzW6kFpdDRl
         T2b3fLhywhXz4QXGcOUUVnuYsddycH4qJBov5d97lVDnIdbmIl/xscyX4Ob7zJ5Z/LBj
         RUcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xWMiSbylOu0+efSfFOFU4/nSRTfelGYWmZODD2D/wPJISb9Lp83XIX1I/3QSlLoNIAxhjPKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Z9pSy8P5s/PzysEgZXQfUMCt2zx+H7gWAoWpZ66Fs9chGVHb
	Kglpp9hm81rVz22ZfTcPJghM2DjWqoAGt0ld+icSAsk/mxMDi7YGpvU4NW44D3wa3KIEL+z/4NF
	Qb9Rcxm5uDt9gvYiOJPd0NP+30NPtNoE=
X-Gm-Gg: AfdE7cklyI66ETHY/v/wZ/qXaS8txGrrHoaYi9tDq01DpHhun/apTt0klxxxUHNCeEM
	fb/wnEDWTy/XCUyQV7z55x4Pwp0D0Z+XsAW5xoiHQYzta5dmuyelsmlth19f5veimOVLmVZvtlT
	Fx5yFapMzyVaox9jabR+dfPn3/H84AAFydoZbHQ3S9B9CnOpaKB3UGzeAOlAKG5Gk7ZoDgYNm3x
	F2EsN8T8H9P7zDShMQxd+6pMbh3CxOzAdAB+V752SJD44yaAw/NSaZg8apu9dkQmaYzV9Y+GPpb
	+vgAT0GyJ95K91uEmjT8Dtcg91RKdAd2dJ6ZpxUGD+TgGcyjRzUmJuGtWJj4f+bdX+iTUoDJ2je
	s4dRXSBBlSyFc6rqh30IpZDSc4XjlkqZ8eWbn1aCgF4ZhkcDDw3+LZwqZhEmL1MgwEo54BR7xvq
	O6kne1rI+4Nao=
X-Received: by 2002:a05:620a:284f:b0:915:cb40:f773 with SMTP id
 af79cd13be357-92092253d13mr196478585a.46.1781824910565; Thu, 18 Jun 2026
 16:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203438.667881-1-henrique.carvalho@suse.com>
In-Reply-To: <20260618203438.667881-1-henrique.carvalho@suse.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 18 Jun 2026 18:21:39 -0500
X-Gm-Features: AVVi8CfonI0tY0QTM_COH8XVvtnyl1oR6XYIRDExk_5J5zNJnBowwug2D2SQ7rk
Message-ID: <CAH2r5mtxg0DZ=BGC+6Jh-+B+y8LgedZ45cqfbgkX7x912Sputg@mail.gmail.com>
Subject: Re: [PATCH 1/6] smb: client: fix double-free in SMB2_open() replay
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	ematsumiya@suse.de, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267284-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:henrique.carvalho@suse.com,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:ematsumiya@suse.de,m:linux-cifs@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD5E96A3113

merged this series into cifs-2.6.git for-next pending additional
review and testing.
AI reviews haven't shown any problems with it so far.

On Thu, Jun 18, 2026 at 3:34=E2=80=AFPM Henrique Carvalho
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
>


--=20
Thanks,

Steve

