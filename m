Return-Path: <stable+bounces-189997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53109C0E606
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC5C1886840
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BC25C838;
	Mon, 27 Oct 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9U0Wxqd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B31F5846
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574935; cv=none; b=nACTzu1i6MiZH6TdHphVnmyJggMdNj0S2yIg5SvgtfmJr7jms9afwhbtOi5tfthltaVCM5VQ2Bbv3nVO3/Sy+SohRj+dBbMAPw73lrYtZMOVhqvgBJ/gb3h2vEMA1/Nzt3RdKnMnPJMJZYHBB8b/4gCgytPvLoxd9z82I0O4kb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574935; c=relaxed/simple;
	bh=5ANSxrrZi6HQxapz++sn1phwm3vX1xZkOoJF48kjpUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6z0Zi5HlQ/MSmwpkZq+0iLlvLgAZKanSrJExXLCTHWZ5eaNViSAZJBhJUaSkei3PirhjMqCDn17BPzOXMW3iPl1Ot8yDRBsTQhdurGE+54UVedFM5ovoGXdo7OUOOL+iLIInUZZDGG8awtfexMdbalQ+DWzm1wdDSV+GSgb91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9U0Wxqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0390AC4CEF1;
	Mon, 27 Oct 2025 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574934;
	bh=5ANSxrrZi6HQxapz++sn1phwm3vX1xZkOoJF48kjpUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9U0WxqdUyHq+zHEOmTqJN7mBHSC6Rsx76n7m0iKPjJTQshB5yQwvhOAlQPnRjIsy
	 KMDVQdBpyw5xvUedmZ+4TIB9TECmbpeH37x2ecUtd0ksAXZCaX9uBcNJFqfvJ6+oVN
	 8Dmg3AcTl/P5R6G6cOZSywjc1wkZUVAPyGmiDGldjiY+sfvdRs2qnuaZTYP0Cfnh6A
	 j6spZfNThPhF9v0ytf6kDY4gKXoCvs13mEwRZZHhCBBd8kkyxCpHTqbsrVjnt9Cx5b
	 38VPl/wQFy3I3J7C+ykxSfWFQWJ4vyhzKptSblz9UGw6FO4Lfd8+WF6QABzrEd8Tyz
	 b9gDzXau/9m1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] selftests: mptcp: disable add_addr retrans in endpoint_tests
Date: Mon, 27 Oct 2025 10:22:11 -0400
Message-ID: <20251027142212.514463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102627-enclosure-issue-a264@gregkh>
References: <2025102627-enclosure-issue-a264@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit f92199f551e617fae028c5c5905ddd63e3616e18 ]

To prevent test instability in the "delete re-add signal" test caused by
ADD_ADDR retransmissions, disable retransmissions for this test by setting
net.mptcp.add_addr_timeout to 0.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-6-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: c3496c052ac3 ("selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6b22b8c737424..2b0319cc738f8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3824,6 +3824,7 @@ endpoint_tests()
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-- 
2.51.0


