Return-Path: <stable+bounces-221443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBulNQSlo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA51CDA39
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 758B33148F28
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21927E1C5;
	Sun,  1 Mar 2026 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnDdYycJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050827E07A
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328278; cv=none; b=BOugRmNIhESsrEtrt9EY+U5QHsCRNffO97DWHz/vZ5onwOGYFIXp7EYL8H2axCa/GdZwbMy5RxkI4uqSF+SDHA1DGH3GvY2YqhacJViJk4O+CIQGgHWalxQC07+t0vBkZ4u0Nmy+5KJq6L/SvtclYoH8qfZvg0E8LppWDu1G39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328278; c=relaxed/simple;
	bh=UZtwMz5sW1+hrbJWun+5atmQ1Rt3jEw+JR/O8wl6ogo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9++bJPe5ZoVx8uVdYBJHTrvOT+a1ciDVvchawseQKuMeBGJ4gwhO4CgUdO6OUHC7WIgN30+0Y55Iz7dfOBNMVbvgc4WkOhIIrrCI3QprFlyQ+aRB0dZKVHPXpVNLJFTCAB/60eb8Fc/vnh+MJpR85Otwih4NWus3jg9G/Fe9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnDdYycJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68288C19421;
	Sun,  1 Mar 2026 01:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328278;
	bh=UZtwMz5sW1+hrbJWun+5atmQ1Rt3jEw+JR/O8wl6ogo=;
	h=From:To:Cc:Subject:Date:From;
	b=NnDdYycJ/yJpxOgBPT0QLaRGfMTLhoJNvRM3RzVNqBKEYmN9+O3BQEFaJp8q6rWcY
	 Y0UvAnQl/LZfpJsBt3ySIREucVzn8z9XkIuPlx/T3Iq7XzON6g71PmE9M3DEZNfj4R
	 DZTWxbqJ/gs+dIAlcNWHSC5/Z3Ce5s6N9jxobGsLHOwMujcjf5MoDwM++AcMc824yx
	 xUzA5ZE7N2rixd6OKWY5K4NwCKElRRuJaanKOihEEjECGCIpBeeaLimS1R+B4ktm+k
	 aSfc9xBuSf01ncRr8h7nPpo++GzApmQfValnA6+nS8SEplqN6lNnP4ne0aIJfVYS/b
	 nfsoevsIhlGVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dalaport@amazon.com
Cc: Gunnar Kudrjavets <gunnarku@amazon.com>,
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org
Subject: FAILED: Patch "mtd: spinand: Disable continuous read during probe" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:24:35 -0500
Message-ID: <20260301012436.1681493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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
	TAGGED_FROM(0.00)[bounces-221443-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,iopsys.eu:email]
X-Rspamd-Queue-Id: 66EA51CDA39
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b4af7d194dc879353829f3c56988a68fbba1fbdd Mon Sep 17 00:00:00 2001
From: David LaPorte <dalaport@amazon.com>
Date: Thu, 29 Jan 2026 17:33:22 -0800
Subject: [PATCH] mtd: spinand: Disable continuous read during probe

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
---
 drivers/mtd/nand/spi/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 21a980e626eb2..514f653f27f3e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -940,6 +940,14 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
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





