Return-Path: <stable+bounces-190002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545DAC0E7B6
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD471891E0E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927CE2C11FA;
	Mon, 27 Oct 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3dgZICF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50129279DCC
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575830; cv=none; b=O99lvwa9I6GBKlk2iPIoJYjnB5Zd3Ci9RwLAmbLRZD1xgAq4WFs2Az3oMbTY3zfNDX/I6AKeUOMNS4S50tx6z9a3EnxHR8y6Q9eS5+4XhvvF7axZFutvRmDwLFis41KSZnbS90q8V0MwgCcZvKDYcXeYUgTP1AXkeAg5ng3Nzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575830; c=relaxed/simple;
	bh=HJu4X/Jf5YZvZtYjeIkSPjmxjaJM2vIay1Wgm7Xgx10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcMsbn4pUJ0PXmxHaY5kpC71249rUXt1veYhIKgwqVO6gvDB/uMDSILGif23Ny9OlMpKzBT2R24SiLjGUsmKOuFeQiIiXAjgm1ag4BTGCKEIhf4n3VK6VdrM3tWOOv/svVcWc6fKjnAEuRQsNGlrIHE/TsVV/jIdrm2YdeXUBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3dgZICF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C211C116C6;
	Mon, 27 Oct 2025 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761575829;
	bh=HJu4X/Jf5YZvZtYjeIkSPjmxjaJM2vIay1Wgm7Xgx10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3dgZICFAnn6UCUFrOtB6ncHgzRl1KXpVvheRuPvJj2/l24jMi7SIo3t4ZSexKxRE
	 Ovg6lj/N6bMlFD9UxpFcKREKLwJbyUGEQUwj1efBYJg1Fsz9LXwwGTmwwO/uZaxeLl
	 PTDCJQOErBuvrg2jvNSqEU7QaJM6JDKIiopZzwNjnkygA1BH/emUEKl7py5or9Q8Ng
	 Cx1DLB0FchtVQkGeGnH2o5sYKhX2DS0VIi0JAhdP0YGaWfoApKDhtsGVCmRTbPRgtz
	 FxZzx886nX9alSucSUciH9YQMpFjPcyqEJ17pHmqpwEpNlV8fFwo26RYUYplbShRQb
	 WaNgmkptuPp8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
Date: Mon, 27 Oct 2025 10:37:06 -0400
Message-ID: <20251027143706.523131-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027143706.523131-1-sashal@kernel.org>
References: <2025102627-tug-sabbath-3edb@gregkh>
 <20251027143706.523131-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit c3496c052ac36ea98ec4f8e95ae6285a425a2457 ]

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251020-net-mptcp-c-flag-late-add-addr-v1-4-8207030cb0e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4acef599e1f1b..bba95531f18f9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3837,7 +3837,7 @@ endpoint_tests()
 
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
-- 
2.51.0


