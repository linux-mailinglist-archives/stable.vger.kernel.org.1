Return-Path: <stable+bounces-161857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2C2B0438A
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD76E1890255
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80BD25EF87;
	Mon, 14 Jul 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYfK1f+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638932522B6;
	Mon, 14 Jul 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506284; cv=none; b=vDLcQgTQPFHAvNemCtaX8f8jjasmBq68VeKkbD3pKWj1gZV8USs0UuETz6o+fDSErWtUsF58PhiftLdbEcxHF2rChN4mdFayQ4BZdfMOMpByecdmYhmIP9fHQa5RIWUFRoXWFdbq9STbR9+krufEzH1pODAM/mBMiaH5TTIiAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506284; c=relaxed/simple;
	bh=2szDlSc1R8x4gfVjXCW1cKyWzdm2cFraWj8u+IrSksw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3mGDset1W3RIU9PpLIxJ0udPzW70l+DUvsL7XtY6baMCyt5nU32lAc2JOr601UqXtdG5jedqrzQJPd6JbaKyaCXwn7yUZFzPkUg9R8t/XxWr7TYvS/l65Qwu7AVOBWmLvy1dQBke4r/lZy7rV3LYs6iIPiXIe03umx3h+NX5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYfK1f+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8740FC4CEF0;
	Mon, 14 Jul 2025 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506283;
	bh=2szDlSc1R8x4gfVjXCW1cKyWzdm2cFraWj8u+IrSksw=;
	h=From:To:Cc:Subject:Date:From;
	b=QYfK1f+7YBrFpAozRp57Wwtk8tC7HKdNDRErC2h7EICTRTrRajNeG//Fx6vygBypo
	 KjStNScY5fzt7cD/0Zf2nu9hyOdyomSq9ZT/mv0AE+LVRSHVT8XC28oNixRIyNpdOQ
	 Z7tfd4SSkUBtolSGkvf/KAJuVctgMVSRNbulgj+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.98
Date: Mon, 14 Jul 2025 17:17:58 +0200
Message-ID: <2025071445-sphinx-cleat-851e@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.98 kernel.

Only users of AMD x86-based processors need to upgrade, all others may
skip this release.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                  |    2 +-
 arch/x86/kernel/cpu/amd.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Properly check the TSA microcode

Greg Kroah-Hartman (1):
      Linux 6.6.98


