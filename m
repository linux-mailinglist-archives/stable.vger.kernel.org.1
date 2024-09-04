Return-Path: <stable+bounces-73053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B0596BEF7
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68400B29676
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BF71DA30E;
	Wed,  4 Sep 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkMGZgsY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FC1DB53E;
	Wed,  4 Sep 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457093; cv=none; b=EWYrzkBYr1H4cUfDbTP15QLOO2u1Z/VhgSEpIJj3UghM8huvKfeG9TvRoJ3iLF/1M3mEWaZk3wNGNQLRdA4SKjKKWWhFpD0r1Hqvj/ncvIhF4KZNzyv+n8Z+lfXjTTPmnujkh0TefB4yQeNZCCLBSdTB0MUMbPrfBLS06yBhcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457093; c=relaxed/simple;
	bh=tb7YFc96A14upkwj8vCfBBAkfuHYUF1Yg5D1DPPQqQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aaSib6A0NKhYJHJum2HnwNUlBUnPpxMaRT6oXQqLSxnWa2l8mD5h4UozeBYTA5WAUlqR2Q/PVIyd5HaQ1AKFwjFtbxsTRvM0hRq+MmqgYz1C21QDV7P7LFbE7PcdW0PwwigX79W3jnFIMgIhuF1qfnqhTE2MD7U0jZe4czGynr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkMGZgsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ABEC4CEC2;
	Wed,  4 Sep 2024 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457093;
	bh=tb7YFc96A14upkwj8vCfBBAkfuHYUF1Yg5D1DPPQqQw=;
	h=From:To:Cc:Subject:Date:From;
	b=EkMGZgsY4dbvnmwtqQF7l+GD/xg6ocHUsNFRV2onv4TS/s+1W/MzmapBqI/HjxcRd
	 714x6eEV2/nZ7CS/M6+xbgThSve+iLYMvxL/+XexSY9Nzi/VZdH6m2cjMOkTbsKqv3
	 AEu/Bp6hiYEFQdK+EaxPgVcjSFPKOdDJf0QMTp86CroFMMvKyG13B97mbvIY+d1VXa
	 v3tL0MdY5kocoF5/ihAaDdzPX2kJUfC4NFsWOZyoUgbQxgi4cmXmJky0Uyv4MKEP5z
	 ouoBRgmMlN49yliFzIG1OTwQVHIlF7/lNoJYAFAQ9rkVi6jwCf95BSvrR1E5uZYAX8
	 XrMfgdwYtTreg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/2] Fixes for recent backports
Date: Wed,  4 Sep 2024 15:37:56 +0200
Message-ID: <20240904133755.67974-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=598; i=matttbe@kernel.org; h=from:subject; bh=tb7YFc96A14upkwj8vCfBBAkfuHYUF1Yg5D1DPPQqQw=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2GKzcwpXxW0mcjYaZccatXieH4/FawSHSPOxw +vj3c+YeLuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZthiswAKCRD2t4JPQmmg c59OD/9G+dj592x+CNFkQ+29pJyFUAkFGValkyhPiKGvgN5VNZUqflrgKXhYmL7Wg6Ya26TPIWq AIJT1zEw7HiD/CkPfJ1gEvPf+nYpg6+Xdmk9KVgiKWsCoYWE5w2cNjJ9J58CAA+Rtvi7yOsoAg1 qnu5CyQ/qtGbmS6ky82j3LJGZBLSu9/4uNS9Uds6jh+KVF0BVC4G20IAl4UKscjgi0298UTFqkC Ojs5DlAS6orHES5X4I0gv9FrxgMXbHamLEsiyee4hzzxXSjiyt4ohqZhHaydgrWxVJZwudDnRth XgnZumNr3wasWmNWWEqMZo53kke4qH6pQhRRDuAHC4p/HcgopPu3XJI8uA9S9BevPTd8SqxB7/h dINN1s743H8urR1ZZCXxxTTrFUHPsJsE0OxL2qn102MJ5+vC9azPUszZ1+OOqNHDmTqrBKnwdL7 6/ENyTv4IGcMS9xP9ixRh7F4NlFv7ZoslC4uUY3k2caYtXpnHpqTFFes4GVt3Gl+Mu2+x63pD6l WWtQ02PJrQaUo7EBoC8qotLba8042a1QgxCVP+VZXoXmIsBH9y3WHHzv+6s6aRJcpbZrC+mjfVr MYnYhwJeiit0izyawxxViXdNaF1WWsipJGbpuxiStyLi1A0mYLXMs7XyH2Hg0EXjGJqIIWnIMHa 5GHyBZNFlLHly8g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

A few commits have been recently queued to v6.6 and needs to be adapted
for this kernel version:

  - 38f027fca1b7 ("selftests: mptcp: dump userspace addrs list")
  - 4cc5cc7ca052 ("selftests: mptcp: userspace pm get addr tests")
  - b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")

Matthieu Baerts (NGI0) (2):
  selftests: mptcp: join: disable get and dump addr checks
  selftests: mptcp: join: stop transfer when check is done (part 2.2)

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.45.2


