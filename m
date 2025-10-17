Return-Path: <stable+bounces-186340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFFBE93D1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3811892B64
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153A32E126;
	Fri, 17 Oct 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiGg8dHX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC4257859;
	Fri, 17 Oct 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712021; cv=none; b=nbdelveXWy5jL9IrbTHAlkEclHHTcOWLWqQyx0nqwdFSpqiIkE9vzxAGhE75ncfWsievLkXobID335tZM533UGa76w2sF/PAXWMVfwNCdTUV+hPp/QY3XO8jqCbkXDDM6sHfHtnY1pG2QTog8uwCodqtPrkijERSAFePQJLjaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712021; c=relaxed/simple;
	bh=llHOMmbr8Mkpz1dy2JXYRv+KnMnM3J1NGe0mSe7nu3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9A6DmDgS9f8GwiJlpzdg2vg1CC+ftfrlzuHDk76tUt8TcaYl3z9Bq6vvjIQwx+Cu0CDhJX/rL+L46q8bGLRcmzVXSeCNTPf/cRRK7tyWeZHx51PibFP6tNyoaQtDoYepN+ainIVJyefomcr0ZMi4e3rXWJO0LRFb3eIk48MpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiGg8dHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1986BC4CEE7;
	Fri, 17 Oct 2025 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712021;
	bh=llHOMmbr8Mkpz1dy2JXYRv+KnMnM3J1NGe0mSe7nu3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiGg8dHXUreYtfm1Ys0T3Ho6SkidEBfr4ABja4sAr8ihatQp/4qsfu6B6z248AqQR
	 5Hdl3q3ZnkO2ldrV8wtyRIZ9PCRhiWOhEt3ajsG/WuqSuOPV6vDp5HEp/MsJXzJ7Hk
	 lGa4WQD0aOKLuZFD0Ttzu2WkFHwKD4ZQN6ycjA7iMonnogcYw1i7sLFb5AUekfhUJ2
	 NHaY9JaLGP3vovUwonceGbHPwzTTpUScT3YXKdKlJ8wX5ranhVP5z+Pkm9244G61aq
	 3emUZFoS9AhCvlz9o3PbyiTikC/CiUrULd8iKPkubo78pMjIK+mQY/qbKxYCcdAPdY
	 EV3ftl6dga5Tg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.15.y 0/2] mptcp: fix recent failed backports (20251016)
Date: Fri, 17 Oct 2025 16:39:50 +0200
Message-ID: <20251017143949.2844546-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101658-underwire-colonize-b998@gregkh>
References: <2025101658-underwire-colonize-b998@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=matttbe@kernel.org; h=from:subject; bh=llHOMmbr8Mkpz1dy2JXYRv+KnMnM3J1NGe0mSe7nu3U=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+hZq9PWxvKKJy50pr5tp88f31qett7y+X9n04t+Kp2 oXeuuYbHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABM5eJvhf8bDiEVBE77W9n5s bb6Zl3qn4tjNhzPzIu/XNn7mnezjfY7hfyyjyR2zFZx/1kRWhf+ouh1bUV3ZfE3z5rb1r9t3SGd u4AAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported the following patch could not be applied without
conflicts in this tree:

 - 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")

Note that the following patch got applied, but at the wrong place and
requiring additional modifications:

 - 008385efd05e ("selftests: mptcp: join: validate C-flag + def limit")

Conflicts have been resolved, and documented in each patch.

Matthieu Baerts (NGI0) (2):
  mptcp: pm: in-kernel: usable client side with C-flag
  selftests: mptcp: join: validate C-flag + def limit

 net/mptcp/pm.c                                |  7 ++-
 net/mptcp/pm_netlink.c                        | 49 ++++++++++++++++++-
 net/mptcp/protocol.h                          |  8 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++
 4 files changed, 71 insertions(+), 3 deletions(-)

-- 
2.51.0


