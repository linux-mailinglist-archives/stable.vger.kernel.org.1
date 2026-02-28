Return-Path: <stable+bounces-220794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FCUF5NVo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:52:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B727F1C8946
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9200E320187B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97A40D892;
	Sat, 28 Feb 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BH00+zye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CB40D88A;
	Sat, 28 Feb 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300678; cv=none; b=JWp7dS32IhIgjSGLlqhKUIo6Y+QBMw3SJjsMnSFJziO+gvoh3r4Rm9kKt6vJvV5GbWcmnZmqjExIBuBiw3cgvU9nJDYL+FlEZT7+dkODyarNDvvymn3Kxeg+c5UW9S8wAJWWCRrbrqzxx7I57Jwic8yzXZ3j4YJXc58a4cLpJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300678; c=relaxed/simple;
	bh=72MtH4etEwxT1k1sD3KO4Y5iZT6lDvDEQvn42kEpSV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfh7CKEXwBWbSIRjDbah3W4G+6V05TgZb7LMSEdsOhOxELLRsIkMD82wzQLgYbef5frk0NMAIhPxcN8HfI0I2FwUcZtDkXn66Zz72hvtlF9g/vMAUExHnhc/0+6HdfiGBP++/wYEeFXu7YLtHaABjhzyAnhALTf4XXug+lLatug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BH00+zye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6132AC19424;
	Sat, 28 Feb 2026 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300678;
	bh=72MtH4etEwxT1k1sD3KO4Y5iZT6lDvDEQvn42kEpSV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BH00+zyesruLx11SHVsP3cLjk19fDK6Tg+x/MaHIaqxyD6Q2726H3O3b+GOgNBNOC
	 1mJHANcc4u3SqTKPgDXAinIWGJkvpHM0RxZRWKQR2XHZGHvOxOaOKipiHzNwjkbWgs
	 Fxdb5FpYCEzrAWcZxmDM2FzNvmPw80RrPTF8vUeWBFhl3se1QxdMc8NXI+IbzzbWoh
	 zsyT0r2yOoeuqgnCCpuy23kkvIZ4XHJon1I8af44I5CGh98HJWZlRHOHAic1Luz/oV
	 lWO4U3GiWaICABXaJ69YfinAYGvSxu5ww8bKMItGCU2ezrrOVC26s6B3PbBf1kYA0m
	 JC1AcUHh38kKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David LaPorte <dalaport@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 715/844] mtd: spinand: Disable continuous read during probe
Date: Sat, 28 Feb 2026 12:30:28 -0500
Message-ID: <20260228173244.1509663-716-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220794-lists,stable=lfdr.de];
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
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B727F1C8946
X-Rspamd-Action: no action

From: David LaPorte <dalaport@amazon.com>

[ Upstream commit b4af7d194dc879353829f3c56988a68fbba1fbdd ]

Macronix serial NAND devices with continuous read support do not
clear the configuration register on soft reset and lack a hardware
reset pin. When continuous read is interrupted (e.g., during reboot),
the feature remains enabled at the device level.

With continuous read enabled, the OOB area becomes inaccessible and
all reads are instead directed to the main area. As a result, during
partition allocation as part of MTD device registration, the first two
bytes of the main area for the master block are read and indicate that
the block is bad. This process repeats for every subsequent block for
the partition.

All reads and writes that reference the BBT find no good blocks and
fail.

The only paths for recovery from this state are triggering the
continuous read feature by way of raw MTD reads or through a NAND
device power drain.

Disable continuous read explicitly during spinand probe to ensure
quiescent feature state.

Fixes: 631cfdd0520d ("mtd: spi-nand: Add continuous read support")
Cc: stable@vger.kernel.org
Signed-off-by: David LaPorte <dalaport@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d207286572d87..9540fd04156c7 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -859,6 +859,14 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 	    (engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE ||
 	     engine_type == NAND_ECC_ENGINE_TYPE_NONE)) {
 		spinand->cont_read_possible = true;
+
+		/*
+		 * Ensure continuous read is disabled on probe.
+		 * Some devices retain this state across soft reset,
+		 * which leaves the OOB area inaccessible and results
+		 * in false positive returns from spinand_isbad().
+		 */
+		spinand_cont_read_enable(spinand, false);
 	}
 }
 
-- 
2.51.0


