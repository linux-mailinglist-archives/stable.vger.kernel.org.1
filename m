Return-Path: <stable+bounces-55779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB1916C9F
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E53B28187E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4F17E447;
	Tue, 25 Jun 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PXBbGOTE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C616FF58
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328218; cv=none; b=FvtrtNanDnf4/u3mmLATC/dtbu5SJpR3RQZZnEVywWK4fA0NPNvpZBR1cpVGIUe7N9pEoyE56nmwr6KWEpBkvoMQMt3n4mx9/NVTVX5/A43y8sP8hQYTu+ZjkaxPdjiAKz48UzIwfMZw5o9rXaMq4M8WqIzAgxrUgNINxcYqbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328218; c=relaxed/simple;
	bh=2XFZUx9ncy1VjO2Y96sMtDxXSBOydfjI8Bu6TbSxPXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lmjg9b1b2HC8gLMcCkPLqxV2g2pZPMgs7uO8Kd+HZwW6teW4zSZuSGfeBRFFeR8aq0nUJ5m0mVZ8YKyY8dk+32KqFko3l6kwHJ3C9zATkQYLRfh/7AzKqq8SKQ5Cux6samKr+f1G57+LZSABCAmiWyjpQT43tNpYfC30umF1jYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PXBbGOTE; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df481bf6680so5282972276.3
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719328215; x=1719933015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYjp+01AHN/+C6u2NMeL7BJg7kKXe78xI4yAEd8t/18=;
        b=PXBbGOTEeRalzPKmxBt9qBrhLBlmVKPrR80p8VZt19hObxQjkPtp0gvszwXl9sAkua
         rOYuC9PpD8UJKGIQysFznCNCioO+b+59qgx8/xFKm915cvMz8xBqXKJOITjWQqkq7bw3
         +VfyKk6MyKp0spxSMAyZJccEg7P0h97mrrtYCukjFuBhf8NcAbThNxk/ucLIb3bml6Sf
         oX1DtAGT65RHDC4r33Xy+cmBEytlEDuJuh6Aiwsv9cO6e+wgDIAnZwaViPqSCJx/+wBC
         MMypmRZl7QZ3NHmobeaZMIBQuSPNhqVvFkS06lPeoOHYMW0mNg7mdjs9jAoseArUWPbU
         lhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719328215; x=1719933015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYjp+01AHN/+C6u2NMeL7BJg7kKXe78xI4yAEd8t/18=;
        b=fd31t7OdxW60IqvKA5xxjVgqIBQ8tx7uT+y6l2hU7Bc4ER3h4iLWa/Ho0EHkahK0NW
         MwSezMKekizzqftDwRXcMkXbyRDAB5R7YXveKuOHOsAquFengOOl2M7vo/aUVppZE7eN
         4YIKeNx0oND0GCbfgbUj67w7ZtMIY8x1MwHzYh5jPMuaq35dVxpoKFB7a0MHbELnuOng
         caqkONrDjpPqBKKLn5WAeBJ6dF2Comtx/xelxaxnSAppmx5SMAnWghfA645CyM2q+I6f
         i6kN9XKmnEgcTg4j//jad4eIRQO+gBvRFDLzXgdHh2wwxne9dDZxKYaqEERrJPu7updw
         CIAg==
X-Forwarded-Encrypted: i=1; AJvYcCXOBLSz4hxj6IgCYuwmhsitcsjoY3PWGFRCCwVrohl0BzM0zt0+cm/zDFiGMW087KKZvOViD37VgEzjNSUjvavADzg2bwyz
X-Gm-Message-State: AOJu0YxxhhE1xS3XROh1maNi5Zl2K8zI2GmU+vIa0uHyPsxWinS+zLfK
	2jicBMkeIoNP2PAVWDyrMdV+A3MzVT18wNvrEpXcn7g9n1KI9/8useLmrKlvvz8Rx7RKCu/vvRD
	8vY/8Mdhh7MS0oC6kUiI5ejj4vOpY/6NuhJzRn+mQdvig+v5uzg==
