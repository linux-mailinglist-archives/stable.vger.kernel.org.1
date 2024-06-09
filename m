Return-Path: <stable+bounces-50050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE4F90166C
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798FB1F21298
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242CD3FB87;
	Sun,  9 Jun 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LkkVwdwl"
X-Original-To: stable@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7A42ABB;
	Sun,  9 Jun 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717945299; cv=pass; b=ILqPfqVraQhgFwboK3lAa6Y2bobfIsfhy2XO9yfKb39vZDu1cgsSaB9X5Lj0t2mi5o7dOiAvSO3GH1+sL88LqRFGHp3u2IrpoCMS7/+RIm1fXb/pJB+2vyDweOsmTz0YoklODRmWRS2URUryTpaXLrq0mgXSDyRBlp15ToS3UMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717945299; c=relaxed/simple;
	bh=sn0BBoGPmqS/LCfQCIEaY2vfwueBz3zAXmZxwGNsV3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otcoZEhYvoBGrcgEOwkFarHCuwsvvepBM0lSqgRGn51tzwNyhRBe1SkdeaQaQvComP7YWPboCvHrBSBiMBfJakDoDC06KMH/5LNDQdujJl1pou/PX/Z8hrYaqKP0MoMXc4bs5gLK8C1MQS71yEupH48cTKYynOzwxKITDkULqMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LkkVwdwl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VxynT26y0zyQL;
	Sun,  9 Jun 2024 18:01:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1717945293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMrkupduALvabSuxIR2q8uxLk8GFltsccXQ5z5lTVac=;
	b=LkkVwdwlq0tGQHRCjKtoGkTE3pFlITBMPF721DTAZl2q0yVQAeLrF/B0uSzWDi4nAdhZZG
	icDQZQO1ueBcPwpN75t80pCqQ4Wz7eZDB0GAiH0vBBNMYh95W3c1qAxG1aNji8Jg3aQ9Il
	Zp1mQFN18H3aRBQdOZjaUjbXHFaRrDo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1717945293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMrkupduALvabSuxIR2q8uxLk8GFltsccXQ5z5lTVac=;
	b=Vehdua56cPiR+tnaW2xgwAz6xFZLG60R1LeXkKmHNBW+S8EEd8XIbVpqYBNNGs3pjIJGSM
	Dm+JsSnj/95QYCBox70W4DGzz/HYBdQ+UaqFRFzGqm9tQjMvjettsj15syJXWAOgvfl124
	2lTirfNcYGAb7boHHXihCZvrsN/6Nao=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1717945293; a=rsa-sha256; cv=none;
	b=DwbRwUxyWmJqeohGbDJnpF5B+kWGf6GGLMM8DwRUx3l/B4BuyZRyX3AKGTf+8VGT9kgswV
	7Dkq+xsucxcnzH95aeJ+RBCUmfaFybgDAueMh3RQnQrKcrPRWhVwN7B8jj68jdZzG6cdGX
	aDifNocTwtjWqVZ3ncY/tLnCWFksZwA=
Message-ID: <74eb0c7120f0f26db090810be2386eadd7137495.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: fix connection setup in l2cap_connect
From: Pauli Virtanen <pav@iki.fi>
To: Timo =?ISO-8859-1?Q?Schr=F6der?= <der.timosch@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, 
	luiz.von.dentz@intel.com
Date: Sun, 09 Jun 2024 18:01:32 +0300
In-Reply-To: <CAGew7Bsdb4iOKrZ+1pBRXs38+GwVJDgQh7N1Zn4DP73fZ_ejeA@mail.gmail.com>
References: 
	<CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
	 <de9169c3e607696a9430f5beb182c914c136edcf.1717883849.git.pav@iki.fi>
	 <CAGew7Bsdb4iOKrZ+1pBRXs38+GwVJDgQh7N1Zn4DP73fZ_ejeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

su, 2024-06-09 kello 14:49 +0200, Timo Schr=C3=B6der kirjoitti:
> Hi Pauli,
>=20
> unfortunately it doesn't fix the issue. I'm still experiencing the
> same behaviour. I attached btmon traces and bluetoothd log.

Right, sorry, I see now the patch is wrong and did it for the wrong if
branch... I'll send a v2.

	Pauli

>=20
> Best regards,
> Timo
>=20
> Am So., 9. Juni 2024 um 00:02 Uhr schrieb Pauli Virtanen <pav@iki.fi>:
> >=20
> > The amp_id argument of l2cap_connect() was removed in
> > commit 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
> >=20
> > It was always called with amp_id =3D=3D 0, i.e. AMP_ID_BREDR =3D=3D 0x0=
0 (ie.
> > non-AMP controller).  In the above commit, the code path for amp_id !=
=3D 0
> > was preserved, although it should have used the amp_id =3D=3D 0 one.
> >=20
> > Restore the previous behavior of the non-AMP code path, to fix problems
> > with L2CAP connections.
> >=20
> > Fixes: 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >=20
> > Notes:
> >     Tried proofreading the commit, and this part seemed suspicious.
> >     Can you try if this fixes the problem?
> >=20
> >  net/bluetooth/l2cap_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index c49e0d4b3c0d..fc633feb12a1 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4016,8 +4016,8 @@ static void l2cap_connect(struct l2cap_conn *conn=
, struct l2cap_cmd_hdr *cmd,
> >                                 status =3D L2CAP_CS_NO_INFO;
> >                         }
> >                 } else {
> > -                       l2cap_state_change(chan, BT_CONNECT2);
> > -                       result =3D L2CAP_CR_PEND;
> > +                       l2cap_state_change(chan, BT_CONFIG);
> > +                       result =3D L2CAP_CR_SUCCESS;
> >                         status =3D L2CAP_CS_AUTHEN_PEND;
> >                 }
> >         } else {
> > --
> > 2.45.2
> >=20


