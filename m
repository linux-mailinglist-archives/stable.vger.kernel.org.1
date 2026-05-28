Return-Path: <stable+bounces-255827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBU/EXCoGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E35F9523
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97143117FD6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33272D9787;
	Thu, 28 May 2026 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dqAECwTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113DF1EA65;
	Thu, 28 May 2026 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999992; cv=none; b=ZpoMeFgaqhIizs/XgXUHWW0KqtPlWcVapWW8lXqHTsvImxvogwCh6hzAMIOzVV+kNCt1NIR0P661h84v1i3XjbZKVRfjCi3B487QUHyWoKJ57YrHUvKx8sSPOx9UgM4SmHT+CSoykNoQwAoNI01vS4qetj4rvwG90DtHE9d6ZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999992; c=relaxed/simple;
	bh=TbRVQiH2AiUbR0aqdDk0B+Ir6ltRo3nxUKDHbyGdz0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEYdu4xeLMVkRUDDG1ZWehKZU8iCIRkLlBJTTPc/49y6XDBybL7vTu7zvQdwoiZpTpAdn99hTFJwW27hK8JLncAFE0KT3v6heAKgLDtHcdk7LB3jAw/WZtLnNOwXTLCp7T0aPO5YcTXGp11krBOvxtzScDp2OwpGFFWWLg2JWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dqAECwTt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0B61F000E9;
	Thu, 28 May 2026 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999990;
	bh=t7RHw49AWXEn2GGoTxjG+ibOwK36pPc3pGuIo4A3Loo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqAECwTtEFOvClDUKMJ403xuKaDf+zpNobehSYnI/hAR5zOieXnSfStkaaOBfgJC7
	 kZOQ/oT9vzuwMlvwe2NjvdxLO4hjaIkR+jwsIAXvZdnHW754h0pTgdemWkxN3GrcGo
	 uNfpdO+9X+NDNhDyTbWmqqEvwakCfnA9CcM3pFgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 262/377] net: shaper: reject handle IDs exceeding internal bit-width
Date: Thu, 28 May 2026 21:48:20 +0200
Message-ID: <20260528194645.955822130@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255827-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DB3E35F9523
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8d5806c600fddb907ebe378f9c366d4b52ac3a39 ]

net_shaper_parse_handle() reads the user-supplied handle ID via
nla_get_u32(), accepting the full u32 range. However, the xarray key
is built by net_shaper_handle_to_index() using
FIELD_PREP(NET_SHAPER_ID_MASK, handle->id), where NET_SHAPER_ID_MASK
is GENMASK(25, 0) - only 26 bits wide. FIELD_PREP silently masks off
the upper bits at runtime. A user-supplied NODE id like 0x04000123
becomes id 0x123.

Additionally, a user-supplied id equal to NET_SHAPER_ID_UNSPEC
(0x03FFFFFF, which is NET_SHAPER_ID_MASK itself) would collide with
the sentinel used internally by the group operation to signal
"allocate a new NODE id".

Reject user-supplied IDs >= NET_SHAPER_ID_MASK (i.e., >= 0x03FFFFFF)
in the policy.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20260510192904.3987113-9-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/net_shaper.yaml | 7 +++++++
 net/shaper/shaper.c                         | 4 +++-
 net/shaper/shaper_nl_gen.c                  | 7 ++++++-
 net/shaper/shaper_nl_gen.h                  | 2 ++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 3f2ad772b64b1..de01f922040a5 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -33,6 +33,11 @@ doc: |
   @cap-get operation.
 
 definitions:
+  -
+    type: const
+    name: max-handle-id
+    value: 0x3fffffe
+    scope: kernel
   -
     type: enum
     name: scope
@@ -140,6 +145,8 @@ attribute-sets:
       -
         name: id
         type: u32
+        checks:
+          max: max-handle-id
         doc: |
           Numeric identifier of a shaper. The id semantic depends on
           the scope. For @queue scope it's the queue id and for @node
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 5338842122a2a..b2d85963243fa 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -21,6 +21,8 @@
 
 #define NET_SHAPER_ID_UNSPEC NET_SHAPER_ID_MASK
 
+static_assert(NET_SHAPER_ID_UNSPEC == NET_SHAPER_MAX_HANDLE_ID + 1);
+
 struct net_shaper_hierarchy {
 	struct xarray shapers;
 };
@@ -360,7 +362,7 @@ static int net_shaper_pre_insert(struct net_shaper_binding *binding,
 	    handle->id == NET_SHAPER_ID_UNSPEC) {
 		u32 min, max;
 
-		handle->id = NET_SHAPER_ID_MASK - 1;
+		handle->id = NET_SHAPER_MAX_HANDLE_ID;
 		max = net_shaper_handle_to_index(handle);
 		handle->id = 0;
 		min = net_shaper_handle_to_index(handle);
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index c52abf13ff0c9..16ab88f5eb7b4 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -10,10 +10,15 @@
 
 #include <uapi/linux/net_shaper.h>
 
+/* Integer value ranges */
+static const struct netlink_range_validation net_shaper_a_handle_id_range = {
+	.max	= NET_SHAPER_MAX_HANDLE_ID,
+};
+
 /* Common nested types */
 const struct nla_policy net_shaper_handle_nl_policy[NET_SHAPER_A_HANDLE_ID + 1] = {
 	[NET_SHAPER_A_HANDLE_SCOPE] = NLA_POLICY_MAX(NLA_U32, 3),
-	[NET_SHAPER_A_HANDLE_ID] = { .type = NLA_U32, },
+	[NET_SHAPER_A_HANDLE_ID] = NLA_POLICY_FULL_RANGE(NLA_U32, &net_shaper_a_handle_id_range),
 };
 
 const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGHT + 1] = {
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index 1e20eebdedd71..3e5e7342ffbbc 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -11,6 +11,8 @@
 
 #include <uapi/linux/net_shaper.h>
 
+#define NET_SHAPER_MAX_HANDLE_ID	67108862
+
 /* Common nested types */
 extern const struct nla_policy net_shaper_handle_nl_policy[NET_SHAPER_A_HANDLE_ID + 1];
 extern const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGHT + 1];
-- 
2.53.0




