Return-Path: <stable+bounces-161859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813EB04391
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E04316B5D5
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41373261591;
	Mon, 14 Jul 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nxkhfcrc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377E261584;
	Mon, 14 Jul 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506305; cv=none; b=oEwqUH0PRlEs5mPfkiZPToG89wwQYKEpOwrZdW6XwFue0Dzj0jKtAmW72CWe9wtnutvaVLuda9JYCkqfFhcwZ9xOtL6fRXOhIpsjRQAjrXo5qNmksicvpIKUa6dIYCx44iVOr8QHlvW0lXbGSb+S/zlJIFaedLRJgP1Gok2YfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506305; c=relaxed/simple;
	bh=pq+NLLmLhIE4dHxrgUkQASyW21vs9n6uPDMFCPR+yNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lm7w47rukTA7Y/NeHNGbLe45h0WA1W6wYIud1fp6Iok2ZtGCUQURN2gCQYQYroJItwLvcG+rLo+TzTkk/hZkmmjDrKhdIoqRnkKFiLo6Y3ngQK5rq4vaxjx6hDb9H06j5bDmVJ5tKA4fIsSrkuziVMGuT4n0JdANcPTv5Z5UCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nxkhfcrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3FDC4CEED;
	Mon, 14 Jul 2025 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506304;
	bh=pq+NLLmLhIE4dHxrgUkQASyW21vs9n6uPDMFCPR+yNw=;
	h=From:To:Cc:Subject:Date:From;
	b=Nxkhfcrc7BQc5znMS2r7yp7f8GeNbsk1DbyVTQN3uT65UsGab+ItMzU0v0skAxHuI
	 JjXF21RsiGmvjp3iD7bb/HR+Ut3U97Co3kvLHRuM5FWz0YaRpdojof71BZmtcVLyY2
	 QkdNZ87W8KOT6CZr0bELAvPnji5I0AVzVjGjrmjk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.38
Date: Mon, 14 Jul 2025 17:18:19 +0200
Message-ID: <2025071408-skimmed-demise-ab18@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.38 kernel.

Only users of AMD x86-based processors need to upgrade, all others may
skip this release.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
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
      Linux 6.12.38


