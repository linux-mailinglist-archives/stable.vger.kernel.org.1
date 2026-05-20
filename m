Return-Path: <stable+bounces-250604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHRDBv7nDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:57:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7A592B4A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CA7430B3862
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A660363C6F;
	Wed, 20 May 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCsu6iXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596722F01;
	Wed, 20 May 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295845; cv=none; b=cHNJ33+oJEqu0SqyPTTRgATsI1RFqnXLESz7zlsE34uUy2ZdbUk1JGDin0YOEuMdzyCcwyL+c6Bb6rZ7NPtih/yMCVpqeF3/nf3Mr3/Y4aUY0yY7qmKKS4X2OB1pS2BOFkZx1CKMiOlS4kB9NqLd/B3l1ZB8DcfE3m/Qj//5uOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295845; c=relaxed/simple;
	bh=3lXpzDhanay9VKbvItF5A0boy98jX/LfwUOOVqltkUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myVVdCb22u/ydmYY/eMsCx3SIb3gnY4Xvlx+q5YaYET01YnmsiO6Cgzaue92wQvuMpTWokow4rcFKYkKtLLZpoeY+qEc4R579GHUtnm4IZhxkRUklXqm1uKhPkdSjWvqu2iYohXt/MMhAVUg2U/vekadtkVZdr9VlvJFT010Fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCsu6iXt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DE91F000E9;
	Wed, 20 May 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295844;
	bh=o/U3+HV8aarztColwFJ30G5mfGuVEt66+1KXtTzIo8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCsu6iXtc64dDxxJHLnaEOIWh9IEWrUyJfR8rjb/Ks9vStxEWKplS0qI4rkwxDuD8
	 O4lfVLx8H5tGEzNz4o1fSjnSCR+62zY29cZAgPiDcscL07pFoLem9ipjMOOtf/jSxm
	 ImkmH41XFsjgWllMwSzlLIyyXQyx5G7lrH6AHqUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cole Leavitt <cole@unwrap.rs>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0575/1146] soundwire: bus: demote UNATTACHED state warnings to dev_dbg()
Date: Wed, 20 May 2026 18:13:45 +0200
Message-ID: <20260520162201.196008607@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250604-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cirrus.com:email,unwrap.rs:email]
X-Rspamd-Queue-Id: 89F7A592B4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index fb68738dfb9b8..fe5316d93fefe 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1899,8 +1899,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 		if (status[i] == SDW_SLAVE_UNATTACHED &&
 		    slave->status != SDW_SLAVE_UNATTACHED) {
-			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
-				 i, slave->status);
+			dev_dbg(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
+			i, slave->status);
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
 
 			/* Ensure driver knows that peripheral unattached */
@@ -1951,8 +1951,8 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
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




