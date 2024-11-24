Return-Path: <stable+bounces-94959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C29D7633
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCF0B28C66
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE671E0DE1;
	Sun, 24 Nov 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c557snMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620011AC8B9;
	Sun, 24 Nov 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455406; cv=none; b=THRorerHGGXP/i9LoIyi/qeo+PClk7q334fKjsdyLFhxGn3NpJLcp0uLzvmbjQHVFkdaOfyuiorB5JSiZ2aI2HxvwNf2zEen2lYQy9afKAcjAqpbBhXaxnnGQUFUYXMlDm/+4M3M4tw90oyvC3tSY2ngvF5XiJlYA+mopAJlC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455406; c=relaxed/simple;
	bh=TxhgsVvjnLFh5Euf09Tu3XyJmT4dP/vKwrUU9mwUEXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4Hg6wi3LmMtx8XPRTM4wJmC+yMLIcyXBxNEDSe/fbP1jSxMlZNvdpEWRLdIgOjZcnvO57MwE0zcQDRRkczeQx66IEVjEYyehXcn435dtSb2ShD6N00Ht1VEoSY+iTS9mCQT7mIuPdF3M2Ta8PrGvFOS+MM796NYWdxJA971CZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c557snMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6659CC4CECC;
	Sun, 24 Nov 2024 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455405;
	bh=TxhgsVvjnLFh5Euf09Tu3XyJmT4dP/vKwrUU9mwUEXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c557snMQte3mbNzcHbxKiLBc0G7ClY4dbClk2eiOToPiejeMOr8DqlTuK1+tO90US
	 SwTZBehwxhYbddE3mpp2tbvg1Jz+yyhXo5kJmfnpUtM8tncQ3Ha9o7tgOGs+asMotE
	 VRO7YhDjEjljNgoK58d474UqSemllrGzV4VVCEILlFScWYm5k6Zw2rTKnJSKT/kgWr
	 T08FLGeKY57/N6XXXI7yWJiz2Aq7F13GXl71MSPQ3oUxkd6urBgXFk0OMFjUvue/JN
	 Jql4F/g/WziT6/3pIiW+IKlKx6EzJDDsFr4S/sxqAXn+DYLkwgGTjhpSOcj0rx2kXk
	 CJWNnUmywZ+nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 063/107] netlink: specs: Add missing bitset attrs to ethtool spec
Date: Sun, 24 Nov 2024 08:29:23 -0500
Message-ID: <20241124133301.3341829-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Donald Hunter <donald.hunter@gmail.com>

[ Upstream commit b0b3683419b45e2971b6d413c506cb818b268d35 ]

There are a couple of attributes missing from the 'bitset' attribute-set
in the ethtool netlink spec. Add them to the spec.

Reported-by: Kory Maincent <kory.maincent@bootlin.com>
Closes: https://lore.kernel.org/netdev/20241017180551.1259bf5c@kmaincent-XPS-13-7390/
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Tested-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/20241018090630.22212-1-donald.hunter@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a050d755b9cb..f6c5d8214c7e9 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -96,7 +96,12 @@ attribute-sets:
         name: bits
         type: nest
         nested-attributes: bitset-bits
-
+      -
+        name: value
+        type: binary
+      -
+        name: mask
+        type: binary
   -
     name: string
     attributes:
-- 
2.43.0


