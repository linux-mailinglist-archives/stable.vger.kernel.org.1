Return-Path: <stable+bounces-161855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A96B04380
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD671886BF6
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C125DCE5;
	Mon, 14 Jul 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQ+nnXN+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6725C81F;
	Mon, 14 Jul 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506260; cv=none; b=MEkudEwADqV3QOIQW2OZQZWQYb7BCW5Mcni0IFRNNK/vGlNGl3M5DifnZVaVLXuD5rI0yas9LIjDoOLUEH1RX6Ce+UwcZTu7RT82srPUVT157hBCMB0CVuXyCOrxalHNDsW13aZk3FTA2I0bOc26Q1tCOHG7MaL9Ie1ZSxFk/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506260; c=relaxed/simple;
	bh=qdKUEEPInZh6NUl9KaS19r2mQAhUH9Vt5gsFhztIAtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TV8+oo4jQNXu2n4PZv7XZWGSw9fBKc8MkKpReZ0lVYwY7K7Jtoo0DGIfhBxYrTbGiLbbVaDPA0pIDX9P9HKkQDC7PP0Z1KQvd9uSZ9Ml+EfTh14yIuMzYUPmDlIUgogAPFDwLNvDJTah3BfbSjk2Kc+UB3bmfPTXOu3ALL1QETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQ+nnXN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FA4C4CEED;
	Mon, 14 Jul 2025 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506260;
	bh=qdKUEEPInZh6NUl9KaS19r2mQAhUH9Vt5gsFhztIAtY=;
	h=From:To:Cc:Subject:Date:From;
	b=cQ+nnXN+VQXvRDYZfY7FZiCMFBw1iVSOQaMzv46qkMnTAXWSgdXqJxhvEDcRm3QNd
	 c2JWjS2PZDPxZQw2wLAs5Z/wIYlN/TV2O80ywQBVWWbiVsrvzXUOxYh72Doci9P++/
	 9JfNldtC/YYXFfMd28NkkD2Eeu2o97jPnWuDA+Vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.145
Date: Mon, 14 Jul 2025 17:17:35 +0200
Message-ID: <2025071424-rigid-dawdler-3bfc@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.145 kernel.

Only users of AMD x86-based processors need to upgrade, all others may
skip this release.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                  |    2 +-
 arch/x86/kernel/cpu/amd.c |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Properly check the TSA microcode

Greg Kroah-Hartman (1):
      Linux 6.1.145


