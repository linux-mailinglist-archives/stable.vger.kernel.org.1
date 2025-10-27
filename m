Return-Path: <stable+bounces-190001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90235C0E7B3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E501891A7C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6448D17A2E0;
	Mon, 27 Oct 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz9umbei"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB9279DCC
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575829; cv=none; b=m/fh0cQg4hq5MoPjwOB1RbsjX+L/n7J6rIdXpMV/bvjIRotkiJAKe2TDHQg4Y2qgYZpCwQRHONgRemh7N17bUNMae29hoYsjz2NyIJwQwVs2g7aCvjFLzh+R0O6EAIlU56qqxCBabl1Yvw6nfcLMTqadzE+PFrCODLfQRDFhrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575829; c=relaxed/simple;
	bh=IDojGxn6zxZSYX8pidKmVxsX9SjeyYH0f+yp4UqFk3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXkNBe7cDinz/9m3UuHN3ZABXv/yAn6vRaAxxRX3WGzSl1pVr33YNJU2EcepluHVIzNwAZQW2J1X09HJ9UuYwmIItYmJxp9LAunWrap69ORGoLmcQDzUajE/O4iehl2xXVFzga1AVB7BD76KN1eHm14l/7gwWh3ta1AV0vSKA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz9umbei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B19BC4CEF1;
	Mon, 27 Oct 2025 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575829;
	bh=IDojGxn6zxZSYX8pidKmVxsX9SjeyYH0f+yp4UqFk3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uz9umbeiH+5kdFkJ7qd61Ou25SWXqqiaK0Z5OrvK8GbdgclL+EUGvCvhVd+plhy1c
	 GWjm/cgXzl5HZlBnShtiZ2QF3mZ6RNgTSLKbsnjGv6nloJQbQBy063+gpCA149TyWm
	 K2kCnP9jBBMOEy3IaAb4OPE4TOhosLVuOYWKxJe7E4ZAr3Ovl13cH/m1DQm0q17spv
	 GFcDf+J+yrrQ2VMRoGJORVy0CmwL/AKYwz/hWzUK6Ox4owMhrYnzXAd5uogLbZ83us
	 dy8KN6iDxLHAY34UtQq9RHl3zYUcUB3Iz958bpVkxemCcTU9K3xOuALAFHtuH8E7mF
	 vJfkCbdUWC+hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] selftests: mptcp: disable add_addr retrans in endpoint_tests
Date: Mon, 27 Oct 2025 10:37:05 -0400
Message-ID: <20251027143706.523131-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102627-tug-sabbath-3edb@gregkh>
References: <2025102627-tug-sabbath-3edb@gregkh>
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
index 9a907d8260c9c..4acef599e1f1b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3838,6 +3838,7 @@ endpoint_tests()
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-- 
2.51.0


