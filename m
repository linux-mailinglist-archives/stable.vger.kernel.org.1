Return-Path: <stable+bounces-25932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B887040C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 15:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAF5283344
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5CA4087C;
	Mon,  4 Mar 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrOZv12F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071473FB14;
	Mon,  4 Mar 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562320; cv=none; b=GqHBbsHBTq70F6MErhhmDM9Hv13VGVURaO215toTTaJqDpAnA4PsJ9LQMSL1wr2qWQ05+uPL+s4OCHvYlQMAKdC4YeDSZ5VP1OLOFZNLfJn/HwXdH6pINwcmEa30jh3RxY8OX4JKuU+pXjeB4Wqy/ibGps4oDkMQ1wVHz0R7KoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562320; c=relaxed/simple;
	bh=VRS+n6ybLa9IWmtYpfnpQ35yJadFpwSuUqSk8qXjlG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0VR6SHdcgr+SlCptu1FLu8tMdAHZ/e/8Pifyg5i1ya3NxxXjVjbG6vCHNbaM7QvXJ41ema6yFdXUDhr02DDyT60XJwkA8JK6KdPYuo8a0M16s4fNj93etYisObkE2lriAdItiaYctyRygLNfZyHHXAG707aEyfLWTCo1eLp38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrOZv12F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9BEC433F1;
	Mon,  4 Mar 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709562319;
	bh=VRS+n6ybLa9IWmtYpfnpQ35yJadFpwSuUqSk8qXjlG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrOZv12FGdvZLa1kyUWHrsIe2aCJ0y95L+R5FvZNUQnsdF3r8W7nOxD0yZpya97ek
	 m3/DuJC+mhdYhCx2BkiMzihSDar3KQ9D1gqz+YNn7Z3Q+ZuRRxQDvjJGpxx5InldDt
	 gTMTud+igphLPYca8j89jMGF2/lV21Ru21jakeiqCJT1D5tomH8fgxyx9vq1nS2yrM
	 p6npyBcyzkdhge6FKB9b6ucsL6/xuPw7rCbE3IfNcziRozFDwcgj3xyiY8YwWLzOc0
	 bFXSOSRPwTJBk7M9uQEwh+9iXxYTgJehd4+OsPRmvYF/qt7iBpgiDvQan7FbrpbGR+
	 eM4aTi3o40Byw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/5] mptcp: dependences for "selftests: mptcp: rm subflow with v4/v4mapped addr"
Date: Mon,  4 Mar 2024 15:25:09 +0100
Message-ID: <20240304142508.2086803-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030421-badly-bucket-6555@gregkh>
References: <2024030421-badly-bucket-6555@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=matttbe@kernel.org; h=from:subject; bh=VRS+n6ybLa9IWmtYpfnpQ35yJadFpwSuUqSk8qXjlG0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5dnEASrdRf3uydwstj1MGa2r19TpipOlZlc9E S+s3g4Vjs+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeXZxAAKCRD2t4JPQmmg c8INEADgvU3ulhsUA26DqkSERsF38WQw/HPt8iLX5gROkdKPEICRS47O9vLQ61L9Dl3o8C4c58J tHcmxlJx1V/bQU4sFgOIZMQHgcYFR2QgUdkC1q+HqGFp9IIcuwz2x/bX7+S5VpzaZpLZGZg7qVA jbnDx0Jej4kAA8VUwvqseRGZIsgVuhtaqL8BLK8djsMJf6XE/v3OQY2HZacQudIczoE1TWLSRRt 4ClxjaQ2LnjoJUw8XyF2hU9/Kn53xQtN8m9SqnuLXSuDTw3SEb40ON1y8sZW990ds3c+C8/kAW6 ZX5GPpOJIZI8+QcYK1zEAaaQODmnhLGJa2kU3d0viMKg2Zhicbs+L36maEdwFrbqh4bNKBggCMk 5FdU3sfCu1z+MQBurQ39UFJlnyPUTUjvOXNemuF24hqOgcv8HSjFX2YXtscg1PTqUmJFj1xw/bo 3gKnTX6frHxUvwat+U5CBibrtNhgTCU+oqE1LOD9iFTYoOp4m1qJa+U44XS16OH7OGNM1+i7YGM 4XN7tIuTGWRxYPBNNfWAt70RxlquYoyCtFGVEYhaLdmZcVKu/TNwv991MSLLxJooGoxrzLtQrY3 XGH19oqfVxXB4CXMagcHtjmeZBSkiH8YKyfU2XoXud3r4XXJcxvhmctNeu3nspXhXBN0iiwxrbt KJOsDc/GZyAEXgQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Hi Greg,

To be able to apply the last patch without conflicts in v6.6, 4 other
clean-up patches are needed.

These patches mainly replace existing code with helpers to reduce code
duplication. It looks interesting to backport them to ease future
backports.

I had a few conflicts in mptcp_lib.sh, because some of the new helpers
have been backported recently, but not all: so I had to place them
between others.

Note that these patches are the same the ones I sent earlier for v6.7, 
no other conflicts.

Geliang Tang (5):
  selftests: mptcp: add evts_get_info helper
  selftests: mptcp: add chk_subflows_total helper
  selftests: mptcp: update userspace pm test helpers
  selftests: mptcp: add mptcp_lib_is_v6
  selftests: mptcp: rm subflow with v4/v4mapped addr

 .../selftests/net/mptcp/mptcp_connect.sh      |  16 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 187 ++++++++++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  15 ++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  86 ++++----
 5 files changed, 170 insertions(+), 142 deletions(-)

-- 
2.43.0


