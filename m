Return-Path: <stable+bounces-216316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAh9MsvHj2lVTgEAu9opvQ
	(envelope-from <stable+bounces-216316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:54:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B8613A312
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED152303AB41
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F11DF75B;
	Sat, 14 Feb 2026 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAcSrBrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1619D07E
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030470; cv=none; b=cirpDZ8d91iNs6rUHksDh3nBZ+h2QKs37iZTBkfizJ8ooW9NohpZ1rjqxukXUhkZExERs1/lAuf7Xe3dSZkg9W54EnB2+1bY/CHQJLUfWA+zOjtSqarTZCrwhNKqDZ+ULoNatjfyRBbWmJaFu7GXzwIQjPK3H7r9iF6XnUvQiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030470; c=relaxed/simple;
	bh=laCmPknrNJDJ59NiOTvNEWvIYgj2NcZ0tHcEU6jopPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4ZhG0iM7ir/6omHF2ZHoYmv+pI9KHsYtS9Wg8bJUpdRH+xIZWKnhWjT5DvLnonD5RV7C26stncti+cv5V0X0RJ6Jka0P6mOhs5ALcyUEBALjWhGCMv2tY+4UTQ49lhXS+nOIyCqY5VYAOnDNfhtkDyE9ytGF/V+Q/mzRWkf05U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAcSrBrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41EBC16AAE;
	Sat, 14 Feb 2026 00:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771030470;
	bh=laCmPknrNJDJ59NiOTvNEWvIYgj2NcZ0tHcEU6jopPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAcSrBrTJWFHeYPkwIaSwXQw6LuhjBvQOHaPCalE6F+DLI7mmz8+oC9SxjRdJKA3y
	 KmmsOpZ8XrzeUcSwAM5BPpJYkdyuQ5ooYcOs0JOCGmdp6gfXSjx4qg8T8XkKK5+Uc2
	 jIEvnh1cc3Syfe/8ZCKj92AoNNywFwa7/75SLtiTRJl+QfYQ6o2WLFhGMn7AaMVOEv
	 McG8Ls2AA2WgWUMbAHSq5HR5yaHWOTMyIQ9qzPLHnCI+MA6aVHxIA8h+rrMBrA/t1l
	 S6sdyKjVrAWNUTONT9xVKN9PwhNMsjXXNIJ9ej7TKD4BnbJ8tlh++WkpgiwaxpWmY1
	 5q7s1jysyo9nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gui-Dong Han <hanguidong02@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] bus: fsl-mc: fix use-after-free in driver_override_show()
Date: Fri, 13 Feb 2026 19:54:27 -0500
Message-ID: <20260214005427.3653008-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214005427.3653008-1-sashal@kernel.org>
References: <2026021347-applicant-whooping-9898@gregkh>
 <20260214005427.3653008-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216316-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 27B8613A312
X-Rspamd-Action: no action

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 148891e95014b5dc5878acefa57f1940c281c431 ]

The driver_override_show() function reads the driver_override string
without holding the device_lock. However, driver_override_store() uses
driver_set_override(), which modifies and frees the string while holding
the device_lock.

This can result in a concurrent use-after-free if the string is freed
by the store function while being read by the show function.

Fix this by holding the device_lock around the read operation.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@gmail.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8e1000a01231b..dc35de3e4379e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -199,8 +199,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.51.0


