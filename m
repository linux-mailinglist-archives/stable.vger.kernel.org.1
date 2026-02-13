Return-Path: <stable+bounces-216274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFTGGJNVj2lqQQEAu9opvQ
	(envelope-from <stable+bounces-216274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:47:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D71385CF
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E6030214FD
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C93644D5;
	Fri, 13 Feb 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiunHIeo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69E364E81
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001111; cv=none; b=kSwFFw80NQG+4y0+hT0oM/Tu5VJN/yaNuDGxA4z2DCobs6WpMYPmcXkZEFiXNiz+mq2Uh9BPnLffu5G7kfxOGp2AZk/IP12FywNpp4Jcxjr7xzb59zEZBB+lerb1pAq1+vaJXE4dt3a/eDxUUYvgj5CTo0ev2GTC1dot5bXn5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001111; c=relaxed/simple;
	bh=3E5OGV+coCFstCmfjqW6tP+TWd03GJGSL1Y/uWekpk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idzfzLjAS5hs6v5xmQNn/t7nZGSgmoy/7PJi/XEG4aQ+JUZU76j/R/qqalCVhl1r1QwDistEhFNXdQx5Joj9oNgXaXI16co3Ez/BnFC/eQyjgweqfZiKv2Bbe1PVgTFkcILzLTJKNgHsdT32hQtWh5xhSoC7Kxg545t3k51EyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiunHIeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9560AC116C6;
	Fri, 13 Feb 2026 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771001111;
	bh=3E5OGV+coCFstCmfjqW6tP+TWd03GJGSL1Y/uWekpk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiunHIeoHqCcVw4n30QDSSdS0C84X4xdHxpHTIjpfcsxqcc9qWJ1iLx43B3oJ/oVy
	 SKZxyKNAJXYSSr8TFIew7TG1CsUGBxh/9VjWWJ4lt4YLwdFCrwAUTBNCmvbO1MU2BF
	 GT8L8B/EZGFw4cojG3LLn9S2Mmgr5Q92tzwU+0e4B6CQwroEQt9goIPPoo/nmY52AW
	 hPjRjI3+Dmu+6JXYJWRGbq64MZGYEuy4YLSdrHtcfM/89BwPKcKG4C9M94oE/601s6
	 zzs9QhWBifu9lTMPBYl3wLeTVSn7BeEWlLTivBLSYB+bKbVG92fYxN3pkHQKCBPkgO
	 6lRlyFPxbVbmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs show functions
Date: Fri, 13 Feb 2026 11:45:07 -0500
Message-ID: <20260213164508.3564699-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021347-showing-tapered-feb3@gregkh>
References: <2026021347-showing-tapered-feb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,csgroup.eu,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216274-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,csgroup.eu:email]
X-Rspamd-Queue-Id: C68D71385CF
X-Rspamd-Action: no action

From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>

[ Upstream commit a50522c805a6c575c80f41b04706e084d814e116 ]

Use sysfs_emit() instead of snprintf()/sprintf()  when writing
to sysfs buffers, as recommended by the kernel documentation.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20250822124339.1739290-1-chelsyratnawat2001@gmail.com
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Stable-dep-of: 148891e95014 ("bus: fsl-mc: fix use-after-free in driver_override_show()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8ae7e7bfc6248..2dded09f68a6d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -175,8 +175,8 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return sprintf(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
-		       mc_dev->obj_desc.type);
+	return sysfs_emit(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
+			mc_dev->obj_desc.type);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -202,7 +202,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.51.0


