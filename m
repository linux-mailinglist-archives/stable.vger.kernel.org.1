Return-Path: <stable+bounces-179654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE60B585FC
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2422E2A4339
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 20:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05428E5F3;
	Mon, 15 Sep 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba4SaV62"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C327C150
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967655; cv=none; b=JQGz+gN+7a0lxpq0sTPbDWeBNk0ycgAL7BocxfRC9Pqkfv5MEijUKc8pnOWSfns/ZIG96VOrh1WCrQ0gj6Y3hW5nO8NqqoBmG+D5Ne5OjweKEhKSvD5hqLBU+QGtegQLks4FloxTxhSN5BWSBQfjg+an7RuG687BRLC9XRtl3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967655; c=relaxed/simple;
	bh=+SLUOZGs/qS2cXaKoug7x+JwelyJoUiOaA7pbJGRa9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvHDa2FgaUToKviESTunteQsNEuyW5j+BYVVuPeLIHe9b1TB3lyMf2y4TWae30YCLqx8//U3MyFt4M+BSCHoZ58ARv9vda54uTgr5WjkdMv0TvYof5dfvbT9jY7r+Ikmta3praoxH2a5+4N+0VBCZbf281mMbqCkiqV4XR+Hy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba4SaV62; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so8843257a12.2
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967652; x=1758572452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcV4wf+5WuOoeJKKBkai9T7otnt8wOzWs/vg6TVn+7A=;
        b=Ba4SaV62pTWNr6EEoguOsWNxRtcAxj66/6IkQPAaxblECwqwQIEzPqOBHreyIxYjRV
         8wkJQMzRvcwO6+qlGv/EzWRcnUpHL0ltzyXAEG7X3VkvGB5AzfR3isK4PfiKRBsTTPEJ
         LbXpPBRuUGddATX8pHy/x2hrNLgYs3vkXvPdHY2UkbnMHWWVxQMMF/2t6drCSVzlEiRe
         0NhRVopH2BbbZnrVQr1IfUOHwvU5Z3bPjJklHVxsFOwEcfMG5Rq9cSZpzvZRrMzQH724
         THHo3f+1/KroN8Mqkgy5ex8o+as22hjJHLAMYVM4gRLS7bnSEX0JXxQTPwuHXwpRWYl+
         GkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967652; x=1758572452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcV4wf+5WuOoeJKKBkai9T7otnt8wOzWs/vg6TVn+7A=;
        b=isdW9+YYfDNpAr3D7Mn1QFvyZI459c17b5UxXEh6PmYKSFmbjKOnS+ZKGtDQgrO9ua
         GVPFYxRAaNOtmMZj9YJXCBAgudNPQ8olCjZ8dZo/4ccZIdePCqhgOEhhHq1v9BjExxLS
         1t9e2bQpr6QGQkd1rAw+59C5SCcj0JHW4bQz6vjiyqZgJNbXeeN2ZPLSxV2kjC+ACK37
         qz6e3/phcyYevzsuSar5aLwVlZf67OqD4F7wPHBg/4ZTMYLOnQawxgQQ0082w5XTS2dC
         E4K1LxyF2r6BycMIA6xYHnYCMIisvn0cRO8imbaVLTlvXm7spQdECQa4VsmKxLFMTLo3
         A5dA==
X-Forwarded-Encrypted: i=1; AJvYcCWz6ms3IYL/zuC2qKCQdkD6/wHMeIlkFaCFHNJK8U8QDILZC1vkoo8Tq8pbiNURZiyLVHuGvqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Oexz2R47WwSLStHJ7kvmAhJsr38QXnMFn7i1biawsKONIe4X
	KKcb0JtS82UAwqlWRQEjlI25hptH92ELM0pN84UPDEcEIbPae8Nsvys8650eGSw2kQfAdoxnhWp
	4JRH6NQltg44u632944nOgfHDWp5Rv+k=
X-Gm-Gg: ASbGnctOHZpzmhPvJhstTBQUBV4hPWCO7kxeCchNeYh0VLr7z55lJUQVVig315e7uyL
	COyjrHculFLsEniOtYpak+SlbWTlxco5Zy7DY7xR93zGka1PhEweszhy+mWK9j2KkK90rRlATjG
	uTlEzJn4igt0JsgX8Wu3TQ9/Ek90YAbnZAlsApoYtOqkJCYw61aK5FAOqRVYk01249IiSAa2Kck
	QBGZsoD4CGtc/ZFhb4kCAMy45wJWxwxaCgXBUGIfwcsMpXnrMPN
X-Google-Smtp-Source: AGHT+IGYABGg7Uj58FeWOIrBs5TeeS8JiH8hNIJ+ma9m4krolqPGMWxATE1E0UGWN02bDuIslGoQuD0eAuM4rI8wTxU=
X-Received: by 2002:a05:6402:524e:b0:62f:4f1b:891d with SMTP id
 4fb4d7f45d1cf-62f4f1b9917mr2408740a12.2.1757967651735; Mon, 15 Sep 2025
 13:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913030503.433914-1-amir73il@gmail.com> <20250915182056.GO8096@frogsfrogsfrogs>
