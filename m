Return-Path: <stable+bounces-58046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F5927625
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 14:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022131F22F34
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F391AE84E;
	Thu,  4 Jul 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v5xkoXT9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660921E494
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096733; cv=none; b=pDarNdZ4VYatx53KKgXp08e4heDXGzF+/5/zZZKBtv/h5+LaScD8SYM2divm+3VtvjWO2lnsozc+DcAKDXwORqs95eq/SIew1wuKrch7Ml7PgF2xm+UwaU5faXu58kt6WSVqYUksjVGUEReKPlY+GvYp8oA7Y+PoFyWjNPzqvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096733; c=relaxed/simple;
	bh=bqLxJ3KS7JelbDmZbufg+3QXF9H7AsCpHI8xNEyWlAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vB3R9NWTRXIi5hp2j5zObmo5g953Q6AHBSyJOwkIaSpkwDGEG6QCQV8L1oDspXEsMFuLUqY0a59CKk1lLafAuaNrKYXz9/+pdHLuZwQqwqVd9s426fasYICeKkP3YADYFD8qGEnh2vFxEK7DVg/XhUjNdGQma6K+HTqWV5S0BC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v5xkoXT9; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFGR31j82zGlt;
	Thu,  4 Jul 2024 14:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720096718;
	bh=oswOPQ88LI9ZZ4dLvGzzNSGgsrVZFJ4bTKOLf0jSje0=;
	h=From:To:Cc:Subject:Date:From;
	b=v5xkoXT9pt4oLWpOuURpdCIOvi1n0uymB7k3u96ouDEmBvC0lD8MqV90lJsEHNyxb
	 9LLj8NgKnPtojW0nAYAXI0k6VeBhNqPxWqzsReKLhg7KTFIRy0m7YhBk+U7Lzlswft
	 y8jT8CBMTr2/BYwxKDDCRKEfmdIRJHlyzwNZgOZo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WFGQy0YxQz14Q;
	Thu,  4 Jul 2024 14:38:33 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jon Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [GIT PULL] Kselftest fixes for v6.10
Date: Thu,  4 Jul 2024 14:38:16 +0200
Message-ID: <20240704123816.669022-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR fixes a few kselftests [1].  This has been in linux-next for a week and
rebased to add Mark Brown's Tested-by.  The race condition found while writing
this fix is not new and seems specific to UML's hostfs (I also tested against
ext4 and btrfs without being able to trigger this issue).

Feel free to take this PR if you see fit.

Regards,
 Mickaël

[1] https://lore.kernel.org/r/9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk

--
The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-2024-07-04

for you to fetch changes up to 130e42806773013e9cf32d211922c935ae2df86c:

  selftests/harness: Fix tests timeout and race condition (2024-06-28 16:06:03 +0200)

----------------------------------------------------------------
Fix Kselftests timeout and race condition

----------------------------------------------------------------
Mickaël Salaün (1):
      selftests/harness: Fix tests timeout and race condition

 tools/testing/selftests/kselftest_harness.h | 43 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 19 deletions(-)

