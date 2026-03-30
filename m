Return-Path: <stable+bounces-231250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GQ2JrmYymmg+QUAu9opvQ
	(envelope-from <stable+bounces-231250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:37:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDD35E02D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90773051AA6
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0B345722;
	Mon, 30 Mar 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+lpnHXI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64284345CA5
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884360; cv=pass; b=SKoOkb19TcfWrR+T4zIpFOeBCPuY8vyJ/F8IPh2Eg6fEQS7+dNYCBvy1owoq+625/9/o5bIsvKRu6RSg0NLTEzlbAp3t376GVuvAZBWz5bZ1GU6AZE4q3Xm3bxTCQE5vm0unwIfE65N5AK1IqGoXRr73qPgoRpKSOtw/Dd6byNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884360; c=relaxed/simple;
	bh=DP7Ai2NkulXkPmE/t8PJMopqExrLgwCFUDxoCWMR8xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfeasBfEqke8o5WgYvyzcbv68Gc8N2/zP8nG0/Gc28naLoY15A5jAXH7DeubHcYjNPC1kl0Ng/Nqie2qKPOnQsH7b8QZKUFk2qjT+uDVWtuoBWSp+oF5AQvzMEdWuGPU4fciYFRtMZrFq83XWFiXrTHvLMLUj4MFVXL/M/VD4N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+lpnHXI; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so8639905a12.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 08:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774884358; cv=none;
        d=google.com; s=arc-20240605;
        b=TnYF7H+ChKrvO0AIkA+ktse4PCJrjn8jgyQUwv4r36rH/GFMc73I5MwMsUvMZamE4k
         P+OxWPVR0DdqcW+FhSXkR492nHqAdvVfQC+7e9jAT+hBMammaPtJS1kDfdDjbpH+lZjg
         ByD/8D5WTiF0GecR96y4HI4KP0/QD3U01xuO5qrZMA4cZuecYyJTV/TKS9uaav4Xv4ha
         y7h6jCwq0y+fPMf7ztSEKvZw/gnuPl7F+D1SnEd0B2/dR6578oP2n7otRcOnY3WIGirf
         pU6q3bvtGCew+v9xnRrgQVO19VNvBjfDC/oljLfsv8d5xRjLBVwmnGVATXXjILWq5yET
         gd6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P8t1EgRm2PwBwbjA7KyKl/zk+ea1WK8eKM9jSHv96Gw=;
        fh=yHaAzIO5OKYZopKWlgdelfwTwyX15rhXoSNkCqoxjwE=;
        b=PmUUQpK5jQegc9zwQSIgNdFI+1lAk15sek56n8yB7zF6PKMa0q5kJUr6n6ASSz3/J5
         5Cwr912F+4LIyGkdP/CAY3ra/L6EYgm5+Vgi8Zx679oTimCaeRoBCTd4VO9MbO4xVA1Q
         aUJqSm5a7Xseij1kqcOmGBct+Ya8q6uuiqnCf9EM5BTvckkRNWu0Fif5SIPbOGx1m82y
         8GaOFMGQDIVFri7jO5CkG8SHah8RwlzbQ72PmpylY77e2EAGYb6cj1ImY6Xa/uZndIii
         wmCoTsRCDdEfydyzt3aomLyr93gRi3qFcL4Uk1kU4cGkhs+MJwlWGGtGEG7ZXc32eTAx
         yctg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774884358; x=1775489158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8t1EgRm2PwBwbjA7KyKl/zk+ea1WK8eKM9jSHv96Gw=;
        b=d+lpnHXI996flvGm7iFCPRhXaGdVrD1jJWQn7VkjNFeAF7v1VwXQrRfTK7oPxc9Om+
         GH4QyO/X1wSBEy1K5Qt5RDLmTxCgznETCwOiKa9pr2Yl0wICFAnJZ2tyg1ivJzSWXxBb
         5DRNRv9f0c+UlSmaIcuq0AAlx83c5aUuSN/ieWmxAbQx6MnNkCzv/lgNFDanOoxvSoMD
         3uCx71s1wzLcUMTTOdCrRicSZY55udW2DzojXD7d4pamcC8Av6ppeIiScX5UHWdxyuX+
         5ZDhzNggtk8ZiNgv2TRtQYMGW+9eAmZ9C/sYWdX4OURW+lLyC8cptJ+5JNCZ4I1PQQh+
         EPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884358; x=1775489158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P8t1EgRm2PwBwbjA7KyKl/zk+ea1WK8eKM9jSHv96Gw=;
        b=i458no1oJrFALQejUT/dJJ80GJSgQslP3eNpo/zmFGvLJRPoymTPWU1kEsEo9tkfHb
         UVHbSD9+6+jzRffPLA1tFhXi6snM3bYdBHsX73gthrS5YwCM8LWjxNdfeZlDKzb8KfHG
         Rd5CiJi1BQ+tglO1a93PdUYKsvGdTvmMZYV6jaeESX4zzomMyltIrk2b86cDvronnFd4
         mlbBIDhwKy67xaH8myke4t4vK0mDeEWWhTSHITWB7BgFI2OR98vNJ+jj2Vyzhg+pGI6m
         wGzpzEEhwtLbHhhFuikRxxLW1UcLlXJSyS3KzRzLvJI+l0PXrDZWJjA+bXtKC4ALNMEp
         lbdw==
X-Forwarded-Encrypted: i=1; AJvYcCUrPrTFMbClpU8PsyIYtvKq5WpKE3lTOek4oac2Wuvk4DmnPa/bYx9mBOX5I6WPQGFibTYtpGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg00ocde+8tOZxB2TfL3ztje01Xe+TGjzaXILIoMs5xT66kQqG
	mNpnWi5z7hCZFP+GUNEThq49QWguvkJl1v/E7s8WGf0JGf7smVxSkfvleANZDohyQoJf9B9AeyH
	NDWk9Kgx4t+N3nF5NdjpMZzplPuM6wks=
X-Gm-Gg: ATEYQzx0YhIZdJ44kfJn0xKLmWlWKa38nr2gAjmKdG3dhjFejy8KN6qCSrKityvoZt9
	34ZevPGYJ8/fXO4ukX49f+rI1zCk6PbZIzZN96Pgpn3YMZjPmsP2kvWs7xBUX/F35O7G/Dp+yku
	GgRJDd8pDsPrlYnflcM/bzJ/z3YWL1FtKv2m/9W8WX5bAqznAf3+BCY5GseIkxFhdkpxcI1EvzC
	NXtz8j6iY0vQTJSptPNnIope/7ctXn6c52lGzJVtoAMkMohH3XEJEYfukAk3ZGHAQkQzxumiAmE
	mMGssVzVRtc3sbJQS43FPDamCD8v4aCrDEa5BaEcBQ==
X-Received: by 2002:a17:907:846:b0:b96:f6f1:e7af with SMTP id
 a640c23a62f3a-b9b502bea2fmr837400666b.9.1774884357664; Mon, 30 Mar 2026
 08:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026033031-backpack-decorator-faaa@gregkh> <CAOQ4uxjUDHxSk8uauLrjou_E_D0N4Frv2ddQwkH7xbXK31B-fg@mail.gmail.com>
 <2026033023-reawake-mutation-b00a@gregkh>
In-Reply-To: <2026033023-reawake-mutation-b00a@gregkh>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Mar 2026 17:25:46 +0200
X-Gm-Features: AQROBzCU25awgMXNaOK5dFCQN-CJ-AtG4gaMPMmY3SNmvpFf76b3UJXYaPcslWc
Message-ID: <CAOQ4uxgY733g8UzJTcEcGPPYO2yL93jtTXsuFZsJSxj=cBUb+A@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ovl: make fsync after metadata copy-up
 opt-in mount option" failed to apply to 6.12-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: feilv@asrmicro.com, chenglongtang@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231250-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4CDD35E02D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 4:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Mar 30, 2026 at 04:15:48PM +0200, Amir Goldstein wrote:
> > On Mon, Mar 30, 2026 at 11:36=E2=80=AFAM <gregkh@linuxfoundation.org> w=
rote:
> > >
> > >
> > > The patch below does not apply to the 6.12-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following com=
mands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git/ linux-6.12.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033=
031-backpack-decorator-faaa@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > >
> > > Possible dependencies:
> > >
> >
> > Please apply this dependency patch as described in commit message:
> >
> > Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_optio=
ns()")
> >
> > Should I describe the dependency using a different format in the future=
 for
> > the scripts to catch it?
>
> Yes, please use the way it is documented in:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
>

Very well, I will keep that in mind.
For now, going with "Option 2":

Please apply
50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()")
to 6.12.y. It is a trivial cleanup patch and it will allow a clean apply of
$SUBJECT fix to 6.12.y.

Thanks,
Amir.

