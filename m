Return-Path: <stable+bounces-220659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKexNGhCo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDE1C7146
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A65032BB38D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E93F26C1;
	Sat, 28 Feb 2026 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9Wizad8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5373F26B9;
	Sat, 28 Feb 2026 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300540; cv=none; b=pfw3MQ5gGHtFdvDykOadNUx0I3jV7eU/l9maaB2/vRxDdVzv6hvORsHLDSG1eI8j8wjI0jtZLqfPdEgrBCvxDnHFAf5iHhIS1CIeS4+KIWIGOwepkZoa48POYIf+383ANakf/Df4KYEohv09GtHfgVVr93bOy2FxFAVzrt7cx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300540; c=relaxed/simple;
	bh=tfkBBqKStCnHLqu7rxJkkFEuyEAHDngvzTEOd1OAGIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMCQYSGsBhVotiyPSMgfbi81/3fhYGC85Q5w9YEzGkaJBWi5TT3JVTh4Hh99AjvumSkzoDSWe7h9xO1oxMPk/mVFkVCAlakVMb+G7HDEGldfzQbbG29nu4GbmTmEsrVF2qyL+19787HLJq/Yokd4x6H6gqgNsIxoJ9Vu5MgAuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9Wizad8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE7BC2BC87;
	Sat, 28 Feb 2026 17:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300540;
	bh=tfkBBqKStCnHLqu7rxJkkFEuyEAHDngvzTEOd1OAGIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9Wizad884BX7GgjMVJIh35hDW4URUDTTAdTK0/mRkvD1Qa/aerSQIRRKjr/ZGBJ1
	 ZwZWPCIKVpNoHyIH+kK4+7Dl2KwRwuAfnIOadabHXfbqVYaSxCiIGNxdhCaF1PsMXe
	 jXKYtB7jUzLS06Bkumnu2pSVx0isu1dJEngkCLTnnKk23jHX3EPhOHrUuQZj9Q4FA+
	 ffi2iGdVqS4Qft2zG0eW4bIWHA86o7C/BOfcFa/LdJBYirOnkTpZEwVS30Y+OSD3gj
	 iFgNrLE0oZd3cvhgafU/H5ZhZg7/AZM27sKRj8uKFGXtYrk8CbbFmSs7pVFht6i+lp
	 WENrq3zV3aKGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 580/844] media: i2c: ov01a10: Fix passing stream instead of pad to v4l2_subdev_state_get_format()
Date: Sat, 28 Feb 2026 12:28:13 -0500
Message-ID: <20260228173244.1509663-581-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220659-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 1AEDE1C7146
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