X-Google-Smtp-Source: AGHT+IFD8YenPlr6l7WSraZrN9TaONJTFVcUbAlRUV+SWQbjEH+93Nq4nnQB+rrzEybVedArtpaiVypzp5xsAPRUfH0=
X-Received: by 2002:a25:ab94:0:b0:e02:c420:e7bb with SMTP id
 3f1490d57ef6-e0303f2ab05mr8231070276.16.1719328215639; Tue, 25 Jun 2024
 08:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024062438-shaft-herbicide-4e7d@gregkh> <7eaf494c90161d4df0855af9697a7be9e9c878b6.camel@linux.ibm.com>
In-Reply-To: <7eaf494c90161d4df0855af9697a7be9e9c878b6.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Jun 2024 11:10:04 -0400
Message-ID: <CAHC9VhTcH8Y78i5=HGQdqtoF3j_qKJZGn2_EYU9dBK+amF-EgA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ima: Avoid blocking in RCU read-side
 critical section" failed to apply to 6.6-stable tree
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: gregkh@linuxfoundation.org, guozihua@huawei.com, casey@schaufler-ca.com, 
	john.johansen@canonical.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:06=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Mon, 2024-06-24 at 18:47 +0200, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202406243=
8-shaft-herbicide-4e7d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> >
> > Possible dependencies:
> >
> > 9a95c5bfbf02 ("ima: Avoid blocking in RCU read-side critical section")
> > 260017f31a8c ("lsm: use default hook return value in call_int_hook()")
> > 923831117611 ("evm: Move to LSM infrastructure")
> > 84594c9ecdca ("ima: Move IMA-Appraisal to LSM infrastructure")
> > cd3cec0a02c7 ("ima: Move to LSM infrastructure")
> > 06cca5110774 ("integrity: Move integrity_kernel_module_request() to IMA=
")
> > b8d997032a46 ("security: Introduce key_post_create_or_update hook")
> > 2d705d802414 ("security: Introduce inode_post_remove_acl hook")
> > 8b9d0b825c65 ("security: Introduce inode_post_set_acl hook")
> > a7811e34d100 ("security: Introduce inode_post_create_tmpfile hook")
> > f09068b5a114 ("security: Introduce file_release hook")
> > 8f46ff5767b0 ("security: Introduce file_post_open hook")
> > dae52cbf5887 ("security: Introduce inode_post_removexattr hook")
> > 77fa6f314f03 ("security: Introduce inode_post_setattr hook")
> > 314a8dc728d0 ("security: Align inode_setattr hook definition with EVM")
> > 779cb1947e27 ("evm: Align evm_inode_post_setxattr() definition with LSM=
 infrastructure")
> > 2b6a4054f8c2 ("evm: Align evm_inode_setxattr() definition with LSM infr=
astructure")
> > 784111d0093e ("evm: Align evm_inode_post_setattr() definition with LSM =
infrastructure")
> > fec5f85e468d ("ima: Align ima_post_read_file() definition with LSM infr=
astructure")
> > 526864dd2f60 ("ima: Align ima_inode_removexattr() definition with LSM i=
nfrastructure")
>
> The patch doesn't apply cleanly due to the '0' in security_audit_rule_ini=
t():
>         return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmr=
ule);
>
> Commit 260017f31a8c ("lsm: use default hook return value in call_int_hook=
()")
> removed it.  Instead of backporting commit 260017f31a8c, adding the '0' w=
ould be
> simpler.  This seems to be the only change needed for linux-6.8.y to 6.4.=
y.

Agreed.

> For linux-6.3.y to linux-6.2.y, commit b14faf9c94a6 ("lsm: move the audit=
 hook
> comments to security/security.c") also needs to be applied.
>
> Paul, how do you normally handle backports?

Normally I just tag them accordingly and let the stable team handle
it, with the understanding that the stable team only picks patches
that have been explicitly marked for stable and not just anything with
a 'Fixes:' tag.  I'm sure you remember when we discussed this
recently, there shouldn't be anything new here.

The tricky part is what the patch fails to merge automatically.  It
has been my experience that the stable team really doesn't try to do
any manual merge fixups on the LSM, SELinux, or audit patches, so it
is really up to me or someone else who cares enough to do the backport
manually and resubmit.  See "option #3" in the stable kernel docs:

* https://docs.kernel.org/process/stable-kernel-rules.html#option-3

I've personally had some bad experiences working with the stable trees
(YMMV) which combined with a chronic lack of time means that I rarely
do a manual backport for the stable trees (the bug needs to be
especially horrendous).  However, others are always free to submit
backports, see the "option #3" link above.

--=20
paul-moore.com

