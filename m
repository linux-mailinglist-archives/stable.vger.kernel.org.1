Return-Path: <stable+bounces-252513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI0ELVn7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:20:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB1595D57
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 289B030F03B7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8991B3D5647;
	Wed, 20 May 2026 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GCp2bpZj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D22F363F;
	Wed, 20 May 2026 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300870; cv=none; b=H6sWgw3KaNsQ+FcD7eDJ6Ke3xwFz4f79SQPhkdyRlBPUyuSA26VhiF6RRgexRO7q6QO7gv4C1MVvMTiOz1pmhSRUZrbITwmAz8K2EsEABDkKsLT9kJ60WwYEYsNwoK001C3e37QZ5WNqScskCJ0LomgBFpHpL1eRz1Wm3J/EOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300870; c=relaxed/simple;
	bh=1JYhdrsA3uw52Uiy/YU8A90pVGpSc1yHSRGZrDkD9ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsbGxMjCROSPUR+VUFmraLylLghRX/47Tc9zLrh9DGE38qAhwanVGL+aVoCjQsaFOawRIbAEVwOPovwjvvbabr+F//l2Eisd3oArNkAqjjuX2S6vwqU4MRYHdIfMwrm4veQaOKpXWD9PM0lYJDyHMOOF4N9KLDS8gsE3vtlNs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GCp2bpZj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7061F000E9;
	Wed, 20 May 2026 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300869;
	bh=S7n5I76gIM7i8AES2XcDPIjVIRVmwVphWCtNSxw6JdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GCp2bpZjJ8cFUAGAJbQIe6A/1ubpcF6CjK9KguApv0f/qYuS9PNbDQEwJ86BXjjq0
	 gM5OQd5lVrzdv3I0Ky7aX2TwgyBwmdrlOF0JcpbA7ojJxbR05uGp71T0hSqId2oaeo
	 CzdlwqHsmnGdbjh63IelT/LBR8h4u/GjQ12zwBR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 337/666] mtd: spi-nor: update spi_nor_fixups::post_sfdp() documentation
Date: Wed, 20 May 2026 18:19:08 +0200
Message-ID: <20260520162118.537152597@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252513-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3BFB1595D57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 3620d67b48493c6252bbc873dc88dde81641d56b ]

After commit 5273cc6df984 ("mtd: spi-nor: core: Call
spi_nor_post_sfdp_fixups() only when SFDP is defined")
spi_nor_post_sfdp_fixups() isn't called anymore if no SFDP is detected.

Update the documentation accordingly.

Fixes: 5273cc6df984 ("mtd: spi-nor: core: Call spi_nor_post_sfdp_fixups() only when SFDP is defined")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 3aeca2299ddb1..df07ded382605 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -412,7 +412,7 @@ struct spi_nor_flash_parameter {
  *                   number of dummy cycles in read register ops.
  * @smpt_map_id: called after map ID in SMPT table has been determined for the
  *               case the map ID is wrong and needs to be fixed.
- * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
+ * @post_sfdp: called after SFDP has been parsed (is not called for SPI NORs
  *             that do not support RDSFDP). Typically used to tweak various
  *             parameters that could not be extracted by other means (i.e.
  *             when information provided by the SFDP/flash_info tables are
-- 
2.53.0




