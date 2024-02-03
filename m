Return-Path: <stable+bounces-18671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16B78483A6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DEC28AC8F
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDEE55E56;
	Sat,  3 Feb 2024 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDwGEjN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A572BB0B;
	Sat,  3 Feb 2024 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933972; cv=none; b=cUMv45R+gXNVsU9T4KlkQcj9xLErkavPB5GXuLjxUaqic+Txp3meQkap192VuUWH2SwkkhqmUJJa50FZkuDhaN60JCrFHccGcaHZlFWWSSDSgTrhXH79DTuuzDn0Czjlp25ZQmngZ+C8c5/tP8Dyc21Jlg99Bu2xQgD2yM6fXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933972; c=relaxed/simple;
	bh=9vg+PDc/iQbfc5UnG+7poXZNGIZrpsIfSLuUkN0KDrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkiaNeS7L/fE6LAJfQTEeFImkojY+3uYo43MwRbL51IKcwkqhRfOshCAgyoeuqfUT8ZkO4LOrfSr8apEoFRAwiWCNVspb6wXWOJOH/XJ52mdd6xP23noyaQ49kBLKvrva5nBhrqRvHaPPCQsVy6+p+0C52c1KDrgN2lTGTWkkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDwGEjN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8555C43390;
	Sat,  3 Feb 2024 04:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933971;
	bh=9vg+PDc/iQbfc5UnG+7poXZNGIZrpsIfSLuUkN0KDrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDwGEjN1OkgBksVieyfB9d7/YywJw9b9zOFiYAXGzJshTeMKolH3jlKrjPa+3T+Ch
	 730kQdjY/u9PiOGrxPX9R95X0IYphnI+njsKnjiBItOPUW9GXg+P5GVWwI7BaYCIW6
	 fUnLPzg63sGoCnVTj65vDqGrYqrHDLiuoL2EvC1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 344/353] selftests: bonding: Check initial state
Date: Fri,  2 Feb 2024 20:07:42 -0800
Message-ID: <20240203035414.641006739@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Poirier <bpoirier@nvidia.com>

[ Upstream commit 8cc063ae1b3dbe416ce62a15d49af4c2314b45fe ]

The purpose of the test_LAG_cleanup() function is to check that some
hardware addresses are removed from underlying devices after they have been
unenslaved. The test function simply checks that those addresses are not
present at the end. However, if the addresses were never added to begin
with due to some error in device setup, the test function currently passes.
This is a false positive since in that situation the test did not actually
exercise the intended functionality.

Add a check that the expected addresses are indeed present after device
setup. This makes the test function more robust.

I noticed this problem when running the team/dev_addr_lists.sh test on a
system without support for dummy and ipv6:

tools/testing/selftests/drivers/net/team# ./dev_addr_lists.sh
Error: Unknown device type.
Error: Unknown device type.
This program is not intended to be run as root.
RTNETLINK answers: Operation not supported
TEST: team cleanup mode lacp                                        [ OK ]

Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Link: https://lore.kernel.org/r/20240131140848.360618-3-bpoirier@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/drivers/net/bonding/lag_lib.sh  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
index 2a268b17b61f..dbdd736a41d3 100644
--- a/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
+++ b/tools/testing/selftests/drivers/net/bonding/lag_lib.sh
@@ -48,6 +48,17 @@ test_LAG_cleanup()
 	ip link add mv0 link "$name" up address "$ucaddr" type macvlan
 	# Used to test dev->mc handling
 	ip address add "$addr6" dev "$name"
+
+	# Check that addresses were added as expected
+	(grep_bridge_fdb "$ucaddr" bridge fdb show dev dummy1 ||
+		grep_bridge_fdb "$ucaddr" bridge fdb show dev dummy2) >/dev/null
+	check_err $? "macvlan unicast address not found on a slave"
+
+	# mcaddr is added asynchronously by addrconf_dad_work(), use busywait
+	(busywait 10000 grep_bridge_fdb "$mcaddr" bridge fdb show dev dummy1 ||
+		grep_bridge_fdb "$mcaddr" bridge fdb show dev dummy2) >/dev/null
+	check_err $? "IPv6 solicited-node multicast mac address not found on a slave"
+
 	ip link set dev "$name" down
 	ip link del "$name"
 
-- 
2.43.0




