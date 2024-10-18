Return-Path: <stable+bounces-86860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EC19A430B
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 17:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FFB2266D
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CE20262A;
	Fri, 18 Oct 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3AP21HZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192C165EFC;
	Fri, 18 Oct 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267070; cv=none; b=dnWeGeev86TccAAg/yrKHxEJItZLy01QOWiP08irpVXqL4QlBWquJqIlsUkpe/wIlnYQwf5TpjYLZxIuOMm+ZEQVGjCpBCb1UbX/QG33bQzTe+DvYbk7cJoKjRYGNKAbUGZqLeIfBCuwtzv4+gHnqrDiHVvY+50jXFgLTSzbA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267070; c=relaxed/simple;
	bh=tCucLaoTh+MK0+9epP2qdVz9E2vSr9Thdxbczad7Uok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQyTR7fwCdTfdibxjZE5a0Zx11LdTKeXLZTbvXARcY1S0Tf+Y3sEubYzHbRDfDTifOqu8YPhrg8eL23xDCr5O4cwRgq9QrHyWjp83jMhWlxi0nBGouI7y4SKdET+LBeLkT+gx8t0E0sa1MCniTGKoA+bZPwmA+6s1HD2bX247F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3AP21HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6DEC4CECF;
	Fri, 18 Oct 2024 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267070;
	bh=tCucLaoTh+MK0+9epP2qdVz9E2vSr9Thdxbczad7Uok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3AP21HZ1an+4Q75Yq61EiRET33dJpnmBNuEKSDlgR6oxgwidfmJjX9+Jo27WZ9wz
	 gLBUJQL9vlJzzvSJIOTY0kN6sjw/CxmR3ZqpWffOVRPBDBs4Vrges+UF781qe7HwNx
	 8gfhyN69lyA8IEjq/ojaLyF95Upr5v0Stp8GxRBsLNhRIu+3O7ZO07JUpTq+tG4BZk
	 L7zAr9bIEj8T81zyJyDAxqDGpxjh8yJVHtIf7vm6gTlUmyBbmIfHwbkuj1ux6Uxz+8
	 eP0n4Uw10j5tNZwC/02RJ4/syVQWuEJ1e6kGZQQVu6UzxPXmKFJRPf+hlH0AJS6gpn
	 Vft/mGxVf/vnQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 4/4] selftests: mptcp: remove duplicated variables
Date: Fri, 18 Oct 2024 17:57:39 +0200
Message-ID: <20241018155734.2548697-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018155734.2548697-6-matttbe@kernel.org>
References: <20241018155734.2548697-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=matttbe@kernel.org; h=from:subject; bh=tCucLaoTh+MK0+9epP2qdVz9E2vSr9Thdxbczad7Uok=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEoVuNHy/nsuu3v/kx4hmzO3wgygG0dMx7Lg3Y SjOAx8SGOCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxKFbgAKCRD2t4JPQmmg c9ZUEADQ4qLZQDbGgxBYsA6hnRHvwPVWgbNe1i2gK11L2khYOTHhYdfZeppNf/9rSNtnf+/C8Go EYcHx0H1PFTz4OT31i385P26L6jt5tBbji6lbCpY+9c5Chwf714cWwuLOQ0xQMnlHyTPhUUY4jq XBOGwHDGH+EGd7sw6DoPEeeTk2LjVLcdGszxkR1kW3zI0REG/37pilyp7UfMW7wjK6LKwrqdbDv G6TO//B2qAz4OWB5NzvyHv/75H1eMjozAWPnJeIu3sPmhN7lDMqI7e+aKgyX31Hs8G+rtQC939F bKlixeXvNmbNaRcZJhloPbbyys6ZD9hxRt1mygVR8g/I4IHuCPtMity8cqOZXzH2+KcF8VCsLBn u0w/rDS7knEDNi2Y4VZFHFSm40ZYN+snfoI0wqcVq4XYESO5qM4NwssV9RS89y5TCUPAVilrxiQ W5M02xvKFauGC2SWCeEPtrzfZXr8CWfeaxd4zxNm4rVY+ej2+7AEec0++cKOB3wcweUFGUgxLAA SY8+ro4RjkOKaANrLX2s+KaincFA63m7wulULbfKCzpHRwdoVeAh0lr2gyf134M2nT3LdeHYeAJ 3bt0Wc0w8G0kAjG+anmX7ygJhkdpJCjU5/Ja+gzH6mwbQho/f75SePoNpbp3XwlQocV7YmdYDQ/ AePuVWk38gWUwVQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

A few week ago, there were some backport issues in MPTCP selftests,
because some patches have been applied twice, but with versions handling
conflicts differently [1].

Patches fixing these issues have been sent [2] and applied, but it looks
like quilt was still confused with the removal of some patches, and
commit a417ef47a665 ("selftests: mptcp: join: validate event numbers")
duplicated some variables, not present in the original patch [3].

Anyway, Bash was complaining, but that was not causing any tests to
fail. Also, that's easy to fix by simply removing the duplicated ones.

Link: https://lore.kernel.org/fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org [1]
Link: https://lore.kernel.org/20240905144306.1192409-5-matttbe@kernel.org [2]
Link: https://lore.kernel.org/20240905144306.1192409-7-matttbe@kernel.org [3]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 869c8eda4bc3..d98c89f31afe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,17 +8,6 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
-# These variables are used in some selftests, read-only
-declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
-declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
-declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
-declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
-declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
-declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
-
-declare -rx MPTCP_LIB_AF_INET=2
-declare -rx MPTCP_LIB_AF_INET6=10
-
 # These variables are used in some selftests, read-only
 declare -rx MPTCP_LIB_EVENT_CREATED=1           # MPTCP_EVENT_CREATED
 declare -rx MPTCP_LIB_EVENT_ESTABLISHED=2       # MPTCP_EVENT_ESTABLISHED
-- 
2.45.2


