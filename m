Return-Path: <stable+bounces-220501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIZ/MQo6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8CB1C6668
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F256A3218F7F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1233B6E0;
	Sat, 28 Feb 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTcTCP54"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB633C8F78;
	Sat, 28 Feb 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300386; cv=none; b=duQqglijOLzhOcUfgSGiL/wQK/ECnXk+w6PvTyM3/sjBZIUybiUXbI2f0M9GHnAJ68g0g/hTSRTRx0RES2yuwYoZgciM/U86OOaCUgVpiLeveb5DxB22Pqw7YDSjFxi5ZsDTT68rudxrs1eqryBZXO9fE17ewbNeEVe1JivEHAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300386; c=relaxed/simple;
	bh=rdw9fSOL60NnHL7PQnfza4CqIrfGPbXzoQmTbqEaQ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRJ3P18zjB3OZ+2U7XBtBCWq/pH4uLmUUZLKci3msHqNbfHWCvA06j6GMCKR7mI/2TKUqSqv7QSkj/MMriJ8u2Pjws6Mpk6KSNOENSsELo/UVY38Ds875Il1EUlSlmmRZFfYALTwM0fwqUeUQAHo8YO4KRDHWY49bSvWKbK9OBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTcTCP54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAE4C116D0;
	Sat, 28 Feb 2026 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300385;
	bh=rdw9fSOL60NnHL7PQnfza4CqIrfGPbXzoQmTbqEaQ/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTcTCP547oOfm5JnLBtygwdbi+pJVAOe2I6Grwjzud20HcRAbzXBIrBKrlEPnS1I1
	 UUF9YSheSalTIVnnuPX53GuzDY4bLovvfuHwwL+eTWcZLV8HHBssCkvSz0Y8CBFmBa
	 CfY6N1aw9X0hW6Yygtr1vplxUr+hjOlfFJdGlfBuq+IkHuFzrG2I1TMXuoMwLqjwth
	 zepQGYo8bnRrfFWPkl4GVGV9U9oHsf4Mi8EbzYX7QT+rRlLdH8NPj4qEGzlRZOFUP9
	 he2axz96J5PZCUmqhLboSzMmrFI+IWhJbQoyiaN7R007waWW/3iXL0cnjkIg/IjGQp
	 eRm5s7Dl/mLoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 422/844] regulator: core: Remove regulator supply_name length limit
Date: Sat, 28 Feb 2026 12:25:35 -0500
Message-ID: <20260228173244.1509663-423-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220501-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4E8CB1C6668
X-Rspamd-Action: no action

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit e243cdd87b911ce9968b62e4ab2b680dfadc4341 ]

When creating the regulator object, associated with a consumer device,
the supply_name is string formatted into a statically sized buffer on
the stack, then strdup()'ed onto the heap.

Not only is the dance on the stack unnecessary, but when the device's
name is long we might not fit the constructed supply_name in the fixed
64 byte buffer on the stack.

One such case can be seen on the Qualcomm Rb3Gen2 board, where we find a
PCIe controller, with a PCIe switch, with a USB controller, with a USB
hub, consuming a regulator. In this example the dev->kobj.name itself is
62 characters long.

Drop the temporary buffer on the stack and kasprintf() the string
directly on the heap, both to simplify the code, and to remove the
length limitation.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Link: https://patch.msgid.link/20260211-regulator-supply-name-length-v1-1-3875541c1576@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 8ee33b777f6ce..838bbdcdede9a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1949,8 +1949,6 @@ static const struct file_operations constraint_flags_fops = {
 #endif
 };
 
-#define REG_STR_SIZE	64
-
 static void link_and_create_debugfs(struct regulator *regulator, struct regulator_dev *rdev,
 				    struct device *dev)
 {
@@ -1998,15 +1996,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	lockdep_assert_held_once(&rdev->mutex.base);
 
 	if (dev) {
-		char buf[REG_STR_SIZE];
-		int size;
-
-		size = snprintf(buf, REG_STR_SIZE, "%s-%s",
-				dev->kobj.name, supply_name);
-		if (size >= REG_STR_SIZE)
-			return NULL;
-
-		supply_name = kstrdup(buf, GFP_KERNEL);
+		supply_name = kasprintf(GFP_KERNEL, "%s-%s", dev->kobj.name, supply_name);
 		if (supply_name == NULL)
 			return NULL;
 	} else {
-- 
2.51.0


