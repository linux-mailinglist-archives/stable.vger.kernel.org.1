Return-Path: <stable+bounces-227360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLbBEpU9vGlxvgIAu9opvQ
	(envelope-from <stable+bounces-227360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:16:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E22D0B1E
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF4832845D4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835EB39447C;
	Thu, 19 Mar 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+7dDoex"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DA23988F1
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943678; cv=pass; b=kM3p7WpIBrd9b6B6gyWi96j19VvLosnU/NefM8L9/KH/UhS0WEk8xrord7mSUJilt/FY2qdaKBejGg7LxVUm51hvypOXf+JylNi6LfNqlfEBo7RLskWU56WyvHWYNjeOjePyHPNhHJoDKZcT+7JOMzPeubuZohdkZ4qgdhO07rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943678; c=relaxed/simple;
	bh=qLyBC2v3psQTDHggKp6cAb3+simj2kT/Xqn/adDf4nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+VdM4dxlr5WhcPxXUKn1wLvh2vCP7HPrMMJYd77Zqo4bYP2O+SZ7eId6CGpFGMQolb9dYaUiyXpkevi1nMjQn+EGt0MpcoKfwb3xYITDk3p3kGI4i89Xi9ZxI/xW/pqNcC62kI+wtr/CD0g5Q8B0wgmlG3TD75/NDoIrUkDObA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+7dDoex; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486b96760easo13744525e9.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773943674; cv=none;
        d=google.com; s=arc-20240605;
        b=Leikmi7aUOm6eTIr2yqyMR+gM+iqsr2cKMO/wmLJdRqwIWWa71fGg7eVIoBpv8MVtm
         ArFMR81nxDBOUQ+uaBBX+JTGvwkvLPubaJ8eo8x2lUJgDOUYsUrJGPU9nP97PjzEqjnm
         46miGV3Satk55io7ycK/VhfXZy/wrUei1Kx1pp/v9q3sPEU0CCf1N3bILX/hLbxHVvpn
         uo2dq4tZ7JSJyB/zOw2t2aAGcwSjJMdao5tQfzx2xiHvzqXD8t17hYnDwOefO/Zn8FPB
         FS7VxK2bR2+k/IG0M/1BBmPMiAKiYSipIagC4zbLagEqFs8syVA2I1X/o0oeCVQ77232
         XykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        fh=ZED9GvzQ19TofPAi8yvKnaq1iTopEEZB1yW0mh5xpW8=;
        b=Ve15rDDDnK+uSKQaBOK5qdMu6IOHvl4SKwP9ffZ1yqyjKHGdPvlbt3BJkLOpY+FqaN
         wnb+0iBBXNv6iBQvr7IvlIC7u4RDylL0UD16M0O/IkjGASTh8VLqftECCI/VeJP9y4Pp
         m4EeZHVsIgAjz+Qf8zQejDAz9dgSrlFCDRUG3S48cuA86qehYRGIBnTe9wfp94LGenIo
         pWHPa/jHo346u2aLlD0wBPKtI5S03teSx7omeYPh87CP2LMtsWmd8bqA6+RbHEKFMqFZ
         QNfE5mf2Rm+ziVupRKtRrTijd4JEl3cJO3yV3j7rYs4jVKBYAx4LYHffpOO7Hlmk6kuQ
         gtzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943674; x=1774548474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        b=g+7dDoexpUo2XZb3gfCtgxL6GYIMbW3NNNU0LNQT+eecn24i0HZpMjD+f4ddNbaxtm
         eXFoxgFBGaYh3Zbfwb/KTIEQLjBxHgbqIgXfxQdQ183zPE9G0Vu6Cxc2mFOa4dYcg5Jl
         sIvbHx0P8K3R0ES7NmwsR7I/KC4msGLZW4A6Vykd3/X7QSQLUC8GqZ7fSKhgGtv62bHc
         OnFpVj6P+PydbBqek+Xw6jfj8DS8rWftuvVYX4w4BhQgvGmEQHa0tMOGa3bb7W3fMjhy
         arWLTvVJrUHqiFVkPDLr/ACX4NG9qHqjqh+mMjOBKSRiB1EGgyu0Qmnf9MJynsV+qsgH
         TQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943674; x=1774548474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPwYDOqDzfGuF9EEcoCkuHGw4QSL61z/ViJbQ5YfE90=;
        b=i7ePijajGx6DYwmCl9OQLVL48VhyPEoRERzTIZ9jPKwE/rZVAXG/FQcjwOtFQT0vbJ
         nRkQ5/1PjRKJ5F+cbQySoTrVvbKFXwH9dJ0i20jGDxQMEoBVkSawQoEjWx1h8FOa2f3P
         zZ36z4StOau0l5C+j0NHWAYuwI8QkR5No+baRbH/6dXWBmEP7kSNG4Yaou5eKtIb/rFV
         gIvpPTBDYbh7q8DqsmwhbBGGrpKWAFTd7Bt4qP4vRe3HGoVDp0dmwqEYqlMIkbqDi7Ib
         DpWXJqnbYBAXPRh2IYhekYkUmWAwdlUxYsixgLo9a5YknlMTs4X8ZIOLwUjMUAGzomBd
         lb+A==
X-Forwarded-Encrypted: i=1; AJvYcCVGFLMvdlzVmxatfG3xjOjElaGgUGXX15tjbUMK2GFMl99WnlJARsZdMpmKeHTU4GRfiDFH+PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMO+SJ90gjUTmw4zjyJqr1GubgNC7BQ3O5fo2kefhKXln3fwq/
	NeFeAOPtRgr9DicKVvPtTJ6nUu5ZanrV5SMzMYBWdXtySx5MiDdwUoAd9KXUhpmu6zm0iOKylvE
	3cxl3ETorxTMV3lG4DNXVKfifYOilcH4=
X-Gm-Gg: ATEYQzwSWhdjPNJiHJwDUaTHcVjg95rV9YskngXbjP6my819ohTVFSqbLxWixM0dQDd
	D0hAcrkMgUNGQaQiNwze3JzGUc1yAVubwq8lpBSbbBDPc2w+H8m32qy6UHc2Slk8g+MzrhLllsr
	V5abceqO62hw0SVs18xvFaThsuc+LdqWLad6s4O8dIVypmW0LjSkBx7uyKqeSIqEEjs9uygAzcX
	Xnp483LNWK3FkzyHDqQ05j+EvgbFn9usXivnxh28bufa5LlHYkWkt+kB5mp/wTip4K3XoabqdOC
	e9rCpA==
X-Received: by 2002:a05:600c:4e8e:b0:485:3fd1:992c with SMTP id
 5b1f17b1804b1-486fedaafc2mr1248265e9.1.1773943674033; Thu, 19 Mar 2026
 11:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318225604.71545-1-joannelkoong@gmail.com> <k7ln2mcmll3t4zic3smao6hvvxprmpsax45fh6mwn4en6f6m42@sdpuqd2pqiwy>
In-Reply-To: <k7ln2mcmll3t4zic3smao6hvvxprmpsax45fh6mwn4en6f6m42@sdpuqd2pqiwy>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Mar 2026 11:07:42 -0700
X-Gm-Features: AaiRm51PiGs5infWIQSFJuqnAy1FZOdjdr7orrxLP3LNZfiW4rd16rvmfCo8zAw
Message-ID: <CAJnrk1Z7OTah=zam8_4LWx8Kc0B6omrVbiiDRNHm34yAKNEBEA@mail.gmail.com>
Subject: Re: [PATCH v1] writeback: skip sync(2) inode writeback for
 filesystems with no data integrity guarantees
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	david@kernel.org, therealgraysky@proton.me, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E44E22D0B1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 5:42=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-03-26 15:56:04, Joanne Koong wrote:
> > Add SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that cannot
> > guarantee data persistence on sync (eg fuse) and skip sync(2) inode
> > writeback for superblocks with this flag set.
> >
> > There was a recent report [1] for a suspend-to-RAM hang on fuse-overlay=
fs with
> > firefox + youtube in wb_wait_for_completion() from the pm_fs_sync_work_=
fn()
> > path:
> >
> > Workqueue: pm_fs_sync pm_fs_sync_work_fn
> > Call Trace:
> >  <TASK>
> >  __schedule+0x457/0x1720
> >  schedule+0x27/0xd0
> >  wb_wait_for_completion+0x97/0xe0
> >  sync_inodes_sb+0xf8/0x2e0
> >  __iterate_supers+0xdc/0x160
> >  ksys_sync+0x43/0xb0
> >  pm_fs_sync_work_fn+0x17/0xa0
> >  process_one_work+0x193/0x350
> >  worker_thread+0x1a1/0x310
> >  kthread+0xfc/0x240
> >  ret_from_fork+0x243/0x280
> >  ret_from_fork_asm+0x1a/0x30
> >  </TASK>
> >
> > This can happen in two ways:
> > a) systemd freezes the user session cgroups first (which freezes the fu=
se daemon)
> > before invoking the kernel suspend. The suspend triggers the wb_workfn(=
) ->
> > write_inode() path, where fuse issues a synchronous setattr request to =
the
> > frozen daemon, which cannot process the request
> > b) if a dirty folio is already under writeback and needs to have writeb=
ack
> > issued again, in writeback_get_folio() -> folio_prepare_writeback(), we
> > unconditionally wait on writeback to finish, but for buggy/faulty fuse
> > servers, the request may never be processed
> >
> > The correct fix is for sync(2) to skip the sync_inodes_sb() path entire=
ly for
> > any filesystems that do not have data integrity guarantees.
> >
> > A prior commit (commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INT=
EGRITY
> > mappings in wait_sb_inodes()")) added the AS_NO_DATA_INTEGRITY mapping =
flag to
> > skip sync(2) waits for mappings without data integrity semantics, but i=
t still
> > allowed wb_workfn() worker threads to be kicked off for the writeback.
> >
> > This patch improves upon that by replacing the per-inode AS_NO_DATA_INT=
EGRITY
> > mapping flag with a flag at the superblock level, and using that superb=
lock
> > flag to skip the sync_inodes_sb() path entirely if there are no data in=
tegrity
> > guarantees. The flag belongs at the superblock level because data integ=
rity is
> > a filesystem-wide property, not a per-inode one. Having the flag at the
> > superblock level allows sync_inodes_one_sb() to skip the entire filesys=
tem
> > efficiently, rather than iterating every dirty inode only to skip each =
one
> > individually.
> >
> > This patch restores fuse to its prior behavior before tmp folios were r=
emoved,
> > where sync was essentially a no-op.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a-asuvfrbKXbEwwDSctvem=
F+6zfhdnuzO65Pt8HsFSRw@mail.gmail.com/T/#m632c4648e9cafc4239299887109ebd880=
ac6c5c1
> >
> > Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and interna=
l rb tree")
> > Reported-by: John <therealgraysky@proton.me>
> > Tested-by: John <therealgraysky@proton.me>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> I'd note that previously, if the FUSE server was not broken, although
> sync(2) would not provide any data integrity guarantee, it would still
> flush the data so practically, there would be no user observable differen=
ce
> unless you really did powerfail testing. So some users might be
> unpleasantly surprised by sync(2) suddently not doing anything on FUSE
> filesystems. Maybe for SB_I_NO_DATA_INTEGRITY filesystems we should at
> least kick flush worker to do writeback in the background?
>
>                                                                 Honza
>

That's a great point. I'll make this change for v2.

Thanks,
Joanne

