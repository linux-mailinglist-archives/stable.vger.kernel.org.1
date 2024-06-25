Return-Path: <stable+bounces-55805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D52917253
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 22:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080AA285A59
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3700E16F91E;
	Tue, 25 Jun 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PjMiy5Lu"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853101448D9
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346426; cv=none; b=jp68xyFW76InbbNsJjAhuzz8oPdkS3yZVBNR2DapET7BbEIh4HuU7IV+39+yLwqNz5yLUJKsMDjkoTmBsjVKR4WvCrnk9avznudxQ/q4BAtOa043dgrCVFYhvO2FNroRiNHFOtPSZo5HBqcINgcs6Qi7kP03XBgSv+RlOd6qfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346426; c=relaxed/simple;
	bh=tVSdQHyWRbg0M74YOCOwp1gaswAnznUIPE/qHsCWrNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYARluBh+MmAp2ssqOUfsiyKXGYPLcKiJgHULFdmH3wFuEjIh2iu1KnerdKAEL0MlNdRwlXbTL/6Wtb2GzKHn+G7nG+OjqLTrjP8imY4f0mqJigESwTJxwkfx+CkkLLqpyY3xBJTPf2SAqnYAknD4NOt3YX5q+DYykkdU6W6ZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PjMiy5Lu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-63bf3452359so57401427b3.2
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719346423; x=1719951223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2BdQuOKgRMl2AZtxD3LytPhTvcjJiWtCLTWYuyIeoQ=;
        b=PjMiy5LuNv5OhU7FHNOewMgMVtV2bkwTcUWRldQU4ByDKYEl+LsSxgdJHNYsweorVl
         sR0zSE7oG7Mq4MTNxO3Ij3D/tUm9UtHh7oNnG1JYRmnXozbturkk2r6+PXi4MBwksvC0
         gJWcyboP7PcpqlejVyownS+TRtY4ZuEWv/SOyecT28V8EZn/AFqxNxiL344fnOKYyBOj
         HHVGYOcDpfqLNGec9vYn0rkxg+Jb1Z4ZXvsw5k0CrnOVx16hHg9ws63rRnCEI+G91vaG
         tBwhvM2ns4qBgvQmeV/q/KGs8fGSrKoKUGJqs+6oUgWQZckGRETSC6TzOQ/KefyGLqIo
         p7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719346423; x=1719951223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2BdQuOKgRMl2AZtxD3LytPhTvcjJiWtCLTWYuyIeoQ=;
        b=sj+3TFNyZfneBI4Z8Pgay1R5AEodOPiWo+gxL1ObA4FUfDE9Lfs2K5PaWXanr8VXTg
         zNR9h1NQ7ds6W1QqT9p0EgT/8hYo9AfbU8CDETchwGUTX3wNRY4EPUzc0wqTz6p2aXiH
         XG0xE5LSnLL/Eb+FXwbTR/UPiWF1uHIdSN4nqlzM+tYbQ+0a1mJMGBI8w/C8SvDHlTwm
         9NJYTwZ9aOn3cYDSAjeCxp9RDHw/0UqJivVaMtye5INJiUK+4EEwsvjfdSV50PqIujh3
         LGyXLBb7ThVqU2dDI6OXiWak06J6kp98+AaHEHc3s+Q7w4u1pFSn6/5tn3cur313GHXG
         Wsgw==
X-Forwarded-Encrypted: i=1; AJvYcCUrO1jtQsTZQyXhUxqH6TKZHNxKl/E9rcHTRD0GWHbRocxLxefWc/gxUjvIc+rk1TSaP0lNE3BrkgeEyUmaMHBjrtKyDl8t
X-Gm-Message-State: AOJu0YzznCXqzWOCxEaxKKI0NpX6l3UWNTN2oJghep+aenh3yiONF566
	aOQO43tul0h1H6eUpHccYzYJQk7tfIO+tp4+pIJCbnr/fGGXrWuS7F9fV+HFk3dkD99pg2aJuj2
	jc9Gf0r+qqihuAQA2SZII5xsxRxDj7JJpJAdS
X-Google-Smtp-Source: AGHT+IE8fnc6mb1QXEDCQNW3h/dbgcwUcDa4Isct6FZAtFdMBxj1BQdT5cIv94kckzOCa1MGI/ev27Bvpy4L2BDDcyE=
X-Received: by 2002:a0d:e689:0:b0:631:e680:b041 with SMTP id
 00721157ae682-643aac782bcmr77479487b3.31.1719346423395; Tue, 25 Jun 2024
 13:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024062438-shaft-herbicide-4e7d@gregkh> <7eaf494c90161d4df0855af9697a7be9e9c878b6.camel@linux.ibm.com>
 <CAHC9VhTcH8Y78i5=HGQdqtoF3j_qKJZGn2_EYU9dBK+amF-EgA@mail.gmail.com> <be9c3320321571b391a068488e3a66bf63ca455c.camel@linux.ibm.com>
