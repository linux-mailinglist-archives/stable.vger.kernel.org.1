Return-Path: <stable+bounces-223080-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOmBGGFOqGmvsgAAu9opvQ
	(envelope-from <stable+bounces-223080-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:23:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C9B202934
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 644AF319A4FB
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC3329371;
	Wed,  4 Mar 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Tyo/AFgg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E991330664
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636742; cv=pass; b=vGpOvswisb0WnrAhsN9A26nEUJrU6J06KtkJT1E7kQGAruE5Z6w+XPyTco9rdZ5rXWdp56TWEGajK4IGsoiTUx24qBS4P/Ih33lgwQ6CUCgify5gLuHaPYl107rxLUXkuZT2OOxosX6+ZDGsUP1Q5Vdm+N95ts/8RF75AAM8pew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636742; c=relaxed/simple;
	bh=31u+jOt3Okd7qZoKUt2+Zv2M7uxDvqIiYT5DdpIOghQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brf5rOOYpw469OLFaqxOzDIGocixweaAoqnSIFqPW2lYfQ1vOf5drzQy8YsdLrCztokesEY3lkI2qPrrdPT/D9nKSHxwA4XfP0sE68s/B9jXWICyncjs9Yf1Y3EV7o377E57r8R1dOla8t7AM4tUJm+3vft24Erq3s09lmEeGLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Tyo/AFgg; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a3225d59fso4743721fa.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 07:05:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772636737; cv=none;
        d=google.com; s=arc-20240605;
        b=hyuB/NB9owvX36li4Ga33QbDX/+kEAkkes7Nrtcl9HgaoorvXS2qwncpBRKrMzyQFK
         OZ61oxrBZylZBClxSMc7gG9etTJSJCqHlI+M86SHNApU0a7EqBqq/cNYGnNDpEzyfuPG
         6mw2/CsjwN8bJ/aBVzMUdEdROCYcICn/j3iVu6Bkefo3P/FiiE4dFoJjTwmU+GS0Dpnw
         wvElakYTJSExov/K8VRB/Udx60JbfyKfrVtt+Cb/0BP5r1RzwpuOdE6VKAT1mpqujqoy
         6UjzLP/PMzDUxLQpNEYcGH5kZipio1HBf2iFKJmhr4aastfRkd0CA2u8hmKdt1StdTqC
         Q7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O8Bn9h/TGg8RahqvjyEQM7uSOR/VAWRWvbMSu+QKfJg=;
        fh=bBuLARRJPctFZirWv6ES8QAYvx3TyZIG0E960dMmvLc=;
        b=VbRwjitNGbJjDmLkxbkzsFqpibjvoBaK4TZnIoFXHuRe4be7UDwsbdASMqzMkCeZL9
         noLmCOl0l6F0MHl1shtRScK0YULKHG/rwYPeqH+pAm2H9T/Ue4X97lloYmes7u0VuGhM
         kfeBFPOLgN2Tc2AC7lXK1XUwzU4STxnkIIKcKN8FxstmnbnqAf9vgQuLiBUXXjlsMIIK
         DdK2Zb0ihEJR3LqLIyFu5yye18igKwbbj4tHpnNHsCbHexcvhOq6G52YncB2e8Jc3N9n
         2OXiNGF/k6sNR1z91NAMl4Bho+ots4ZaMSJ5zfECtT3GjYOaIM0PCI3ebN35YQghEVJ3
         XDhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1772636737; x=1773241537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8Bn9h/TGg8RahqvjyEQM7uSOR/VAWRWvbMSu+QKfJg=;
        b=Tyo/AFggImyShwarZr29mR1gpMzKrsi+yBI4/haBB/w5AAUG3bO6qm2iTmDxf82OAr
         7VflFamsjzwZn0jaI0xO1SkC4zAoI7aBxxDrYgSwPENvr5D3eQxFtZXHCoNs99U6nqHU
         V2kLa306EjVmoeJAYPoqiDkVyxKt/qStFrc2S2CsWs7jCGOYw+1Ma4CCfHiYfjO6aBB+
         ZHO9Ft35h9rdK0ZMeMVUl/ySXdZfrNP85Yn0pytB2hwE0iOjHBUfSFMNp5Gc83tCshPT
         0PvRPqT+TbQBC9ga6xrOSSLVBree69Zd3RSs+dtdrFAMqlMScTjPewt6jDDyij3QPkzu
         JCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636737; x=1773241537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8Bn9h/TGg8RahqvjyEQM7uSOR/VAWRWvbMSu+QKfJg=;
        b=TGypll3iJBRqbWrJC7aGufQM1mhjIoFe7PuAnci6yWZWWZwSdBTZHGwbY16qpoLlWS
         rPpHsmDpt55DMknU3QiPapnjTGd0VFy8fIIiGz0zm0m9ukU2BeHp8X6kM1gZYynb695l
         GW86uhIsTGWtgnuO9llm61DFmG/bw4OLZsoV7m7jrj4gVn+uPO5IU2aUR8dNl0/hHWpH
         fpohDlaeVtgMKO1zO+Vu77VwGZbORKs+/BgtifK9w7P9ad8xyzPc1S60r9X9sCloVpZd
         tMFsyGvYYmzKkNA6dutf+J+GVWEx21wYnvM1WZ5bZTY/3TjBz38k8Hgf6JU2vmpqr9L6
         +jgg==
X-Forwarded-Encrypted: i=1; AJvYcCVM6+Vgev2BOx/aym2nxaLut89RGwuXNAwPI2kmpLkd4lUOcIMfcdPiWf6r8f4Bv3Uz2gKXobM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2K+LcQIcZsXI35QYe20YQ6DkupnT5YMqBurq7pU/w5/sq79ej
	ybXqzJ1iiK2RYs2O0v8+SH1JHSobYNWzCHH/EGnxnZB1ZVReYeK1u7bHviRiuwSi5hIwi1iZEPz
	cGt/nBuHVz87kJ0OGOKwleMEYLDjWWS4=
X-Gm-Gg: ATEYQzzcb3UH2PKGxiubdhBZR3BGBwbhgJgsi5M2ebHPJiiaxogkGMrv2bdPZDMjZYu
	8fikzqukpgdcHoUtER+XATYSrL4evGH7eZDaeTQCUtGw8YJ6FXLa58nLk50A6STilnceDud+OwP
	VFTln83/NsoLZtncaiC4ySxUFk9gkXA0a4Iln8bfyGgxwrEESedzZyOfcqUm8glretDLSE/q7hQ
	k8CZLx1lEEWKIOtCLuC6qIrUFGTDDrbRFRi0/cA81wW+PSQ3P8dYqO6PebyLEgaMUZopYuwbx/k
	XY6MATt32ElOCJlhNfbXpgVLplW4P3FdTW+pXDBW
X-Received: by 2002:a2e:9659:0:b0:38a:1eb8:b435 with SMTP id
 38308e7fff4ca-38a2c7c6255mr13711101fa.38.1772636736764; Wed, 04 Mar 2026
 07:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me> <418f30b5-06ae-471f-bf5f-f14f3f75deff@leemhuis.info>
In-Reply-To: <418f30b5-06ae-471f-bf5f-f14f3f75deff@leemhuis.info>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 4 Mar 2026 10:05:24 -0500
X-Gm-Features: AaiRm51PI1Lp7O44wLc1I1pkNDqWhOjyYlFKiOF_nsZ7SE-96pmYevd16B6C1nk
Message-ID: <CAN-5tyGgiKnBAjrMq_vJ+rBhFQ1DDWWv_Szxdxy0WVbsJ0FwOg@mail.gmail.com>
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK No
 locks available
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Tj <tj.iam.tj@proton.me>, 1128861@bugs.debian.org, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, stable@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 04C9B202934
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223080-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,spinics.net:url,umich.edu:dkim]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 5:00=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [CCing a few people and lists]
>
> On 2/24/26 03:09, Tj wrote:
> > Upstream commit 4cc9b9f2bf4dfe13fe573 "nfsd: refine and rename
> > NFSD_MAY_LOCK" and
> >   stable v6.12.54 commit 18744bc56b0ec
>
> In case anyone just like me is wondering: the latter is a backport of
> the former.
>
> >  (re)moves checks from  fs/nfsd/vfs.c::nfsd_permission().>   This cause=
s NFS clients to see
> >
> > $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> > flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks availabl=
e
>
> Does this happen on mainline (e.g. 7.0-rc1) as well?

