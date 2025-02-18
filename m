Return-Path: <stable+bounces-116681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A42A3962E
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F5163D32
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6A22AE59;
	Tue, 18 Feb 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qt4hxlY0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28BC2FA;
	Tue, 18 Feb 2025 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868669; cv=none; b=DSPBEaZKGW+unax9aCz63QUaju/dPS5dX0VhFrzYGs3vMarU9K2CnW2SM9AiW9sZonLvsroZcWBuGC/yHYT0LHN6VC47mpnqX55Oz8gCIkBlAtD/iFR6WrJj4uE5swUqtAf2Uj7yyV3pWF4dbj07CyqjDTruYyf2Ylvb41V2Cwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868669; c=relaxed/simple;
	bh=uG38YvT99i7xMHbcT1O4XLMKDJIqWxXPD59LZ2yMXc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSzAGVOqksR/asiAYH6cKOgV2QjGw7YGXRuONPq+ypvuD5J9gfWRg02ADZ97xCH5HVOW7F13ucPdSh89hrdIuCN4yfqQ3DAk7IJ3cHeiISYCOOQsSXHubh5CGMRG8ujSG/41u5pLSDhL8EcoWq4RvH09VEbrYmf+M6gZpKg+Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qt4hxlY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF92C4CEE2;
	Tue, 18 Feb 2025 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739868669;
	bh=uG38YvT99i7xMHbcT1O4XLMKDJIqWxXPD59LZ2yMXc4=;
	h=From:To:Cc:Subject:Date:From;
	b=Qt4hxlY06T2tANZsci4eBueVTIEbBHHch3JYkkRBWyMLlo5LNlxxwSwx9Ywg3zcRC
	 RDTU5M65ajFPMD6v1dG/sI7A5kHyi94gVVOdDL7ydS9Am6JzpA+gmI2Hivq0EYubUU
	 cPqzpq9UiwY5TFo/4vwLRTI5KAfkWI/+tDuN9BOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.15
Date: Tue, 18 Feb 2025 09:51:03 +0100
Message-ID: <2025021819-flagman-dimmer-96d8@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.15 kernel.

This is ONLY needed for users of the XFS filesystem.  If you do not use
XFS, no need to upgrade.  If you do use XFS, please upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 +-
 fs/xfs/xfs_quota.h       |    5 +++--
 fs/xfs/xfs_trans.c       |   10 +++-------
 fs/xfs/xfs_trans_dquot.c |   31 ++++++++++++++++++++++++++-----
 4 files changed, 33 insertions(+), 15 deletions(-)

Darrick J. Wong (1):
      xfs: don't lose solo dquot update transactions

Greg Kroah-Hartman (1):
      Linux 6.12.15


