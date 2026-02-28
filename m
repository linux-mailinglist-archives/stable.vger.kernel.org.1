Return-Path: <stable+bounces-220662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJCKBRVSo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:37:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A781C875B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A880330D3C49
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002613F325D;
	Sat, 28 Feb 2026 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHLDIFt8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780D3F3254;
	Sat, 28 Feb 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300543; cv=none; b=S1g7WfgCEMsNkSkr++7td3kAH7eTcRNZf1A6YITPhqsJ5HtWqH+kHmoCcbN+cwhZjWzz5kxk5L/iM3pdFa7UGOmDb2BYdvRM3YplB6kxVJm03iDWGIfV19Uy7eCIS5pFRIT+OD6HPWLhYMUjwc4bmtZ0imozlGN03p5qCdAKB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300543; c=relaxed/simple;
	bh=YH7SUM71e+UxP/mZW5mT01cQ4S9baMEJHd3vHF97weI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmzT4by8dRohRFRJ4b/McdiWbbvAWtFL3reTfq00wrvTFn4h28rKA6+p0M+u9Og+x68YGBnNhxiHf3CIf0ZiiXjf67hkxfDRvV7PTGiON3jR6IyIpGxOq2rjZ+AoV1ZobDmXVFD053GyzSPTOcM6Ywty5q91k2Tj+plvxfpxShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHLDIFt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B47C19425;
	Sat, 28 Feb 2026 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300543;
	bh=YH7SUM71e+UxP/mZW5mT01cQ4S9baMEJHd3vHF97weI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHLDIFt8NsvkzkOQ0m8aiwnedYhOPQvMm8zKJC4efSpCtZvJRIgNLRfE1fGDe33ls
	 RsAo0bLOi7Mo47X5VDQiJ44Kxh0+gwb18j12It76o0V7lt48lwRXM1OyNwB9oVYljn
	 uiyklkl1EceG1yRlWYWMqiDyDOXEzHdrdoaAxcFRNtdrR35NlcuvLwKFjbWA/gwK5Q
	 7xu489l1mvKECRuiFHZC06FO/rXBJC2B9cFACnC99RfQCFBNeerNWG2utqv6RmSaDM
	 iHd/1bsI36UlXwqJrUBoanNkcXCUOKOuuy2fV9gCjPAM63uKFWbdgJYG1nB7XX1xbc
	 1RawPaXyOTlVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 583/844] media: ccs: Avoid possible division by zero
Date: Sat, 28 Feb 2026 12:28:16 -0500
Message-ID: <20260228173244.1509663-584-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220662-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52A781C875B
X-Rspamd-Action: no action

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 679f0b7b6a409750a25754c8833e268e5fdde742 ]

Calculating maximum M for scaler configuration involves dividing by
MIN_X_OUTPUT_SIZE limit register's value. Albeit the value is presumably
non-zero, the driver was missing the check it in fact was. Fix this.

Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Closes: https://lore.kernel.org/all/ahukd6b3wonye3zgtptvwzvrxldcruazs2exfvll6etjhmcxyj@vq3eh6pd375b/
Fixes: ccfc97bdb5ae ("[media] smiapp: Add driver")
Cc: stable@vger.kernel.org # for 5.15 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ccs/ccs-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 43f7d515bab67..3cacc7d904935 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -2346,7 +2346,7 @@ static void ccs_set_compose_scaler(struct v4l2_subdev *subdev,
 		* CCS_LIM(sensor, SCALER_N_MIN) / sel->r.height;
 	max_m = crops[CCS_PAD_SINK]->width
 		* CCS_LIM(sensor, SCALER_N_MIN)
-		/ CCS_LIM(sensor, MIN_X_OUTPUT_SIZE);
+		/ (CCS_LIM(sensor, MIN_X_OUTPUT_SIZE) ?: 1);
 
 	a = clamp(a, CCS_LIM(sensor, SCALER_M_MIN),
 		  CCS_LIM(sensor, SCALER_M_MAX));
-- 
2.51.0