I believe it probably does.

I could be wrong but I suspect that this occurs when the user running
flock does not have write access to the file it's trying to get an
exclusive lock on. Furthermore, it has been noted that the export
policy of the server contains "auth_nlm".

I ran into this before and there is an email thread titled: "[PATCH
3/3] nfsd: reset access mask for NLM calls in nfsd_permission" which
tried to "fix the nfsd: refine and rename NFSD_MAY_LOCK" (this is in
the middle of the discussion link
https://www.spinics.net/lists/linux-nfs/msg111534.html .. that
basically says flock should fail) . There was a period of time related
to commit 4cc9b9f2bf4d when such access was allowed until it was not.

Change export policy to no_auth_nlm if it's desired that flock gets an
exclusive lock on a file without write permissions. Or give write
permissions to get


>
> Ciao, Thorsten
>
> > Keeping the check in nfsd_permission() whilst also copying it to
> > fs/nfsd/nfsfh.c::__fh_verify() resolves the issue.
> >
> > This was discovered on the Debian openQA infrastructure server when
> > upgrading kernel from v6.12.48 to later v6.12.y where worker hosts (wit=
h
> > any earlier or later kernel version) pass NFSv3 mounted ISO images to
> > qemu-system-x86_64 and it reports:
> >
> > !!! : qemu-system-x86_64: -device
> > scsi-cd,id=3Dcd0-device,drive=3Dcd0-overlay0,serial=3Dcd0: Failed to ge=
t
> > "consistent read" lock: No locks available
> > QEMU: Is another process using the image
> > [/var/lib/openqa/pool/2/20260223-1-debian-testing-amd64-netinst.iso]?
> >
> > A simple reproducer with the server using:
> >
> > # cat /etc/exports.d/test.exports
> > /srv/NAS/test
> > fdff::/64(fsid=3D0,rw,no_root_squash,sync,no_subtree_check,auth_nlm)
> >
> > and clients using:
> >
> > # mount -t nfs [fdff::2]:/srv/NAS/test /srv/NAS/test -o
> > proto=3Dtcp6,ro,fsc,soft
> >
> > will trigger the error as shown above:
> >
> > $ flock -e -w 4 /srv/NAS/test/debian-13.3.0-amd64-netinst.iso sleep 1
> > flock: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso: No locks availabl=
e
> >
> > A simple test program calling fcntl() with the same arguments QEMU uses
> > also fails in the same way.
> >
> > $ ./nfs3_range_lock_test
> > /srv/NAS/test/debian-13.3.0-amd64-netinst.{iso,overlay}
> > Opened base file: /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> > Opened overlay file: /srv/NAS/test/debian-13.3.0-amd64-netinst.overlay
> > Attempting lock at 4 on /srv/NAS/test/debian-13.3.0-amd64-netinst.iso
> > fcntl(fd, F_GETLK, &fl) failed on base: No locks available
> > Attempting lock at 8 on /srv/NAS/test/debian-13.3.0-amd64-netinst.overl=
ay
> > fcntl(fd, F_GETLK, &fl) failed on overlay: No locks available
> >
> >
>
>

