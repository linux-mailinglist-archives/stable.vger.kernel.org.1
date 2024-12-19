Return-Path: <stable+bounces-105354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A846E9F83F3
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A767A25D5
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 19:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A71AAE1A;
	Thu, 19 Dec 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDVUSTji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FA1AA7BA;
	Thu, 19 Dec 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635938; cv=none; b=UmHBwOdCEAERtc91o0BZAX8lPFkPLLW4MDsPglLyHd7nGkpYVTdL7ck902eC3Nh9XDRgCfMyhLyBe/00pAEcuyQ9qClPQRfk8EwbLwcdxKH6SrY6aJrTIv/COUz4dKNtrOHmLmVmBhei9OS+xaSDPF1kU+g7gL3huNx7rdetqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635938; c=relaxed/simple;
	bh=PiEDJmRgJ7E0oJScUKnekyqnsf1u7h8/HbTR1w56YKw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScMX/MuseIf5iZ5T05YW8JD09DXJhwhP/mr2YxEbnWWp8YK6bsvbd1FofNeqSEdsCGjuTIjFMEajdp6hbshxIGeW9K5kQdwVG3tCpODCTUTbkFD8sLKDJZVImTTAfxnxRsw7kGEnamx4cSPQbFgyD+K4jbR/thU3cxxE/YoPC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDVUSTji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D99DC4CECE;
	Thu, 19 Dec 2024 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734635938;
	bh=PiEDJmRgJ7E0oJScUKnekyqnsf1u7h8/HbTR1w56YKw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pDVUSTjiATTYNlSP4xKvoZoZEojxB2maGEayHH5HqwhCWef9cetrwv3H5sEt1k0a0
	 eSFxXOeJIMpsP69ITFh/NU8TGFl5Xhx6ECuS9t7D55FdzV/PUp7KstmNKusqUXbzw3
	 vEBUpT7FdV1KpKFPPTI9SPLnGBSgwWLSyxMHFOv7WuCQIL64axqhF5zxcu06aJiwsg
	 XOenZm2yjUUloELD+jToBIHVpsnHS9O7VcTmhBirNmB2MP4UWqr+tL9YbhJXT1jBVT
	 TuZDEs+0pmVbe3mkj68hd3qknE6w5k6u5Xsl+kA68MeEVpq5hs8cFWmC65gO9bqywD
	 T6pFNUJYU4THw==
Date: Thu, 19 Dec 2024 11:18:57 -0800
Subject: [PATCHSET 1/5] xfs: bug fixes for 6.13
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: eflorac@intellique.com,
 syzbot+3126ab3db03db42e7a31@syzkaller.appspotmail.com, hch@lst.de,
 stable@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de
Message-ID: <173463578212.1570935.4004660775026906039.stgit@frogsfrogsfrogs>
In-Reply-To: <20241219191553.GI6160@frogsfrogsfrogs>
References: <20241219191553.GI6160@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Bug fixes for 6.13.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=xfs-6.13-fixes

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=xfs-6.13-fixes
---
Commits in this patchset:
 * xfs: don't over-report free space or inodes in statvfs
 * xfs: release the dquot buf outside of qli_lock
---
 fs/xfs/xfs_dquot.c  |   12 ++++++++----
 fs/xfs/xfs_qm_bhv.c |   27 +++++++++++++++++----------
 2 files changed, 25 insertions(+), 14 deletions(-)


