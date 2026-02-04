Return-Path: <stable+bounces-213437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F4jLg9cg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E6E75C3
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E4423042088
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B028B7EA;
	Wed,  4 Feb 2026 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bztQFC48"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40238280CD2;
	Wed,  4 Feb 2026 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216335; cv=none; b=HR56iXxFDpuiqAoWTlswknazyz6vbYL0yOKPTaduHsXk6Ir2rSbTjkubqjoxh3NJftvVayOFPZhZK3cIiaqSDFJnwL9xMTqFLJZVG2jdO1us8mkcQF3cOi7xKcTTwJ5JjstplENED+Q64/AnZWRcxdkEeEyZ2dvPh2CQhmx69iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216335; c=relaxed/simple;
	bh=btn/EdilN7LJTAvNR6GM/6WTftNDxKYNO7JACDrvWiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPfhlueIwO2q4Cmt90EU6E0BN//rg/Zz25WXKVdcoelFL9NEySDu/tDHyqxOCGQs7iYRVLXBZYFoAQcyHvNeJod5v6h1WGYp0uAqZUBm0HUppzqgFF9iyalMFypnPIMcIgLNSPHE7tnR/1G3C47lescwDWX68qoNVNBOcNlKtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bztQFC48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D62C116C6;
	Wed,  4 Feb 2026 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216335;
	bh=btn/EdilN7LJTAvNR6GM/6WTftNDxKYNO7JACDrvWiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bztQFC483obUygXamtmwxz1SyHEQ/t0McoCgmSlxUXcCxI2RKwa+sTTGVkzyYLfHi
	 VQTbpU1m0bfFkTp939UAUi71bpD43tkqLhjw78Xxw9kF0KZ8VVqGMx+gyR6TgpYqzx
	 hvk1fOP3XYXJAQAVUU32Bow9Ryr99+SMqJqGAdL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislav Fomichev <sdf@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 056/161] netlink: add a proto specification for FOU
Date: Wed,  4 Feb 2026 15:38:39 +0100
Message-ID: <20260204143853.777831697@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213437-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 181E6E75C3
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 4eb77b4ecd3c5eaab83adf76e67e0a7ed2a24418 ]

FOU has a reasonably modern Genetlink family. Add a spec.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 7a9bc9e3f423 ("fou: Don't allow 0 for FOU_ATTR_IPPROTO.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/fou.yaml | 128 +++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/netlink/specs/fou.yaml

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
new file mode 100644
index 0000000000000..266c386eedf3a
--- /dev/null
+++ b/Documentation/netlink/specs/fou.yaml
@@ -0,0 +1,128 @@
+name: fou
+
+protocol: genetlink-legacy
+
+doc: |
+  Foo-over-UDP.
+
+c-family-name: fou-genl-name
+c-version-name: fou-genl-version
+max-by-define: true
+kernel-policy: global
+
+definitions:
+  -
+    type: enum
+    name: encap_type
+    name-prefix: fou-encap-
+    enum-name:
+    entries: [ unspec, direct, gue ]
+
+attribute-sets:
+  -
+    name: fou
+    name-prefix: fou-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
+      -
+        name: af
+        type: u8
+      -
+        name: ipproto
+        type: u8
+      -
+        name: type
+        type: u8
+      -
+        name: remcsum_nopartial
+        type: flag
+      -
+        name: local_v4
+        type: u32
+      -
+        name: local_v6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: peer_v4
+        type: u32
+      -
+        name: peer_v6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: peer_port
+        type: u16
+        byte-order: big-endian
+      -
+        name: ifindex
+        type: s32
+
+operations:
+  list:
+    -
+      name: unspec
+      doc: unused
+
+    -
+      name: add
+      doc: Add port.
+      attribute-set: fou
+
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request: &all_attrs
+          attributes:
+            - port
+            - ipproto
+            - type
+            - remcsum_nopartial
+            - local_v4
+            - peer_v4
+            - local_v6
+            - peer_v6
+            - peer_port
+            - ifindex
+
+    -
+      name: del
+      doc: Delete port.
+      attribute-set: fou
+
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request:  &select_attrs
+          attributes:
+          - af
+          - ifindex
+          - port
+          - peer_port
+          - local_v4
+          - peer_v4
+          - local_v6
+          - peer_v6
+
+    -
+      name: get
+      doc: Get tunnel info.
+      attribute-set: fou
+      dont-validate: [ strict, dump ]
+
+      do:
+        request: *select_attrs
+        reply: *all_attrs
+
+      dump:
+        reply: *all_attrs
-- 
2.51.0




