Return-Path: <stable+bounces-218678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL9IFCdTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B118F700
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4050E300C0D0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADAD265CA6;
	Wed, 25 Feb 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKVhP+jh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6D1E2834;
	Wed, 25 Feb 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983534; cv=none; b=GTJmLbx1WAsMWPmfqNX5XsHpT0dTNOEAVXbEOfaiT3CkEAwpXYB0TKyK8GIB0rsuaPSdPfMdYhzQeYHeb59HVLY2J2A6iGZZGSepfZXCp7Gn85pRWLGQzWri/XmoZ/g5/NwkHNBxFXEv8oLB9uJRUUxqAEpBqiGgB74rk0+6NJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983534; c=relaxed/simple;
	bh=dJjt3JLLnOZMZ4x7FtHNDe3L4GbHYjmbNw0ZS04+fRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok3uL7T2jmnzJV2rcFrG7NH0CSrvT8Nu9N7sH0Fr9iSHdPVuh4DnC6v88b6GuCmIxtU17d2YJXxwuK0/oiRzXQLTFPil0r2SBYJES87XOaGaTFwfFODj2oUIHwuAbE5cznlC95ifIhYeSRXuCqkRNfK4k1L/w6TfIM0VqiI4m6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKVhP+jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE73C116D0;
	Wed, 25 Feb 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983534;
	bh=dJjt3JLLnOZMZ4x7FtHNDe3L4GbHYjmbNw0ZS04+fRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKVhP+jhw3Hp7QDmvqSJhDcF63DZV/s9ES6WNR84FZs3JHIpgFzyRmvyvTJeQdTMW
	 m3UuTBddbceJuaXYjKcMQ03UecOgecZIL5M/oduI98YnmJW9IZpKdw9gCLrRuMKcST
	 8tMMaabOjQKJ5JxYctFs1BH4A1F2+JZn4ZNMISug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Machon <daniel.machon@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 639/781] net: sparx5/lan969x: fix DWRR cost max to match hardware register width
Date: Tue, 24 Feb 2026 17:22:28 -0800
Message-ID: <20260225012415.478694523@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218678-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,microchip.com:email]
X-Rspamd-Queue-Id: EB0B118F700
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Machon <daniel.machon@microchip.com>

[ Upstream commit 6c28aa8dfdf24f554d4c5d4ff7d723a95360d94a ]

DWRR (Deficit Weighted Round Robin) scheduling distributes bandwidth
across traffic classes based on per-queue cost values, where lower cost
means higher bandwidth share.

The SPX5_DWRR_COST_MAX constant is 63 (6 bits) but the hardware
register field HSCH_DWRR_ENTRY_DWRR_COST is GENMASK(24, 20), only
5 bits wide (max 31). This causes sparx5_weight_to_hw_cost() to
compute cost values that silently overflow via FIELD_PREP, resulting
in incorrect scheduling weights.

Set SPX5_DWRR_COST_MAX to 31 to match the hardware register width.

Fixes: 211225428d65 ("net: microchip: sparx5: add support for offloading ets qdisc")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260210-sparx5-fix-dwrr-cost-max-v1-1-58fbdbc25652@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
index 1231a80335d7b..04f76f1e23f60 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
@@ -35,7 +35,7 @@
 #define SPX5_SE_BURST_UNIT 4096
 
 /* Dwrr */
-#define SPX5_DWRR_COST_MAX 63
+#define SPX5_DWRR_COST_MAX 31
 
 struct sparx5_shaper {
 	u32 mode;
-- 
2.51.0




