Return-Path: <stable+bounces-95208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161AD9D7432
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC0D167435
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69323B57D;
	Sun, 24 Nov 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzhIvx1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA7C23B576;
	Sun, 24 Nov 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456357; cv=none; b=op94iaBLYiig0L2oW6rI1mHnRSj/qDYu+V6V/4M4FUYP+HcaLrtEpyEv57riTNfq4RZdtLTXSQBdnR52LhokwAGnrIynYZjxNtL/sDjnIWOQLOlSvX9qva+kDI3CQWXY1nZIkjhIyVFQOIyW2UsmR0JguhuFg6s1s+fasnj2l/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456357; c=relaxed/simple;
	bh=ipkFevY1MfQBNTOgrt4MBIXh/391alCnzqOLL4k8CIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS6hp9nOciQDE7HHLRmTfwexw+9HKSE6c/5b/xaS2xdJxlvLl+Wx0gDsBCSBGG5pl8EuVbB/h2ls97TtkHojMQIZ6WKe7Aog1gudCDPnoi8NgsURH2RO04RWBVBivNYg1KUusiANPbFpX0bNWQn+zgHsBw/R/VMpyt5UCvJ+4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzhIvx1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AF2C4CECC;
	Sun, 24 Nov 2024 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456357;
	bh=ipkFevY1MfQBNTOgrt4MBIXh/391alCnzqOLL4k8CIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pzhIvx1V5KJMVIPSQMcby+s13FLCdsfu+KQ7ZTDAzQmHiSp/1ZEli7mSOZPSedbgo
	 G0nX5Ulilgpy53jRy3qklmKLJfHoIVLjFajn4Pv0WF2HPO1wjZCVfd9aiEBTBRJldk
	 2WmafB4M25sMps82DyeWXBBUPL1H7T0xSpHhkUOt/mnqAjsI+3cbtUXNdIz96/vlSx
	 JntmuHMF9lPnDZ3HxWejvoravL5nUuRlnRUcKhG9PGAbZ2AIR2SnzkVtuiyn1biwxj
	 IyvVPeqQrChxqB2Ns/HTcdJt6PKP/vBd9VYEwosN2cyu5WgesAGGnZNgU3UHDCnsNS
	 yPm6FVdgrhACw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Elena Salomatkina <esalomatkina@ispras.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/36] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
Date: Sun, 24 Nov 2024 08:51:23 -0500
Message-ID: <20241124135219.3349183-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Elena Salomatkina <esalomatkina@ispras.ru>

[ Upstream commit 397006ba5d918f9b74e734867e8fddbc36dc2282 ]

The subsequent calculation of port_rate = speed * 1000 * BYTES_PER_KBIT,
where the BYTES_PER_KBIT is of type LL, may cause an overflow.
At least when speed = SPEED_20000, the expression to the left of port_rate
will be greater than INT_MAX.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
Link: https://patch.msgid.link/20241013124529.1043-1-esalomatkina@ispras.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 459cc240eda9c..e0ced550808a5 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -310,7 +310,7 @@ static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 {
 	struct ethtool_link_ksettings ecmd;
 	int speed = SPEED_10;
-	int port_rate;
+	s64 port_rate;
 	int err;
 
 	err = __ethtool_get_link_ksettings(dev, &ecmd);
-- 
2.43.0


