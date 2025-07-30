Return-Path: <stable+bounces-165495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0262B15E24
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC64E3BB507
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719702820C6;
	Wed, 30 Jul 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgKjAiG7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D573280327;
	Wed, 30 Jul 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871304; cv=none; b=rsPvcGG1milOFLm1DFSzl+9jfmebkYBZDTqEw53zLB/7lxZj78/n/By3/FMUCEv6GvZTdGR96G6MTUdhf3FhZyFBjaJBZC4vZ4tIEbCfxDCnsvjGD0o7CSSvuSi5gYR/lWam90aDo3H7yuBzYais74rheynBsDa6o5Fs49vbev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871304; c=relaxed/simple;
	bh=4eKEE2oxKbUIMvYdq08YttHSJ7A8EjT8Lsx2ym/M6vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdzrcB6CHRxcr8upyWmRMgnBGQI9MwcVCER9CpZ65wtQta7wXmmyWVtwZy7kokgCkxLOhrv+SXPHn0aCtkp0blMn4NM/1lFO5OagD2MyLwSl945JZSSnOzr1Xs/YrSslNZE8KCHG8LaBkCkaJhuVaKkvwY2sy1laTvtFgJqGbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgKjAiG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872DBC4CEE7;
	Wed, 30 Jul 2025 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753871303;
	bh=4eKEE2oxKbUIMvYdq08YttHSJ7A8EjT8Lsx2ym/M6vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgKjAiG72PZoFwf8rEaGtF5fQm5ZNisHDGDep8lmpt4uGKn58KzRK4J7hauI1zXh2
	 hqPHklpx/Gb1OssojVDsVUb+SHDYb09jBolSe0vt23uzKlYHF88KKqiQ67uyP+Nk+1
	 exGv9o/3v5dTmIFrQp/MbFnnY07/Ti73DFrXIsLSI7P1enVPAfHLwDKS7fDUZBKJc3
	 /mtctazUfNFXgJ+i74jrXCeknYvosCTHFmaApPMdI6SM8ZnhqvuSPodNtB3d4exThU
	 OBi+vUG+mJfSLWxXfRK9isfAfx9hL2NHHDviIzsNNF/24mNISyQD6J8c146PF27+fj
	 Or7mKR6ZI7Brw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.15.y 0/3] mptcp: fix recent failed backports (20250728)
Date: Wed, 30 Jul 2025 12:28:07 +0200
Message-ID: <20250730102806.1405622-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025072839-wildly-gala-e85f@gregkh>
References: <2025072839-wildly-gala-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=matttbe@kernel.org; h=from:subject; bh=4eKEE2oxKbUIMvYdq08YttHSJ7A8EjT8Lsx2ym/M6vo=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI6P29ft+tOguMLmcRUC6Y7rxsbkj6uyv2tcqQzvK4j9 JfflYSmjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm0szL8jz/dV70m+LyRwbPT Dk3HJZ5/O+FWu+jqc59iw+m//U7nvWf4H6K0XmH2J/O8xbuS6udpXmyQr2Jj7/6leVhvk6PX9yQ NJgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 2 patches that could not be applied without
conflicts in v5.15:

 - 37848a456fc3 ("selftests: mptcp: connect: also cover alt modes")
 - fdf0f60a2bb0 ("selftests: mptcp: connect: also cover checksum")

The first one has been resolved by Sasha in [1].

An additional backport was needed to fix issues when running the new
sendfile test:

 - df9e03aec3b1 ("selftests: mptcp: make sendfile selftest work")

Conflicts have been resolved, and documented in each patch.

Link: https://lore.kernel.org/20250729142019.2718195-1-sashal@kernel.org [1]

Florian Westphal (1):
  selftests: mptcp: make sendfile selftest work

Matthieu Baerts (NGI0) (2):
  selftests: mptcp: connect: also cover alt modes
  selftests: mptcp: connect: also cover checksum

 tools/testing/selftests/net/mptcp/Makefile    |  3 ++-
 .../selftests/net/mptcp/mptcp_connect.c       | 26 ++++++++++++-------
 .../net/mptcp/mptcp_connect_checksum.sh       |  5 ++++
 .../selftests/net/mptcp/mptcp_connect_mmap.sh |  5 ++++
 .../net/mptcp/mptcp_connect_sendfile.sh       |  5 ++++
 5 files changed, 34 insertions(+), 10 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh

-- 
2.50.0


