Return-Path: <stable+bounces-248877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNSMI65NB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:45:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8464F553D98
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00AD13045E93
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AFC3D0C1D;
	Fri, 15 May 2026 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1vsM7yZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE43321A2
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863191; cv=pass; b=BNo71cRenosPamYM0fxJUEPsXOySAKlSbNnPK5QXr63rV3EImAGRTTQfJR5QgKxercKfjKSpwsxcOCnHYxW4m/YIGZhb1Js4QAOuyY4T/7rFtN/cSdQte9pzfLbRbwXUlxsgU+D6DCwNuBcdAppNlBpx/a7JPg3HqLBjiT/rbpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863191; c=relaxed/simple;
	bh=X0/FYBGL2UFez5gMIokAoweUxT0r42Cl4VVd+nHXcgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mmn4buzyNXBb+CcPRNQ8SUMuFWmVCfANhUfZ2c6CaJjhh107Zb7ZZ11u6VSnLpteI3SH5OtZ8yMXYjvujrruNHR/PimXbVgcRHtzcztyZeAUZKyaik5YL+tdWY0PsLm2oZpDJu7oVbwc/hBfyssZEphmA+t8TNYnfeZWdnrX2zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1vsM7yZ; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd2e8931915so282067666b.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778863187; cv=none;
        d=google.com; s=arc-20240605;
        b=PjqM8scAOwrspt3X+qQuMv7csefwMJzWK3jC/Isgl5bwVpzESS4TY2W5mYfHJb5SgA
         VyzOFaydXUrFlM5l9n8CGl6DML3ECbb1/4TS9MKWHl0+ZLT8jXiLy+R8FwVBG5a3d7xC
         OGd7XrHvN6OcPDr7+skZRiIMsh41J7Z6XtzXHzK6uoZG3Ae1Dkfy3PVP9m6k/bh/HKcf
         Nkx7wS4egctFeLYn9sEflYNqS1JkN64Vp7aPz4q4isK5gQ3/5giJ/xHNUdAZNwvRF6Hk
         9cXaaI7x4W+X4/n/L43MHW1bvvmhNEHRLZh5eOA77LYhy9Q6tYVDLkkrawn+VRl3IovM
         3TNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HlWb6KwLW1iKWT50I5UpGmZm4onihoatH6gRlOACLtE=;
        fh=JxeBm8a6h8v24CPyDQOKApFB28SeCiqECf7wOkiPnzo=;
        b=DbMQD4tsb7Z1QNRHReSe+Rwol51LfAFWX4PDas5T161S9vAlZv3tTiXjDjfrlW29Xc
         6jrC6z9U6/FtsAn0/7el3Y/XWL97UffIxrOEdhj37dcbJsRcLi3t9bEHE2cxOHM3Lp2r
         ZOcD4EBIhJFWdL51uqjBgX7O4upClezfU6g0ZjQFOgEmy3/kqgtWlGXbXrewbAZ5wheV
         AGuy5u/D10ZbtpXZmN0HeIvxcAc9PYgEfzX8jStqhzSNq+eGZ9gFzmdOljioDUyBUxOA
         Oinq6ewSY2msDPUoIJums1lD92+IH8thRhBFLw/KgiCk/6+1AKGf1VC+hOA0cQQz2q0U
         aEqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863187; x=1779467987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlWb6KwLW1iKWT50I5UpGmZm4onihoatH6gRlOACLtE=;
        b=Q1vsM7yZxLHYEQv3w/EEOAQww65tVjgvfXPr9rpionyxK6P+si+5j4AtNsk+DHq/C/
         1fliqDaK1XJVeVzsRRGOxFRwQC0SywQTz/GLBRqyVf/LNyK0XSWit7kidBEgPxK0Xtgv
         u9bZR7Pjon98keI+sXblB49vzznxT/QCJOTDJ15rI605la83nN7nONnqzT1VvVEPUQuo
         tabedoD9/FY/lki55kCt/3gOwfSVDu+GRCvcWy+vpF4fjfwfJ/8TZHUTM14jbuDwZgL+
         YzSL//uYQ0TH1CGkd0WUna/lYBKO4wNzcWY2b081z91sna/vjyx2jKsgVBp19eZBqk8C
         zgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863187; x=1779467987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlWb6KwLW1iKWT50I5UpGmZm4onihoatH6gRlOACLtE=;
        b=SLrwPb30piwZwtMSdReJBlwAWx4V9p6lfsdB3Xa3IIQyWONXv5vY8MODNuMm2E+TWW
         p23YZGNBpq+JheXqbVCjN8plMtDTsJ1oKenjiNcfW/osW9fCbg2FVTfkkc/cVrlwXV7E
         dAS+mvdPNfuhIPMS86DcuB9yRuAafouKOgV97Sug4L7B2Zb7dlvphlBptqTO/4j02fL3
         E+ZfvHzv7BOyh1NZnv+lSxEVuaN5+AjhhlQYGrB8DShWu85qQ4t6f62ledmGl8isx0Bd
         cOdGBnG9m7KciHu3vf4u+2U2iDhgCdmJzcNrtRGIrjWSHFTa1aym4eoy88LiSWUEiYC/
         mkWQ==
