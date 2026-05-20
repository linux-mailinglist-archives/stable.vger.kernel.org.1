Return-Path: <stable+bounces-252767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP0bAw4pDmqk6gUAu9opvQ
	(envelope-from <stable+bounces-252767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:35:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6074D59B0DA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA8839E14A7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE53FD14D;
	Wed, 20 May 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6zxX6BL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7693F9296;
	Wed, 20 May 2026 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301537; cv=none; b=eciic6lO99jZuiJ4C7+MAaK2SYlb0WQFRh/i/+HdmQvmtYKe8T9NFnfoshj+WkNdfZRR2AcDxfnDX79f+ORJqKfPVdzapkvzHJKG1a3AyqdJmjUlfuuvI6xQoVyLCNZJicb+x4lPalvJ1W0KKsUb8SmOAmK3wIkNPlxl/bAW5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301537; c=relaxed/simple;
	bh=63FcdFOVROcleBa1qLeA9cDlkOBIUjYIfnPIjIlAJ4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZUPn2w76gWnxluXdkfZjI4wJt4MlRmYZmApqGA7ZbHSEc3Nvsb4M69tCYyptgxTBaRxG8aZS4GuQWFvPZtwMiKLxkHstzuV61+wF4g/L3PQLBgjFz3pnOSO8dTIiOMvkm8JGQOxAK/2RrH84H9Cr71f9HAihGMWPAIDz3Z+wE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6zxX6BL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A7C1F000E9;
	Wed, 20 May 2026 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301536;
	bh=8AINpeB7+D4fUTMjg4XXPo+3A3eCTrPBHxKjrSQ1efE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6zxX6BLVBRjTjvgdcUPm0SuY/z6qf/z2TIgV7PgaLlmXwjgylE6O1lJSoBVzivw6
	 Zqj690AXyRXhoMwP/YXoQ6i2HZSo+SHJx5XQmpm7zCVPoWJ/EBc5t9PzwFpzbTTF0T
	 TiIst/GWsh7MzUbVt0YyFoB2D3zSEMCV4aNEO+L0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <error27@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 592/666] sfc: fix error code in efx_devlink_info_running_versions()
Date: Wed, 20 May 2026 18:23:23 +0200
Message-ID: <20260520162124.095771047@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252767-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6074D59B0DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit 051ffb001b8a232cfa6e72f38bb5f51c4270a60b ]

Return -EIO if efx_mcdi_rpc() doesn't return enough space.

Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Link: https://patch.msgid.link/afGpsbLRHL4_H0KS@stanley.mountain
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/efx_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index 3cd750820fdde..d5a4b3cf94544 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -530,7 +530,7 @@ static int efx_devlink_info_running_versions(struct efx_nic *efx,
 	if (rc || outlength < MC_CMD_GET_VERSION_OUT_LEN) {
 		netif_err(efx, drv, efx->net_dev,
 			  "mcdi MC_CMD_GET_VERSION failed\n");
-		return rc;
+		return rc ?: -EIO;
 	}
 
 	/* Handle previous output */
-- 
2.53.0




