Return-Path: <stable+bounces-247300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF/jIOJtBmqFjgIAu9opvQ
	(envelope-from <stable+bounces-247300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B05482C6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 200923005EA7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 00:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDFE357D0E;
	Fri, 15 May 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4DdJ/KX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C135838F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806236; cv=pass; b=HmjWBwzCahir8Ep3bW1iN2VOHVHFe9L2SJRckQnZ/tXjtI4EhEg+u6HLTh148KlbqeqtRYIpCJQAKc718jxntt32EurJRUVRRsn0I6pZN/6aIGBj3Db4QOVXTG0/kE5xxnR3i8/39vPxlcft1X0tzhs8TnucL6Wg0MqgplSXyTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806236; c=relaxed/simple;
	bh=h7aZZPfBiNQip0iF1QmxBvNSaBlmSFlDsLahup/x09I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYx2LF0eD0KPPF/nJuvod9F4VLadPqScvW9cjyCc7LWm8g8eE/smlGxm1RQ+DdGz8Z3H+egytWHcs8iuq+Bj+V40sOqtUBbQ0Mra2vdu7HbVV5z08JClBdmDAPYRYpDR+o01naGmy3Ne52IkU9b16k9Rn1QyCQr+EA5rwhN/eQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4DdJ/KX; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso14873399a12.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 17:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778806225; cv=none;
        d=google.com; s=arc-20240605;
        b=OVSx2vFklYiZJX6IuYvkIHxTGkdfwktjjpUwg+EMVtqkSIMloatrcs2q3CsPE54W+6
         D4OPJOZah/6dSM2NH9iGW20OC6ITBJ8V2FDBSsDKgrfYfB0lMROFQGul67eX7Yv9vS9A
         /xLgXAnfEGXzLDqm68+3V24uc+sbWVdf5viz9gBI7fXfxcVwc1LitwekQNamRbaavs+n
         dRzU/SjC3WNzALdt6Zinvyoe+YYVbCOB7zlQsN0RotgYvacOvfg6PXfrN/Jh1eNrEnfW
         gsiFBorOTrVHMXMxTZWVNcF0uvLZ1PzKvtq0LpT7z9A34InKBdbf00JdrLoyHdkunNIT
         T89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MM/tBbAryKwMsxmUqWSfBVPUIhCFEcLFQJCVxRl3Fv8=;
        fh=zX/F1VLXX6lJxSxZlUHSVAS3a0LGXMPcwDj6zDabPRg=;
        b=lx/VVESQL8ozYqzyeZN8yWElBNvn177ZG+xvCUBilIscb+bYbSQODBU4jTUyMGVlIC
         bceYz9jrWl3HIOxoyYTAXB1DBFZhejkRsTP9DB7hWyvj8piHUl58j/RpgvtVS5Zo+BIp
         uLojZaFPIq5ngEsYcPpiTaEYpigiYOd28AT8ucBYqQD3UnvXuSpGWU9d8cyBQG1JPnWV
         hxFCe6fxe9AxvKG2VwC9hkwJzq3mKYugqndEoluljtunCU/X98aYr3sF0TDupfatidfQ
         b22WUjIt5kAZG17T9G6pKYhZCFIXy2RS3qA7dUuLJeBSPCk4tESiYoHehQaEUFB+2YU9
         tx9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778806225; x=1779411025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM/tBbAryKwMsxmUqWSfBVPUIhCFEcLFQJCVxRl3Fv8=;
        b=L4DdJ/KXK2wYMlh92m9JfF+JRQ2ms5xCGW4c8tC0uLEL9Zsuei2GvBlQQ1VeX1nh3P
         u9GThN76hjHKGpnfCprcUKnpQTORtC2GThTNgO5H/B0FObbdJyaiwWs8n3FQtZIyD4IA
         4RVfgMHQ/MSWwfJHXECtKQ//3CYvYOBqqxe6w4V2DVSkYteKL0M3LUYKK3CmwKLXpOed
         x9jJOnjUEJGYuRjw2gdPBoTcWT4eFwMks7UI+oGkpzROS87QaCaWnJ3QJijELrr0xanm
         jHRvnPhVs09FeIbfh/xPwoi/1XW597qS9iLIsvBWW4vLjYy3x33RhA0p1gX51V6LaY6S
         8jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778806225; x=1779411025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MM/tBbAryKwMsxmUqWSfBVPUIhCFEcLFQJCVxRl3Fv8=;
        b=cLGI+hsddnDWooEDybABvZAyRUZ7XkK3IZJYC4RKFaArQ7/FEn/Ng0zAcUp/sGbRVU
         0s8RYenUGTrtXk2eYDDQ00AY355SqrJHe5wYDvtwt3bwAOPHEP6Pp5gpkXf+ep5VWu7H
         JpLMU6yUnA55X7DGnp0gpQ8t5j8Lv9dGuAueBhoRD+8V7zsTr/0UaIGS3/70UFcYvhgK
         h06EkyAO0r5djaW5z+nBYNNLKCec84k4Iwobt0L2atUYvj5dCVw5u14BDjmTcCW8BGWG
         0XMqZX/ByRCfIRVTslePXWGCdAnZL0VwSrPoqarVk/wsRkrRkkNcVfagWMhAT0SObawC
         Xz+A==
X-Forwarded-Encrypted: i=1; AFNElJ+IyW/7E8ISkFn4E4SO/9Wr9AqwVOVfevO2+nhAK09TETAa29F3y3pN+eY5u7MWParknsWXDZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3zrQOsRk8B0q/KpOksLPgozNtC5beOlnLDdMh7Qx5jQ49E4V
	2CV7wxch6jjeiZk+v+Z4yQfB69a3zvLikH4n+yeWgncwdWvvwSFwW6olbVd6aJU9TDFa4MBgEGo
	/IO/Za8yoCr2kpcODDowJiV99rgIXgDg=
X-Gm-Gg: Acq92OF0TYuT/YEhK9QFVCdKh41dCiGVtnSyS9gmpma3IWFDBnBXkD+ZUUnqfTk59LO
	+Nri/K9AtGxsuC+zYioh4yYKUBRc8l4iJgBzjwE17yz9KCotf7cWy8NAYGWbFic9OPZX1F93vFK
	AHnOKIypBpyYX4qB7v2dnvv47Fp2EncF153DZuY588MvQnFL8htF1LtS5spVIuc6ILJTvY9508Q
	D9HzLNJEludvAEzHlsrjisHCambePKkxspAppTrQO5TKUdz942u9CZNxwL2qi9oGHp9DOdhyBoX
	6ZzOzg==
X-Received: by 2002:a17:907:84a:b0:b9c:aba8:87c6 with SMTP id
 a640c23a62f3a-bd5179506e8mr75199166b.37.1778806225168; Thu, 14 May 2026
 17:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514231825.63211-1-henrique.carvalho@suse.com>
In-Reply-To: <20260514231825.63211-1-henrique.carvalho@suse.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 15 May 2026 06:20:14 +0530
X-Gm-Features: AVHnY4LVtZnz2SQlZ9QCXUQAQJNIRfd74bXKezzuMgWGVmlcWkRm-Z3HpDUfv98
Message-ID: <CANT5p=r1Y3h44dE62DB+VWbGOToQv5CGBc+dR-tr14vah3SObw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: protect tc_count increment in smb2_find_smb_sess_tcon_unlocked()
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	ematsumiya@suse.de, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E78B05482C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247300-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 4:48=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> Commit 96c4af418586 ("cifs: Fix locking usage for tcon fields")
> refactored cifs code to change cifs_tcp_ses_lock for tc_lock around
> tc_count changes.
>
> There was missing lock around tc_count increment inside
> smb2_find_smb_sess_tcon_unlocked().
>
> Cc: stable@vger.kernel.org
> Fixes: 96c4af418586 ("cifs: Fix locking usage for tcon fields")
> Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
> ---
>  fs/smb/client/smb2transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.=
c
> index e8eeff9e50d6..1143ee52470a 100644
> --- a/fs/smb/client/smb2transport.c
> +++ b/fs/smb/client/smb2transport.c
> @@ -169,7 +169,9 @@ smb2_find_smb_sess_tcon_unlocked(struct cifs_ses *ses=
, __u32  tid)
>         list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
>                 if (tcon->tid !=3D tid)
>                         continue;
> +               spin_lock(&tcon->tc_lock);
>                 ++tcon->tc_count;
> +               spin_unlock(&tcon->tc_lock);
>                 trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
>                                     netfs_trace_tcon_ref_get_find_sess_tc=
on);
>                 return tcon;
> --
> 2.54.0
>
>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>

--=20
Regards,
Shyam

