Return-Path: <stable+bounces-139645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B18AA8EF3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37D83A95FD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504361E5B7D;
	Mon,  5 May 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sLt5y9gq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F3433A8;
	Mon,  5 May 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436094; cv=none; b=qibSPcQ8LJZXCTv6GkSB58hsdbTO03D6EncC341XQG8UOQVfyzHr/OsWdnhEfpfk67XLlWnaFHYYZn4tRg0au+cj6ZOxu35yosq/RJoxOS2gHY6+FhZE0r7zscfwc9W2wKbvYgcii5wMtzHEbk2EQ8TiMguz3qjpplAQqKkzkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436094; c=relaxed/simple;
	bh=hZ3Tey/nCg7Ar7Z2kkdEqd3sXQld12eYknMg4AR3kOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oiPivb9mFcRZbkwPcsey+KZkNZAv+mdJ9YNW48qZGSWtlasx64VhCK2EYg1YAsise8OOATLndxtiA/hw5MOgifoMGnLPaBPxzCRkCMJj3ClexlTMWT39CLlzNNyZXGw+WLLzv+x3yJx0h8GXdWd0lxaISCHCx/6fXYSkut90LlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sLt5y9gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBECC4CEE9;
	Mon,  5 May 2025 09:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746436093;
	bh=hZ3Tey/nCg7Ar7Z2kkdEqd3sXQld12eYknMg4AR3kOc=;
	h=From:To:Cc:Subject:Date:From;
	b=sLt5y9gqmigz/91nbb2xwKb3+G8QSctzntCECHdzCcAIGI+NiZHokW35YWOlVp1JT
	 KPfxSGHVEpOs3k9NuENqU+9stn6ckhusDD7UxWFgxEV934lulsRXURm1V9i2T+LVQw
	 tawRink4fUvVKRwRzuwtZEmg6eevmII3zbDNTUCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.27
Date: Mon,  5 May 2025 11:08:08 +0200
Message-ID: <2025050518-humorous-tricycle-f8d9@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.27 kernel.

This fixes a build problem in the 6.12.26 release.  If you do not have a
build issue with 6.12.26, there is no need to update.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 kernel/bpf/preload/bpf_preload_kern.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.27

Xi Ruoyao (1):
      bpf: Fix BPF_INTERNAL namespace import


