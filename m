Return-Path: <stable+bounces-135578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB39A98F17
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A8292041E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA532820C1;
	Wed, 23 Apr 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Terzpf6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B023281363;
	Wed, 23 Apr 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420292; cv=none; b=RdBvodjKPR8wc0OivpTupE8OAcRygyac0qWMrqaBOaedy7YNO506N2sqS4XcUaymiUd1n1IVK8fIR3nP+dbR7g2znHCHSxv2tfbrxZ0C5pgysGH58tPYKWUZHF+UMxCKjlQU1Q1U/1lSkdeeWJ6gHQBUWesJa3N6aY4QY+IWuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420292; c=relaxed/simple;
	bh=LKVC5/eg+DQOxYqw/KHAlISdIYnYd9XPB57BNjnlrUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFUUL2VGMM9Y+rbvlUcHpRjN+4roL5NCl1kWff7s4k1P5T7QIGbr5abBsT0dToSQIQ9Y0QYGXx91xBVnBzi+cGt5zkxs+daurLNrsgYg41fic2TwKSSPvZ1UVrb9EdIKBjgI5kj2VIc8Ba8ojXMpF588Vy/XRT2SjW90eOCLxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Terzpf6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2446C4CEE2;
	Wed, 23 Apr 2025 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420292;
	bh=LKVC5/eg+DQOxYqw/KHAlISdIYnYd9XPB57BNjnlrUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Terzpf6UltPZa+E3G1BR8EiaJcGDHt0rfWsvrquRHtwYdTIF5oggcszFTq0jYj4z1
	 YhaO3wDnoZYaEo3Cgsil5GEJmwdoQTuCyK7g7S6oUUWtF2BN6QBdvMdk7Q0Tmknzx1
	 QhEa49eYrGC0Urx+PXbBcaIZ1IKgjNBW3A/6FlMw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 067/241] netlink: specs: rt-link: add an attr layer around alt-ifname
Date: Wed, 23 Apr 2025 16:42:11 +0200
Message-ID: <20250423142623.337397597@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit acf4da17deada7f8b120e051aa6c9cac40dbd83b ]

alt-ifname attr is directly placed in requests (as an alternative
to ifname) but in responses its wrapped up in IFLA_PROP_LIST
and only there is may be multi-attr. See rtnl_fill_prop_list().

Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250414211851.602096-6-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/rt_link.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0d492500c7e57..1eab6aeaa2193 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1101,11 +1101,10 @@ attribute-sets:
       -
         name: prop-list
         type: nest
-        nested-attributes: link-attrs
+        nested-attributes: prop-list-link-attrs
       -
         name: alt-ifname
         type: string
-        multi-attr: true
       -
         name: perm-address
         type: binary
@@ -1148,6 +1147,13 @@ attribute-sets:
         name: max-pacing-offload-horizon
         type: uint
         doc: EDT offload horizon supported by the device (in nsec).
+  -
+    name: prop-list-link-attrs
+    subset-of: link-attrs
+    attributes:
+      -
+        name: alt-ifname
+        multi-attr: true
   -
     name: af-spec-attrs
     attributes:
@@ -2434,7 +2440,6 @@ operations:
             - min-mtu
             - max-mtu
             - prop-list
-            - alt-ifname
             - perm-address
             - proto-down-reason
             - parent-dev-name
-- 
2.39.5




