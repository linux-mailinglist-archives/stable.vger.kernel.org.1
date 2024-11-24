Return-Path: <stable+bounces-95125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAAA9D74DD
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A446FBE72B2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA821D599;
	Sun, 24 Nov 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/E/DIoD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13721D594;
	Sun, 24 Nov 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456083; cv=none; b=tctLy20fR3v1oIkr6vcJIMlxMWQghD1r42fNZAaBCOX9i+B3Wn84ZBoVeAUN4hDrR4xXJCgUBoua4bUQdYvj3WLk/Gi9hKs0vbKVKxWjSiNYf6swTUvcBCq+rLDLYU/E8lteinQ6RwGRsgP9Yh63id2MsgNTZ2Vfvw6QKiwn5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456083; c=relaxed/simple;
	bh=BBG73lx73I8C416X3gWvgY92RRrVoHpysx3AFG2SZhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkGCwBbRls/r+iPEZRFyAimKtvkqoM9uInBkYsmBPdhUrW4qr+pXjCxp8jjZB1xJAwtBEUXrbo98RteWGDLLMgqxLcxvm771G3baNaHEtwW+PQgABO+Tp0m9iNw2nQ7qIo8hRD3Kq5/bMsS2fpQ/x8LG29+a1/5UD2VZujbzqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/E/DIoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0B8C4CECC;
	Sun, 24 Nov 2024 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456083;
	bh=BBG73lx73I8C416X3gWvgY92RRrVoHpysx3AFG2SZhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/E/DIoDVM+C/2/7NR+/VOBMAHNHmbaec0wX8WJmawSk26Dv+4HnfN32DR7QoPYT9
	 EntpPpFsBCZrmTlbhtIgnKR2xCMvpjevlJRkvZpJwelUxmDXUOLigjJ8Vlhv8xgDmV
	 uQbs4PgerhKVoKfRoG/EpSYz6KHYS0kDour64FiZNxriy9Ym/GcVPBteFTXjgPuHAa
	 wMwz/co1+wPRnQCMf2bm4MmkeWE0q9LXje9a3ZVDu53U2lS9JxLGne6KPc7pOSEEGy
	 z1cZflNe6tjcuda6+7sFp3KieMcx8mAjd+PmjY7IRbU6YqIYR7kclQGzCCZjAKA5AL
	 LJT7ee102i6Cw==
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
Subject: [PATCH AUTOSEL 6.6 35/61] netlink: specs: Add missing bitset attrs to ethtool spec
Date: Sun, 24 Nov 2024 08:45:10 -0500
Message-ID: <20241124134637.3346391-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 837b565577ca6..3e38f69567939 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -64,7 +64,12 @@ attribute-sets:
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


