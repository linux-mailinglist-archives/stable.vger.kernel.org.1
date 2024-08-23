Return-Path: <stable+bounces-69994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC095CEEF
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C4A288569
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CF41946C2;
	Fri, 23 Aug 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbD2Xp4+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE1188904;
	Fri, 23 Aug 2024 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421797; cv=none; b=nidHEoeiDeWv+JLYGqVzRdA5NtB5IMZvlKLZPr6lRfo7mRRJlspHajtaVmom6q15ExzdgRE+jiKLTFJ3764TkWBX9OkBwVh85bZRFlGbAxPhhzO+/n/l0WTavSwz/EQBoFvwrnrr8fDweKb5HMy1ul3PwSgROT4gLIerX9tBSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421797; c=relaxed/simple;
	bh=yyLRPc7BWlh0n3nzjsmQdJGceCFz05ihd1PqC5TEijI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEASgHLbG1SvxjMfRIepwfA/MFzJGpQtlMSyUjNen/V5UW/P/GWft3H4RHNbTCQoCxMnmEFjaUqBnsKGXX9F25e6DaCu5M2Y44RC0HgDkomFuX/wOZTfduKqk6LmkS1B1/JJIO8azNeDDZmg5cr9rIrQvzWMTHamRf7sK203DvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbD2Xp4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A1DC4AF09;
	Fri, 23 Aug 2024 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421796;
	bh=yyLRPc7BWlh0n3nzjsmQdJGceCFz05ihd1PqC5TEijI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbD2Xp4+LsqnnF/v6JiiSDZXzxRToQhZpcI1fJZyf6+jMjRgMGYPxPvQAe/H09vC6
	 4n0c7l+aVCToQ74HitD47sZTnSXF0gJCiJeX5I3RwVOBjVJ31oEkVMPI0cxhLoCX0G
	 Q4S0oHLJavVURlIoHHhFcqmekE/VIySpRDkRqUV/Pkvrj00jLrOAVUSNlT7GdV55Nn
	 UYNmkeBSsNAlmWGz3ftn/sWEHAsLnHyqUCm7cmr2V7PcLmbTo26ae+IlX4+eBRNdUy
	 2UhOGTqFdAlLnR2DuH5x5mtjtUkC2AIGiHojz4ixGrYdYMsIN+MwJLq2jGoSF3xTn1
	 nyT9v9hOd8rFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Foster Snowhill <forst@pen.gy>,
	Georgi Valkov <gvalkov@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/20] usbnet: ipheth: race between ipheth_close and error handling
Date: Fri, 23 Aug 2024 10:02:17 -0400
Message-ID: <20240823140309.1974696-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit e5876b088ba03a62124266fa20d00e65533c7269 ]

ipheth_sndbulk_callback() can submit carrier_work
as a part of its error handling. That means that
the driver must make sure that the work is cancelled
after it has made sure that no more URB can terminate
with an error condition.

Hence the order of actions in ipheth_close() needs
to be inverted.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Foster Snowhill <forst@pen.gy>
Tested-by: Georgi Valkov <gvalkov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ipheth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 687d70cfc5563..6eeef10edadad 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -475,8 +475,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
-- 
2.43.0


