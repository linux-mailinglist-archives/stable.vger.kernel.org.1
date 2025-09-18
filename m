Return-Path: <stable+bounces-168979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955ABB2379C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FEE624DBA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F542D3230;
	Tue, 12 Aug 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q9+FgcI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2226FA77;
	Tue, 12 Aug 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025973; cv=none; b=N1gBNtk2b49wY+bAqqpcrahEEdiv7UTcayXZgC7D3FAXhYCVcDjabT68fYE8LBfUaQfIQJmBWS9D0W1uO75L1Z4i8nOCtffcmLBTEAmXU5nF7OKCO68aP3OMXdG/OAmX7+8PnCGLFzABFsuIiTCO2KFpO0X3hB5xS/gtVK8K1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025973; c=relaxed/simple;
	bh=Lwz5UiwE+kdXg0wYox6870LIqKD3XcDTGNEezJ2sKzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAZuZYA5rsfoP+i7y7vBdTsTmJZHJB9gO54BhEd7XXWqjh3X9je9pCbeygZfo/fwKyZa1plwjpKLwYuzMQkv9vRdWdg/iGVyRvU9gDXZt1PTZZUTfLyGSk8TEfN9xQzz7QudUFnQN2PQ0FmqavF1KRU4WPOhcZVqee3YY7r/2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q9+FgcI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD9C4CEF0;
	Tue, 12 Aug 2025 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025973;
	bh=Lwz5UiwE+kdXg0wYox6870LIqKD3XcDTGNEezJ2sKzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9+FgcI/3Wf27H6Eu7wdVH8QmXOgIrOL8n1Csdh+YVElybeF+DnjJCJzJjFLoFEdt
	 4qd0sk0iRAAb00ssSrw/7UqrN4aziHMzG3dgrIC1yNrSaD3aMsWqWUXwEe0+hMxyzC
	 0bi+Rle0nkTgmtnhe5gP1b0RLknoWOKbzG8sygdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 200/480] selftests: drv-net: tso: fix non-tunneled tso6 test case name
Date: Tue, 12 Aug 2025 19:46:48 +0200
Message-ID: <20250812174405.731376367@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Zahka <daniel.zahka@gmail.com>

[ Upstream commit b25b44cd178cc54277f2dc0ff3b3d5a37ae4b26b ]

The non-tunneled tso6 test case was showing up as:
ok 8 tso.ipv4

This is because of the way test_builder() uses the inner_ipver arg in
test naming, and how test_info is iterated over in main(). Given that
some tunnels not supported yet, e.g. ipip or sit, only support ipv4 or
ipv6 as the inner network protocol, I think the best fix here is to
call test_builder() in separate branches for tunneled and non-tunneled
tests, and to make supported inner l3 types an explicit attribute of
tunnel test cases.

  # Detected qstat for LSO wire-packets
  TAP version 13
  1..14
  ok 1 tso.ipv4
  # Testing with mangleid enabled
  ok 2 tso.vxlan4_ipv4
  ok 3 tso.vxlan4_ipv6
  # Testing with mangleid enabled
  ok 4 tso.vxlan_csum4_ipv4
  ok 5 tso.vxlan_csum4_ipv6
  # Testing with mangleid enabled
  ok 6 tso.gre4_ipv4
  ok 7 tso.gre4_ipv6
  ok 8 tso.ipv6
  # Testing with mangleid enabled
  ok 9 tso.vxlan6_ipv4
  ok 10 tso.vxlan6_ipv6
  # Testing with mangleid enabled
  ok 11 tso.vxlan_csum6_ipv4
  ok 12 tso.vxlan_csum6_ipv6
  # Testing with mangleid enabled
  ok 13 tso.gre6_ipv4
  ok 14 tso.gre6_ipv6
  # Totals: pass:14 fail:0 xfail:0 xpass:0 skip:0 error:0

Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Link: https://patch.msgid.link/20250723184740.4075410-4-daniel.zahka@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/tso.py | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index 6461a83b3d0e..5fddb5056a20 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -227,14 +227,14 @@ def main() -> None:
         query_nic_features(cfg)
 
         test_info = (
-            # name,       v4/v6  ethtool_feature              tun:(type,     args)
-            ("",            "4", "tx-tcp-segmentation",           None),
-            ("",            "6", "tx-tcp6-segmentation",          None),
-            ("vxlan",       "4", "tx-udp_tnl-segmentation",       ("vxlan",  "id 100 dstport 4789 noudpcsum")),
-            ("vxlan",       "6", "tx-udp_tnl-segmentation",       ("vxlan",  "id 100 dstport 4789 udp6zerocsumtx udp6zerocsumrx")),
-            ("vxlan_csum",   "", "tx-udp_tnl-csum-segmentation",  ("vxlan",  "id 100 dstport 4789 udpcsum")),
-            ("gre",         "4", "tx-gre-segmentation",           ("gre",    "")),
-            ("gre",         "6", "tx-gre-segmentation",           ("ip6gre", "")),
+            # name,       v4/v6  ethtool_feature               tun:(type, args, inner ip versions)
+            ("",           "4", "tx-tcp-segmentation",         None),
+            ("",           "6", "tx-tcp6-segmentation",        None),
+            ("vxlan",      "4", "tx-udp_tnl-segmentation",     ("vxlan", "id 100 dstport 4789 noudpcsum", ("4", "6"))),
+            ("vxlan",      "6", "tx-udp_tnl-segmentation",     ("vxlan", "id 100 dstport 4789 udp6zerocsumtx udp6zerocsumrx", ("4", "6"))),
+            ("vxlan_csum", "", "tx-udp_tnl-csum-segmentation", ("vxlan", "id 100 dstport 4789 udpcsum", ("4", "6"))),
+            ("gre",        "4", "tx-gre-segmentation",         ("gre",   "", ("4", "6"))),
+            ("gre",        "6", "tx-gre-segmentation",         ("ip6gre","", ("4", "6"))),
         )
 
         cases = []
@@ -244,11 +244,13 @@ def main() -> None:
                 if info[1] and outer_ipver != info[1]:
                     continue
 
-                cases.append(test_builder(info[0], cfg, outer_ipver, info[2],
-                                          tun=info[3], inner_ipver="4"))
                 if info[3]:
-                    cases.append(test_builder(info[0], cfg, outer_ipver, info[2],
-                                              tun=info[3], inner_ipver="6"))
+                    cases += [
+                        test_builder(info[0], cfg, outer_ipver, info[2], info[3], inner_ipver)
+                        for inner_ipver in info[3][2]
+                    ]
+                else:
+                    cases.append(test_builder(info[0], cfg, outer_ipver, info[2], None, outer_ipver))
 
         ksft_run(cases=cases, args=(cfg, ))
     ksft_exit()
-- 
2.39.5




