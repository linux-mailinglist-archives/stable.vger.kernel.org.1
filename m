Return-Path: <stable+bounces-66729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93294F12F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BB81F22186
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD017E8E5;
	Mon, 12 Aug 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/mUz6oD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807B183CA5;
	Mon, 12 Aug 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474958; cv=none; b=SHgZIIWCpOiohe6C+JhPt4I5pt5YtQC3rE3Vt26NunbfQcuDD+tAIGZH8YS/DEoogKX4ozewEhL6kXdd6+XDGPBCg0zPkeNTEpWqM7TA//qay4rpFqch5X7XAPAbkhWzMFKDEVLGHHIKmIHnTV6orJV1rRP4krTKfA9zr/Q69WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474958; c=relaxed/simple;
	bh=FEw403kKLcXlCijFEs5f5Y9/0D/vtM11tHHmkCfoy1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYmGoga1GIKgZZgQkhJR2Stz/o9T7Z9+Q4GAuvMEPwJ41jw+zLTzy4hFZVv6zwaIYlUoPgh1Zp3WOdt0YLQGmVd2PFmMn1omYA7EPaJOteXSEwFn/Gah06Q3jNGIW9k3SCfFoToXRIhTEkiF3+HOkYVWCnoh/tTd9Q8f28gre9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/mUz6oD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802CDC4AF0D;
	Mon, 12 Aug 2024 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723474957;
	bh=FEw403kKLcXlCijFEs5f5Y9/0D/vtM11tHHmkCfoy1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/mUz6oDiEp8EFNzpVm5K2ibyVvUS6E7t2r82xQiCzdNnaRwPy2Z+avMgn8BhtYof
	 Jw6DuCHzMrZyIyJMIs6KlHumjtobNBcRZa1RSi/HO3+frZo7VahKMr5bPWuNO+tPGh
	 VLVajG9938d0IKMrvgWMO1bbxkB3KAkg80uUuCoVMy+DEuY5m1HZ1JCgLsHGmUVbwz
	 Css+1j+Cq7QuAMOthJCmBI3UwRNY26COJU+oCr3eigi68QTeF0s1NMl1LnTJ+Y0Oov
	 gnqlGD0JM2whABjPyEYRhUR44Nkxy+NmZ5pwRLKmZLLvfskMgaK3fDO5T4LtWj7QS6
	 XLQc7017D4a0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.10.y 0/5] Backport of "mptcp: pm: don't try to create sf if alloc failed" and more
Date: Mon, 12 Aug 2024 17:02:14 +0200
Message-ID: <20240812150213.489098-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-smock-nearest-c09a@gregkh>
References: <2024081244-smock-nearest-c09a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=matttbe@kernel.org; h=from:subject; bh=FEw403kKLcXlCijFEs5f5Y9/0D/vtM11tHHmkCfoy1o=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiP14nthapHV7DxdVNsoE+9Mwk2TaUWe1rVkY psNugcmZuKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroj9QAKCRD2t4JPQmmg c+2RD/0VsFyvoMGetMaHBTmDnu5yDgL2GkHrS1OocGuHKCMFluK1k1DoRo53svt9ZOMWIEF5k7f zC9vjDwZ5wSVa7dz6TEYnyiojuQ7hCzAU94g2H2cTkkMsRx61f35rAAVyrm16NZAhGVfNczsmyF rt419iZtIDo9u+feL6p7HnlwxLtsruyIpjO/AHgZTHLDnFP7juXY7Vyjc6M3LtLWYMD6UCdVedE Esou8WnJ+LGCPNTajmo54CaekzaRN/mzIGOyAAE5HPvsBnCNL8sVyQDaSkFKcIuvPqLN/V12vj8 TDAl8FX3d2N83URKBrboh7Ec+PQMGymjADpQFCbF8b6Ujay7MbEvYQM2y4fJYzteVqSTOKlnXlU cG/yJRlxdSZiLtUtIyVnjD4boic7aEEWCSHQ3Gn6ywqG8DWkbicLCwdAbAWh5bPI7tSK8OOVWSE 9S/0IqqmRhRr7nufWMUokjcdxPlPb6QhUk7qa3ICNE5Mdej/EXc3JYINqRNtcJuDdgJuQ90/CbN rNMElG4KPFK1hvm8DJBQ4xainlj0HA+R5KwmIoqsAO3jXwQ+mNt9dy4SOT3hA6j1VjQLMNbaP5n 7HvdXBwcSkgKcDt/TtUhj8Cg3+ycShGSOBIm4cELFkPikXm8HXDL4Zf0wLpZKfemj9YTqHI9T/2 Apt90yvhernhWyA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Patches "mptcp: pm: don't try to create sf if alloc failed" and "mptcp:
pm: do not ignore 'subflow' if 'signal' flag is also set" depend on
"mptcp: pm: reduce indentation blocks", a simple refactoring that can be
picked to ease the backports. Including this patch avoids conflicts with
the two other patches.

While at it, also picked the modifications of the selftests to validate
the other modifications.

If you prefer, feel free to backport these 5 commits to v6.10:

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


