Return-Path: <stable+bounces-224436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF+8MmMFsGlregIAu9opvQ
	(envelope-from <stable+bounces-224436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:49:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 147BD24B9DB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D34423043519
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A938A28F;
	Tue, 10 Mar 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ/eJGuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F43389DEF;
	Tue, 10 Mar 2026 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142169; cv=none; b=BRC49ImL55gnJqIAgNDHiOFlHcC0oCSCcCp/847jtDoKwDNkGZyis5rjJcNgOuV29YQfApVw3LpqjVSnWkVRg8XQCQ87OTYIlQdMdcxZIZS30Ra8cW+6+2EZKHr8H+oAuWspmaI93ibvQFLo8mznc9Y96Q2FwAEjwsoJMTjSa2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142169; c=relaxed/simple;
	bh=rtfGrCfs+MnENY0aRTRF2wfF6nliyrn8/nswJqUofi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HN7/fRMqJtdoWJV7+ZtgFE5yHgyOPRr+dK381X+T/gFPSgZ9yF7wvALKT/8z1JCxN+etd1wqUtmFCJNdEak6MgpcHuI8ads59AcXlxreUcpYU3M/KeySJST0Ff/NovyXcyI9W7Wh4L21YxSd0r20QvKCSsbYJm0dxfU/g6fseJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ/eJGuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B86BC2BC86;
	Tue, 10 Mar 2026 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142168;
	bh=rtfGrCfs+MnENY0aRTRF2wfF6nliyrn8/nswJqUofi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJ/eJGuFW4SdQR//5iB78RA5rcwNsaiStcLcubj2MiZP+tESTXYhcfMZU/sG2oP/G
	 iudCupsdgHMpnScZOZmyvQosgF883LCnVulOyX051utCGRZ1kNBWsl/ljE/Xk/9DRS
	 u/2mZQDsgJUTardk/7d7fhmZlRBVVfXRIvQ/Svm3s0VUTNMGaNBzbkmbbHDoPtnaBN
	 jkrlJBsxCs8yreDjI6E0K2Vk/77XMXqJBWKCGrbBMtkowdoDoVOWNOIKw5d2N/qHnG
	 I4vzK2P5nrzfSed32hB+0X7G4K2r8qGyDk1Kfxx7Zv6CUYYJ+Esb22NBvW84P5tAGk
	 TARddLVgkJDsg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 257/314] wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_80211()
Date: Tue, 10 Mar 2026 07:18:36 -0400
Message-ID: <99457eba1385c2fb2fdfb7613f4e56cc00f4f564.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 147BD24B9DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224436-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 4e10a730d1b511ff49723371ed6d694dd1b2c785 ]

Check frame length before accessing the mgmt fields in
mt76_connac2_mac_write_txwi_80211 in order to avoid a possible oob
access.

Fixes: 577dbc6c656d ("mt76: mt7915: enable offloading of sequence number assignment")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260226-mt76-addba-req-oob-access-v1-3-b0f6d1ad4850@kernel.org
[fix check to also cover mgmt->u.action.u.addba_req.capab,
correct Fixes tag]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0db00efe88b0b..837bd0f136fa1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -411,6 +411,7 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 	u32 val;
 
 	if (ieee80211_is_action(fc) &&
+	    skb->len >= IEEE80211_MIN_ACTION_SIZE + 1 + 1 + 2 &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
 	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
 		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
-- 
2.51.0