In-Reply-To: <be9c3320321571b391a068488e3a66bf63ca455c.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Jun 2024 16:13:32 -0400
Message-ID: <CAHC9VhSYXAidPHv1vX0_ORfCYhuNT2sxNej+vyfvwcCkSJiPuQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ima: Avoid blocking in RCU read-side
 critical section" failed to apply to 6.6-stable tree
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: gregkh@linuxfoundation.org, guozihua@huawei.com, casey@schaufler-ca.com, 
	john.johansen@canonical.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:09=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2024-06-25 at 11:10 -0400, Paul Moore wrote:
> > On Mon, Jun 24, 2024 at 8:06=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Mon, 2024-06-24 at 18:47 +0200, gregkh@linuxfoundation.org wrote:
> > > > The patch below does not apply to the 6.6-stable tree.
> > > > If someone wants it applied there, or to any other stable or longte=
rm
> > > > tree, then please email the backport, including the original git co=
mmit
> > > > id to <stable@vger.kernel.org>.
> > > >
> > > > To reproduce the conflict and resubmit, you may use the following c=
ommands:
> > > >
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/li=
nux.git/ linux-6.6.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34
> > > > # <resolve conflicts, build, test, etc.>
> > > > git commit -s
> > > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20240=
62438-shaft-herbicide-4e7d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > > >
> > > > Possible dependencies:
> > > >
> > > > 9a95c5bfbf02 ("ima: Avoid blocking in RCU read-side critical sectio=
n")
> > > > 260017f31a8c ("lsm: use default hook return value in call_int_hook(=
)")
> > > > 923831117611 ("evm: Move to LSM infrastructure")
> > > > 84594c9ecdca ("ima: Move IMA-Appraisal to LSM infrastructure")
> > > > cd3cec0a02c7 ("ima: Move to LSM infrastructure")
> > > > 06cca5110774 ("integrity: Move integrity_kernel_module_request() to=
 IMA")
> > > > b8d997032a46 ("security: Introduce key_post_create_or_update hook")
> > > > 2d705d802414 ("security: Introduce inode_post_remove_acl hook")
> > > > 8b9d0b825c65 ("security: Introduce inode_post_set_acl hook")
> > > > a7811e34d100 ("security: Introduce inode_post_create_tmpfile hook")
> > > > f09068b5a114 ("security: Introduce file_release hook")
> > > > 8f46ff5767b0 ("security: Introduce file_post_open hook")
> > > > dae52cbf5887 ("security: Introduce inode_post_removexattr hook")
> > > > 77fa6f314f03 ("security: Introduce inode_post_setattr hook")
> > > > 314a8dc728d0 ("security: Align inode_setattr hook definition with E=
VM")
> > > > 779cb1947e27 ("evm: Align evm_inode_post_setxattr() definition with=
 LSM infrastructure")
> > > > 2b6a4054f8c2 ("evm: Align evm_inode_setxattr() definition with LSM =
infrastructure")
> > > > 784111d0093e ("evm: Align evm_inode_post_setattr() definition with =
LSM infrastructure")
> > > > fec5f85e468d ("ima: Align ima_post_read_file() definition with LSM =
infrastructure")
> > > > 526864dd2f60 ("ima: Align ima_inode_removexattr() definition with L=
SM infrastructure")
> > >
> > > The patch doesn't apply cleanly due to the '0' in security_audit_rule=
_init():
> > >         return call_int_hook(audit_rule_init, 0, field, op, rulestr, =
lsmrule);
> > >
> > > Commit 260017f31a8c ("lsm: use default hook return value in call_int_=
hook()")
> > > removed it.  Instead of backporting commit 260017f31a8c, adding the '=
0' would be
> > > simpler.  This seems to be the only change needed for linux-6.8.y to =
6.4.y.
> >
> > Agreed.
> >
> > > For linux-6.3.y to linux-6.2.y, commit b14faf9c94a6 ("lsm: move the a=
udit hook
> > > comments to security/security.c") also needs to be applied.
> > >
> > > Paul, how do you normally handle backports?
> >
> > Normally I just tag them accordingly and let the stable team handle
> > it, with the understanding that the stable team only picks patches
> > that have been explicitly marked for stable and not just anything with
> > a 'Fixes:' tag.  I'm sure you remember when we discussed this
> > recently, there shouldn't be anything new here.
>
> Ok. This should have then been tagged for Stable.

Yep, it was.

> > The tricky part is what the patch fails to merge automatically.  It
> > has been my experience that the stable team really doesn't try to do
> > any manual merge fixups on the LSM, SELinux, or audit patches, so it
> > is really up to me or someone else who cares enough to do the backport
> > manually and resubmit.  See "option #3" in the stable kernel docs:
> >
> > * https://docs.kernel.org/process/stable-kernel-rules.html#option-3
> >
> > I've personally had some bad experiences working with the stable trees
> > (YMMV) which combined with a chronic lack of time means that I rarely
> > do a manual backport for the stable trees (the bug needs to be
> > especially horrendous).  However, others are always free to submit
> > backports, see the "option #3" link above.
>
> Ok. Looks like option 3 is the way to go then.

Sounds good.

--=20
paul-moore.com

