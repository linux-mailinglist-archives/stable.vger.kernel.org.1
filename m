Return-Path: <stable+bounces-93821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530D9D180A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8F6B232C3
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47081E0DF0;
	Mon, 18 Nov 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7Ngp+VU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35C2E3EB;
	Mon, 18 Nov 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954461; cv=none; b=VO7UhrObpKP+ngh3XIiQEl0swbd6/9uPvKyNLdGCLPuYwPZCk44BE3kJSsiHG7Wv2eH7mW7MnfkBZ5HZiID1cKLyPWJGvF6xqzgUQLMmGtVeGLCqXzarn9IB8NLOUH5Ka2jKo+E+J0vF0PyLeKifonHTgTHanQO4OXwIvk9pHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954461; c=relaxed/simple;
	bh=NLdKw/UATgY4PqOfpBzRkVWIWTouEGLzd5iy/KkeXW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kh2ZlZV/HTxgh5k5RSX586m0KOSrsmOXj3nW2/YD/Df7M01v4I3/dZhjIfono3qS6ixrWGFh0PQ2XBk0UvzJd5rOUb3R96Gpk4AaFYHpYQorn5FRj/46z0AL9C1FnMW18dt/rioRfeX6Oz4H6xN5ygwN5tGoif9/7IcE9SDRF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7Ngp+VU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A22C4CECC;
	Mon, 18 Nov 2024 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954461;
	bh=NLdKw/UATgY4PqOfpBzRkVWIWTouEGLzd5iy/KkeXW8=;
	h=From:To:Cc:Subject:Date:From;
	b=J7Ngp+VUS32b4tPJv7i6zLMSUuRFGeMe+we4rkV7lMr//2w/tbrOZ2402xTQZ/VWm
	 Rw67989FyR6MDB4NB/VPejESWPKqXIXh3m/jhSRZmVfZYnrd06aIY+99UWua56Oouu
	 r5pI52kOGBB1hmitcRkAzvk43JHQhu92/Pn3ecHhGDNML8CeCGiMiheZVDaRN93/pq
	 NAlWyqrUW9+lZSoc7Qqfg79xe0TRFTi3V5rR6L2v/7N3iRg7f55bQ0+nDfYlqhsW1G
	 MIIlzgY6YySxQaorutVqZr3+EleD2CnkMtt7TogyJvtzDlxkNu0iVtL0yIzjAvr2ID
	 zSBWGPqpXdPWw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/6] mptcp: fix recent failed backports
Date: Mon, 18 Nov 2024 19:27:18 +0100
Message-ID: <20241118182718.3011097-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=matttbe@kernel.org; h=from:subject; bh=NLdKw/UATgY4PqOfpBzRkVWIWTouEGLzd5iy/KkeXW8=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnO4cGa9U1ksfWHBO80GsDAcf1QYthw2LR9SWyQ 5AWDdMuBNuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzuHBgAKCRD2t4JPQmmg c7j6EADJaqejSNp/FsLbQsLMmS/u0dIJ2cN7PKOmuWySE7LZHPRCY5CsqEQmw066eMtaNPDhlgo Qx2lakT9qymCmZgY23/Zb0vkmePTMQuasPbrPJeYir7z3qTTTPZdfsZYmXrFb7Bjm9VPr3rGDuP GJ8PA49PDu/eu7ri9QmNL2ghUnpueDUnQo5rZ1q1aOy16dhRHGoVNQzwaqZAecSSwgR1KOdZa2L Jq25t7cNJ5xJa5PJyGbj//h/WHWtPzOH+UIZlepbFFzFYypxiHGT/tHUMhIDxGIFy86mzyUm6om wByzu0BJnIwjrnhWBlXG8ix6Fu6RXfM3EpEwkGOAHJztOXrVVF6UkWcrhLX6XI54vUgCN0raRvV FUHNfYFE3T5iTFrKiK74yM/rBtMXkWvOley5fqVDZEDkoGYMEbOc+BWpxxbgrg7Edp90Ik30MFY t3t4HDR/0xjFXXza93guMtG6/iRifOlHgvqXb8bI7bPA/maYZuiZq3Sw+amnUQOYUYdNiZMkYhD q+x8yKloE2FlOeMN60+0TK89R6HGtYnuY6MVbuhkHwY8eK2czLJO6kHYXaKS8QpzViDK6uJNOHo wr7ToepsS/bRRwjgsUkQqDr/lvxZYrXp36txxijLn8Yd5ZA4XxE5brENc0P/CjiEpNJPt/iDZkp AN5W5EU3JTyDIIw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 3 patches that could not be applied without
conflict in v6.6:

 - e0266319413d ("mptcp: update local address flags when setting it")
 - f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
 - db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")

Conflicts, if any, have been resolved, and documented in each patch.

Note that there are 3 extra patches added to avoid some conflicts:

 - 14cb0e0bf39b ("mptcp: define more local variables sk")
 - 06afe09091ee ("mptcp: add userspace_pm_lookup_addr_by_id helper")
 - af250c27ea1c ("mptcp: drop lookup_by_id in lookup_addr")

The Stable-dep-of tags have been added to these patches.

Geliang Tang (5):
  mptcp: define more local variables sk
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: update local address flags when setting it
  mptcp: hold pm lock when deleting entry
  mptcp: drop lookup_by_id in lookup_addr

Matthieu Baerts (NGI0) (1):
  mptcp: pm: use _rcu variant under rcu_read_lock

 net/mptcp/pm_netlink.c   | 15 ++++----
 net/mptcp/pm_userspace.c | 77 ++++++++++++++++++++++++++--------------
 2 files changed, 58 insertions(+), 34 deletions(-)

-- 
2.45.2


