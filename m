Return-Path: <stable+bounces-220734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJf1Dqg/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:19:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C01C6D3F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6024310FFE7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B3400C02;
	Sat, 28 Feb 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D87Z6KeU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670C492181;
	Sat, 28 Feb 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300615; cv=none; b=Oeh29U9o+iHBeATZeaa5rT+bf9ZI7KwxqYbPXNXrKNrqQOb2li375Kz2EhQOXljcym5tXhMRNtPTENP0J6ZU2Jt4YYXByKFeXOJZViMUrjch9jWg0xYTPcjVK3XEKxabBE/yT5bwLRHpcISlAlhtZaemoEtIVxBnYV/VjlGQQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300615; c=relaxed/simple;
	bh=SZPQi8By45shZVXLcPDJbaFQuKe0/9kstN6rwHLOtMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNk++EjygzA/XU6FC5RNe41uvI6S7BaMewAVvaA89k5vG87xH6Uq6PevGUhtJUkhjVR19JeYtu5YWv5g3cMkHmG3iLP0XJ3+/4/xPOn1i1hiNwqnjjPz+lJ7MsFTFnxx/7sX/jnREPn/2k3DJ9q8YZDTgsoNqKMLBSHei0M5V+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D87Z6KeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75966C19423;
	Sat, 28 Feb 2026 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300615;
	bh=SZPQi8By45shZVXLcPDJbaFQuKe0/9kstN6rwHLOtMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D87Z6KeUuvTE+yBPRTEgbtXfNMF0mWzQuiuV+xAwx/I5OQzGIQp0nQ+2QTH7PfoNE
	 Qh6++PGj7j5+sjVT7mSI4Q156AY2JYtmdGDUDWDfV3chWPN2K6dCTtlf2TrXsYyAkF
	 hKsTTM4e+UpLc2w+3VwFhrCMKHw6fywAmOgq/Igw3FMLCk3JurZWA4+X4yOhk445sV
	 NhEcNMFYmxGO7q2q0+hyt3FCMcvHVqqu8gOhhTeo9dZgnybHDrltW0cJEwjRs1ANbE
	 bgLc8b4r63KFlL8wqovAvj9zTM56yultHuyzyUH59F7kV62LYSf1QmsOLznttB9JP7
	 Pc0IrNGGeLLlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 655/844] dm: fix excessive blk-crypto operations for invalid keys
Date: Sat, 28 Feb 2026 12:29:28 -0500
Message-ID: <20260228173244.1509663-656-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220734-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC7C01C6D3F
X-Rspamd-Action: no action

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit d6d0e6b9d54532264761405a1ba8ea5bd293acb1 ]

dm_exec_wrappedkey_op() passes through the derive_sw_secret, import_key,
generate_key, and prepare_key blk-crypto operations to an underlying
device.

Currently, it calls the operation on every underlying device until one
returns success.

This logic is flawed when the operation is expected to fail, such as an
invalid key being passed to derive_sw_secret.  That can happen if
userspace passes an invalid key to the FS_IOC_ADD_ENCRYPTION_KEY ioctl.

When that happens on a device-mapper device that consists of many
dm-linear targets, a lot of unnecessary key unwrapping requests get sent
to the underlying key wrapping hardware.

Fix this by considering the first device only.  As already documented in
the comment, it was already checked that all underlying devices support
wrapped keys, so this should be fine.

Fixes: e93912786e50 ("dm: pass through operations on wrapped inline crypto keys")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-table.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0522cd700e0e2..4b70872725d04 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1237,9 +1237,6 @@ static int dm_wrappedkey_op_callback(struct dm_target *ti, struct dm_dev *dev,
 		bdev_get_queue(bdev)->crypto_profile;
 	int err = -EOPNOTSUPP;
 
-	if (!args->err)
-		return 0;
-
 	switch (args->op) {
 	case DERIVE_SW_SECRET:
 		err = blk_crypto_derive_sw_secret(
@@ -1266,9 +1263,7 @@ static int dm_wrappedkey_op_callback(struct dm_target *ti, struct dm_dev *dev,
 		break;
 	}
 	args->err = err;
-
-	/* Try another device in case this fails. */
-	return 0;
+	return 1; /* No need to continue the iteration. */
 }
 
 static int dm_exec_wrappedkey_op(struct blk_crypto_profile *profile,
@@ -1294,14 +1289,13 @@ static int dm_exec_wrappedkey_op(struct blk_crypto_profile *profile,
 	 * declared on all underlying devices.  Thus, all the underlying devices
 	 * should support all wrapped key operations and they should behave
 	 * identically, i.e. work with the same keys.  So, just executing the
-	 * operation on the first device on which it works suffices for now.
+	 * operation on the first device suffices for now.
 	 */
 	for (i = 0; i < t->num_targets; i++) {
 		ti = dm_table_get_target(t, i);
 		if (!ti->type->iterate_devices)
 			continue;
-		ti->type->iterate_devices(ti, dm_wrappedkey_op_callback, args);
-		if (!args->err)
+		if (ti->type->iterate_devices(ti, dm_wrappedkey_op_callback, args) != 0)
 			break;
 	}
 out:
-- 
2.51.0


