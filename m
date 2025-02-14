Return-Path: <stable+bounces-116442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8FDA365AC
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 19:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A517A129B
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976A2686B3;
	Fri, 14 Feb 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBfCeEh4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157E6FC5;
	Fri, 14 Feb 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739557477; cv=none; b=W+wbdqdLGV1Xa4BRbdE4++Rp8YLGG2pfVNcDpDdXLIgDyHekZYXM082vNGZzeN+LNJ2YY7dOBP91TD2XDQPQU/rfQ+xlq//Q2ktO33XlKTszquDCh3lr91SuoZEKL0MvoU2n3E9CG85e1lgFYFUlms/uBJBqpvioszcGMxeRSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739557477; c=relaxed/simple;
	bh=EnPyDsRXxOiW9E/OiZLbcdVLTE16+ppq7ViugzHEnYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAAM5Xgc+jweLxlukSRrnyMrVjRX7dxgc6VsxdBy1Fu7UZ0xw4ZbXScNALElJB35yZ5fPVWGe1SXDqT65LX8PUjqi8LJbKoAfGwp739uFJwbu0WhsdwaMfwoG2sJOhslY4LIDkaNwtEP2ErJC2XcbsQAmlPvzTDJU0FipX/u+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBfCeEh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F42C4CED1;
	Fri, 14 Feb 2025 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739557476;
	bh=EnPyDsRXxOiW9E/OiZLbcdVLTE16+ppq7ViugzHEnYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBfCeEh4gj/A6ILiMdKMqQabCX9D4An7sg2s5CFZUToePUnsiq+euusSu7APeYf6z
	 BSZSwpY/LkyWyaWPw1xj0/nAYzz24KcNxBl4yywdrKFjnPZGldFsTwCPknANmHx2uK
	 Qxj9PkuRcxBOfErjo5bAJHoPoexjCsu+bGT41vAIsNimspWVUtggCukVPM+9FfrFjR
	 CebW6UtQwU7FecdBmn31qW+xL3U1I5/k6WyyaVLswvheP8KgQR8jBdNU/+eH5WxKEG
	 1eTRPLKnzsuzYLwcKjzFD/kQtBdMnKsDypCq9ElEr53g1mnXgUt6ZAJUnNXI0bmHsP
	 G4sUA4MrhDPVA==
Date: Fri, 14 Feb 2025 10:24:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: xfs-stable@lists.linux.dev, hch@lst.de, stable@vger.kernel.org
Subject: Re: [PATCH 03/11] xfs: don't lose solo dquot update transactions
Message-ID: <20250214182436.GB21799@frogsfrogsfrogs>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
 <173895601451.3373740.13218256058657142856.stgit@frogsfrogsfrogs>
 <2025021409-royal-swoosh-04d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021409-royal-swoosh-04d3@gregkh>

On Fri, Feb 14, 2025 at 02:35:34PM +0100, Greg KH wrote:
> On Fri, Feb 07, 2025 at 11:27:04AM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > commit d00ffba4adacd0d4d905f6e64bd8cd87011f5711 upstream
> 
> There is no such commit upstream :(
> 
> And maybe because of this, it turns out this commit breaks the build, so
> I'll be dropping it now.

Heh, I originally ported this patch when it was in my dev tree, then
later fixed something in the dev branch and forgot to update the lts
branch.  Then all those quota fixes got delayed for a month because
the upstream maintainer was on vacation and didn't push anything, and I
forgot to ever get back to this, and checkpatch didn't notice because it
doesn't validate commit ids that link to another repo.

Soooo here I go updating my bespoke checkpatch for a third day in a row,
and will resubmit this patch soon.

Q: Does everyone else already have Really Good maintainer scripts and I
am the grossly ignorant one?  Or is scripts/checkpatch.pl really the
only thing available?  Because it whines about things that nobody in the
xfs community really care about (minor style problems), and misses
things that we really /do/ care about (correct commit tagging).

--D

> thanks,
> 
> greg k-h
> 

