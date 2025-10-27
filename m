Return-Path: <stable+bounces-190011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAAC0ECB0
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18D074FC04D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51B2C236D;
	Mon, 27 Oct 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhoT9362"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89668218AD1
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577148; cv=none; b=JdXqsYDiQ6dPYBqB2HNCmqw67GZ6AGdjsipP+Q4JLOvhMveeM5idu/1UAkD2IY4RN4pV4cPcZyNNryXQX4VRnxKMRl+5RmloPSynEpYLvh5N6vISnM6dWGSWx90+OLiF1IcRSM+ytfNDkIgZSihNbrE083QybAZkgArf+cuc0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577148; c=relaxed/simple;
	bh=WjNfT6QpM9zkJH2Lb+yR0DbbuEzlaBWBgHGmdYrrQQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf2A6RxND1A0ecxSsvfp9IfotO4P+N/AoCoyORBca1/6zcPnA6TRD+Md0uOviNrtIzjBayWrJMRAgUH1Kj2Kxe1iTehm/jwCV1YWdj6sHLvjndV3kgKoyEDRSGgsIMhyvMfE078EcsLcB0twJc7V9dWAcRZ4j6N1mpycLK6ihqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhoT9362; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF59C4CEF1;
	Mon, 27 Oct 2025 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761577147;
	bh=WjNfT6QpM9zkJH2Lb+yR0DbbuEzlaBWBgHGmdYrrQQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhoT9362oRlV2yeRz4LqpkmiO5AROF+t40UvOo32y9T1FYjqlDQ9Eu9Cg3cYmfnIE
	 Hw2sOC3FMwxBGpDGorTA3cOswBd35mbuXfzdYpBT11YMVUfd8cusVCTlMF1Mr7Wg+5
	 d+X3EjYPf9s994mLjPpJm+owbeEWc8KBCpXnByIntqHGUspCwjf8oiF51tUzne+uRv
	 PwmxhtSIqM33FPRCgbuvbKjqYl3vJTfdQAsnxLq9noibSVfjTtWL162CTR16+rPfT+
	 IvCY/Ox9hb90VeC3416pfQrx+CCf+T97aiExOop3EzoF9gPEho2PFOCio8uX/m9I4e
	 OXsSE7sprnf5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] selftests: mptcp: disable add_addr retrans in endpoint_tests
Date: Mon, 27 Oct 2025 10:59:02 -0400
Message-ID: <20251027145903.532999-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102628-overrun-runny-87fb@gregkh>
References: <2025102628-overrun-runny-87fb@gregkh>
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
index f8589e7c9383e..bf3987bec2747 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3394,6 +3394,7 @@ endpoint_tests()
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-- 
2.51.0


