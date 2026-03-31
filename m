Return-Path: <stable+bounces-231349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPLdOip9y2mLIQYAu9opvQ
	(envelope-from <stable+bounces-231349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:52:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1919365835
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3119B305F96A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000BD3CB2D8;
	Tue, 31 Mar 2026 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSlHoI1v"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C93C3BE6
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942907; cv=pass; b=dvP++1Y1P+9WHT6M58SZ+jI0QF8zY40xgc3bNQ988tj3vEZTvZimtVnl8YJkkizh00e4rS0AqZNSDdyDmAegt6xBITt500wrr723UrPW/hfwwaBPXBjtQNZrWtAKhf6LnKFgVoYaSwaX6ldcAKeT0XHwc7N4cR/l12oG+yyha9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942907; c=relaxed/simple;
	bh=aWPwc0cTosgJmdbPXI037r01bH5DgAIXxmQX/wcosfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdLQKu8mO18zT/8DWQyPnNCCF1vWCF6X+0Y5JjF6/WT90Q2YqSBP344Y3G3PT+t6EjxbdTnQx1c9XlV9FXfpKi4O9N1szlo2mDFBWQkafoNA4hUtGsBvMpJeBulmKGiLWms7nissJBaozuZxakLXS7muKGUs8TYO3URVYUls/3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSlHoI1v; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38704f70ea3so50747141fa.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 00:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774942905; cv=none;
        d=google.com; s=arc-20240605;
        b=XI6abXdY1wT9iPZLoAxqhwWqXI7dxk46YOM5m4ITlL4yWl1mn1q1gUDT5ihcpEbftn
         0ywpdyk5YezUkYCvLWsyjmaT1uchHucntOfAVsX6KYefv/J0KkLGTkWX/TZnSHLy9K0Z
         b4tONlvrID4afBLcPvmUIxQY6WW2iWeaVu2zYedGvFlMC8ImWoHwDEC1gS6Fkq/BHBGH
         9gU+LzwKXR0qQPFnyMpVd5YP6wjqSyLBrTSZrP7dmISZRvS4TqDPdLnNiFHhFKkP7CuF
         U2TgVo8SakBx4IpZohHjqHd58brh1sI67K72pGbpEfBlA/4TiGr/Dgcf1C7nxpBq8N/L
         u1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KKZX1gxZy4jzOatrXwkZvEdUXieJsQW6+W95OcMVVlM=;
        fh=CHt2Qip7L1ZK5OiZ3DzyNS1ZlxjFiJoQqJOC3lS5mCI=;
        b=RH8vfFY96tFU1Jf+IePASpNPQaVOLyKwmlLV3sZUvj0+6csT/VgYjz7E7AVy267VZr
         Prnk+NCEmo8LO1K7lbO0wCEfDeaZdVJ2UO+5Fwpt8XAHipxwJXotH+aeWmLwOGkYOVJl
         ulENgjSgjQ5ATxG/mBQW7y5x7EsL3fybVD9n5BUXz6HhbwDPgWnkW14zKDeDYjo4pnic
         iQ6MiuIpwcGJolQ69kyMSy60a8FoOuoE499Szk1dIwNC63QlqHGCphcZXbFAz7SymQ79
         bmQZYPqKC9HVcBGdnUvFM1iUO4tkKraIaR+FAuP1dUKBY7oP8TBOEarmHw0dnTHFKUXe
         d8bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774942905; x=1775547705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKZX1gxZy4jzOatrXwkZvEdUXieJsQW6+W95OcMVVlM=;
        b=SSlHoI1vIi2HVARd10GAqsYXtycM5rWwtFIa6r2o2OsYk58qqACn/CyLyMnNoDqJeU
         JxcNloUuMo4dN4wfWhopULnLy9AWIkxx0XF8Y9UhGDQ/OTYauV/95d970WlwL2yF4VnV
         +6IolfoUeGmOrt7DSpwF947Nuh51VC9V2RMeUc87vgm2Mqve/6xKcs8bj4EDR8EzpITw
         ERVTY3C7/5sexVGdEAU2wk+hppVlrCQL+uvxp9/Nt+/RLa6paL8xvaanYzABpaOmFhe8
         47jfMQldpNUvWLJ5wXNoX9m8iOXSjtriF2xSFUyN/A9Y78nmgKnKkCFRtSRXcblU0Z2w
         bToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942905; x=1775547705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKZX1gxZy4jzOatrXwkZvEdUXieJsQW6+W95OcMVVlM=;
        b=ck5IkmPkOigLIg9w6tDH5iGd1bGJTt/sdwWbwncsfduUqXKG7hPCfcaWKRpa9K1Uo8
         B3OgBBDW0Yjyx+aYHdY+WxvZgU4lbhntJ4BNF/XGl4vfbLzUIh12lz0zw97N1awcc2Q1
         IrL9XxmWDo3WefpLURmTXSo5xOq91ptk1sMPSTSHxhrFurRjp6fbo3XemWbzr5cYartO
         WrYUkZ0Q2vDoZ/5bh0vaZG6KEQnVBqJZnqHyUHAdm8LBYSKnpveW6ZWtVc2x6vafE+G4
         EMhj9uw07SxdRnHk9cWzyCJvBNAv/W94MrLmu5Bdpqc3goG7IjelQtRlze84IE9ehMdD
         gUog==
X-Forwarded-Encrypted: i=1; AJvYcCXlSaYOBXS7cUVKif8lMnHwS48eqs4tH0+zU88ZJVcy4WdZVRC8CIlY4UU53SiGs/1YgHc+dZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4a0/Aede7nOQD3ECsCDyqXTpy8AzCVvdixnsiCMDS9a8rkDMc
	qJRrgw8fQuDFy3a7qUcNLy4hVfrAP1FG6JFgwQqCppHytM9nOADBF/HlUs5O+e4Wb+3r9FyffZ9
	3gYm5h7Xc2/4V6HDfo7PValALq6OzU6o=
X-Gm-Gg: ATEYQzzDhtrThZizyVBH4JIHRaf9TNSBUijFT++Y7xsH91Lb+vwBds1FzmrkDxjlRRt
	L09IH5ZfVImOTIi4YoXj3UL2dSVOE/WUoRIUvIyGtpTlkeUqFmt5tZp8EmaB4Ob4UlSylR6Fkek
	YhZE9esyXFL1M1q/osz2q2V1Sgj5sOhSKKHaofOfYfswkiTXS1k0dw7PAESAGOgm4j6xnKU3kMv
	XMB5fx91Oa+cjQCcuzboUAIJK61E6r+Ya96MTMgku3Yld1w2evoI2pOR2v+hV/U00jrf7LowI4w
	T7fP+g==
X-Received: by 2002:a05:651c:324d:b0:38a:437a:516c with SMTP id
 38308e7fff4ca-38c73ff1327mr53062951fa.17.1774942904207; Tue, 31 Mar 2026
 00:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
 <20260328185804.41325-1-xiaoguai0992@gmail.com> <20260330181541.5a3c9f73@kernel.org>
In-Reply-To: <20260330181541.5a3c9f73@kernel.org>
From: Kangzheng Gu <xiaoguai0992@gmail.com>
Date: Tue, 31 Mar 2026 15:41:28 +0800
X-Gm-Features: AQROBzBrXvn1mm06vDIzXBB3QWsVoi1e3Vq6PUpdCG8chWsRve8q_yAD7-HYpV0
Message-ID: <CAKvcANN1OEqXv9fo=cxTEEnq+=qs8NnZBrDTf=FTzdo9rHYJbQ@mail.gmail.com>
Subject: Re: [PATCH] net-shapers: free rollback entries using kfree_rcu
To: Jakub Kicinski <kuba@kernel.org>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, kees@kernel.org, p@1g4.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231349-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1919365835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B43=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=BA=8C 09:15=E5=86=99=E9=81=93=EF=BC=9A
> If dump can see NOT_VALID entries we have a bigger problem than a UAF
> don't you think? :/
I am not sure. My concern is whether the NOT_VALID can be exposed to
user by design.
I find that NOT_VALID is used in limited place.
A representative one is that net_shaper_nl_get_doit calling
net_shaper_lookup to check the NOT_VALID flag.
If it is a problem, maybe there are more paths that should be guarded
with NOT_VALID check.

I use the kfree_rcu since net_shaper_pre_insert has another failing
path like this:
    xa_lock(&hierarchy->shapers);
    prev =3D __xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
    __xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_NOT_VALID);
    xa_unlock(&hierarchy->shapers);
    if (xa_err(prev)) {
        NL_SET_ERR_MSG(extack, "Can't insert shaper into device store");
        kfree_rcu(cur, rcu);
        ret =3D xa_err(prev);
        goto free_id;
    }

Beside rollback, I also find another kfree(cur) in net_shaper_flush,
which I reported several weeks ago to security@kernel:
        <CAKvcANOZufuVeDqPAuMWh0GCiV5pGmmZHrRo_V+_8YSG7Cs_ag@mail.gmail.com=
>
It involves another free of shaper using kfree instead of kfree_rcu, I
think it is also a problem.
I noticed this patch
https://patchwork.kernel.org/project/netdevbpf/patch/20260309173450.538026-=
1-p@1g4.org/,
but it seems that there is no further progress on it.
Except in rollback and flush, all other frees of shaper uses
kfree_rcu, so I think that it maybe just the problem of free rather
than the flag.

Best Regards,
Kangzheng

