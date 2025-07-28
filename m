Return-Path: <stable+bounces-164895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91D5B13757
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE74D1894C5E
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EAB1B4153;
	Mon, 28 Jul 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7WDrxy4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDA186284;
	Mon, 28 Jul 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694126; cv=none; b=h/MdtkTlz+cO0AeaHA/1HEu20Zhy468YxLF4cFg+qS3iFb2MvEXLQoKLeTQ9iJoDwkr3/hP28XoQ8YIzXhFzg0wMU8slMsaF+ApD/ZvSU8CqJVJPkWbKT6IjCiP9XAKBnT0k4iTaiCvGTZmphwzREPKdJ1oytCawsWK+72+BGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694126; c=relaxed/simple;
	bh=0+NQ1gPo3v4RHvbc1xnQW9ASSzDxej/xbJFkI6skPCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQpf5sJC874DSUmyvVZXcI/4EMnkItM71/yF5JUumYZCxLp/V28HuLHqvHy1fSS1COUoRW43bQ/aUpr032TGBbfv5KFgy4KqGjRxrI+FdGwua3qatg1GfBpNLJBoxF7v4EEF44THs1hY07YO8bfsrsJLSop88JZ2bGRTrfIn+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7WDrxy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2145C4CEE7;
	Mon, 28 Jul 2025 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753694125;
	bh=0+NQ1gPo3v4RHvbc1xnQW9ASSzDxej/xbJFkI6skPCU=;
	h=From:To:Cc:Subject:Date:From;
	b=P7WDrxy4G5/yiJWjqzC3/k/cisGs6niUuLGPAHoCAiLKsbpK2T6qRZgmz4MKXLLYX
	 H/TPONd1iFVvF9QkanNI70C+4O1B8NQhjf3LIv5G7dkLEvjOZKRCf6lothvz13UAh+
	 Y5cRpkWeGNV32mFC5gJSqtFwoQhwIn7b4qFR117fd1LhThxltFGyIrWph0CScAsCh5
	 g10auSBb4hec23Fwg+CnuIKNh9ssgl/GVWufAhJsoZlxyFH8+YgGcy3AptqEr7XB/O
	 lhugqWDN8N7mqJHA8RjZMvsCt0cI+siylDKq4y5KsRHnJegju+2L4hgnFb/mrgcmxP
	 Lt44K7VJjvOnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/3] mptcp: fix recent failed backports (20250721)
Date: Mon, 28 Jul 2025 11:14:48 +0200
Message-ID: <20250728091448.3494479-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=matttbe@kernel.org; h=from:subject; bh=0+NQ1gPo3v4RHvbc1xnQW9ASSzDxej/xbJFkI6skPCU=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLa7TuP9c2vPPFwk3K+0dt7F9bztfTtfMrr1vEjZIf5D Xn5YP85HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5KMjIcNTIbmv5ZX6zxSZV s+Leqc3i0Xa5scF0RsO1QJPaBTJWrxn+qczac49ls8ybGGljvyurzno3KnKunX0rxXen40Pv6PB cBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 3 patches that could not be applied without
conflicts in v6.6:

 - f8a1d9b18c5e ("mptcp: make fallback action and fallback decision atomic")
 - def5b7b2643e ("mptcp: plug races between subflow fail and subflow creation")
 - da9b2fc7b73d ("mptcp: reset fallback status gracefully at disconnect() time")

Conflicts, if any, have been resolved, and documented in each patch.

Paolo Abeni (3):
  mptcp: make fallback action and fallback decision atomic
  mptcp: plug races between subflow fail and subflow creation
  mptcp: reset fallback status gracefully at disconnect() time

 net/mptcp/options.c  |  3 ++-
 net/mptcp/pm.c       |  8 +++++-
 net/mptcp/protocol.c | 58 +++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h | 27 ++++++++++++++++-----
 net/mptcp/subflow.c  | 30 ++++++++++++++---------
 5 files changed, 98 insertions(+), 28 deletions(-)

-- 
2.50.0


