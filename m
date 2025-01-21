Return-Path: <stable+bounces-109590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11BA17995
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680233A93B9
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CA1B87CF;
	Tue, 21 Jan 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ice8T2P1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B21B87F3;
	Tue, 21 Jan 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449634; cv=none; b=sxVrxqybtD24fYFLd7/KPCWYa/IrfcWzLEhWe0NVsKE/JOiOYDEogg20GNBhA4bVAiBK9/6Gx12azaIHATuOM9PS9HqOqFP5LdvmFHIDDfQdnSM68YvXwndAEnKFD81xqn7MOcLA7a1EYF17kYbEsM6neewFefl9n9QCs48/4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449634; c=relaxed/simple;
	bh=jWCVQwcsVLc6oE0iN9v0o/VPm03RdoGFmyhMEbi/daU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsrdEAtokW1hxmihKmjdiLqT6BB34Vi5k29lyn9EbUq8laC8nRwkDIVCYfpZ3O2RVz4aVAUV5sB9t3XLdwzwPztxuC1IOqWbrcfracbl+aQmt/VOHOh1nHNjYwd4kffXn/yNGNfG+Fm1b6V23isE59aoOxl/7XuYeJ99kULA7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ice8T2P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E03C4CEE3;
	Tue, 21 Jan 2025 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737449633;
	bh=jWCVQwcsVLc6oE0iN9v0o/VPm03RdoGFmyhMEbi/daU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ice8T2P1A4JkZitCpAFcBrNDn7laWS0yW9YPI/VCCmzQlvTXEbMuRAi8qhX0KPrPi
	 k8d4SomNKFi9lapR0ot+eqw0P6/XMTm+I33A4IuGaWuPfPpX2LO1HTyKCjtBXIp7m4
	 /xw/Y9IAq5xf+oBhA5LEccOnU+loACERWVeMbLeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	ignat@cloudflare.com,
	amir73il@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.73
Date: Tue, 21 Jan 2025 09:53:47 +0100
Message-ID: <2025012131-euphemism-jingle-8949@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.73 kernel.

Only users of overlayfs need to upgrade, this release reverts some
changes that were reported to be causing problems.  Thanks to Ignat and
Amir for the quick reporting on the issue.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                 |    2 -
 fs/overlayfs/copy_up.c   |   62 ++++++++++++++++++-----------------------------
 fs/overlayfs/export.c    |   49 ++++++++++++++++---------------------
 fs/overlayfs/namei.c     |   41 ++++++++-----------------------
 fs/overlayfs/overlayfs.h |   28 ++++++---------------
 fs/overlayfs/super.c     |   20 ++++-----------
 fs/overlayfs/util.c      |   10 -------
 7 files changed, 72 insertions(+), 140 deletions(-)

Greg Kroah-Hartman (4):
      Revert "ovl: support encoding fid from inode with no alias"
      Revert "ovl: pass realinode to ovl_encode_real_fh() instead of realdentry"
      Revert "ovl: do not encode lower fh with upper sb_writers held"
      Linux 6.6.73


