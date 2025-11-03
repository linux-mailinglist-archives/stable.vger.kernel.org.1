Return-Path: <stable+bounces-192243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4050C2D50C
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603693A27BA
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B23164CE;
	Mon,  3 Nov 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBzwMo7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DC305068;
	Mon,  3 Nov 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188888; cv=none; b=LqNlzDiwA9bEEOpjfjCqkl6U5VGKxt5h1jMLaPQekpfgpjq12tNhTsPVhAOzEguoKbZ1xgz0TqQPilrS+rLZkMVv0q1k7dvISUNBdEqH3SYpRxBWYNuKbuLVSW7ZCsBChbs2Ffzkm76UaUXzFa0/z7nd810HL2uuZheIM719ZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188888; c=relaxed/simple;
	bh=fb82UjdKBdbrSYPWwUccE9Tz96ZUIbYr0+PlrnzgvuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lh3XCppl1wUQlJcod9wvdQaXLr5NULbDz6MGtuPyYPkYy4xs8j4yAN34RsZAnxonDTgAfp8bJ/1hwA19gApGdNXV4pr6PIuVavTzPq/r/RR5EyHuuzuBC1uJ3X5E3GshVwV27/Yk3iNvPtuPUv6h455FgWjk4wnk1Zathem4XZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBzwMo7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC2C4CEE7;
	Mon,  3 Nov 2025 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188888;
	bh=fb82UjdKBdbrSYPWwUccE9Tz96ZUIbYr0+PlrnzgvuY=;
	h=From:To:Cc:Subject:Date:From;
	b=nBzwMo7ji4uppYdVpl5HMsrUxxrILIK99UGjdjGjKrgKmINB+wUM2Pngcth/4OHmY
	 E7EPbqQYxLGym5CczbEmGCHkJFtkKTZWoK7B1kA1+Q/FLy30eMV97htGNV2LsloGyD
	 ptiOWKkb9gApK2ywWM3NOWsvWXavYeCezetXoImI4lEilfU1m8FvCCYJowSNJl8Hc+
	 cMVIVgtF3rx2DIR0dDwWXFlT9CCij2ggAsj7Ni8i30ML+mpbBXNW8YThqVRQFuVIli
	 i6kGzRSmsbNSbRev5vKgdV2tuJCdhdSW26wPHz4oPjsQiHPhGFDZwHp71fBdGmryIW
	 67fdyqcZYjj2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.12.y-5.10.y] selftests: mptcp: connect modes: re-add exec mode
Date: Mon,  3 Nov 2025 17:54:34 +0100
Message-ID: <20251103165433.6396-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=matttbe@kernel.org; h=from:subject; bh=fb82UjdKBdbrSYPWwUccE9Tz96ZUIbYr0+PlrnzgvuY=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI57nnF8a+In7h30ZUpfkV2z7ZvnZptN93r6bm7pyLcW R7PKP10taOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiS7kY/vDdj/wnkCqx3zhZ QnxLv97a6NmrxbareEe8u/JlV9FRgzeMDI3XxXhnzFyoF5YTrvoxOKI8NFQyupnvfZ/BjcPtqov vMAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

It looks like the execution permissions (+x) got lost during the
backports of these new files.

The issue is that some CIs don't execute these tests without that.

Fixes: 37848a456fc3 ("selftests: mptcp: connect: also cover alt modes")
Fixes: fdf0f60a2bb0 ("selftests: mptcp: connect: also cover checksum")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
I'm not sure why they got lost, maybe Quilt doesn't support that? But
then, can this patch still be applied?
The same patch can be applied up to v5.10. In v5.10, only
mptcp_connect_mmap.sh file is present, but I can send a dedicated patch
for v5.10.
---
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 0
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 0
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
 mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
 mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
old mode 100644
new mode 100755
-- 
2.51.0