In-Reply-To: <20250915182056.GO8096@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Sep 2025 22:20:40 +0200
X-Gm-Features: AS18NWAt3QLFx-SVagIXEf_zp-tZNYESWbPWrYnKJUdNAFCyHFTA7DKGZO2-Wjs
Message-ID: <CAOQ4uxg4eBMS-FQADVYLGVh66QfMO+tHDAv3TUSpKqXn==XdKw@mail.gmail.com>
Subject: Re: [PATCH CANDIDATE 5.15, 6.1, 6.6] xfs: Increase
 XFS_QM_TRANS_MAXDQS to 5
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Catherine Hoang <catherine.hoang@oracle.com>, 
	Leah Rumancik <leah.rumancik@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:20=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sat, Sep 13, 2025 at 05:05:02AM +0200, Amir Goldstein wrote:
> > From: Allison Henderson <allison.henderson@oracle.com>
> >
> > [ Upstream  commit f103df763563ad6849307ed5985d1513acc586dd ]
> >
> > With parent pointers enabled, a rename operation can update up to 5
> > inodes: src_dp, target_dp, src_ip, target_ip and wip.  This causes
> > their dquots to a be attached to the transaction chain, so we need
> > to increase XFS_QM_TRANS_MAXDQS.  This patch also add a helper
> > function xfs_dqlockn to lock an arbitrary number of dquots.
> >
> > Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > [amir: backport to kernels prior to parent pointers to fix an old bug]
> >
> > A rename operation of a directory (i.e. mv A/C/ B/) may end up changing
> > three different dquot accounts under the following conditions:
> > 1. user (or group) quotas are enabled
> > 2. A/ B/ and C/ have different owner uids (or gids)
> > 3. A/ blocks shrinks after remove of entry C/
> > 4. B/ blocks grows before adding of entry C/
> > 5. A/ ino <=3D XFS_DIR2_MAX_SHORT_INUM
> > 6. B/ ino > XFS_DIR2_MAX_SHORT_INUM
> > 7. C/ is converted from sf to block format, because its parent entry
> >    needs to be stored as 8 bytes (see xfs_dir2_sf_replace_needblock)
> >
> > When all conditions are met (observed in the wild) we get this assertio=
n:
> >
> > XFS: Assertion failed: qtrx, file: fs/xfs/xfs_trans_dquot.c, line: 207
> >
> > The upstream commit fixed this bug as a side effect, so decided to appl=
y
> > it as is rather than changing XFS_QM_TRANS_MAXDQS to 3 in stable kernel=
s.
>
> Heh.  Indeed, you only need MAXDQS=3D=3D5 for filesystems that support
> parent pointers, because only on those filesystems can you end up
> needing to allocate a xattr block either to the new whiteout file or
> free one from the file being unlinked.
>
> > The Fixes commit below is NOT the commit that introduced the bug, but
> > for some reason, which is not explained in the commit message, it fixes
> > the comment to state that highest number of dquots of one type is 3 and
> > not 2 (which leads to the assertion), without actually fixing it.
>
> Agree.
>
> > The change of wording from "usr, grp OR prj" to "usr, grp and prj"
> > suggests that there may have been a confusion between "the number of
> > dquote of one type" and "the number of dquot types" (which is also 3),
> > so the comment change was only accidentally correct.
>
> I interpret the "OR" -> "and" change to reflect the V4 -> V5 transition
> where you actually can have all three dquot types because group/project
> quota are no longer mutually exclusive.
>
> The "...involved in a transaction is 3" part I think is separate, and
> strange that XFS_QM_TRANS_MAXDQS wasn't updated.
>
> > Fixes: 10f73d27c8e9 ("xfs: fix the comment explaining xfs_trans_dqlocke=
djoin")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christoph,
> >
> > This is a cognitive challenge. can you say what you where thinking in
> > 2013 when making the comment change in the Fixes commit?
> > Is my speculation above correct?
> >
> > Catherine and Leah,
> >
> > I decided that cherry-pick this upstream commit as is with a commit
> > message addendum was the best stable tree strategy.
> > The commit applies cleanly to 5.15.y, so I assume it does for 6.6 and
> > 6.1 as well. I ran my tests on 5.15.y and nothing fell out, but did not
> > try to reproduce these complex assertion in a test.
> >
> > Could you take this candidate backport patch to a spin on your test
> > branch?
> >
> > What do you all think about this?
>
> I only think you need MAXDQS=3D=3D5 for 6.12 to handle parent pointers.
>

Yes, of course. I just preferred to keep the 5 to avoid deviating from
the upstream commit if there is no good reason to do so.

> The older kernels could have it set to 3 instead.  struct xfs_dqtrx on a
> 6.17-rc6 kernel is 88 bytes.  Stuffing 9 of them into struct
> xfs_dquot_acct instead of 15 means that the _acct struct is only 792
> bytes instead of 1392, which means we can use the 1k slab instead of the
> 2k slab.

Huh? there is only one xfs_dquot_acct per transaction.
Does it really matter if it's 1k or 2k??

Am I missing something?

Thanks,
Amir.

