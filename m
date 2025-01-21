Return-Path: <stable+bounces-109770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35084A183D8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE442188D4F1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886C185935;
	Tue, 21 Jan 2025 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMET7TM9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BD1F238E;
	Tue, 21 Jan 2025 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482388; cv=none; b=eCS43wOGv/RXbJkBUPp/yTXugDae4L3gN9zsHlTboL4JT6TFmosCAp3JtAVCRVYoNTU7/4x2QXI+q7JucqSsCDU+YstNy6tOiGrbeWeAdoFoLCIKHMXJ0F5VJercnkiUENo66IarMiDeHMxPZ064sFO31iS8E3EWS6NTtI2x8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482388; c=relaxed/simple;
	bh=wsPPv+GVoGTBivP1yGxtbESVKRuc7f1HaqcenU5J3+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS4SInszH3XtJp8HwL4ExqtVp0S/Sr/sm6xUB9/xm4RxOzt2hxAMIw+le5I8v5F3oR82rcoDhWSforSLtqDJa4OEQ7F2/eXbb1rQEp47L6XoV9ueqWSzFghh6Zr4kDOx1JuwLuArvKUXZHZ9X3/bRzNRLGTj3CP1mj0aH2wdKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMET7TM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2398C4CEDF;
	Tue, 21 Jan 2025 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482388;
	bh=wsPPv+GVoGTBivP1yGxtbESVKRuc7f1HaqcenU5J3+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMET7TM9LcFhzHTHQk3tAwwRnObpa5r0rokDuC2BSUXCXfF5SFifAX7gxrsP7h6xv
	 Eb6DHxKIYcKeQYnXCBL8rNyLwe7G7GZAD1tD5I8oDJDXopPjhEPc70kqbVkdBtIWhh
	 W2A0fM3BKf8LOBoXO3txKCgwqcYdMBcaHkJM+W40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 059/122] selftests: tc-testing: reduce rshift value
Date: Tue, 21 Jan 2025 18:51:47 +0100
Message-ID: <20250121174535.269601654@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit e95274dfe86490ec2a5633035c24b2de6722841f ]

After previous change rshift >= 32 is no longer allowed.
Modify the test to use 31, the test doesn't seem to send
any traffic so the exact value shouldn't matter.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250103182458.1213486-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/tc-testing/tc-tests/filters/flow.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
index 58189327f6444..383fbda07245c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
@@ -78,10 +78,10 @@
         "setup": [
             "$TC qdisc add dev $DEV1 ingress"
         ],
-        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0xff",
+        "cmdUnderTest": "$TC filter add dev $DEV1 parent ffff: handle 1 prio 1 protocol ip flow map key dst rshift 0x1f",
         "expExitCode": "0",
         "verifyCmd": "$TC filter get dev $DEV1 parent ffff: handle 1 protocol ip prio 1 flow",
-        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 255 baseclass",
+        "matchPattern": "filter parent ffff: protocol ip pref 1 flow chain [0-9]+ handle 0x1 map keys dst rshift 31 baseclass",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
-- 
2.39.5




