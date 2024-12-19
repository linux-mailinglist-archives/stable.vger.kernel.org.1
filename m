Return-Path: <stable+bounces-105294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08AC9F7AA1
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C571116F284
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F62248BE;
	Thu, 19 Dec 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJgR9Tx6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A61FC7E4;
	Thu, 19 Dec 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608751; cv=none; b=mkO92fs04s6Nn6ozgDL8u6GRjkKwAYYkfPTe7nHn8GEGCGYs0v+VpStMlApuZB7EGDtopqi/su32g5cAHuqGhcByAn+tnf12VFaIq6cEB++xFXBxApMUt7BpMQU2hiQiKSv3J8mqNHzGVgSvUVtfZjORymF5Y7bsC9ui2KwDsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608751; c=relaxed/simple;
	bh=aiSPkoyBjAXUDkzk8JUHVfdu5Q7meDKM18WsgqCRG9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4LgkjSqsr6tWktdw9rP9Otl2q5WTpVkhUYL/vIefJQAQrKqjphhxepCrVY8udRyQiPnI7lfn6lyNbki24mwLje+OXO3WQhWcF8LYkA+lEKPKQ1kbhXoXlMIXxHLV/g3R6fzqpzIhzpekzGcb/XfwkKfZm6QGInWE2/35Ex3n5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJgR9Tx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C77C4CEDE;
	Thu, 19 Dec 2024 11:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608751;
	bh=aiSPkoyBjAXUDkzk8JUHVfdu5Q7meDKM18WsgqCRG9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JJgR9Tx6JlOJDoo1od0cd2OlNdHttiSpT0sMrKOs43bN1aUh//OSbr4PdhfRY4MKt
	 Rs2Ar0bfEJ+Eu2s+qpGTL/sgzP8XFHb2O/PThRIer38iTar3TQwKzu4d9MXZFQnObo
	 fB//b6ib3T0p5zSybOncw+QP6i5yF+NvvmMi5wCjZQB280Q3iC/xbc0I0ypSevDUP8
	 ZRcDUwAwJ0Mrv9aHmWN3O+TuRyx/VYfjbjaQQLABeFSyJBU7YqNW3uvQiZ6JEy1cR6
	 Vj2zBCWfwA5TECcm+bII09YumHB2y9DCKiMURkelWRvHH6gmT4lKldxtoNl/PVaP1w
	 o2yz1q1tGMU+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 12:45:28 +0100
Subject: [PATCH net 2/3] netlink: specs: mptcp: clearly mention attributes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-2-825d3b45f27b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4438; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aiSPkoyBjAXUDkzk8JUHVfdu5Q7meDKM18WsgqCRG9c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZAdlCBfJAU3WbKdSZ1K4eoEHCPCgX18g2hWOy
 ldA1JSlc92JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2QHZQAKCRD2t4JPQmmg
 cy4sD/9nPcp+7EFYRLaDsAaFLARrPE8zefDq+QehJqA3KHLAguFqzle7eTLrx5bCO3zAs57K/zw
 l3v2Xtl6OSbiaR3zorWVYS5Cw412hp21ZdRMLmTTy4fxdCyoPWdjQoL8++WqJUEXBxLBmMCfSI0
 t28Y+AcpkMIWl5iQxW0CmuX/TS0iYxubvk1q6lmlwRAXvEx8ZYErcxjB1/eFnGGInexFRrwDwRT
 +TyRA8O4ghWnP0ShhdL2zOaJjEIx4CpRibYVH0iBsXhdDET10CKkvgPybigRLYiYANP5qkGd5j/
 RT1x/7V1Bc1ID0OHocrTvmh3neSn0YO8h9iO3hnlUJcO5N+1Vzp9TBHtd77Xg6FgDOqhurX8W+N
 gON6XGaPKABxs4IlNoUQLRdwoCG41sp1HeCKw+gD2BD1e22sTFdiL6iy0ANyJELQsyJ2/ypmYJn
 pUUfGpHX1xZQjeaHY+lutJTGaS/B27sdYyiQTL8KXqMFoKWxAou2rz2JB40SZ5gQk/0kG3tjIyL
 I5YKoN1n/b4XdL8Psoxo1NwvtuHkxRj3oEMdfYzAQBmD8jcoZP5m19tvVZuOELKxRh8Pp2YA+v1
 7NzCEfneJ98yzpGj485HfHvI1p5GwvO0xpfzZqMji6tA2Zei/WhoWrQrnWCUo29RIrx+2m3yQLz
 j6Bkm1u5eXfapRg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The rendered version of the MPTCP events [1] looked strange, because the
whole content of the 'doc' was displayed in the same block.

It was then not clear that the first words, not even ended by a period,
were the attributes that are defined when such events are emitted. These
attributes have now been moved to the end, prefixed by 'Attributes:' and
ended with a period. Note that '>-' has been added after 'doc:' to allow
':' in the text below.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Cc: stable@vger.kernel.org
Link: https://docs.kernel.org/networking/netlink_spec/mptcp_pm.html#event-type [1]
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index fc0603f51665a6260fb4dc78bc641c4175a8577e..59087a23056510dfb939b702e231b6e97ae042c7 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -22,67 +22,67 @@ definitions:
       doc: unused event
      -
       name: created
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
+      doc: >-
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
         MPTCP_EVENT_ESTABLISHED is sent.
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: established
-      doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
-        server-side
+      doc: >-
         A MPTCP connection is established (can start new subflows).
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
      -
       name: closed
-      doc:
-        token
+      doc: >-
         A MPTCP connection has stopped.
+        Attribute: token.
      -
       name: announced
       value: 6
-      doc:
-        token, rem_id, family, daddr4 | daddr6 [, dport]
+      doc: >-
         A new address has been announced by the peer.
+        Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
      -
       name: removed
-      doc:
-        token, rem_id
+      doc: >-
         An address has been lost by the peer.
+        Attributes: token, rem_id.
      -
       name: sub-established
       value: 10
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A new subflow has been established. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-closed
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: sub-priority
       value: 13
-      doc:
-        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, backup, if_idx [, error]
+      doc: >-
         The priority of a subflow has changed. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
+        daddr6, sport, dport, backup, if_idx [, error].
      -
       name: listener-created
       value: 15
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A new PM listener is created.
+        Attributes: family, sport, saddr4 | saddr6.
      -
       name: listener-closed
-      doc:
-        family, sport, saddr4 | saddr6
+      doc: >-
         A PM listener is closed.
+        Attributes: family, sport, saddr4 | saddr6.
 
 attribute-sets:
   -

-- 
2.47.1


