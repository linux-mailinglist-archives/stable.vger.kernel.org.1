Return-Path: <stable+bounces-214543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAQDJpvphGkj6gMAu9opvQ
	(envelope-from <stable+bounces-214543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:03:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED24F6AC9
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B57F83007497
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61330DED5;
	Thu,  5 Feb 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw6I11wU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BA30DD2A
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318229; cv=none; b=iw/S2wrVK7Y9FuaiJQLUjSWH/XyQcITzqiWoqs6MFwuUMnN/8ZD/lgM9z0NN/kM1p/EGL5WD0gkC9LEBFXW9s4ZiU8XNvFbN+Y+ViD+jB62g0pB/TFqiMTP42dqPiqS6HXiGqRyeGp27GYLD2ncDsd9lUlr8jQbRNC12rcayRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318229; c=relaxed/simple;
	bh=/wD2ni17a+X09DLamcGiBxtnqEVcXchS+9wo3LaM3xU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDmvXcQeYD8kT5XiYwv6jHY8wBnNo+d23Y4xGtRKxHwFNX63TXgOWtUVlEcQvI13ElpnJoSKJdiozhiy1+L+rQqJnnm9E+UViXNtovdGc4p5z81wGPKczHB/v3iheXrx8s43/uC9VZ4skaa0PtLtW0xT0A9ipM3REtlPh8nIglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw6I11wU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48069a48629so12224085e9.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318227; x=1770923027; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Laz+RPoNLyJoC2bBJYm8bZttzdcZ3Pgrc3YN6EdV/1U=;
        b=Vw6I11wUJ3Eeqrrfy2t1h+ZHAHQv8cWJ8syejGn4GrwNIaLYe6yjLPopKQUw7hMvN6
         6yei9QaaZhXp3TMBn0fx4v/9rGRdjw3r/ivhs7moo0BrxAv1BJ1R2YN71zVEIJJWJxKi
         ceNG1kR4zdVX/yCLnQKzc9wqOdZgvALsjd3j7rqkMD+tBdH9yToQevxwwn399wtjTRHA
         kjnIuzubD4jL/+QIcnVb1+pKKA8iu/SSackuOzJmZJFpHcE0BE0Yn7MJJmY7rCaodqis
         dqLoFrM+sG34k7lrYqKb+lMwLsZAGBVEX1T6IhQi2pwrCgInP/keTwieiwFXZKfpSvU+
         FO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318227; x=1770923027;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Laz+RPoNLyJoC2bBJYm8bZttzdcZ3Pgrc3YN6EdV/1U=;
        b=InXb5EolBdWuwP5d/bZYFejao2+/rBH19i00+j3shMmXOMx/9YCZc4iKF9+014tT+Q
         UMn3Pt0JpA0qzdNVEXG89IOrIT+KP8fW57Dg+UX9aREXa8JQzvVCyj19Q2+5Yok34zxG
         852xcYNTe9nbEMq/f8YMaQenw9oMcXXhmcYERp607W6IKEtfK4PF/Wz5ySwLsR9Fi9q6
         WY7gV76ABaKDz1ZEmbKbEi4azZwRASaaqPejrOitGoUCV9F+p4q5s/nB4nAy8nnSFyEw
         CkeZWVZjzE5Hnj1e3S4eVghRutGUdr7VzMK4K8noB8Wn+Gp5y3bxFG0ylxi5AUS3bLVQ
         PJ0g==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1tQXoOpZ0BDPIscwfL9ZK/PVf3WWCYykjW0+eVBsNkf4cg6rdj00LHAbVF4ajAShL2OcQjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0o7YitNt6YCkcUAYr/UERMdp2/Q5frbLQnxpwpSvXPnb4yJti
	g73Ls7Um81jDJc97Ef/MSSHCwD1HEAfR5N51I3mSdF80f2xtym79aFlm
X-Gm-Gg: AZuq6aLWAKH9AVmepXNxkZXtnAllyMNck7RuC+o21vZZhd2kq0WTJ070cRmyQdOpyDd
	q8foXPvIm6c882I7HrjrxxazahEFSdYC8UKKFJN7GGhqoyjESmCW6Jv3lYE218KC6OLlqaIWQuu
	GEO2DaePgEEm1SSJeemGRK25X7s4g+5eWZN3Qeh6/ZkbGsZLiuRey15YCXzH3qneDhvDAZtw/xm
	c191PBKdbZOXsQAERk0xPopxLMn3XE8hyw630jsrnqwRDKI0Ssi1C47XZk/R4pAXp2hBS8sL8FL
	FgcE4wYCa6K6BXRx45Ai+71IJXq1zaNCy1M4vjfPjJKF0Ks3k8ckz4pLkF8ktYBYsuu1/Jo6yT0
	L6jD1wnpgr1qKRUq9rne+VV7LeFnSp1obCrBR4oFlgdaS5lK5YrsfFg1QAEfiBycxBm8YkWOFe2
	jqro5Fu17XXbE6EN2i5V/7J0ZVomb90j1syO2vLip5HZVV1km0024+x6H9FLHiAd/MnWw=
X-Received: by 2002:a05:600c:8489:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-48320216cb8mr7006905e9.22.1770318226602;
        Thu, 05 Feb 2026 11:03:46 -0800 (PST)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296c0f2esm235375f8f.19.2026.02.05.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 11:03:46 -0800 (PST)
Message-ID: <ddd1f32c073f155f61104ad92d4fe7de327ca11d.camel@gmail.com>
Subject: Re: [PATCH net 2/2] net: cpsw_new: Fix potential unregister of
 netdev that has not been registered yet
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Saeed Mahameed	 <saeedm@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Lorenzo Bianconi	
 <lorenzo@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Murali
 Karicheri <m-karicheri2@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Grygorii Strashko	
 <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 05 Feb 2026 20:03:45 +0100
In-Reply-To: <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
	 <20260205-cpsw-error-path-v1-2-6e58bae6b299@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214543-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandersverdlin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2ED24F6AC9
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 10:47 +0800, Kevin Hao wrote:
> If an error occurs during register_netdev() for the first MAC in
> cpsw_register_ports(), even though cpsw->slaves[0].ndev is set to NULL,
> cpsw->slaves[1].ndev would remain unchanged. This could later cause
> cpsw_unregister_ports() to attempt unregistering the second MAC.
> To address this, add a check for ndev->reg_state before calling
> unregister_netdev(). With this change, setting cpsw->slaves[i].ndev
> to NULL becomes unnecessary and can be removed accordingly.
>=20
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based d=
river part 1 - dual-emac")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Cc: stable@vger.kernel.org
> ---
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti=
/cpsw_new.c
> index b9fc31eb06134dae33427eaba06341c39eb4b41c..7f42f58a4b031fab4c93680c1=
53383e8eeb8f7f8 100644
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c
> @@ -1472,7 +1472,7 @@ static void cpsw_unregister_ports(struct cpsw_commo=
n *cpsw)
> =C2=A0
> =C2=A0	for (i =3D 0; i < cpsw->data.slaves; i++) {
> =C2=A0		ndev =3D cpsw->slaves[i].ndev;
> -		if (!ndev)
> +		if (!ndev || ndev->reg_state !=3D NETREG_REGISTERED)
> =C2=A0			continue;
> =C2=A0
> =C2=A0		priv =3D netdev_priv(ndev);
> @@ -1494,7 +1494,6 @@ static int cpsw_register_ports(struct cpsw_common *=
cpsw)
> =C2=A0		if (ret) {
> =C2=A0			dev_err(cpsw->dev,
> =C2=A0				"cpsw: err registering net device%d\n", i);
> -			cpsw->slaves[i].ndev =3D NULL;
> =C2=A0			break;
> =C2=A0		}
> =C2=A0	}

--=20
Alexander Sverdlin.

