Return-Path: <stable+bounces-189998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576BC0E6A5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A6564F637F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AB2797B5;
	Mon, 27 Oct 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDEaYInD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB61F5846
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574936; cv=none; b=lt+9GOLoizkR/YlJ9qnB6Ovn3t38ahZhUEMSXrIsljSLJrkhGUtHr6rFljKiKuK0a2RE5p+nRc5Fl/BW2CJLyfkKJtiaGdEEq2KEGBZFU2g2+7dTlSsUsQUYjL+5v2+LSayUDlQS386m8CNoGBzhNGC6VG1WQHGNiCZqSsgacA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574936; c=relaxed/simple;
	bh=oc2iByHJSKLNSXFDJxW88hproerYKfyIj0IFmS81NYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEW1golS2NV0zgtSzGkbrlR9IoHV9eZClmnvYfevQMBoPRmnP0+ntmz7fN9NkQSv++toBgyFqrMbIfCH7TTbPpsrwuyFnsVTZow88vs+LTNf0ZLADTTr591BjK+Uo7gPA6tWZgZrTnDQb0fyr35sKFkft3MchA0BDISvUVeNC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDEaYInD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76C0C113D0;
	Mon, 27 Oct 2025 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574935;
	bh=oc2iByHJSKLNSXFDJxW88hproerYKfyIj0IFmS81NYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDEaYInDrDZ7MvNbStn+/hq/eCx6JzujmpoE43jowKYfSLx4wFPk2tXuBQLkI7szp
	 qxEytZ3iQyjup4si904OwkMuvJ5/1bd1JUpXZLGqSl05XifzztFzirPDiSSUddNEw+
	 wLORfxaoahtuXhMRJkjF38u800qlEhQVjRPi7abAE9Ezy8J3mIFeM31kRbC0rJbmsD
	 bKpQYjh9/AeCi78APq7GhB4BWpRPr8UPNDk0w6lFcBJB+tBLl3x5qh/4mJ60NPOtgy
	 24zc73bT32zqN4rJNuVUPLSv8RBNTjhY+ZcZygZzLbblBFPS275kZyk7gv0GB814O6
	 idHIN5ScKlRaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
Date: Mon, 27 Oct 2025 10:22:12 -0400
Message-ID: <20251027142212.514463-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027142212.514463-1-sashal@kernel.org>
References: <2025102627-enclosure-issue-a264@gregkh>
 <20251027142212.514463-1-sashal@kernel.org>
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
index 2b0319cc738f8..79bcd9000e676 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3823,7 +3823,7 @@ endpoint_tests()
 
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
-- 
2.51.0


