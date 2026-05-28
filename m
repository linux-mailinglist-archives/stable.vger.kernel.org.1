Return-Path: <stable+bounces-255503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPx7AuChGGqblggAu9opvQ
	(envelope-from <stable+bounces-255503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A11455F8189
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10B63305E7DD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFCE335566;
	Thu, 28 May 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wqgOANNW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80932ABC0;
	Thu, 28 May 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999094; cv=none; b=UHBYFt9hHl/vjf+IhRF6shJ2GL5W3Z4yggpGTl6xQ7nqHoAnE7imhWWuk+8N/W0g5nPhqAaTFl/fjauamnHbLea0BO5zN1ZByJ9JqOlLCmHmSVaReIgqBGJvGS2JBY4wABhsU1DxcC04+hOuD5QVKfgSkzkGtkeULuVb2+woJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999094; c=relaxed/simple;
	bh=GOLeDGq/P0pox/fYvDajz7pFyAVGwh6lcggUcjZmbJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhskAMhcTOlcXDgMQqCodtErmd7J1OjfLdyPE8hWUyKyYl4HFKK62mtUeaYMEaeMKhcb3DDbaHRnTb8ARgoMiCNTdClLNSpO3wMWdaYItTBogUcRK4DdEhksOFaXXYoyQAyfP41UyvC9+bF7+24FEycNqtt/QXVfmq3FUAYybc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wqgOANNW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98DD1F000E9;
	Thu, 28 May 2026 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999093;
	bh=CqT1mDtDrMS49Dt+h5i98A1d9ULApvv/gO7AAY9/Tic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wqgOANNWI4IEvYRYHLLSY5HU6DMVeczkk+12KSxHjzx+O+bn3OhcKHHDlND20hAz3
	 W9NLH13ks6EOco1CApGM3S8O9qQ3MksTNUMfZ6cKuRagOH6rZ1hL6hykzJBTeoJRvL
	 I3v0SX65bschwt8EEEMTHHsZR0vB073nwvBe2YGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Nikhil P. Rao" <nikhil.rao@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 407/461] pds_core: fix error handling in pdsc_devcmd_wait
Date: Thu, 28 May 2026 21:48:56 +0200
Message-ID: <20260528194659.263521644@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255503-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: A11455F8189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikhil P. Rao <nikhil.rao@amd.com>

[ Upstream commit 0e46b6635b03d29807f810c3b415c4755a3f958d ]

Fix two cases where pdsc_devcmd_wait() returns stale success from
the completion register instead of an error:

1. FW crash: If firmware stops running, the wait loop breaks early with
   running=false. The condition "if ((!done || timeout) && running)" is
   false, so error handling is bypassed and stale status is returned.
   Check !running first and return -ENXIO.

2. Timeout: If a command times out, err is set to -ETIMEDOUT but then
   overwritten by pdsc_err_to_errno(status) which reads stale status.
   Return -ETIMEDOUT immediately after cleaning up.

Both errors now propagate to pdsc_devcmd_locked() which queues
health_work for recovery.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Link: https://patch.msgid.link/20260515212907.998028-1-nikhil.rao@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 2e1d0d01d03af..bded6b33289ce 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -162,12 +162,19 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 		dev_dbg(dev, "DEVCMD %d %s after %ld secs\n",
 			opcode, pdsc_devcmd_str(opcode), duration / HZ);
 
-	if ((!done || timeout) && running) {
+	if (!running) {
+		dev_err(dev, "DEVCMD %d %s fw not running\n",
+			opcode, pdsc_devcmd_str(opcode));
+		pdsc_devcmd_clean(pdsc);
+		return -ENXIO;
+	}
+
+	if (!done || timeout) {
 		dev_err(dev, "DEVCMD %d %s timeout, done %d timeout %d max_seconds=%d\n",
 			opcode, pdsc_devcmd_str(opcode), done, timeout,
 			max_seconds);
-		err = -ETIMEDOUT;
 		pdsc_devcmd_clean(pdsc);
+		return -ETIMEDOUT;
 	}
 
 	status = pdsc_devcmd_status(pdsc);
-- 
2.53.0




