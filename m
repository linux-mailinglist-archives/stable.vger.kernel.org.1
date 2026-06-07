Return-Path: <stable+bounces-261158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qUtTJkRFJWotFgIAu9opvQ
	(envelope-from <stable+bounces-261158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87E64F7AC
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=PS50NR37;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261158-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261158-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C88BF3003632
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62712DB7A3;
	Sun,  7 Jun 2026 10:17:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616E2AD00;
	Sun,  7 Jun 2026 10:17:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827458; cv=none; b=OX0vgq2v7T5nH2JT/ZibG8LThcWZFqdV/G9RUGpD7pCaFFQ5/RYr+83yolYl+/j8eE3u6OKUrtZ6TuzPHOWcQ7ADViWU2nTB30Phr5WBhNNyut+PrQ+kHfNX8jbCP8m/ghWovsRDs8muzAs6G2ogYGrLMfpvIc20feX70d20P9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827458; c=relaxed/simple;
	bh=PXyu85d7mKe85l8sMH+cdyQkWIFgW1C3QKSPOTQKwa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhdy4ymMYz9JZtPJJwlMd2UHV0ZqZ7LdTHrZHYCWRktWNvazVJy1vNy2YN05OF5jYN+kPhznzqoy9a4zJdBkNAUzQN6kabLVOkQsgpKXl+Gm8qCr+/HAxf80cpaj0RRLMt4BUdc/FXgIsw8dq/R9+1GHH51Wzta5oaQrHJya71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PS50NR37; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CA41F00893;
	Sun,  7 Jun 2026 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827457;
	bh=axAw4j+1FZTptNB/reG1pQnUVHIuTaeBOFaN45pB+SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PS50NR378Wi0g4/CKYQHIdHHPrtA3BNrfq4Hevc7SMPJmyrk9jvhm4RRLvAtSDxUD
	 tn6bi8VtegVVRfVOERiMvYxRYF2nWRHqzUUPnO7mTfXETBJcEDn5owYcPTHKW9dzuC
	 6hOSiXLSyKwGPTfbiAZBm1zu7/pT6NbeSybZPaU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 057/307] ethtool: cmis: validate start_cmd_payload_size from module
Date: Sun,  7 Jun 2026 11:57:34 +0200
Message-ID: <20260607095729.831436786@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261158-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:danieller@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A87E64F7AC

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 12c2496a71f82f63617971ca9b730dffa05cf58b ]

The CMIS firmware update code reads start_cmd_payload_size from
the module's FW Management Features CDB reply and uses it directly
as the byte count for memcpy. The destination buffer is 112 bytes
(ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH - 8). So a malicious
module (or corrupted response) can cause a OOB write later on in
cmis_fw_update_start_download().

Let's error out. If modules that expect longer LPL writes actually
exist we should revisit.

struct cmis_cdb_start_fw_download_pl's definition has to move,
no change there.

Fixes: c4f78134d45c ("ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Link: https://patch.msgid.link/20260522231312.1710836-9-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/cmis_fw_update.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index 48aef6220f0094..560bafd4d16864 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -43,6 +43,20 @@ enum cmis_cdb_fw_write_mechanism {
 	CMIS_CDB_FW_WRITE_MECHANISM_BOTH	= 0x11,
 };
 
+/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_start_fw_download_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_start_fw_download_pl {
+	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
+			__be32	image_size;
+			__be32	resv1;
+	);
+	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
+		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
+};
+
 static int
 cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 				   struct net_device *dev,
@@ -85,6 +99,14 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	 */
 	cdb->read_write_len_ext = rpl->read_write_len_ext;
 	fw_mng->start_cmd_payload_size = rpl->start_cmd_payload_size;
+	if (fw_mng->start_cmd_payload_size >
+	    sizeof_field(struct cmis_cdb_start_fw_download_pl, vendor_data)) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Start cmd payload size exceeds max LPL payload",
+					      NULL);
+		return -EINVAL;
+	}
+
 	fw_mng->write_mechanism =
 		rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL ?
 		CMIS_CDB_FW_WRITE_MECHANISM_LPL :
@@ -96,20 +118,6 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	return 0;
 }
 
-/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
- * revision 5.2.
- * struct cmis_cdb_start_fw_download_pl is a structured layout of the
- * flat array, ethtool_cmis_cdb_request::payload.
- */
-struct cmis_cdb_start_fw_download_pl {
-	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
-			__be32	image_size;
-			__be32	resv1;
-	);
-	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
-		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
-};
-
 static int
 cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
 			      struct ethtool_cmis_fw_update_params *fw_update,
-- 
2.53.0




