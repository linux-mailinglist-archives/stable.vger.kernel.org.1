Return-Path: <stable+bounces-253105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPEOFkguDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:57:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C304659B85C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F9D3395C8A0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726F3401A1F;
	Wed, 20 May 2026 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kWgW10oF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC9401A0B;
	Wed, 20 May 2026 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302418; cv=none; b=X8ecRCmkT00cRe9Q+wDWTPrR0aCwLwyIkO5vgjnoHhmPY4z/XTwnpb/bhAk0BuZ7XfjhQjltgJRsFmqLaUTV4hGDDgKlCauStn2dxhwmzr1PDlnj6jQGBoCpk0y3uE7Lw8BTR6+sN1erlij6ESZUOa59ZWmkmNHrnSpCxHqo1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302418; c=relaxed/simple;
	bh=YVQOk2puGMPA3K5rrgzQKXjPTG4AAYFmM/o9Owbce6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4hQx+CoPe/K0cgU3mrs0ThNbTjeKJGJsrqxrrpBPA5w7aNNusGVX1MtEI9tMpZpCXOnoXEOMPUVhh942w5y6vwQaSN029/TtngWUQyvq0NQU0k/3fs8CAlC1lTRzCTCxZTBEF42pMYcaQZfKWifVmeMdlrYBXArp+/9nGZaDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kWgW10oF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF3A1F000E9;
	Wed, 20 May 2026 18:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302417;
	bh=X+UqHr3NRWYawGIAOfvQAh/llKnlGrLa0w2Cb10wT/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWgW10oFlRLBiO21u1o7nF/govd5C7O59taEa704EmxBp4HDE6sd+se77wG92k1je
	 ZAHKFsbRFAVJTqFxdPSEPRjihaXMfEF8ZOATXSI5te+/pnfDSdL8XWa+BqPpi+19DN
	 xF9+58K/u2me/IFjXisXzSuSuarOO4LjtBsDXIrg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cole Leavitt <cole@unwrap.rs>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 217/508] soundwire: bus: demote UNATTACHED state warnings to dev_dbg()
Date: Wed, 20 May 2026 18:20:40 +0200
Message-ID: <20260520162103.341961254@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253105-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,unwrap.rs:email,cirrus.com:email]
X-Rspamd-Queue-Id: C304659B85C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index e7397fd8e9ad9..50448a4dd0b38 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1864,8 +1864,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 		if (status[i] == SDW_SLAVE_UNATTACHED &&
 		    slave->status != SDW_SLAVE_UNATTACHED) {
-			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
-				 i, slave->status);
+			dev_dbg(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
+			i, slave->status);
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
 
 			/* Ensure driver knows that peripheral unattached */
@@ -1916,8 +1916,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
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




