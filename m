Return-Path: <stable+bounces-221222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFHSH69eo2myBQUAu9opvQ
	(envelope-from <stable+bounces-221222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:31:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67AC1C9219
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02B93372483
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3E3A2AE9;
	Sat, 28 Feb 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxjDie8H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80535AC3F;
	Sat, 28 Feb 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302698; cv=none; b=PbBRkqxKf5MA/w59ufUA2n/syISiKnii2VjD5cO0I7VPUJa4a3w2R2kuhw+bq6fF3faJ50GzNDn/vdioXbK6UBJL/jsD73tylUbZRxRqxVv6RsUXG8D7/A5Z9K3f/Jrual14Ek1lRxDXphhpYX6rWzDqcYi9toU6QVTXDScVUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302698; c=relaxed/simple;
	bh=/BjgGt45Ip7AxPMQAhGDndys9eeQL5U07wmtIDtmMRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+21mgr8HDTbIpS+ai+5BYHCP1yDmWUvrBOsTCxLmEu5hQW96m/BkatDpeEF7j31gTI6FRJS4NihOzSsS31dGyRX5uawTd29AIwO8FRGrUxZS9G/gIFlGT1osVbgIPDhzdc8ARJOhOjo0hGJELuLvNsbXNhWZOVoKtNJ9GWOJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxjDie8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24066C19424;
	Sat, 28 Feb 2026 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772302698;
	bh=/BjgGt45Ip7AxPMQAhGDndys9eeQL5U07wmtIDtmMRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxjDie8H5GM7pMVAIoR5/QdKoGfGiwykwGYEyCUmHMB0Rl30ymQP8erUxN7M0ugAw
	 4cj9hV4qWhyrkpEbF9oiSuFTlR2ZAfo2SYPsf0vmGG4e+CwO1x7tRuELr9Ta00vFRF
	 dWo+WxELSgzqZdmKFThKMfOQHU34Uc6ULJw4PcWgsF6mxPUUWmT8a/I/qzStbvePd1
	 /goCKNMZ8rCJXvB6BJA6/IkoGlQ8iBXDtfEw+iUryMse9mmDl0ctaax3GlkJeJuoHN
	 eGn4kC71RpUyZGx4pqTSUci/cyllnOLXTs77nLqSwjwQhtCY2HDInLZ0HS/eRCyxri
	 Pznwntm9WMA5A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Matthias Kaehlcke <mka@chromium.org>,
	stable@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 054/147] regulator: core: Use ktime_get_boottime() to determine how long a regulator was off
Date: Sat, 28 Feb 2026 13:16:02 -0500
Message-ID: <20260228181736.1605592-54-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228181736.1605592-1-sashal@kernel.org>
References: <20260228181736.1605592-1-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221222-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A67AC1C9219
X-Rspamd-Action: no action

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit 80d2c29e09e663761c2778167a625b25ffe01b6f ]

For regulators with 'off-on-delay-us' the regulator framework currently
uses ktime_get() to determine how long the regulator has been off
before re-enabling it (after a delay if needed). A problem with using
ktime_get() is that it doesn't account for the time the system is
suspended. As a result a regulator with a longer 'off-on-delay' (e.g.
500ms) that was switched off during suspend might still incurr in a
delay on resume before it is re-enabled, even though the regulator
might have been off for hours. ktime_get_boottime() accounts for
suspend time, use it instead of ktime_get().

Fixes: a8ce7bd89689 ("regulator: core: Fix off_on_delay handling")
Cc: stable@vger.kernel.org    # 5.13+
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20230223003301.v2.1.I9719661b8eb0a73b8c416f9c26cf5bd8c0563f99@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 86a8eeb0e913 ("regulator: core: move supply check earlier in set_machine_constraints()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 84578a107fef2..6d413f936e0f2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1510,7 +1510,7 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	}
 
 	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get();
+		rdev->last_off = ktime_get_boottime();
 
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
@@ -2628,7 +2628,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		 * this regulator was disabled.
 		 */
 		ktime_t end = ktime_add_us(rdev->last_off, rdev->desc->off_on_delay);
-		s64 remaining = ktime_us_delta(end, ktime_get());
+		s64 remaining = ktime_us_delta(end, ktime_get_boottime());
 
 		if (remaining > 0)
 			_regulator_enable_delay(remaining);
@@ -2864,7 +2864,7 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 	}
 
 	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get();
+		rdev->last_off = ktime_get_boottime();
 
 	trace_regulator_disable_complete(rdev_get_name(rdev));
 
-- 
2.51.0


