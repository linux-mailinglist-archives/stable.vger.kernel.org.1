Return-Path: <stable+bounces-220664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGc+AZJCo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:31:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7912E1C7171
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3EAB32E774B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3439A3F3A56;
	Sat, 28 Feb 2026 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbV4k0Sr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49103F3A4C;
	Sat, 28 Feb 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300546; cv=none; b=T3WpqnfJ289PlhBSF/RDWRCr0i6vE8YcqYyaCuQqVLMtidJtJ361DBKWblsXYyj1cnhGqiLMFGEQWtzgUb5c2Kntw9zA1yFCCEAB3iZjaAVCmC6bc4yrCn9aQ2adUYZLjxQt2W7gPWFhBDip53nDdagiFFT9vXfFbUBC678cGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300546; c=relaxed/simple;
	bh=0QaQnWkvIXvBE9XpsdBu7sO72Xv5kEXcQG12BIWTGsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDCiB8gS58ncQ4yQp/B2rMxI/9twGUBpKVkUXILqYG46FxGqXFfSc7Uc+ocxuv4ulzNCRPAUTd18cSiUhknRn0b8ZGdCA+upwLJJgK4sZPEUEeu3ol3c4Ww+rB5/demNLHURKHsvvAyisd1X38debVfMs5ag8uFnEv2clVm53Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbV4k0Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E767FC19423;
	Sat, 28 Feb 2026 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300545;
	bh=0QaQnWkvIXvBE9XpsdBu7sO72Xv5kEXcQG12BIWTGsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbV4k0SrQSsa2/FRZbO1h84t/3KIKSHaatEI271vU16luLdW/S6Z41A/G3wJEbVbQ
	 F7NGHvw1W3pixXhao5lLhx5LCxR+ZswnmFgk1cOtddhCxX1ZAfKZzE/hUwIUWfZAGh
	 Q0iyKnjXbXvyAERvnABYL8F1thst8wjq63fe6JWxJuPo14lSP6r+jQrvugB5qEzCgJ
	 Xje5M0OnrOFr3rh/I0tCx67zy/oks5Li5RUvBC6fZZhha6aPBVEqR5OcgLiBvYcBwy
	 Mw/SIILUzDOjH5FX9uhPIdqgoZplx+ht9DblbuYrgy2sPBB2O078Xo+s+5HAOfDgtJ
	 mQGGYfUZfcZgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Plowman <david.plowman@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 585/844] media: i2c: ov5647: Correct pixel array offset
Date: Sat, 28 Feb 2026 12:28:18 -0500
Message-ID: <20260228173244.1509663-586-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220664-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email,raspberrypi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7912E1C7171
X-Rspamd-Action: no action

From: David Plowman <david.plowman@raspberrypi.com>

[ Upstream commit a4e62e597f21bb37db0ad13aca486094e9188167 ]

The top offset in the pixel array is actually 6 (see page 3-1 of the
OV5647 data sheet).

Fixes: 14f70a3232aa ("media: ov5647: Add support for get_selection()")
Cc: stable@vger.kernel.org
Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index f9fac858dc7ba..d9e300406f58e 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -69,7 +69,7 @@
 #define OV5647_NATIVE_HEIGHT		1956U
 
 #define OV5647_PIXEL_ARRAY_LEFT		16U
-#define OV5647_PIXEL_ARRAY_TOP		16U
+#define OV5647_PIXEL_ARRAY_TOP		6U
 #define OV5647_PIXEL_ARRAY_WIDTH	2592U
 #define OV5647_PIXEL_ARRAY_HEIGHT	1944U
 
-- 
2.51.0


