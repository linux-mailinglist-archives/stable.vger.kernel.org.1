Return-Path: <stable+bounces-180711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAD8B8B942
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 00:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981A8B643DE
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 22:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D331F2E0920;
	Fri, 19 Sep 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuquJ0Av"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871262D7387;
	Fri, 19 Sep 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321515; cv=none; b=cbqi7gvdvB1WshY304Hb/hJbt7FLJHv0fIvLvbys5O+ZXQm1CjLkgh0yI+IdebfXQZ9jSUA8l3zbK1Wf7Qs/Em/p28tjfRGWLyoqAnjhryHt/MRNop0y4Pr7jnnsrbztj0XNGLkguTW33sVYrRczQbYWSqBQZE3UaPpyOcAQAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321515; c=relaxed/simple;
	bh=/ENTuGe/EHVkKW0s1LBXa8rSzksujKaMUBrslnPTyhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nczjdGPrflI96IKqovtPrPrpyuZ0d0CdptPZDFsUWl3dtKHVpd3nqdBEvCdwpWOUXUfoFyUsyifUBNCKgtcGCoGgb6Y91Eh/lUghCksPge9oJ7OXzc9uxyh/3+U+cBBOuKbCs9FZUZV95PBIYHfRnT2R7laV+BZqWgNKtLrKz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuquJ0Av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECD7C4CEF9;
	Fri, 19 Sep 2025 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758321515;
	bh=/ENTuGe/EHVkKW0s1LBXa8rSzksujKaMUBrslnPTyhk=;
	h=From:To:Cc:Subject:Date:From;
	b=iuquJ0AvlonDBC+RnQrctykhJQ/U4NpmIWSUztPgCU10pywWd1L13XhO3i3g4KO2J
	 xtV7TTe9LhVM/dSBtTSNqy7FOT7y+fw6vZGw2hABg5E3pk9TyoPM5nxgK5tUGHagKW
	 5Uwkll7MdZTO1g4JCllYpXFS2biUE983cMxCg7IwP+HP1QDaNIAygk0oC5jE1m34YD
	 f2r/iBb97Nv5yIL9edlA6UhrV8D8toHVA3IWuDSPhx7mP1uAssG+b3Xg2r76pjYOf1
	 cZbBYG4rWjo8Xko+SZOAEeGPJy9sYh4YUhclbhKEGc8n+NZa52HCF0/6lY/sJpCagD
	 FtG/ZwvrW54dA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/2] mptcp: fix recent failed backports (20250919)
Date: Sat, 20 Sep 2025 00:38:20 +0200
Message-ID: <20250919223819.3679521-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=matttbe@kernel.org; h=from:subject; bh=/ENTuGe/EHVkKW0s1LBXa8rSzksujKaMUBrslnPTyhk=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLO3o75+JK34tstvtSwaZsbEieJCznsuPRQ0ti/NKVxn pLc4UkzOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbiZcrwP7Y9rS/l6bb5jb/v bPLPZrrxeKbhg6DDRZ4XJ3McffDlXhgjw5aXvHGG26RvzxYM2Zt8LyI0p8D4/2fnNzvdIhPu7S3 axgAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

 - 2293c57484ae ("mptcp: pm: nl: announce deny-join-id0 flag")
 - 24733e193a0d ("selftests: mptcp: userspace pm: validate deny-join-id0 flag")

Conflicts have been resolved, and documented in each patch.

Matthieu Baerts (NGI0) (2):
  mptcp: pm: nl: announce deny-join-id0 flag
  selftests: mptcp: userspace pm: validate deny-join-id0 flag

 include/uapi/linux/mptcp.h                        |  6 ++++--
 net/mptcp/pm_netlink.c                            |  7 +++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 +++++++++++---
 4 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.51.0


