Return-Path: <stable+bounces-98208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE29E31B1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD52282103
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30B03B192;
	Wed,  4 Dec 2024 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfG5VuYE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE87FC1D;
	Wed,  4 Dec 2024 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281344; cv=none; b=FbOj//eMCzjvVr60XPhrmlpb54Yth5wftgUZ95yBYedPJfdzVr+2ViiofEvj9SS5Vn/BisuDA3sfTuwXdoB0P7I1Z1aD+vuHqv03mPuoqSe5W7bWBVTyUPLphVtgEvpHNMtbmPfsalnkBBw3nzCPSTXtDW2KRAbCAEH0cV5sDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281344; c=relaxed/simple;
	bh=kzQMxwy6Tj9leoCoZSvE17afHwh3GsqGcBKPQr5brHI=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=ibhw8e7QiezB4qcpsQ/E94rohU3CBLnRtDwXdY+HDFwLJAztaapOaGrFMrqOGidlY5eQHyufbS0NGdps1bN0+HJG8RcBqtC/jhwLoGx7xzoTAItRzmhLsh7/bv1Cd2s9qrGi6WdfEJjsbDn5mYkaUJFTmffAxKagJn6ftXbOdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfG5VuYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433B2C4CEDC;
	Wed,  4 Dec 2024 03:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281344;
	bh=kzQMxwy6Tj9leoCoZSvE17afHwh3GsqGcBKPQr5brHI=;
	h=Date:Subject:From:To:Cc:From;
	b=SfG5VuYE9HkLAfdsRsTZK6onMIt9KbeIWeXT8GME1d2dlQ9gE3LKGQr1ImmawMAlV
	 WkmYIFLfpa9NBozQHLM75kl/A08YZA4iAKGNzCCYegpsoshh8w10nyNMe+JrtXBABA
	 a7uW8aea1MZtvYYKsq8wHH2ZoDTWQzcICn/fe+ngXtW4+4Fo5Rh2GPV6nD9dEUxLvq
	 1ovRf4RmPlWIJOMPXFBB5By7rsi9LnMc9c7YOb/u/geAQLIL0jfE8lhTIkyAX/DBX+
	 6hhWIz4NYqnamC4iDY8dfVHCGtAXc7d4h6RJ9p3Y6VXzWRYyd15WKBEVXGDFxMSydu
	 YiZrP+/0M6PYA==
Date: Tue, 03 Dec 2024 19:02:23 -0800
Subject: [PATCHSET v2] xfs: proposed bug fixes for 6.13
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: stable@vger.kernel.org, jlayton@kernel.org, linux-xfs@vger.kernel.org,
 hch@lst.de
Message-ID: <173328106571.1145623.3212405760436181793.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here are even more bugfixes for 6.13 that have been accumulating since
6.12 was released.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=proposed-fixes-6.13
---
Commits in this patchset:
 * xfs: don't move nondir/nonreg temporary repair files to the metadir namespace
 * xfs: don't crash on corrupt /quotas dirent
 * xfs: check pre-metadir fields correctly
 * xfs: fix zero byte checking in the superblock scrubber
 * xfs: return from xfs_symlink_verify early on V4 filesystems
 * xfs: port xfs_ioc_start_commit to multigrain timestamps
---
 fs/xfs/libxfs/xfs_symlink_remote.c |    4 ++
 fs/xfs/scrub/agheader.c            |   66 ++++++++++++++++++++++++++++--------
 fs/xfs/scrub/tempfile.c            |    3 ++
 fs/xfs/xfs_exchrange.c             |   14 ++++----
 fs/xfs/xfs_qm.c                    |    7 ++++
 5 files changed, 71 insertions(+), 23 deletions(-)


