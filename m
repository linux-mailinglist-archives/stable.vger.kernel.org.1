Return-Path: <stable+bounces-161853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08931B04375
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922364E17FB
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3EB263F3C;
	Mon, 14 Jul 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jgb4/1SG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1362620C6;
	Mon, 14 Jul 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506238; cv=none; b=qfP+jNnGI0up94tB3GsASEb/L5/m/T27COmdBTiy/QrfnXskejeFb76qldXR+5y5e4qliIQUoUUdBptFTWAka0SOaCn7CQK5Hvwkm3VtKU19Viyr2kTGcYQ1HSlu2Qxzewkh1Vv7PUSZ6JWAxy2iMCi6SfIyM/hnOd2XIp8apqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506238; c=relaxed/simple;
	bh=S8q8C99655ddkYtz/yyQh0Fd1nbtne8tn0MV8oemuhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WC4/YiQd7a2wVT/NwDj3bcRgUjeQk8ugDZWl+MIFTHSoc4KZ6FC7sg/jMHiizsVmgX2bD0CNDLi/QtULYOKVF8iZ8Nt6+T6nBVoGifiDcVLFQp0wyMoQQoWdSRi0Zfdk5s9KAcVVb2DZIqdQUzJqr6Z1c3T/c50xOUOJaZY/uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jgb4/1SG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5FFC4CEFC;
	Mon, 14 Jul 2025 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506237;
	bh=S8q8C99655ddkYtz/yyQh0Fd1nbtne8tn0MV8oemuhU=;
	h=From:To:Cc:Subject:Date:From;
	b=jgb4/1SGOhCU+U+hUgGbiwzUYh9/F1lYotBRiiwaNB5qXXjEU/ki9oNVw9tm7cyNp
	 5I9pLxvCH29x9cMUMIaMEMLk9iOAYS0OvS4kQv0Mh1D5YfIUOUWoxLN3tFePQKpcJr
	 M2wOEz62iQXZdT3tZSvo5PxbT52pzratt3Vyl00A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.188
Date: Mon, 14 Jul 2025 17:17:13 +0200
Message-ID: <2025071438-wrinkle-luridness-84ab@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.188 kernel.

Only users of AMD x86-based processors need to upgrade, all others may
skip this release.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
      Linux 5.15.188


