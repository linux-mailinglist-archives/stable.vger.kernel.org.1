Return-Path: <stable+bounces-266690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q/qOG/hmMmr2zQUAu9opvQ
	(envelope-from <stable+bounces-266690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:20:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E7697D8E
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:20:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fsorKhlC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266690-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266690-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16C42304EC32
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111D39F188;
	Wed, 17 Jun 2026 09:19:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA438C2A7
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:19:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687979; cv=pass; b=tX4NJ0LZafilmzSSqayJp05Y0hZIf7AcbV9m8s1wiHk+wU6Om+MD5ATQrNaHfWjo/AvzfxBRlr/9PWSoxO1m92bJ9c1C/qe4J+Pb7/A2zUAdOZxdmlQwUlE6x8NpE6RwBSDVyxsgbc7PsHaLEpTRZNJbM0sN94oFwoJ+DR5S3NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687979; c=relaxed/simple;
	bh=TtmlPZkdUEGWVMO3BaztFv7ViFMKiwGF4OaOQ3x2ymU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HghUMOsvgyu+ev5PeFcaEg0hL6dKvE5munoIyGJxySAtZygCj2+w1Hb5VnHrC1DVclaZEQeWw4/5Dsf7w8BOs6xZGt0xCk4XjoPCTDEzq8AJKoJZl8SxVvglnXQoLddKt6ACPgpqNVHyAvMPIeKInXCbi0We7iwCSc1mqq6Y3hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsorKhlC; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69165354c87so6955727a12.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781687977; cv=none;
        d=google.com; s=arc-20240605;
        b=GuXi8u2zoNR+jvJMaGhra+3V6UDdLy/Mc0SI/C/ZVU/CAn48Rj0urt3hqDgoBWqVvJ
         SDH9BwHRvE9AJQDpeCbdc6F3C+R7D1mBkdcfB+c4bGu3J35zbJvGVXkmJxAMSkmejxBr
         deQPLrCVAKCr5Vn/1XcmYSMF21gDPyFakX2J4ucjjzhxEENfWjexdQqmzf9cbYJlOedx
         MBUUtlE+PKb6OJl9Bh8sQhbSJI0Mb4TA7MdWUH/BOK2WfwSaHyMacHikRBm+vIrP8+lW
         k+7ePaMwNcQc+FplrII+CAkGO+yXl8mtOm6F11Bp53tNWuY/schhGv9RGeSUahx16GR9
         TQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TtmlPZkdUEGWVMO3BaztFv7ViFMKiwGF4OaOQ3x2ymU=;
        fh=GE2VBWvBtgngWiHP7JtJV2OKnv7OriZOygCqHFkbM1w=;
        b=cixCX4VBUp6bk5tPEv6gvHlrk+SV+/ffW2nGBwwVCHkucTz0jOc/J6RYWC3trA2yBj
         BuksncJ5f7za3Qn3Jk5qVOlNOUF+EJqoDw4G41XkkiMXdtLaS0tETncO6I1JcUbb1ozU
         JVPrsQ/SlHUl7jiJXtz3fTO6Ujp7B8OMdVLbr9ct3CHyrvrA2JPWnRmXJ52tSPaPCPE+
         GsI7wNGs8QmA4Rikw5T+xLWkPPIKWey40VcYZQJcZ4vsaq0FCNk+QpfTjyxkCBGGpK/u
         Vtd6SjoqUT+IjItWJCP1lT3xMJ/vjNRrfipw90VqxR8LssjPkOCmr+AYCp4fkS/ZNHk3
         YvgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687977; x=1782292777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtmlPZkdUEGWVMO3BaztFv7ViFMKiwGF4OaOQ3x2ymU=;
        b=fsorKhlCbkaWHRHMVDxRAXv0DMwi8XcIx1aK306AXXuRc25t76t3K9bATnj20dAerV
         zXMQqXbgv4/y88wdfdqHW5uRalAZ7Ev4lC+tMPR3nvLMrQJqy6Z5YGDeLvAFVqF4vcwh
         gSJR8q4o3SL1U9hgG+Obd3BfVVAWGWZ+Ht6FZIv1MK9BYRB4ovNxITCBF95v51radIba
         BsOSCfV+PFzXG4E5TCHqEXByggVzvdMLs9gLi+p1DintMCwHPt5plcJY4ebkXIPa5WnB
         zn1WQEtj34Dlp9PvsVqnbozU8eWuH5SIN8EUhA4hLkfIf+t+nC/lErpQuRKIA7bZytRX
         0/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687977; x=1782292777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtmlPZkdUEGWVMO3BaztFv7ViFMKiwGF4OaOQ3x2ymU=;
        b=p4B3OQYEMmZTwzXnxLObBq4Ss6jSGSuSmJiFUNZCmtMp186LuSz4ozVZ+ZCdu5yuut
         iPDKc4uMfiDGXeGrA78yKAH6pOL9AXtBJ609FXuXAVJUJijQE6Jnr5rRSvzziwjFM1K+
         BGxslgtLzcoUbTvz/WSwOjt08BMW3dY8Bhf2nBcmiekNRDf0vEsiSFIRaOs/qIH2OhRM
         lzWLg0wpxCn+jWIwHLptMqRiHd9McxQ0y+ojy6XmNuGLLXs1ULXx/r1LR1o3L+xFSpCA
         a79351QMsyMVIyLkPOqgXK28DecfONcGomYPwXZWKhH4kl7Ms+mVhYHRWVZ9Bp6RiaqP
         wHcw==
X-Forwarded-Encrypted: i=1; AFNElJ9AUaOQjaYa5WOOIziEylNQ6rCTulTWOnFTYG4TE2aF4kJQmGd0d6hmpVJKfVt7a/p0okYf9mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+kAEcHgQYCScJ0Ca03WL6XRc/KhSKOgjc0/0+3qQlQTnAiRu
	07Zw9J3QpNkqtVgrNx+KCL7V5Vu8Em+J88PXMuOcFrRuI7KBLABif1HWrRnvCQWJ6lPWp/QfdQd
	FKnGjPwGgaNp0NfqH/0kthILcWkIZxpE=
X-Gm-Gg: AfdE7ckxVLXBZg+B1q1ix4URnxlW2oBGQj4EZuWtxI525Ri2edfbYInIK80+LjQGOfF
	i4Algkd1QQ5w6u5RfxBnYVeWdzMC81YRzxxz3yRdrWZYSGBKHwNVl/bR6xKAkbCxs0Op5sjmdm5
	t2fJCNKtrhqd7MsxjbJRzxuc//PMu18nOADsCnv3B/gYOR0IOfZiBQvcgvZ7/O10+N3wrDHed90
	061CQfOK8svoCQjNIn6rkdNV4bKBegRQNiIsr4NIjXAYRBBwGFCZGbEST9+4f9A8zbx+Ene+QIa
	6go6lPxXZfC97XR2FFBmhr9e9fs3Qb1tUpAVbC8gfg==
X-Received: by 2002:a05:6402:13c4:b0:695:830:bb89 with SMTP id
 4fb4d7f45d1cf-6954747df63mr1395872a12.13.1781687976321; Wed, 17 Jun 2026
 02:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322143418.216654-1-pchelkin@ispras.ru> <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org> <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc> <ajFQPY2m2A6ltvTH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajFabPtI8UGfkyix@nidhogg.toxiclabs.cc> <CACzhbgS59uCYhjX80__+nPjEx=N8mKUsYyFS1+aRDpMA-b-VXQ@mail.gmail.com>
In-Reply-To: <CACzhbgS59uCYhjX80__+nPjEx=N8mKUsYyFS1+aRDpMA-b-VXQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 17 Jun 2026 11:19:25 +0200
X-Gm-Features: AVVi8Cc9eUtJ7SFshQ1kNO4f0YyZBdUzhILlClrpolwmyxOlqH5yukBv9F0GLVo
Message-ID: <CAOQ4uxgXqmP49FV3b_cKDD_703bRHz0fjm=k=FmNytsPpnKx3g@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Sasha Levin <sashal@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>, stable@vger.kernel.org, 
	xfs-stable@lists.linux.dev, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org, 
	linux-xfs@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:cem@kernel.org,m:hamzamahfooz@linux.microsoft.com,m:sashal@kernel.org,m:pchelkin@ispras.ru,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:linux-xfs@vger.kernel.org,m:leah.rumancik@gmail.com,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.microsoft.com,ispras.ru,vger.kernel.org,lists.linux.dev,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 510E7697D8E

On Tue, Jun 16, 2026 at 7:33=E2=80=AFPM Leah Rumancik <leah.rumancik@gmail.=
com> wrote:
>
> I have changed teams so I no longer work on kernel and I don't believe
> my xfs maintenance work was backfilled ;(
>
> On Tue, Jun 16, 2026 at 7:19=E2=80=AFAM Carlos Maiolino <cem@kernel.org> =
wrote:
> >
> > On Tue, Jun 16, 2026 at 09:31:41AM -0400, Hamza Mahfooz wrote:
> > > Cc: linux-xfs@vger.kernel.org
> > >
> > > On Tue, Jun 16, 2026 at 09:13:45AM +0200, Carlos Maiolino wrote:
> > > > On Mon, Jun 15, 2026 at 03:19:24PM -0400, Hamza Mahfooz wrote:
> > > > > Cc: Carlos Maiolino <cem@kernel.org>
> > > >
> > > > FWIW I don't maintain the stable trees I really don't have time for
> > > > that. Darrick/Leah have been doing a best effort case for that, but
> > > > again, this is mostly a best effort so we shouldn't expect them to =
be
> > > > looking/picking up every single possible patch suggested for stable=
.
> > > >
> > >
> > > Now that you mention it, the xfs-stable mailing list seems to be pret=
ty
> > > much dead (i.e. the last time fixes from it were merged into stable w=
as
> > > almost a year ago). I guess no one is really working on it anymore?
> >
> > IIRC Darrick started it, I personally never worked on it, but I didn't
> > follow the evolution there.

I think at this point we can officially declare xfs in stable <=3D 6.6
unmaintained
maybe need to send patches to LTS MAINTAINERS.

The best chance in this case to apply the requested fix to 6.6.y is that th=
e
author (Darrick) approves it.

Thanks,
Amir.

