Return-Path: <stable+bounces-172413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D8B31B0C
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776D4A23721
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F22E3B0D;
	Fri, 22 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzFmiV80"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D912FF17D;
	Fri, 22 Aug 2025 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871880; cv=none; b=J1xIqC8QvdGuJEnirh9iij1QFl9FQdXxQVQRXRoBKUoFuwPtP1wviIkNoOJQ7WB7zVrqal/QQ5mybE6iJrsulyjoaqD0ulgUB79znynfODfcV0srRT5QqxqRNPdRT824+NWCDHfGTZTxjFHkEgPxLZ1jsfGgQRZg3E+MirVjPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871880; c=relaxed/simple;
	bh=FFMMERj0qQlRbjWXircV2NLy1dGM0N8IP4sm/8waveg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsEuQzgtEaLX5CgJZ2+BK54n7GlXLaldHfy4LZyEOFv1FRYav1/M/uG0Twm3ymbeiZgDV1ouB1X4iGQLRFaLLuEH5bCZW28k9ilPAlyQMMSmUOhkGLTjBfhPjRXWOKyJrckMkqNU5blB0j+pUjv6CPurnPkME7Ohwb4FBxxJVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzFmiV80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1392C4AF0D;
	Fri, 22 Aug 2025 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871880;
	bh=FFMMERj0qQlRbjWXircV2NLy1dGM0N8IP4sm/8waveg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzFmiV80D4rHKjdVy/i4FE1u8ZfTEVvylnB94CaHRLjkcrEFBD9/efey/OX5qmOza
	 oqBJWtsGlWjJ3wkf+N/qEgppAaVHQY3Xzb/rsQY2ZndXvOm64TCqd0lMigCMmW7UJw
	 KOaojWTD1GfD+bPqKDc1CCVa460srvNex1JjHAQsntRM8XPCiOmNy28IzU+oJk45WZ
	 8mT9MjkW8fD1FpyRIOhW/Q322Ii8SpZc+TIik8nVF7sOgIGjQQrmTksRu/n++03EYd
	 urRO/aMKXqansMvCjZ6qavM0L6oJG8rFRbs1kFqGfJw4Yu++9dq+SL4iazdOlMlRf5
	 ux7iAN3W1H5Hw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/3] selftests: mptcp: pm: check flush doesn't reset limits
Date: Fri, 22 Aug 2025 16:11:03 +0200
Message-ID: <20250822141059.48927-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250822141059.48927-5-matttbe@kernel.org>
References: <20250822141059.48927-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=matttbe@kernel.org; h=from:subject; bh=FFMMERj0qQlRbjWXircV2NLy1dGM0N8IP4sm/8waveg=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVFVEeUoWXLcrq1rKJXPuwNnGp88cjvyu6FgdudL+m ozowT//O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyIYSR4fS0rN+H3v/L4Ujh veSSutU6xd9Vu1z4/QqxQM2OyGXnZjAyLP833/p209+lKlerIhY+m+USK6e74P4Rz5sWRZY/d99 fxAAA
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
index 71899a3ffa7a..3528e730e4d3 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -134,6 +134,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
 subflows 8" "set limits"
 
-- 
2.50.0


