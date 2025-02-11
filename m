Return-Path: <stable+bounces-114860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B55A30627
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B503160C79
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420DB1F0E2A;
	Tue, 11 Feb 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDk8DLNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA91F03F1;
	Tue, 11 Feb 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263504; cv=none; b=HU71yOedTM56hwVKxvSP/qof0XcaXHb+apo3f1imWpXmjcUXkruKcWuaA2ov+3ljFXmLgb8p04B7uvN8Kt7HYe2dem/psPL/e2//EhIijwQEQDxEgHZ9WD6hj+QkNMotNk4iEPRAt4uTlj2g1zOTCXWj3/TXWRfg57tlE1KJMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263504; c=relaxed/simple;
	bh=YwLcB7linsP/tcU08MgVkEh8syG5tLxCw02uTczvFDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvCjlG3j6Hc0bbs+2LT2A0v1RkEJSFmvTJODGngbBMyk8jO3X3CwyHLBwMnGQsWZa+4E2lkvIHnr+hhKYz+DHPJp9CNTIdR7E4CMDL/phVdNirXZlCmrYknRVDWcPpWq5iF3grF80TIatuCIOcyVrnjSf4wgukOMmxhOkOBq2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDk8DLNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9E4C4CEDD;
	Tue, 11 Feb 2025 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739263503;
	bh=YwLcB7linsP/tcU08MgVkEh8syG5tLxCw02uTczvFDM=;
	h=From:To:Cc:Subject:Date:From;
	b=KDk8DLNrm65WgtNWYoftNsKWoHNdXIZOMHTk8XbJGnb/LNX9z17CxANZh+PHfQFX0
	 8ABTkp0fGPq4n9vFKkGx77ULzdlkTs+N/tmJ1nhADOXASqFU7D7ymbqfFjV9jWnxG6
	 38dnbwFHyDpN6MK1dR7qIKU+Odo8wPMWJ4lwyQR8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.77
Date: Tue, 11 Feb 2025 09:44:57 +0100
Message-ID: <2025021111-senate-unburned-9456@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.77 kernel.

Only users of the um platform need to upgrade, this fixes a build error
in 6.6.76 with that platform.  All other users can ignore this release.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                |    2 
 fs/hostfs/hostfs_kern.c |  157 +++++++++++++-----------------------------------
 2 files changed, 44 insertions(+), 115 deletions(-)

Greg Kroah-Hartman (5):
      Revert "hostfs: fix the host directory parse when mounting."
      Revert "hostfs: Add const qualifier to host_root in hostfs_fill_super()"
      Revert "hostfs: fix string handling in __dentry_name()"
      Revert "hostfs: convert hostfs to use the new mount API"
      Linux 6.6.77


