Return-Path: <stable+bounces-74468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49841972F71
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BBD1F24FAF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093218BC3F;
	Tue, 10 Sep 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQsNPF8S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334214F12C;
	Tue, 10 Sep 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961893; cv=none; b=JSae92U5pa6ZoB150IhvZTS0xAvb7dOG10AukTwMcHNmV8GwMassnUFv1STz+gr8wCgw9mjAYeY+fF7//WbGxUgz54nddmfqDHRABfsFiAtcMRI7fHeY+ki/ohkUvu2Ynrh39/gB6wBuydUtx/ljt2sWDHkxyhkm0JF1cGvCkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961893; c=relaxed/simple;
	bh=qzP12xfRuKMWGNTZI/5fSNC5FxX+VHZgVxgmH76aR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmdwShDSiZQd2tcOhnFYsTLhXrSK2aUUfeaTapcjB6ZmbXLGvgyph5ObVI22mT/1D0rlyVh1eix/NQgpugzfWNCASRsx/wFrBwL6u3blaMgb4ybf9z2KOlnGv8LZRHFVSgHm2oO1mNmqVHw9/4sHYHbb/usnDYK6Bl8uZEY60EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQsNPF8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BECFC4CEC3;
	Tue, 10 Sep 2024 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961893;
	bh=qzP12xfRuKMWGNTZI/5fSNC5FxX+VHZgVxgmH76aR9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQsNPF8S8fBUqCTWBto8eF9agSqWdZg5f9Bg9a+5NbbvW6BThPb+SCwNW79vCUnRr
	 1T8WkY+QFKP1d3AnmILQRJphin73dCJ2HxZPVmwLTkQVXBsBP/tZxvt68wWPqSw8yv
	 376PxIUQFZfQ2myJrSgeirXTQqn6DW7QgMq3bITo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 197/375] selftests: net: enable bind tests
Date: Tue, 10 Sep 2024 11:29:54 +0200
Message-ID: <20240910092629.120159720@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamie Bainbridge <jamie.bainbridge@gmail.com>

[ Upstream commit e4af74a53b7aa865e7fcc104630ebb7a9129b71f ]

bind_wildcard is compiled but not run, bind_timewait is not compiled.

These two tests complete in a very short time, use the test harness
properly, and seem reasonable to enable.

The author of the tests confirmed via email that these were
intended to be run.

Enable these two tests.

Fixes: 13715acf8ab5 ("selftest: Add test for bind() conflicts.")
Fixes: 2c042e8e54ef ("tcp: Add selftest for bind() and TIME_WAIT.")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/5a009b26cf5fb1ad1512d89c61b37e2fac702323.1725430322.git.jamie.bainbridge@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index d9393569d03a..ec5377ffda31 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,7 +84,8 @@ TEST_GEN_PROGS += so_incoming_cpu
 TEST_PROGS += sctp_vrf.sh
 TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += ip_local_port_range
-TEST_GEN_FILES += bind_wildcard
+TEST_GEN_PROGS += bind_wildcard
+TEST_GEN_PROGS += bind_timewait
 TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
-- 
2.43.0




