Return-Path: <stable+bounces-242888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHhkNgRb+GlStQIAu9opvQ
	(envelope-from <stable+bounces-242888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BCF4BA53E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F1DB3001CCA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03837340283;
	Mon,  4 May 2026 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcsXVviD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC510329365
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883901; cv=none; b=lfOpL6/nwlI+rquMY2YQQtVT/PtF9NpBm4xFnMj18Q6SKoa2dktuHF+4JQxhPx7AUAI5Vz0vUi8QaHDyQQ0BVF/JqFrR/CdnSErxpQXf+2Zee9igx8vVBzxcgz2gj3ajGnjVQHa2DtAdIvbX4QaYtp4cd/eHero0gGUMpMJHrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883901; c=relaxed/simple;
	bh=mtQY6jzGH7CXI+fabmyOMI0kwoM3L2OTiPJO+F5o8Xw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MgW40SAwDB7vj3peYtEtnN98G5DPnw45Wt782dHckQzEdFcFPfAYwOodx73CH4CLOJMpcr7Jc7LLX/g4647dCaXm/fUa/xLtL6BF0YiClVwd5ZfV31NWHfxwE8IVdmLUs5oIBiaCUFFIe78wzmPCSIMZVU7Q07l9fHkSnUmngzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VcsXVviD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175A1C2BCB8;
	Mon,  4 May 2026 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777883901;
	bh=mtQY6jzGH7CXI+fabmyOMI0kwoM3L2OTiPJO+F5o8Xw=;
	h=Subject:To:Cc:From:Date:From;
	b=VcsXVviDKZnKl1Iwm/u/LobEZ9lNgpw4yFOIJMp9cxJI4cvnJtXdppLfMvkHnBkLm
	 1y972LzbuoVZg4wxDWtL19D/wL2+GEDennDvKOuNAY3q3lVbVKdenAv/LvI3ZDGRvB
	 o1oozIeIDVue7bZP6manVTUXoOddAxZPjga8inB8=
Subject: FAILED: patch "[PATCH] mtd: spi-nor: sst: Fix write enable before AAI sequence" failed to apply to 5.15-stable tree
To: sanjaikumar.vs@dicortech.com,hd@os-cillation.de,pratyush@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:38:06 +0200
Message-ID: <2026050406-deputize-unengaged-f5c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35BCF4BA53E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242888-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,os-cillation.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a0f64241d3566a49c0a9b33ba7ae458ae22003a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050406-deputize-unengaged-f5c5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0f64241d3566a49c0a9b33ba7ae458ae22003a9 Mon Sep 17 00:00:00 2001
From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
Date: Wed, 11 Mar 2026 10:30:56 +0000
Subject: [PATCH] mtd: spi-nor: sst: Fix write enable before AAI sequence

When writing to SST flash starting at an odd address, a single byte is
first programmed using the byte program (BP) command. After this
operation completes, the flash hardware automatically clears the Write
Enable Latch (WEL) bit.

If an AAI (Auto Address Increment) word program sequence follows, it
requires WEL to be set. Without re-enabling writes, the AAI sequence
fails.

Add spi_nor_write_enable() after the odd-address byte program when more
data needs to be written. Use a local boolean for clarity.

Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
Tested-by: Hendrik Donner <hd@os-cillation.de>
Reviewed-by: Hendrik Donner <hd@os-cillation.de>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 175211fe6a5e..db02c14ba16f 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -203,6 +203,8 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Start write from odd address. */
 	if (to % 2) {
+		bool needs_write_enable = (len > 1);
+
 		/* write one byte. */
 		ret = sst_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
@@ -210,6 +212,17 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/*
+		 * Byte program clears the write enable latch. If more
+		 * data needs to be written using the AAI sequence,
+		 * re-enable writes.
+		 */
+		if (needs_write_enable) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */


