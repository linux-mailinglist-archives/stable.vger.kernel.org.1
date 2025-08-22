Return-Path: <stable+bounces-172437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337FAB31CAE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B206DB0862A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53407311974;
	Fri, 22 Aug 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmVWSfFx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31230E0F2;
	Fri, 22 Aug 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873818; cv=none; b=A3yqRxta92TS76QiZDVw+8/t8Z6to23Z/L3PQhKPmJJxz+sit8tlCv4NGr+rwaL+gSvVCPItnPULnQMNGAmE4v1m4hEo5CL0mazTApln6/lDnXhQbVzp4yfJZlOPu2Zg8iG/TYEojhP47OZ57Igh+RrvhmqpmTCCt17rUAhsKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873818; c=relaxed/simple;
	bh=qRISSD0T4GCUU5yfMH4uUcJGBBZhh2NGiVvlvLAJsls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJQ7DSYc0iOWcjOwAb0o21+m3eTwoKcyEc382wFO+OsHdAOXQy0da6OcE8RItqx3aV+PvSabFibw4+Vc4T/yIVIKredMUU6ByCc/nwp/Gf+kuVOLtkNBm+rP+3xOk0bIHKSz+2DVUv/E79hSgc/ReBXlPHvSfiWFhSisdjOst30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmVWSfFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B057C113D0;
	Fri, 22 Aug 2025 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873817;
	bh=qRISSD0T4GCUU5yfMH4uUcJGBBZhh2NGiVvlvLAJsls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmVWSfFxfvPzNW9yF8I6Ns5tut7zVDaSFvHmN1oA2XbGQ8KYIU8DWdS/AKzPoUD3c
	 fzC6YUROLgK/YpqaR7g++EcUrj4mEkbXWPsldcmzeOM90SZX/W6Q9WWc06nC30T8l0
	 zzrEYQ23P7peIafDaCqzJaRPBnySFirOEzjo58iy+WpxbVcTkXjwQDV6OeP3BmRgMC
	 h4vToYfXTaV8WJhF2yFMtbtvYcRFUeu60mzVS/80lb0QqnThy2xIy1kg6G1/j/YVw0
	 WPTQnNBxQu7MeHaSWOySL0A4V5hRCbYlOvI1fac5BkgGFoCG4vlLCcTC/hdBznuhcI
	 8C5Fysnp0AO5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] selftests: mptcp: pm: check flush doesn't reset limits
Date: Fri, 22 Aug 2025 16:43:29 +0200
Message-ID: <20250822144328.108718-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025082203-populate-sublease-ef51@gregkh>
References: <2025082203-populate-sublease-ef51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=matttbe@kernel.org; h=from:subject; bh=qRISSD0T4GCUU5yfMH4uUcJGBBZhh2NGiVvlvLAJsls=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWNAnu/bps+XZ/2+DLnuGVS48t6DuhtlTS9bLSiUDHi 0v6f+j96ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIizHD/7rngS/9NH6xzD+S Var9w4qnz791R/7+q9bHepyT1xqkqzMy/P3DX9CdEerO8vqwzB8b5yfnbiXcN66Yd2zny1+Jz5+ VcgAA
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
Note: this patch is validating the upstream's parent patch, commit
68fc0f4b0d25 ("mptcp: pm: kernel: flush: do not reset ADD_ADDR limit"),
which has not been queued in the v5.10 queue yet. I'm already sending
this patch, because I got the FAILED notification, and the resolution is
the same as previous patches I sent earlier today.
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index fff6f74ebe16..7d194f5c2939 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -130,6 +130,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
 subflows 8" "set limits"
 
-- 
2.50.0


