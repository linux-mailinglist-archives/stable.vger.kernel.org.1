Return-Path: <stable+bounces-220994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NatDy1Yo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:03:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501491C8BC2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 658DB313FF3C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC331334C1C;
	Sat, 28 Feb 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB17cpf3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7BB328B71;
	Sat, 28 Feb 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301338; cv=none; b=KYlACdTnTdLRzl8iAYVniedL/fChdRo+hL/t+YDP4ULgUW8bkpUiIJ5AGjIBZKsmu2nJIAAuo+Rz7uWa44gfx9IVnNBmGQhDfrOjCewdaKklKZJWqN1Za+e+wTtEdktsydotxd6VpYOalheXQO77NMOe8qtwpI5cxRI7ssSaUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301338; c=relaxed/simple;
	bh=0QaQnWkvIXvBE9XpsdBu7sO72Xv5kEXcQG12BIWTGsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzfz0hiSdTKPdfIc9Op7jDOUHk1/D8sp2wbF3Av3euXtrsAttDkUgpIRsPGf76CSbdjb6b55CcglpTsop7CWJfQgSjwH57GKomAOh5opiC0sVYxpocpboAQ8y7ydkOrsIqIcFIYynDbcU2ij+TBeWDdGYf4uhuEUMGKjVyLwCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB17cpf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFF4C19424;
	Sat, 28 Feb 2026 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301338;
	bh=0QaQnWkvIXvBE9XpsdBu7sO72Xv5kEXcQG12BIWTGsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QB17cpf3P3tse7Ml3qLKhPS03Ji8JCyWf477TAlCBXvwgtuQOob5GmoRLZGGWkkjo
	 YSKhxuwjLKVs/n0PP1fyUDddI+TmRkeLn9/tVhGRcM0PjYS/jgfFHaRA8WdJcF8KZg
	 bhRlhCVVaCaJ8d2Lzyyx7ZAtUwjm3AscW/vmJ5JoCivKAW8Bm4xKw4VXeNSvS/XSVI
	 6WhsOdHpU5cAMH0Tt6/MZEU0Y/2HKj+CWkuxLE877ydWgDW88AxBlQ9YJtnUfJaBG5
	 sX4KRJ4/V8RGo0FLc5f1EMZ8ugJ4fcHomm582nEknEJOgMseRpRT+AQrbDk8co5GC+
	 a9+EK0B6TAymA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: David Plowman <david.plowman@raspberrypi.com>,
	stable@vger.kernel.org,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 525/752] media: i2c: ov5647: Correct pixel array offset
Date: Sat, 28 Feb 2026 12:43:56 -0500
Message-ID: <20260228174750.1542406-525-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220994-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,raspberrypi.com:email]
X-Rspamd-Queue-Id: 501491C8BC2
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


