Return-Path: <stable+bounces-66750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5794F1C1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2081C21FD5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE918951F;
	Mon, 12 Aug 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UybtaNXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89350185E7B;
	Mon, 12 Aug 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476657; cv=none; b=lV3CacEwZz+nNU3+iZFFtd16e9719P1hkzaAMA4OQ3KUCBMLrJEP93ODEZd1cM5Uiz0SL4MhjwJrqhnaaTKN3HqONUEOnvGNjUzC30jThpNmVEUcbL8Pmo0LaTXgNInHWYiSRMdbwBFs++DmIShLE3UUp3JuibowEffZPQC/kNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476657; c=relaxed/simple;
	bh=j1KKsEv7LB1KVKKulCI9+b+USbdWMSFLg6h1Jham6AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXZWkL5n+YEBpWYQcDWDyBry6+U0yYGTVckkEd2h9yCUg26ecj5vZP5ci7onENdtMyJuLa6T1MHvlzqFutq7P5D+nIv0QxuXXa3rArCM08jnKJ4GC32AE9G0JIiUmRXHZW6Jj+ug2DjeKZFdJ89pznSmWjCX/y/+oI5d7Z7ZEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UybtaNXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D61CC32782;
	Mon, 12 Aug 2024 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476657;
	bh=j1KKsEv7LB1KVKKulCI9+b+USbdWMSFLg6h1Jham6AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UybtaNXpoDU/l+C4zt/6hvR7Jvxy4jDYdc7IZSQ67utjIXYy1865h5vA8RtvYYZr3
	 InkI+w5RkvtgTSyfDez9odoRgT4zQLAKCTbhQgVtnZ2U0YFNgn6zCqipP9BHaGrnDh
	 50u1Yj5pwcAfR4GNns3xycN1TGnTClOs0X/BFjlHXrORnDxvRH4ChPe7WIgYwkAwjD
	 ShmrgaZS7Dgm6cO2Ijyi9p9pfaqe5HgIrKu58YAR5Ugkd1cbDe5FDuLC48OxoomhEa
	 1NNsMYRCcOToDGtCqPfc6eVImslWNEXYEviAWZh+qID0+Qvs9fTdwCVDcKf13U6gUW
	 E9CAV2XgetLRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/5] Backport of "mptcp: pm: don't try to create sf if alloc failed" and more
Date: Mon, 12 Aug 2024 17:30:51 +0200
Message-ID: <20240812153050.573404-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-uncertain-snarl-e4f6@gregkh>
References: <2024081244-uncertain-snarl-e4f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=matttbe@kernel.org; h=from:subject; bh=j1KKsEv7LB1KVKKulCI9+b+USbdWMSFLg6h1Jham6AE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiqrrzvMfXRFBuRvr7myzcQKnqXVAibVSHOX/ Qt3RdnoR7iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroqqwAKCRD2t4JPQmmg c8nvEACRCZb/8u/6oGGNuyJKBMo1KMx57Edn17Ikq1VbbTkJNWToFQiX4j2vBfdGNr5YJ1MjgZz X2pyhAPnK6f//iOXXtP5eJcUqHAwRFt/xkxdevobIFQ+yYVYyEXBSbOv9B88zA94TfolsHnj+Sb dDC+T0vxCJ5A9zFU6t8/1BOoJ3CrJiXrYl4d9sgkIwwgz+q+KjtkPvPtlnPqAQ+9gVX5kIFPfMV ix96+QtCAq/c7YBacl+jd9eyRvG4zdt41A8prl12o4JLuYWoVgscZ0ogWG2UDPyDpy5sC5WYssa CYm/iF1AoCvLkUZmuTh75X24y7QtfYphcAipbGVV82FyrGnOA95QPwb5+NII6ninja4Jy7Ddi5j Rkx6YgkBFXPRQRkytpdGaeVlRo+VpLnEsggrmcegbXALxSkbV//9r3ysKlclzBDbXx051eLATIk C1kR+kH/FdYZeBeDSv0RBgUTGjnQpsYy7NZbtmhbCbLrvSLWBjj46tGkdID0DtMqwF0aEqH/y6p D+TbYpDTfQH6PXONWXLhkT0tri7wUpyr1HitMrUAU/4xDmQJmbqi1qv7Wyf0SEB32XdwG8ooj7g nJ3YVBK5FxxxFWsOJ7ZKdWQ9Ygs9FcE1+8RRBl/wnAJUypyHjIjlD3VwvZtN+EloPDBSqLzE9ct yTn0Mouq7WHY6eg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Patches "mptcp: pm: don't try to create sf if alloc failed" and "mptcp:
pm: do not ignore 'subflow' if 'signal' flag is also set" depend on
"mptcp: pm: reduce indentation blocks", a simple refactoring that can be
picked to ease the backports. Including this patch avoids conflicts with
the two other patches.

While at it, also picked the modifications of the selftests to validate
the other modifications.

If you prefer, feel free to backport these 5 commits to v6.6:

  c95eb32ced82 cd7c957f936f 85df533a787b bec1f3b119eb 4d2868b5d191

In this order, and thanks to c95eb32ced82, there are no conflicts.

Details:

- c95eb32ced82 ("mptcp: pm: reduce indentation blocks")
- cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
- 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
- bec1f3b119eb ("selftests: mptcp: join: ability to invert ADD_ADDR check")
- 4d2868b5d191 ("selftests: mptcp: join: test both signal & subflow")


Matthieu Baerts (NGI0) (5):
  mptcp: pm: reduce indentation blocks
  mptcp: pm: don't try to create sf if alloc failed
  mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
  selftests: mptcp: join: ability to invert ADD_ADDR check
  selftests: mptcp: join: test both signal & subflow

 net/mptcp/pm_netlink.c                        | 43 ++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++++++++++-----
 2 files changed, 69 insertions(+), 29 deletions(-)

-- 
2.45.2