X-Forwarded-Encrypted: i=1; AFNElJ90e2N16OYhog4fdc0faj1lmrOG58sy38YxsAHpchefx9dKpZbL8z1gAl4Mo5VjlRQSNDJlZuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHZwmhxZbn+1VGc4tsbqYaW7h3kTFTBModwMBax02c3/YOAxU
	CcaXOBOAi2B6wnZjeyimZ7NE6XJI6L/1kubDE36HeG4KUNx1MucODrlVpqeuvP+uBZeHVytJZ2C
	/JV43U5s6GeNTiL/bTWgWD3t/IJPNfUY=
X-Gm-Gg: Acq92OFoo2+pXVts9mAXalNOZecccoRS8+ENDt/5u1FYTW6UmJlsD8KH7I6fv7B+jAq
	MyZqPLtRNffTeyR4/3LRFyjfzR/2h92x77oWL9Avjd+QfH6Y4nFAMSnXx6+Kr/jR29gNH4zuSh0
	jJlgtVewlqtjlPFp9hFuNgcnIM5l6+Fo6GHPWmyjq9It4hYtWAcvl1D7WnifFHM/fOa/drJr3oC
	FKf+aFB+OClEpPnEYnjEuzHDEvuxvj/6nd5vLMVl4VDMG9Sq53Ml6284ZuVSe0L6hXcXdf4lnIh
	G5d8qssiqTVO9E/tmRhSEreF4dVZky754v7No9ou7w==
X-Received: by 2002:a17:907:9347:b0:bc7:6336:6947 with SMTP id
 a640c23a62f3a-bd4f32fe846mr479049466b.4.1778863187379; Fri, 15 May 2026
 09:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514111354.3552538-1-nirmoyd@nvidia.com> <20260514144258.3068715-1-nirmoyd@nvidia.com>
 <CAOQ4uxjGhRLnuU_=m=P-omUMM=0F+Mxs1O=zTasVnLdLz8ut3A@mail.gmail.com>
 <CAOQ4uxgad=DE9wMAS6Wn9rrEkOX3p0S8jEhsjnj=Or=_7HsqyA@mail.gmail.com> <20be39e1-8da7-4f81-9134-d748841b3611@nvidia.com>
