Return-Path: <stable+bounces-220989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJeYGy9Yo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:03:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B886B1C8BCA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EEE69313D160
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D354B8DF6;
	Sat, 28 Feb 2026 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt8Dt7/i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FE47CC7E;
	Sat, 28 Feb 2026 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301333; cv=none; b=Wn4zago5YfgH3iL94dddrWv2NZr8oFK/Nc9axOcYcvSfFBMGk9d9sFUs7bSKl5nry5wkinCzv5Ujfd0C3DYYyZmw8xGPdfHXAWH6aAtOHaogOOWtMWuyJbHDWQK3XZyaKmontv5SSOxZLojBT4kjpt5X9Linpo9z6sXhI5jtRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301333; c=relaxed/simple;
	bh=tfkBBqKStCnHLqu7rxJkkFEuyEAHDngvzTEOd1OAGIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7jfCfllVcXCP8gXZjN/jPWjjWFO83x9YOM1joya6KZv25KDz9USOcV/G71AtfFPo2OPnL2wME80x+UMtVkZOkCyBNxGIYd0EiEgH3bQVFtb4f/ctuOnYYH4BhVcs1Xk7bmb+HG9hcf0CIca8hwPNw87E5GO/sdQXiKETY4ljBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt8Dt7/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA93C19423;
	Sat, 28 Feb 2026 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301333;
	bh=tfkBBqKStCnHLqu7rxJkkFEuyEAHDngvzTEOd1OAGIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gt8Dt7/irJ2MACOZ3A85INLFWYvRZjhbyfLQqSxo4XMC+xBChqk94GInc3JkgAIal
	 CIQsDZubmSiTF/A/2yLLLhmDwnpWAcC3ghNVGDediKO5Ryn6fAvGA262DIRxQh4XAe
	 wHsmRkRr7n9uLo4I+E+TK4QIigm4yT6JqiKOIgg2ZkRQHFVY0czMljGDIUz3Ry3cOZ
	 RTYaZG8hpO0TbYdE+j81JI8jYrVjEkEI5yYhqPv5+8TEFJUUBO6PSwkQhcOUW38I0e
	 ci76p79FeEf7atacyNjecejgvDLtkGaDM9lMPOH25rNbK4K3WQ3KCISxlVhtDBEPUG
	 Lk/U9dd58onIg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Hans de Goede <hansg@kernel.org>,
	stable@vger.kernel.org,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 520/752] media: i2c: ov01a10: Fix passing stream instead of pad to v4l2_subdev_state_get_format()
Date: Sat, 28 Feb 2026 12:43:51 -0500
Message-ID: <20260228174750.1542406-520-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220989-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B886B1C8BCA
X-Rspamd-Action: no action

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit f8563a375e7fba7c776eb591d4498be592c19098 ]

The 2 argument version of v4l2_subdev_state_get_format() takes the pad
as second argument, not the stream.

Fixes: bc0e8d91feec ("media: v4l: subdev: Switch to stream-aware state functions")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov01a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
index 1e22df12989ae..dd2b6d381175a 100644
--- a/drivers/media/i2c/ov01a10.c
+++ b/drivers/media/i2c/ov01a10.c
@@ -731,7 +731,7 @@ static int ov01a10_set_format(struct v4l2_subdev *sd,
 					 h_blank);
 	}
 
-	format = v4l2_subdev_state_get_format(sd_state, fmt->stream);
+	format = v4l2_subdev_state_get_format(sd_state, fmt->pad);
 	*format = fmt->format;
 
 	return 0;
-- 
2.51.0


