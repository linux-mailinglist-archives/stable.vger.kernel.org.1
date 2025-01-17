Return-Path: <stable+bounces-109355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C77A14E71
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E900188227F
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612D1FBEBF;
	Fri, 17 Jan 2025 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qp1R4vDK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737A46BF
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113141; cv=none; b=AaUH3TYy/CDsIUQS1EXg65EmqPlXVrmNKpJpgWRdcvRd8Arq5NTMN07ZrAniopAXqk2hwfBSFm4BafZWM+cTTzNEohb+xIVmxERVfAOz5scm52OBywEK0IEGveE+CFCXmLvQcifhScBfgCCLYyYdDCHx/+4ayTVq1unPmozxyqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113141; c=relaxed/simple;
	bh=H7A2hqMxKZYMX9asT2op2wIPHhhvQn1el8J9qlmdtis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbzorqb+Sd1TQbsOz7NUfS2/8Vn68S4K9+bJGc4KfGxHsgGw2Dm+klb3ncgmdd7ACnmupV6yIlGkKgmafzeqdUkyZa/j8QSC6ZrFcZz81oG0/Zb1G+VzTG4XXFZe7ZtJupetGkto650IjXV4EvDNsj+QX1Kp9ahNwMZcTSQnlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qp1R4vDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4E5C4CEDD;
	Fri, 17 Jan 2025 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737113140;
	bh=H7A2hqMxKZYMX9asT2op2wIPHhhvQn1el8J9qlmdtis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qp1R4vDKGsYVTSE+0Gmin5L01IIwaxm5u81jCuOsFQ0XP0R1hyps7+7dMVFT6mVvD
	 k6hfLf0C4qF0PVm4QKvSTXV+V7or4SoDBK36qLYRrOHb7iowfvuQvJHkyAZjOjhwpZ
	 xte/EL3Lqrew7nv5rkRqZZ1UPD6dNbL1JjtDFtaE=
Date: Fri, 17 Jan 2025 12:25:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dave Airlie <airlied@gmail.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	stable@vger.kernel.org, ashutosh.dixit@intel.com,
	dri-devel@lists.freedesktop.org
Subject: Re: AAARRRGGGHHH!!!! (was Re: [PATCH 6.12.y] xe/oa: Fix query mode
 of operation for OAR/OAC)
Message-ID: <2025011749-pueblo-brought-3107@gregkh>
References: <2025010650-tuesday-motivate-5cbb@gregkh>
 <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
 <2025011215-agreeing-bonfire-97ae@gregkh>
 <CAPM=9txn1x5A7xt+9YQ+nvLaQ3ycekC1Oj4J2PUpWCJwyQEL9w@mail.gmail.com>
 <2025011244-backlit-jubilance-4fa1@gregkh>
 <jwnn3zov3akpnqzbk5lss3r6q4yupj6indmmapwvh6hadcdycg@pvquyntsvqpe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jwnn3zov3akpnqzbk5lss3r6q4yupj6indmmapwvh6hadcdycg@pvquyntsvqpe>

On Fri, Jan 17, 2025 at 12:01:01PM +0100, Uwe Kleine-König wrote:
> On Sun, Jan 12, 2025 at 10:06:42PM +0100, Greg KH wrote:
> > That's fine, the issue is that you are the only ones with "duplicate"
> > commits in the tree that are both tagged for stable, every release.
> 
> Isn't a solution as easy as teaching your tooling not to create/accept
> commits on -next with Cc: stable? This way folks intending to push a
> change will notice it should go to the fixes branch. And if only
> afterwards you notice this is a critical fix that should get backported
> at least the commit that takes more time entering mainline doesn't have
> the stable tag.
> 
> Maybe additionally make sure that Fixes: and revert notices only point
> to commits that are an ancestor.

The commit is always an ancestor, the "trick" is which one when the
ancestor was cherry-picked previously?  That's the real problem here..

gre k-h

