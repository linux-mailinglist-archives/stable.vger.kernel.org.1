Return-Path: <stable+bounces-172418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC43B31B14
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8284CA24230
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F03054CF;
	Fri, 22 Aug 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEItV1aA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FC2E7641;
	Fri, 22 Aug 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871902; cv=none; b=VjmW6KkvlXJ/iySThIJXZUpWAQzIA+LKcmxtconFBSrKM11AbFprLJQZWymu9K0Jxqzh7LDrV3eXJzAc1yRzrbAWbWce/9gLzqo0oOM4b1iaf0aw2kc0M9LFWThrVKsIAygGiiE0CLO9TgjyWDpbZS9KT1fpcefQ+JWvZanTWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871902; c=relaxed/simple;
	bh=I0mg1j0nvO9uGzt4aZjTCOu1YQrmacl35sqTUv51k9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXvYngfHxEViVDEFzPuaOjfbpgBEB5ll2MEGrWKsOxf75vLMFGkliDdkqvXWW0PMvKytdjCsSeXFCRdr8twMQ4uJYKEnRXx8QsQvCJ+uRfsaBbu/upRlcpHnlp6kZwaMuk4KrKhjvMVwDZejmONo0jQDWhIcWMnCPdvj2Yq+qMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEItV1aA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD968C116B1;
	Fri, 22 Aug 2025 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871902;
	bh=I0mg1j0nvO9uGzt4aZjTCOu1YQrmacl35sqTUv51k9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEItV1aAADRZjpo/RV6HTveB8zkKbZjcOB9wgLUV8ASTzqcDTxWknyPmwxulaY4L/
	 L1kbfkFRGV5YdWVxn6p0mhYuv73B7Dgci4bhLHDBvGzM+xwQjxOlEOdtUBBFjg2bZa
	 PIVu3khuy2F+joJSHsWJIGkUcYkNCAVZ1kR5NnCh79ffmZXbQgYGjILq923lIZZ54N
	 3TXUD9yJlRS5uHHfyWRDrPwKvbDMPrtGZqlqfpu0Eehpg2Jd5LuidC9S5MNd/OlWDf
	 g7OUY8/6UOmem3Fnu24kWLZ5FfQnJO6PX238x4MMzClt4dhbG6VuPXV9WrVkD3SjN1
	 a9ytNr6kQu91Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 3/3] selftests: mptcp: pm: check flush doesn't reset limits
Date: Fri, 22 Aug 2025 16:11:28 +0200
Message-ID: <20250822141124.49727-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141124.49727-5-matttbe@kernel.org>
References: <20250822141124.49727-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=matttbe@kernel.org; h=from:subject; bh=I0mg1j0nvO9uGzt4aZjTCOu1YQrmacl35sqTUv51k9I=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVE3cfUn+ycJlSSm/W7pfv9t8r13y+oE5ShwzjZ6Je Ys/+yG7taOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi/xMY/sppM4itLxLo7Nbc qndvz7ncV5XPee9rXuOv/Kpffcxtlxcjw2QvwZ8fP3r9WMuwzHi/5iOzyS7XLT4/LH+W3HvDLf9 sBT8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 452690be7de2f91cc0de68cb9e95252875b33503 upstream.

This modification is linked to the parent commit where the received
ADD_ADDR limit was accidentally reset when the endpoints were flushed.

To validate that, the test is now flushing endpoints after having set
new limits, and before checking them.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-3-521fe9957892@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.sh, because some refactoring have been done
  later on: commit 3188309c8ceb ("selftests: mptcp: netlink:
  add 'limits' helpers") and commit c99d57d0007a ("selftests: mptcp: use
  pm_nl endpoint ops") are not in this version. The same operation can
  still be done at the same place, without using the new helper. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d02e0d63a8f9..1b0ed849c617 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -131,6 +131,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
 subflows 8" "set limits"
 
-- 
2.50.0