In-Reply-To: <20be39e1-8da7-4f81-9134-d748841b3611@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 18:39:35 +0200
X-Gm-Features: AVHnY4Lq6JVsCpgqykJC2yfUGTMMoHPOa_7PG3ScFKZu8EN8Pa8ub2vRTeloplc
Message-ID: <CAOQ4uxifua9RvEGJfU0ho28Lkdn_oqS8fBYiyxBC0Q8PWc2nJA@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: keep err zero after successful ovl_cache_get()
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8464F553D98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248877-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,a16fb0cce329a320661c];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 1:16=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> wro=
te:
>
> Hi Amir,
>
> On 14.05.26 22:19, Amir Goldstein wrote:
> > On Thu, May 14, 2026 at 5:26=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> >> On Thu, May 14, 2026 at 4:43=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com=
> wrote:
> >>> ovl_iterate_merged() stores PTR_ERR(cache) in err before checking
> >>> IS_ERR(cache). On success err holds the truncated cache pointer and
> >>> can be returned as a bogus non-zero error.
> >>>
> >>> The syzbot reproducer reaches this through overlay-on-overlay readdir=
:
> >>>
> >>>    getdents64
> >>>      iterate_dir(outer overlay file)
> >>>        ovl_iterate_merged()
> >>>          ovl_cache_get()
> >>>            ovl_dir_read_merged()
> >>>              ovl_dir_read()
> >>>                iterate_dir(inner overlay file)
> >>>                  ovl_iterate_merged()
> >>>
> >>> Only compute PTR_ERR(cache) on the error path.
> >>>
> >>> Fixes: d25e4b739f83 ("ovl: refactor ovl_iterate() and port to cred gu=
ard")
> >>> Reported-by: syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com
> >>> Closes: https://syzkaller.appspot.com/bug?extid=3Da16fb0cce329a320661=
c
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> >>> ---
> >>> v2:
> >>>   - Drop the now-redundant 'int err =3D 0' initializer and the traili=
ng
> >>>     'return err' in ovl_iterate_merged(); err is only used inside the
> >>>     loop's update-check, so the function can just return 0 on success=
.
> >>>     (Amir Goldstein)
> >>>   - Link to v1:
> >>>     https://lore.kernel.org/all/20260514111354.3552538-1-nirmoyd@nvid=
ia.com/
> >>>
> >> I queue this up and will work on fortifying patches.
> > Nirmoy,
> >
> > I pushed fortify patches to ovl-fixes on my github [1].
> >
> > Can you verify that the assertions trigger if you revert your fix
> > and run the reproducer?
> >
> > I imagine they would trigger much more frequently than the KASAN
> > warnings do.
>
>
> Yes, the assertion triggers with your ovl-fixes branch after reverting
> my fix.
>
> 9541f25af774 Revert "ovl: keep err zero after successful ovl_cache_get()"
> 1c067d912e47 ovl: add assertions in dir cache code
> 98e3a2d258e9 ovl: fix race between copy-up and open of a directory
> 4f80bb375112 ovl: keep err zero after successful ovl_cache_get()
> 18de6460b6bd ovl: opt-in for fortified ERR_PTR()
> 690bd87e1fef err_ptr.h: introduce ERR_PTR_SAFE()
> 7fd2df204f34 Linux 7.1-rc2
>
> Running the syz reproducer with panic_on_warn=3D1 triggered:
>
> [   55.404636] ------------[ cut here ]------------
> [   55.404646] WARNING: fs/overlayfs/readdir.c:511 at
> ovl_iterate+0x4c0/0x5bc, CPU#2: syz-ovl-iterate/14575
> [   55.406875] CPU: 2 UID: 0 PID: 14575 Comm: syz-ovl-iterate Not
> tainted 7.1.0-rc2-g9541f25af774 #1 PREEMPT
> [   55.408328] pc : ovl_iterate+0x4c0/0x5bc
> [   55.408632] lr : ovl_iterate+0x4b4/0x5bc
> [   55.413504] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffffffffc152db40
> [   55.414036] Call trace:
> [   55.414209]  ovl_iterate+0x4c0/0x5bc (P)
> [   55.414503]  wrap_directory_iterator+0x60/0x90
> [   55.414809]  shared_ovl_iterate+0x18/0x24
> [   55.415125]  iterate_dir+0x10c/0x3a4
> [   55.415365]  __arm64_sys_getdents64+0xe0/0x1e4
> [   55.417312] Kernel panic - not syncing: kernel: panic_on_warn set ...
>

Thanks for testing!

Did it trigger faster than the KASAN warning?
I'd imagine that it would?

Thanks,
Amir.

