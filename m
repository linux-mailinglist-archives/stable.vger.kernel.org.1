Return-Path: <stable+bounces-190010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3758C0ECF1
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2574503869
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4932C21CC;
	Mon, 27 Oct 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a69S1UI3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C821C9E1
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577148; cv=none; b=WMkzfCf63bQtV4hJgMdRTHgJVYJ0YNZNPqoLBCCgqdpEsAl3/5PkJ7dlkjnxScsoS1aJp4YfgP+ISI+a3AZGf8xZ3AtBU6gQah/6dYHyhoReNHSnVBFNmW038pfWaus9hfZdO4kw3QVYB6RaSC1Y9j7osVvCcCr836t2nJpOz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577148; c=relaxed/simple;
	bh=5+7a+mlxbAXc46BY638ADR9LUnTPrl9C9njQC8rjEbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH+GcyhdNnzPlhwrXO1CuUd4OMe4ttrfSDPyb4TDcy+ZFCA94C19pyXnHr2KbxV56mDPOHKg1zDjKUqtatAEWxE9smVlr29biMbGY6gMKBk0ZkogT8tE8gzdl+cN4eAnQfmjIQ90JBljsPWaR3SnS83rJvAxJbBZ10b7fPoYVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a69S1UI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B818C4CEFF;
	Mon, 27 Oct 2025 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761577148;
	bh=5+7a+mlxbAXc46BY638ADR9LUnTPrl9C9njQC8rjEbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a69S1UI3DfXvzV7DF+1ycHBcVd8evVfIfnhXGZnUiWRE9ml7MwGTqhT9BpaKb1c7t
	 QV6k6stWJyyXixT+/FQnmgqDyHDzj/G858FR+E38to0KIb4GUEYUDlnyaGOFri1wK9
	 0e2ZgOBQcsDI3HVTqCedBzpULBRFAkoHOAJJCZKIRA86EXWCY8TPx9Q+SEedJiJT3N
	 p9n3msIzu15qb/B58R9HQiRbgH5bQ1TUN8gOZppb4HE9DCX7jq8fEFIXSN6CR27uQL
	 395Pnn8UJxK364pxAJ4LLIIad3UOGdcFQgT9if+72KU/hDRKF92U6kI0kDInMt3I3+
	 6LPd2FhXUh5Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
Date: Mon, 27 Oct 2025 10:59:03 -0400
Message-ID: <20251027145903.532999-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027145903.532999-1-sashal@kernel.org>
References: <2025102628-overrun-runny-87fb@gregkh>
 <20251027145903.532999-1-sashal@kernel.org>
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
index bf3987bec2747..66f6dda965adb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3393,7 +3393,7 @@ endpoint_tests()
 
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
-- 
2.51.0


