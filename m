Return-Path: <stable+bounces-189208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF2C04FA1
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 10:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3023500B53
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE72FF170;
	Fri, 24 Oct 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzu/hS9Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510D2FDC37
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293284; cv=none; b=ntXp9Dd9/L2dv0GaG8wKYNPFeW9VBMFqL6GGmQiFgFZgH8y/dUPJykoDgH0P3FKJN9O6qmpddArJuDWbruuQO48ss8Jdl9fUmTVgKczB4dxZoDGtfLiExyIPTkrgaCjqTkI+1B+/WnvCl4vy1Jk54ha8OYAOxoomrOmZPMVocZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293284; c=relaxed/simple;
	bh=IU+pnkb8iIp2RtUo9AKGUS4QXSBis0P6PzHO17Q4JIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q36JyWethfo7Npcr7qJt9Xbe7Frv0Q42jDmwEPIHvM0DVtnO4AkiFO60bW7bWr5oLkl12E0m0ygkSlKs4I5qtpVMq5ng8C197BsBKgMW/sor9+0EQxnHyu8zwtlcz9OvYCsEMss3B22ha/vDori3tX72hSoAyNGc69sOqLQ77xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzu/hS9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ECEC4CEF1
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 08:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761293284;
	bh=IU+pnkb8iIp2RtUo9AKGUS4QXSBis0P6PzHO17Q4JIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fzu/hS9YWzHZSfJQj2I9AdHG/xtllgmSJwX7oWqK2q2hyYeBRnWjGaxA9TFfqS5I1
	 lA1SHHd41i8kEFsRtSKhIxs6OetRuvsECD1EfH5Fz717zxEUqo2AuxkWVEWqIw1BKN
	 So5WMu3X9/kVQ0Ss/+r5qOGPs37xhxUWMvgh+odRjTXmkgb1X2zKNVX2vO1w9mZx/i
	 qt0GaLyWQPpc5+B1E4LDO1TMQQsAxG2nNE6sT4GcjzuL996gHxIbxcBSEzM4VEOPna
	 jycjmkS1PzEqdaR9AJK7dBkXTu+ly9j0xceSbD+2JjNXSqZqblwMlQ1UhSyz1SO7Te
	 IjCRkZdCsUc3A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b5c18993b73so311828566b.0
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 01:08:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFC6V9vfpBSDPZb/gn4NTnqaRDi4qsn41ugURN/tl0mfgqIVdVe4leULDCKtJR1IHV0iA5+OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrpJ5sHW9CDHhrVYkmalbcWyBY0Q496ezzsUvJazQOfigFBe1
	/zdO8A/B8K8eplmgzfHd4K4IUO0ERkQB8WyoSrPgfSj/FkbZAQb9q38qOcMXDlKO0L0MXEL/9Cj
	rLVaJqpo/VOYGdZqCk5HBtC0ezc/Cb5g=
X-Google-Smtp-Source: AGHT+IGH79+JgwLclN4+8Tp8Gekgcp5d7Xc46At305N7IPdNgexbnoFilL+RyujhJbuI2+sVIr8COIf0tyA7lhSe+E4=
X-Received: by 2002:a17:907:3f8f:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b6d6ffb541fmr152945166b.55.1761293282925; Fri, 24 Oct 2025
 01:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
 <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com> <6f36e8d0-630b-4cc3-a780-11be4aa0a65f@suse.com>
In-Reply-To: <6f36e8d0-630b-4cc3-a780-11be4aa0a65f@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 09:07:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4TcJNY7cYeYWoByOW0ek6BBEbtgSSFFOvc7aagarfFXQ@mail.gmail.com>
X-Gm-Features: AS18NWD7MUh43ObV5_snK0od1BhyGPDV6iPjIDcHqpg08WbG7w_nr3m1M3qJujA
Message-ID: <CAL3q7H4TcJNY7cYeYWoByOW0ek6BBEbtgSSFFOvc7aagarfFXQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: make sure no dirty metadata write is submitted
 after btrfs_stop_all_workers()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/10/24 01:56, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Oct 23, 2025 at 10:33=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
> [...]
> > So two suggestions:
> >
> > 1) Move this into btrfs_error_commit_super(), to have all code related
> > to fs in error state in one single place.
> >
> > 2) Instead of of calling filemap_write_and_wait(), make this simpler
> > by doing the iput() of the btree inode right before calling
> > btrfs_stop_all_workers() and removing the call to
> > invalidate_inode_pages2() which is irrelevant since the final iput()
> > removes everything from the page cache except dirty pages (but the
> > iput() already triggered writeback of them).
> >
> > In fact for this scenario the call to invalidate_inode_pages2() must
> > be returning -EBUSY due to the dirty pages, but we have always ignored
> > its return value.
> >
> >  From a quick glance, it seems to me that suggestion 2 should work.
>
> Yes, that's the original workaround I went with, the problem is we're
> still submitting metadata writes after a trans abort.
>
> I don't feel that comfort writing back metadata in that situation.
> Maybe the trans abort is triggered because a corrupted extent/free space
> tree which allows us to allocate new tree blocks where we shouldn't
> (aka, metadata COW is already broken).

Metadata COW is broken why??

Even after a transaction aborts, it's ok, but pointless, to allocate
extents and trigger writeback for them.
As long as we don't allow the transaction to be committed and new
transactions to be started, we are safe - in fact that's the only
thing a transaction abort guarantees.

We may have many places that could check if a transaction was aborted
and avoid extent allocation and writeback, but that's ok, as long as
we don't allow transaction commits.

>
> Thus I consider delaying btrfs_stop_all_workers() until iput() is only a
> workaround, it still allows us to submit unnecessary writes.
>
> I'd prefer the solution 1) in this case, still with the extra handling
> in write_one_eb().
>
> Thanks for the review and suggestion, will follow the advice of the
> remaining part.
>
> Thanks,
> Qu
>

