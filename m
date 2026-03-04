Return-Path: <stable+bounces-222974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMinCvyfp2nTigAAu9opvQ
	(envelope-from <stable+bounces-222974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 03:59:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C01FA212
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38B04301DD78
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8B26290;
	Wed,  4 Mar 2026 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHa3MaJN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4A353EEB
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593141; cv=pass; b=F0IyO/h0eeg1kS7ndJO20I2EfV+h5TMWfp0boEt+EdjCyjE6lQ9yMpp3NQMwzD2wIukRPD31rVAUuEOwzKJ/FUFIo+FPRZqAzCyuhWFLW89sLtWM2j9Y/qnTzkXRra6PtPwawDnx/aFghDOKRW/PIdF4XUO6FFNUjlAs77Gt/Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593141; c=relaxed/simple;
	bh=zKM6EuG/p08waYJ2nHV56Gzg4x1zITq/xxo+w01zNwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/srD8yAtYsuDWpVyMmRZqZYGuXat7cxYYmY8EqBX5+Im4GmcfsrEGtkZk0T/tNpz7mokTRL2pdR/5+58VEwQ9JjpOrH1se3Pw5i811sOl05kUOkU28py+1TzllzGyOlkVq4JBZU4c4maEwxEQsia5WAFxRO9ur5BaRFuZe97PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHa3MaJN; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5033387c80aso91107501cf.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 18:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772593139; cv=none;
        d=google.com; s=arc-20240605;
        b=ej0QZaOU8rMDCcb05k2Xa1ETP8vE17bF0CWobhSkISx7JOn19J216jDfUIP0RbLYDj
         XiZOWWZOXP7gVcjKJwQnoyK+XTXiMZJSpllN44rawB9v/lkElWp6FxWaKGNfIRmAx7c5
         erB3H3dsbGpuCNjYHw7a5/j8Q1K6yqgRCFfs3+ThUHWDUVe2LfBsb+EwlYtgtnj6bgtv
         wIqxI6OYjX25xSsnkobS7r56YDQWLgssphLnuy5qdpzyt2if+xLv8Puugyud2aBEDj4l
         cvbdw2FDIaaVAx6Q2LzZ2XStsEg7/2XXjVDcZg+RrbDwWP37ed1/XNo/6GQYqNU5xw66
         d55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVj5WUNu9TPSYD5sj9qQF+48hWTkAcgHwSgxIiLsvcU=;
        fh=0uPF/Pd6A+BekA5yzo0aXkfd15FwlRrp7+FT5s9loU0=;
        b=Jl3bl2L3WYoeQ38knzklDS1lEkdgipI9ixYYnXyJoYAZc7kFkhowMHUF1SMjHz7THi
         7oYr0/nqRVuD4gy4cK3pcIt6SIpceG4swO4KcDgfRtUXUpBiPdElRO+Bcr/iWbUsiRRg
         D1GcCv+v3abVzLkaHxdTvQ2yn1ogy/dF3dhW4H156TkkD6odUDLWx0e1lZ3Aheg5KRKc
         uDCWjODTqpNxYi+/H7MiNDIB0IuJEto8UfUGnc6fockhI5HFHNB1lj4EnS49qLn2xFew
         Bwb0VH5e9KKO1JhCLmnJBFAjGNBL1dqt80Ksn2fw0k40q2OdVjmfJKyOGVMTwKYeeLVy
         tNEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772593139; x=1773197939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVj5WUNu9TPSYD5sj9qQF+48hWTkAcgHwSgxIiLsvcU=;
        b=nHa3MaJNiZ39Xglg5yrpCr6keC9Z/LMxfDUcQmNRji6wi4dNI+g69hGo00U1iH9A9n
         EZDOnVN6aC/GBXJUzE+lSNhN/DFXjGQg8ll+uIODlg3mBKidI12cd+1Xc3ZQZxxMOb5T
         3pPm6O8vLK+2IScQ/R8BkhShR7/B9RuVnM9U8ZQ40+UsuVle6RZNd7ajCRDelErSX8il
         R4+w5F4M23s4oB9BX5XDV11Ue4SQkx8v5Wjz0RN5mC9DPtdm6arli389s7iSgm1COd3V
         n2TIWCku+ggntGuhnWKU2FvIUlGHs9qhPLcg6fCEg5ThhTSmfPI+SYAr2+yVRbEuX7IM
         Pbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772593139; x=1773197939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVj5WUNu9TPSYD5sj9qQF+48hWTkAcgHwSgxIiLsvcU=;
        b=HpYttGUhxj/9aDBJSkVxnJ8udl355/ojXOGSeAkE3Q5+2azTmAw1BheIFTunl1WrlQ
         oVKF5tbMw6I8D66xR/b79TOjzUd+xjtbWUzwJshm5mrcOPvH0ZnrXXpuOVhrXwhBTsZ1
         BBKGo4pBAX+E3q3rkIetkz3umdBRR/guqDuzrydNlX7hTD/0y3gT1g1zVxJzVT0aMZVD
         h8XedWBK6D6fNorhhTp0mlTHh5r1J1uWWMBxMOMgUpFMThcr+OKDKs05IfnKRu3K/3qP
         uZm3utLMG4mAIS5ib6UA/gJwuxoFAbNT7CCYfPGSYjgKpQIxkphszGs0yZ3+uoJKnbch
         uD7g==
X-Forwarded-Encrypted: i=1; AJvYcCVTJEkhPsNzl9UcIdhVOXTlLK8G1HJdXq6M//w2MFwYq7/wdQHRTHcVyM8BVmvUJXYQWfrVZ7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KOgAp7sEjEV9kMJLosBef+BzPzLMCSYOP6XtBXvEs2Ktbdgs
	RJLtwUiKQHyzb7AWSqVpBQx0vWa2W6cDFkg5nLMI1OB+P9YYbt7uQhRV076Qcm7fl7Ph5NMPaLc
	Dto6sdjbDYAn+8JjLXVp1s+u37WJnuYg=
X-Gm-Gg: ATEYQzzqUC4T4Gm+R/lUmDmFOQBRVMZUBwK80g53ouzGFdg+JF0+tJpqdxvSKhO+hvb
	Ayvnaq5l7oJLAZLZIzxgKFkQw95LHj9Q8FjmpzEj+hwmBUmDL/6WA//4e9+j0OfoZqk6gXUn3Yn
	TW4Lo2lh3aomHBmGKkL75xbh+l3ItXylOT73hIE2qXqvgwiw6onjrePWaUzTCM/9qWIxpsN69JU
	5pnZt4tq7q5uyUCPrMn/gUpUO7/8Kg0pq4fpTbLgnVF8ctD34TC44O6/R4ujacf/vq1Xz3i445W
	Wod/gDk6wZGEnyUzi4QTD7b1GPLPqmrv6H+/Hs33WdhWguCZBb1VL56mGXQ6GAht/0SS/+zu53Z
	7Ad1bYfSYX8s0TPGmcI0yKHENH4ksPXz7ncnPXBjm7QmPpFBqNXuh3wG1hLZ7moMtZR54xyh1pO
	pyVoEunndpwDzYuCfngxiCxQ==
X-Received: by 2002:a05:622a:53:b0:501:46b7:401b with SMTP id
 d75a77b69052e-508ce9b1e9cmr50583111cf.15.1772593139466; Tue, 03 Mar 2026
 18:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218042702.67907-1-ebiggers@kernel.org> <b3b9f12347367ea4f0ab1f255e79cf35@manguebit.org>
In-Reply-To: <b3b9f12347367ea4f0ab1f255e79cf35@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 3 Mar 2026 20:58:47 -0600
X-Gm-Features: AaiRm51JuVXJWtCFDs_Tw4S5B-GhRlIEkDR479pURfiq3nh76oTAjTjCjs4_wiA
Message-ID: <CAH2r5mu+VkO8rSL+CWWDR55aKRLaiAxFp_G5PAfQsssK-Erm-A@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Compare MACs in constant time
To: Paulo Alcantara <pc@manguebit.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AB4C01FA212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222974-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,manguebit.org:email]
X-Rspamd-Action: no action

merged into cifs-2.6.git for-next

On Tue, Mar 3, 2026 at 10:24=E2=80=AFAM Paulo Alcantara via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Eric Biggers <ebiggers@kernel.org> writes:
>
> > To prevent timing attacks, MAC comparisons need to be constant-time.
> > Replace the memcmp() with the correct function, crypto_memneq().
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  fs/smb/client/smb1encrypt.c   | 3 ++-
> >  fs/smb/client/smb2transport.c | 4 +++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
>
> Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>


--=20
Thanks,

Steve

