Return-Path: <stable+bounces-252494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD8zB+P6DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B8595BF6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605353056632
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D13F8896;
	Wed, 20 May 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KEQkHRB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6E3F871A;
	Wed, 20 May 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300820; cv=none; b=MzYrQHu08ASPbzd3niu8plk8RpiYnVJt61tjBnpadJcqaujkYlB0bZDAENMKjv+sYTiNrkYrQ3zN5sJH4pfb5u4Oh8BFqTNijNw5OHOnw1d6O3bKvvzNN8IPDI7GVhaOhmqam9FhPbYGIQgdkwlSh0hLQCCzRGYIkVJKdrDG/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300820; c=relaxed/simple;
	bh=ivxqdsc9yhzFHDr7gO6ueaVcRqyTOrPEGrnE7uKaykU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF165gJnOswpiFGqwFMBGfzuLxQvpEOuQg2iN5Gx0IQXrDyEXZOToyeNQ7sHx6+I2uFSEFI5dBXMiKo/lPgDtsxyC9UTOtxf/1G/vx09avv+tJpiTHAuzcXSHkPPw/QzNCT2Vjpo0AJcgbBlXozEBzfXh8Z3GqFI4JNjgskgV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KEQkHRB0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F151F00894;
	Wed, 20 May 2026 18:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300819;
	bh=6qGaTF2ZQe1vVgBeCXNqCX18+zSVFp5H2EuoBsUbubE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEQkHRB06LfueJnZH73Uyxbo//ulWi0EuHpQZnLhY5adqL7nQb5aFeUSHdJWMVzQm
	 UHijJxql8T3UK01hRDWSzeG3fAKCSkxY/wa/L2pgwXAQKZDKrbbB08YXtSJYuRerM9
	 ssXs8i81DyKsMJySGWETwNBH52lazjQPvgpCHEdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cole Leavitt <cole@unwrap.rs>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 320/666] soundwire: bus: demote UNATTACHED state warnings to dev_dbg()
Date: Wed, 20 May 2026 18:18:51 +0200
Message-ID: <20260520162118.158531143@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252494-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,cirrus.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 858B8595BF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cole Leavitt <cole@unwrap.rs>

[ Upstream commit 2c96956fe764f8224f9ec93b2a9160a578949a7a ]

The dev_warn() messages in sdw_handle_slave_status() for UNATTACHED
transitions were added in commit d1b328557058 ("soundwire: bus: add
dev_warn() messages to track UNATTACHED devices") to debug attachment
failures with dynamic debug enabled.

These warnings fire during normal operation -- for example when a codec
driver triggers a hardware reset after firmware download, causing the
device to momentarily go UNATTACHED before re-attaching -- producing
misleading noise on every boot.

Demote the messages to dev_dbg() so they remain available via dynamic
debug for diagnosing real attachment failures without alarming users
during expected initialization sequences.

Fixes: d1b328557058 ("soundwire: bus: add dev_warn() messages to track UNATTACHED devices")
Signed-off-by: Cole Leavitt <cole@unwrap.rs>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20260218180210.9263-1-cole@unwrap.rs
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6c7989e2079e0..25efafd89c036 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1866,8 +1866,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 		if (status[i] == SDW_SLAVE_UNATTACHED &&
 		    slave->status != SDW_SLAVE_UNATTACHED) {
-			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
-				 i, slave->status);
+			dev_dbg(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
+			i, slave->status);
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
 
 			/* Ensure driver knows that peripheral unattached */
@@ -1918,8 +1918,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			if (slave->status == SDW_SLAVE_UNATTACHED)
 				break;
 
-			dev_warn(&slave->dev, "Slave %d state check2: UNATTACHED, status was %d\n",
-				 i, slave->status);
+			dev_dbg(&slave->dev, "Slave %d state check2: UNATTACHED, status was %d\n",
+			i, slave->status);
 
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
 			break;
-- 
2.53.0




