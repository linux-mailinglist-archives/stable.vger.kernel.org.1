Return-Path: <stable+bounces-95054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D59D72A1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278D5284FA0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C94201256;
	Sun, 24 Nov 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLfD7txI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3311991CD;
	Sun, 24 Nov 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455824; cv=none; b=qCG+KxIe3B5mjFIkdVvfd6ddTJ1Xg1orTl6likuVDOyllXrFSukBYmMpnPIcNmhbDnz1aAGoQVoq9tEDu7cfgQ1sqMU5K/Q+/x1hvnvx0ZBQavVpCg+ewamypya89X9OdPpWaIW2lHaRJD7KGhIp5Dqbn4JZXw0RyQ2MxqCKHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455824; c=relaxed/simple;
	bh=bzb2TBt1W/ozaEIEoBDYJUxkHrtoOt8XHyvRmkMDDec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clJF7wAyeJRhtssdnPaN4IGrNLNbhN95JuKQtEyvCdvxqoCqHqzqqF81Na1JfqgTy2QVW3CtmY79swNof358ozkhXErleDjTDAZ1cC6RFS3+OQxmdDUrVn5bM1GPmPNmh2hDgd5VmvLdu16hf5tJMoIzMTbLowWRCkOQ9kA3wmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLfD7txI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A0C4CECC;
	Sun, 24 Nov 2024 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455824;
	bh=bzb2TBt1W/ozaEIEoBDYJUxkHrtoOt8XHyvRmkMDDec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLfD7txIYqKnzgubn8Zp0OKp5fcX2f+mZVcCtdBRXxldFq2DaRqtHxi4GZvxvswd+
	 O6SDvQ3y/HjEBLA61ktRyHxX2hf6wJV7IpgPJpg/YWcXpG9DN4ZAFj1kA5aZdVqhTm
	 HXY58amjfCOEXNcz8JRZ3Dl8R5IgCgI8dTg+Gh1exe8fLM1iE4NnHPxM71rMfPJang
	 mbAMHF9wuKpF84Thz4nFVwx0UfZLtLUhWKnBGPtgVfmdv8yHQPeQ4bxjjMUE8jZ/ao
	 wmY5BRwxHw7FsXPxjF2QFpnyaBkhb9RzuJZ1He234UDJX1XefhN48CKfs11RkAMew4
	 zVE4+ke+N9R8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 51/87] netlink: specs: Add missing bitset attrs to ethtool spec
Date: Sun, 24 Nov 2024 08:38:29 -0500
Message-ID: <20241124134102.3344326-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index ea21fe135b97e..c6cfa1665d5b0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -88,7 +88,12 @@ attribute-sets:
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


