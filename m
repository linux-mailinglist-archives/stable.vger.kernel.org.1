Return-Path: <stable+bounces-235815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCOSGjyW22njDgkAu9opvQ
	(envelope-from <stable+bounces-235815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:55:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B80433E3DDA
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C85300F120
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78337756E;
	Sun, 12 Apr 2026 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRPdQo/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15A18EB0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998519; cv=none; b=sM+m2pjc51RKqmXNPpMgmT8LVnwAFTmwQ0NzQNLPqC83hXmcG75qGbMIfKcqbQ47E/0teyaj8OdvTLw8Uth2KI6dVpYI0Ak3K5rU2QBfyHI6pWfL4b00u9NgEnclPvqsTaQgwnkSZomsHUU4pa24M6ZqtGXBRSUcrfe9wuGNhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998519; c=relaxed/simple;
	bh=EY/glukiHG0CuNq3pY3NMBV0SIwR/PXUF7VtG3U8UDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDpznrtmp2pD3AYCiaSGOWPmfNAaNiZUHsD05gAP5dtUnMlThFBWz301UHdgnxU4CEt1W/SnCorYf7BM/MbP5GFqyNahQJGNrna4H8PvQaQLntoG1NeiPbmNf/gkoVkjkTa9/1LKqXmRyyU5icTRe/t+k9z4sDS/aPWbMmHcxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRPdQo/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C142FC19424;
	Sun, 12 Apr 2026 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998519;
	bh=EY/glukiHG0CuNq3pY3NMBV0SIwR/PXUF7VtG3U8UDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRPdQo/IoXhJPoPfmPwmwiAyYt7oFVEjsvUJpObSALy5ElSADphkIUCHsBpPWcxEs
	 PGMfYtmRDd1ZicdmxYuc+13eFSWZSTGgEuhbh4IAcKMqzkD9XNaHyBYff0MAkWkIyc
	 ox2H1LwyP1gsAwylf9O3fzrUgi3ZoAOWqQ4jm/yc+rVxUwctoQCKG4xAMY9+ZF5bEz
	 Rwk7gXY5muIT/hZNGvfNTQp07B1fwoMRPQp97q3FgPLQtJNd8w7r9lwXTzS3GFOV+F
	 bDKOuUY8D6YV4aNSg5NoC8byf08GOa2hR49byXAvt+DDIySWE9sgre4GaBLBB9LVzd
	 6m8XZpALgpAFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bo Liu <liubo03@inspur.com>,
	Simon Horman <simon.horman@corigine.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] rfkill: Use sysfs_emit() to instead of sprintf()
Date: Sun, 12 Apr 2026 08:55:14 -0400
Message-ID: <20260412125517.2219007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041215-clamp-serpent-1558@gregkh>
References: <2026041215-clamp-serpent-1558@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235815-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[corigine.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,inspur.com:email]
X-Rspamd-Queue-Id: B80433E3DDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bo Liu <liubo03@inspur.com>

[ Upstream commit 796703baead0c2862f7f2ebb9b177590af533035 ]

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Bo Liu <liubo03@inspur.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230206081641.3193-1-liubo03@inspur.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: ea245d78dec5 ("net: rfkill: prevent unlimited numbers of rfkill events from being created")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index dac4fdc7488a3..65913ac35bd59 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -685,7 +685,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%s\n", rfkill->name);
+	return sysfs_emit(buf, "%s\n", rfkill->name);
 }
 static DEVICE_ATTR_RO(name);
 
@@ -694,7 +694,7 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%s\n", rfkill_types[rfkill->type]);
+	return sysfs_emit(buf, "%s\n", rfkill_types[rfkill->type]);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -703,7 +703,7 @@ static ssize_t index_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", rfkill->idx);
+	return sysfs_emit(buf, "%d\n", rfkill->idx);
 }
 static DEVICE_ATTR_RO(index);
 
@@ -712,7 +712,7 @@ static ssize_t persistent_show(struct device *dev,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", rfkill->persistent);
+	return sysfs_emit(buf, "%d\n", rfkill->persistent);
 }
 static DEVICE_ATTR_RO(persistent);
 
@@ -721,7 +721,7 @@ static ssize_t hard_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_HW) ? 1 : 0 );
+	return sysfs_emit(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_HW) ? 1 : 0);
 }
 static DEVICE_ATTR_RO(hard);
 
@@ -730,7 +730,7 @@ static ssize_t soft_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_SW) ? 1 : 0 );
+	return sysfs_emit(buf, "%d\n", (rfkill->state & RFKILL_BLOCK_SW) ? 1 : 0);
 }
 
 static ssize_t soft_store(struct device *dev, struct device_attribute *attr,
@@ -764,7 +764,7 @@ static ssize_t hard_block_reasons_show(struct device *dev,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "0x%lx\n", rfkill->hard_block_reasons);
+	return sysfs_emit(buf, "0x%lx\n", rfkill->hard_block_reasons);
 }
 static DEVICE_ATTR_RO(hard_block_reasons);
 
@@ -783,7 +783,7 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rfkill *rfkill = to_rfkill(dev);
 
-	return sprintf(buf, "%d\n", user_state_from_blocked(rfkill->state));
+	return sysfs_emit(buf, "%d\n", user_state_from_blocked(rfkill->state));
 }
 
 static ssize_t state_store(struct device *dev, struct device_attribute *attr,
-- 
2.53.0


