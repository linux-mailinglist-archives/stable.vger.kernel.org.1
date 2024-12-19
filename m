Return-Path: <stable+bounces-105295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BEE9F7AA3
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D528D18953F0
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63089224B0C;
	Thu, 19 Dec 2024 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTakhQcu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BE224B03;
	Thu, 19 Dec 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608755; cv=none; b=aofaKv/7St7UrESLkaB6oOF1JjN/5NZldBkO3so9uRGPHCYMWCQOXoM5wsVxx/qS8L6VpulH7kmhBO/p9Ap/8e0rydGBOgJo8QQzwMzfNVrPHGxuv8163RIW+BGGDlENZ4YELqrBeMy+8W4lj6GP06FpkSMyS/gD4lIv2iq2+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608755; c=relaxed/simple;
	bh=ryauDGaV2QHx9bvaKw23915p8KRYzK7ghEvxtEuqeVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L96gBFbVcoPknC+W12ia1wtV34puiPtj0etnkxO1O1VRaBovgiZPqbYEDmvxnXrFyukL0tZxRqMtvrAU5fmrZiKVQ4j8atrYcOBBHDCRgy2NwbnvcHpzLa1v8Q0DGGw9JUIsxSwexJ+MrNQg0npB9uft9ZFf7grGcfAeiFEIJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTakhQcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2397C4CECE;
	Thu, 19 Dec 2024 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608754;
	bh=ryauDGaV2QHx9bvaKw23915p8KRYzK7ghEvxtEuqeVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FTakhQcuXVIcAfb7YSnh1oSxVg4mNdSZuiKxYjqKOh9e6N+krS80zq1jrHJrfGL31
	 7taezG7624oRU3jTlTRzue+hiluGcAm3NJqFNEqXZ2eTf+XzxqcPBPWPhKnol4Oilb
	 bIElwSnCTpX96o3pT2azCW0RY7LRDGDUSPqQUmFC9qxuyboVfREac2j+j3o1EtJ6Zk
	 2ry4w8hDYU+mcgb0H5chh8gE2ZOM7NVwgpMQd7KIeMrpDl8mtgMvHcIL83IyUWIn8j
	 hbtuJe8xzjN9RAxJI9+O8ZON/97uql7bCZnnThmm/PDbrxAxGrmZzqZU/dpgV3vp+z
	 wihcfRRCRS8FA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 12:45:29 +0100
Subject: [PATCH net 3/3] netlink: specs: mptcp: fix missing doc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-3-825d3b45f27b@kernel.org>
References: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
In-Reply-To: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kishen Maloor <kishen.maloor@intel.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ryauDGaV2QHx9bvaKw23915p8KRYzK7ghEvxtEuqeVs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZAdlzuGXzA3A6/O1SLyvTrLBmTTpkRX/zu2sc
 CR+BFyISraJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2QHZQAKCRD2t4JPQmmg
 c3+rD/9rVcEyFP0Ktq5YY/84fhUL3T0aWD/ASYqjrP7likvyMhmCUQ9owuywqB2Br0AwbB+pKZy
 dtc//ZWPjQEH5M2bBh3neR5iuRwYq9BNe5kO2FwLGEFL88wLdbJPHqbRrTHeZWQtKg+vCOufUvO
 ATPImKIGu7HYplkaNL6ZybBWSs3vYyQ7MgdgV2NPf8Vi+3z3lakdrdxBKb7HkGbSIRuQysUrj4G
 Y1scL6twCmTajRjo5TVcu0suaSa/k+fWmvHNvq3BmmlP1Bkc1Nd5sswwVU5Fto9+zDFMRfvF3QW
 /OXb3u+pkDQgxb//WUVkkOUsGMuUahCYvOVTx+Qsq4b5kMUL/R8ef8USZASAGZhcQ6u0/sowoEn
 Ye6yuVJ784OHN1B5EsDH64IWHcDaoDD087X1gMP98un18QjBfP0ZLMLmYv9ElURAHkiwfOR4q+q
 Xv2GzpywGJjD0JRVdlyJ/zvxB+aLBaujYItbGw5mm4BcASmvj0lGYlbM3FiOQ2oac+SRj+D//Z2
 BDZSHYPYy4ou9ODdYR8jLQFkK6QiO2Qr8lRX6VQMehSW+9OF4uCuiuVfjcsV9XpIfceeGzucL+6
 MlevL948W9sudHl6olk+biOVICmMdOhoD2WfXXklwsZkuICCi3ocOZVJo/XwQla6UCQ6Tj1SOiq
 XAnYKZ+UwYaSCfA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Two operations didn't have a small description. It looks like something
that has been missed in the original commit introducing this file.

Replace the two "todo" by a small and simple description: Create/Destroy
subflow.

While at it, also uniform the capital letters, avoid double spaces, and
fix the "announce" event description: a new "address" has been
announced, not a new "subflow".

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 59087a23056510dfb939b702e231b6e97ae042c7..dfd017780d2f942eefd6e5ab0f1edd3fba653172 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -308,8 +308,8 @@ operations:
          attributes:
            - addr
     -
-      name:  flush-addrs
-      doc: flush addresses
+      name: flush-addrs
+      doc: Flush addresses
       attribute-set: endpoint
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -353,7 +353,7 @@ operations:
             - addr-remote
     -
       name: announce
-      doc: announce new sf
+      doc: Announce new address
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -364,7 +364,7 @@ operations:
             - token
     -
       name: remove
-      doc: announce removal
+      doc: Announce removal
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -375,7 +375,7 @@ operations:
            - loc-id
     -
       name: subflow-create
-      doc: todo
+      doc: Create subflow
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]
@@ -387,7 +387,7 @@ operations:
             - addr-remote
     -
       name: subflow-destroy
-      doc: todo
+      doc: Destroy subflow
       attribute-set: attr
       dont-validate: [ strict ]
       flags: [ uns-admin-perm ]

-- 
2.47.1


