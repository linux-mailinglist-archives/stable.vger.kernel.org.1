Return-Path: <stable+bounces-52147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D05908418
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB88AB21DBC
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 06:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264B1487C0;
	Fri, 14 Jun 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UGsLEM3J"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4EB1482FD
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348343; cv=none; b=snXts46Zh4qBAoFgVkkDXhz3/204NMeEpNABZnkaWt8YdJr9P9pl5TBoZolVFQW/d79ry73PbgJtGgIne5EQACPnXEYhmjbRjuPH5V4JBpUVMAq3nTajyhp2KIoISQS/GV6LxlJkODIfgod/i5h+O6GyEBloONexoV4ApnMY6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348343; c=relaxed/simple;
	bh=qQUcF6yzBo9Rj6INfK0tTfFyPFFD7Dos2CpGt65pGBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3kfWFJVWcHJ04K8EH/4zh34+dt6DHwIg4TEt4fYUsnb9JUBDVxShXEUqqxnDLcphtNhjC9yrMXaFe8JSqOX2s2mSsuV99Qhq/a7OH0AEyBqa30ixaSwKL5+mg2r58T0e09/U1BTcA6tatlwS5KeLg373mNHImyH031vLt+ouso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UGsLEM3J; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D758440822;
	Fri, 14 Jun 2024 06:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718348336;
	bh=VHYPmIQSAFTHpR12wIrYSEXbqnsWf4A8yOgVNiU2JXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=UGsLEM3J6JBTcejU+RAbdxaRVUuQiVyCyKA2Y12/ga5I11YLl2vWafnQWRLC6QCPA
	 n5XaviHjxbh5l5IiudnZ3zlVNsFKdISl8yOrIvjpQWnCIhFn7EED1GwdHI8Ss6WZhs
	 p8x61UqyjqIf1C7BY1X8qfsIDA5U7LcUkRQFXdFtVQEZlw8EyY67sTM2z39G9HVefA
	 Qi/jmvOdqwCUvo3kwDaJabvHFLD4ZlrCbF7RWX7Jui8kLkiLcMJNQoxeOc1JP843zN
	 3M7b1qHqBn+g2tTMpTt60LEmflTfLcZhGq9EX6HGATjJ+oJljs+HWyIDiqgk5nQms1
	 md2qKbTaMqhEw==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	gregkh@linuxfoundation.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org
Subject: [PATCH 6.6.y 2/2] selftests/net: add variable NS_LIST for lib.sh
Date: Fri, 14 Jun 2024 14:58:20 +0800
Message-Id: <20240614065820.865974-3-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614065820.865974-1-po-hsu.lin@canonical.com>
References: <20240614065820.865974-1-po-hsu.lin@canonical.com>
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


