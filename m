Return-Path: <stable+bounces-53804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C4290E72C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B96281FB6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853448120D;
	Wed, 19 Jun 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="d8Q2LvWk"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47380BEC
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790008; cv=none; b=N7P0t13VNOaBAmgb2EZQ5Cbg1vBVKlqXcb0sUF5WU1t8O2ia+gf0OHXFOJLXs+89OFfW281H88p5g2kyK9VnQXxonLOhmxRv5hgAMpoq42HEuqFLYVwpFYdcS09/YZzavzrM/qIo0R6I6lJWRe2Rm+xN8opyMhCJXFex9NpKlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790008; c=relaxed/simple;
	bh=qQUcF6yzBo9Rj6INfK0tTfFyPFFD7Dos2CpGt65pGBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbQ3apDz1PiuiDuhHdUqea3NQ3ORCXpcAUuceWIOUBKsqWtm0p22SCDZ/AentWPfMJrFKfROwTsdiEhFyuDTAxj9KBsPB6k97hnQt+d62zJUbBFqoZ/zUMbqtBwxez2TmOWmQV9NRBWVU/nB75x+qy1o5yYS6ps5x8/yzLnhmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=d8Q2LvWk; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4873A40890;
	Wed, 19 Jun 2024 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718790004;
	bh=VHYPmIQSAFTHpR12wIrYSEXbqnsWf4A8yOgVNiU2JXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=d8Q2LvWkui4Yed8xbl6VbArKcBno26pi+ohnRgYbRIPtbfmYbv7w+NCyor5oD7/HH
	 yjoEJewmudioxmgC8UtFLRh32fdmvYftMXIkFkk+JTop9F5ufRPes6kXzriYHETD/Z
	 iDm869SoqiNBD7QJuRuZBWePY5mi6lmCdjOfSANaLiOd2TJA2VQXpxLlJCtsuSrkmC
	 lM864pjAUJdvHuW9PFyDZIazfnXId8ZHcU2/nuMXSHmTEi29BcV3dhzyCOtosqI/P+
	 aPJF5GGyjesXy9eJhdGHLNGNvOiCOhr4dVB+gZ4KpPM5GwuJiW0d0nEJ3b6kpsY4Cg
	 KxxUphXEXaAZA==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	gregkh@linuxfoundation.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	bpoirier@nvidia.com,
	idosch@nvidia.com
Subject: [PATCHv3 6.6.y 2/3] selftests/net: add variable NS_LIST for lib.sh
Date: Wed, 19 Jun 2024 17:39:23 +0800
Message-Id: <20240619093924.1291623-3-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619093924.1291623-1-po-hsu.lin@canonical.com>
References: <20240619093924.1291623-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hangbin Liu <liuhangbin@gmail.com>

commit b6925b4ed57cccf42ca0fb46c7446f0859e7ad4b upstream.

Add a global variable NS_LIST to store all the namespaces that setup_ns
created, so the caller could call cleanup_all_ns() instead of remember
all the netns names when using cleanup_ns().

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://lore.kernel.org/r/20231213060856.4030084-2-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/lib.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 518eca5..dca5494 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -6,6 +6,8 @@
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+# namespace list created by setup_ns
+NS_LIST=""
 
 ##############################################################################
 # Helpers
@@ -56,6 +58,11 @@ cleanup_ns()
 	return $ret
 }
 
+cleanup_all_ns()
+{
+	cleanup_ns $NS_LIST
+}
+
 # setup netns with given names as prefix. e.g
 # setup_ns local remote
 setup_ns()
@@ -82,4 +89,5 @@ setup_ns()
 		ip -n "$ns" link set lo up
 		ns_list="$ns_list $ns"
 	done
+	NS_LIST="$NS_LIST $ns_list"
 }
-- 
2.7.4


