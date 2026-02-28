Return-Path: <stable+bounces-220390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMJ0HBA0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB21C5DC6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD19F332174A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8E63A8E1D;
	Sat, 28 Feb 2026 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/B/WxTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB063A8E10;
	Sat, 28 Feb 2026 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300283; cv=none; b=mn8E9vbHI5pw7kfl23VuaHqodKAoA2RtRRDbp0tm5tAyxt/Ve6mz+BzI1lPPB0YYwWXfgyV3FK8jUUEU3+PVK7+gDYA7t4yN+rgA/+T/N95fJJlYwg5k3AOO95UplrfR+RePOa+KkxJT/4Qx4EIrUK7PlswvtJpLXGNm6a2cXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300283; c=relaxed/simple;
	bh=LA3/TqVyfM6rXtgOiZo+UUq4qe5bn3h1BzNRYOGH/Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsDABlZHZ1WvBjwbl+a+QbF620hi5+szIgzXaQVeTwKI5LUs5Y3Z7iRscOhJB321UYtnl/DjE45gl/6v1T3k80bedRCs0Lgy+HB7AC68gtjgBl+LmZp9d1GYxYDk1mS2fKFv+tuH0w1AEkmxM2sdCihhS+MTgMPRdldCwuG0rVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/B/WxTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7991C19423;
	Sat, 28 Feb 2026 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300283;
	bh=LA3/TqVyfM6rXtgOiZo+UUq4qe5bn3h1BzNRYOGH/Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/B/WxTtxq8iyVmldY4MpFB4xvhjSOFBQBEL9AC/FlYv15P4KiNC+Tt38N24EJQDp
	 BDsOURMpBcm4nzSyP31dD3dnID3HwiQ4QndcKZgy7C+C86IoF0PXi9r//Vjjg0a1kE
	 OhfbRO6PIvESbGCcDM8TxVXyC3odG37lmEh9raOa/Re8RWLNnJMYMPmRk/frnCpWBa
	 i8Iq9dk0XSMw4DEPYypgpOKcv749DHnnqJhVCynubDRTaybCHb3HGk9krQWOzT9iSe
	 c42I/3qAHAD9iqu021gfxDk9hqY+3nYUEDNLMWt5tsrbLMEdqne44ze9iAxiHi6tK/
	 KzYKgT5t6W+3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 311/844] wifi: iwlegacy: add missing mutex protection in il4965_store_tx_power()
Date: Sat, 28 Feb 2026 12:23:44 -0500
Message-ID: <20260228173244.1509663-312-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[u.northwestern.edu,wp.pl,intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220390-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DDFB21C5DC6
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit e31fa691d0b1c07b6094a6cf0cce894192c462b3 ]

il4965_store_tx_power() calls il_set_tx_power() without holding il->mutex.
However, il_set_tx_power() has lockdep_assert_held(&il->mutex) indicating
that callers must hold this lock.

All other callers of il_set_tx_power() properly acquire the mutex:
- il_bg_scan_completed() acquires mutex at common.c:1683
- il_mac_config() acquires mutex at common.c:5006
- il3945_commit_rxon() and il4965_commit_rxon() are called via work
  queues that hold the mutex (like il4965_bg_alive_start)

Add mutex_lock()/mutex_unlock() around the il_set_tx_power() call in
the sysfs store function to fix the missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260125194039.1196488-1-n7l8m4@u.northwestern.edu
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 3588dec75ebdd..57fa866efd9f8 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -4606,7 +4606,9 @@ il4965_store_tx_power(struct device *d, struct device_attribute *attr,
 	if (ret)
 		IL_INFO("%s is not in decimal form.\n", buf);
 	else {
+		mutex_lock(&il->mutex);
 		ret = il_set_tx_power(il, val, false);
+		mutex_unlock(&il->mutex);
 		if (ret)
 			IL_ERR("failed setting tx power (0x%08x).\n", ret);
 		else
-- 
2.51.0


