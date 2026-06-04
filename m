Return-Path: <stable+bounces-260571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1vPgCWTVIWqaPQEAu9opvQ
	(envelope-from <stable+bounces-260571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 21:43:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A13642FDB
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 21:43:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S33BFZ03;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260571-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260571-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD9B303B6E6
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956A3B960F;
	Thu,  4 Jun 2026 19:40:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB863A7F72
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602022; cv=none; b=hO4CImKdreNtKyQHyfv/iDpY/Tjf2O3omfPnZ5cnQmgXJj60+tAzSLAbznUONbsRz/cBGCN/f8/heSJy+f/VJqMztq+Yae207KvbIiWjt7qDVN3wL5FmsqqNejGvS9nNZKNSMi8Al3WyBY0F+98seegqRurhWxNw3kGZkgS4SXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602022; c=relaxed/simple;
	bh=/4xkadzyMpNBPh7LtuPXdwwOr29e8GS7U/YbxymPKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8RC1VpvWpGFPsUQ5HXczIIinjzpQNuQoz/iVPhD3BLgQEnip8PAWafDR+VXcuXOP/oGEY1OpJa6wnAqN7ZvSMnRyplvqyTq7RYRDzM5BHuvyFkyUCSBkg3tUqNNiPOWZPzDyIbMAKDSQF6n+n29OD3p36dadJpqZdLAUtsRoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S33BFZ03; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100F71F00898;
	Thu,  4 Jun 2026 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602021;
	bh=FdtEjzAPyzaRGmptOScglPtFP6cN3p8luNKvRDfaCZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S33BFZ03hNPbei+PYI00eLFMIZhAAtBAisj1JCw9Amv+gsCyRhjeET8KjkAXqfi/m
	 pcuNElpS3VrWPuXXQnG9VnG+2xQRGupX4q10R8J0Cf902iOJmDz0FXrbEO8DV6uxcd
	 t6EJh/Rn9vG4kiWLh+BKKfOZEMAFFSTAUhe3oYrHp1pME8OpMU/9veWFGJL76WA/Oy
	 nk2b/8yBfo5Yi7wo/XB+GJfl2+ai5B8fNO19p8El9zDInbaBXGSwpFdLBAB+yA76Sx
	 LRnwQMj1YB9f4m1/V5OO7JQDxpKGOUwSJxt+xvcVuKnmr9ziHOcR5JJv83bLJUY0/9
	 byU2wP45JbGog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] iio: chemical: scd30: fix division by zero in write_raw
Date: Thu,  4 Jun 2026 15:40:17 -0400
Message-ID: <20260604194017.889785-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604194017.889785-1-sashal@kernel.org>
References: <2026060457-coastal-washable-cab4@gregkh>
 <20260604194017.889785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260571-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:antoniu.miclaus@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86A13642FDB

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit 5aba4f94b225617a55fed442a70329b2ee19c0a5 ]

Add a zero check for val2 before using it as a divisor when setting the
sampling frequency. A user writing a zero fractional part to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a0a1f89deba913..26216154c8591b 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -257,7 +257,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;
-- 
2.53.0


