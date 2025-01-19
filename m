Return-Path: <stable+bounces-109479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7FEA160DF
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 09:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A571D164F7C
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73719EEBF;
	Sun, 19 Jan 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VyVjg4wJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1319E833;
	Sun, 19 Jan 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737273866; cv=none; b=JbzaFGH1ccRzoYxLdwI5nVqzTTkOrGme2GHq1PSp9TXDZwnXq/MoSiyFRq1UGkFp3/PmsG+UdxB+DcFURee+FnmDRAOqGb33q6yNiHMNVaEqoHm+t5od9qC4FR4SUTcatEOGRHoju4A78axMY6c7KEoPsuZockinHiDmBz33nec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737273866; c=relaxed/simple;
	bh=nQzJk4H234ldtimwoLjytcPjXkOJsWG9b02UifjrzpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ycaql6iL920XdoEjTLJOKGAdiDFibkIu8QrsQYqmfbATWShfDvvntTmCt7oRICg51CtZ1nNhvLmsLbBUgHTfdWRYi3U5ZYgHo4eQ+LIWU8VpaqOgTy1a2X7dFzqNBQ/QFhvT8b6fWNA4ENADX3Hu1SHQwLnwcgRTLenhYW+ByCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VyVjg4wJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66430C4CEE4;
	Sun, 19 Jan 2025 08:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737273865;
	bh=nQzJk4H234ldtimwoLjytcPjXkOJsWG9b02UifjrzpA=;
	h=From:To:Cc:Subject:Date:From;
	b=VyVjg4wJsDhbEEGlXa5arDxQE7H/BQNzQeOiKFH74u9Y/CDaaOAva1TmYtg1I3wHk
	 pusItBMeYJzNYX+aYxBdHM5S3YOpIoAR2ykp9jQi8Tc9mshCKGp1sYGUfbmM4Xs3kQ
	 c5Lmv5k+wG+E6NovyTk2qfp9WKvfBBwCt4Iv94R0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Ron Economos <re@w6rz.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.126
Date: Sun, 19 Jan 2025 09:04:16 +0100
Message-ID: <2025011941-sludge-pushup-e772@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.126 kernel.

Only upgrade if 6.1.125 did not build properly for you.  If it did build
properly, no need to upgrade.  Thanks to Ron Economos for the fix for
this issue.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                    |    2 +-
 drivers/usb/host/xhci-pci.c |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 6.1.126

Ron Economos (1):
      Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals


