Return-Path: <stable+bounces-172407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316CB31ADC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E0AB643FA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913653043DC;
	Fri, 22 Aug 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZamAO73j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9EB2AE66;
	Fri, 22 Aug 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871850; cv=none; b=stsAArYHzyXyVbMpn6gX1uQMq+/Q0HArUOcq2oGmH2tMGyzNSnSlFhUlCma2e/0MPIAHFlmWyzMfkbVdk/V6MnwXLCPWQexMRJt4hfdvL4l2uEooQ0lw4sJNGzvqqCBUoShF40zID4lj4rCXhzL0/aoshRx1ZzlDscXDcKxCW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871850; c=relaxed/simple;
	bh=eb8JwK5s4DirRALdjkcA+TD9gyTRhC0+Er7gB3WMI9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lV/iJ5v2ZBgS1cOx6td/5n5336ModcAxmOFQihlMffNf6iahTeLl41XEgDWzvM4MVjV1i42a7lYtUTxquwn1SAM0kGtxQmmX6wVdV9OmIFX5rXuqYoSt2+97vkW6bjMCIiLHSw73wEGoL4RyGqBvbWgUiHSu9E+t6vilJNa4W9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZamAO73j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978A6C113D0;
	Fri, 22 Aug 2025 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871849;
	bh=eb8JwK5s4DirRALdjkcA+TD9gyTRhC0+Er7gB3WMI9o=;
	h=From:To:Cc:Subject:Date:From;
	b=ZamAO73jNaI5CWQ1/6lfrIff2Nl/qYrVaNXPP7UbRdkkhhPqMX8SxF8zHspTNBuYp
	 yUq9f2Jb9HC6t3kadf327K+PA21aP+TUyH0OjyyfqIB/pCC1T7SIBv/Cxkex+BlJt/
	 fzE7MDid1qud4ug0PHyC5dZLrQlwmQ0C/85M7Lgz+nYKDskNZgyUCfayEN9Mhypk2G
	 Ik+14ojAUxHYxUqLXxohzHiQPe7XKOkSrCzl4sJejR2YEWDlna3QE98X6u60e6TsWT
	 ALHKaxzTLrWDz2g50o0W+XAdmvSTUe+RalWOCluqRgaRup5PTQWiaOHvPIgSnQ5SoT
	 hc8aQBXvdhT5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.12.y 0/2] mptcp: fix recent failed backports (20250822)
Date: Fri, 22 Aug 2025 16:10:27 +0200
Message-ID: <20250822141026.47992-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=625; i=matttbe@kernel.org; h=from:subject; bh=eb8JwK5s4DirRALdjkcA+TD9gyTRhC0+Er7gB3WMI9o=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVAUr71UOCPkyf/YkayWluzaVR65Z/hVr5HCe7crRO eVWbd3cjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkYbWVk2J5pLd7QwbX52rSy eeZPGkSO7BMOebfm+NLmN49nCxZXNDD8Myy4WnPA0aXWeNf3tgfSK6c5Bv0rTLjG0/bGbLdWzKw 0VgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported the following patches could not be applied
without conflicts in this tree:

 - 5d13349472ac ("mptcp: remove duplicate sk_reset_timer call")
 - f5ce0714623c ("mptcp: disable add_addr retransmission when timeout is 0")

Conflicts have been resolved, and documented in each patch.

Geliang Tang (2):
  mptcp: remove duplicate sk_reset_timer call
  mptcp: disable add_addr retransmission when timeout is 0

 Documentation/networking/mptcp-sysctl.rst |  2 ++
 net/mptcp/pm_netlink.c                    | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.50.0


