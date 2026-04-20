Return-Path: <stable+bounces-239428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NRtODBd5ml6vQEAu9opvQ
	(envelope-from <stable+bounces-239428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:06:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5943091E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A248B38CF705
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B733262B;
	Mon, 20 Apr 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0NWYhSan"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E32C236B;
	Mon, 20 Apr 2026 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700228; cv=none; b=CDJfWlsIv2LIloRPdEPHXr/YzvZS3mMe8i1L+AP7OCT3/3O5u6e+dRHZPDh0gcdVQ7h6ZCXof2Oce5AHHAWcOvObZrdYMeBBSUAP21NLWWrkNH2PV+LnedS7cdcXm2Y5vvygr2pQDUjr/8WAWz92aPkg+eMiaRpxE+GlDHxlOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700228; c=relaxed/simple;
	bh=h7BAcTrhn9M192jlZRSh/zUpfqGjrpCoi6DNwi8sHhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQUBQcWfSzL+RyLERZuE8a5f6ggyRAbpmCVGeOAwckFhCW3z340Pa+aiPDVYRVJVhBJF9PK15ZGnzVGIWyT9SLpUZA/lgeDyaHdIF3H+61Ja57McTJf2XewYaJTUureJbzsYL6s8jS6ovmmGRqRRhh48E29uN1ApwCOWt3ekbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0NWYhSan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB3AC2BCB6;
	Mon, 20 Apr 2026 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700227;
	bh=h7BAcTrhn9M192jlZRSh/zUpfqGjrpCoi6DNwi8sHhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0NWYhSang4oIjaNrHCBwoG2j4ejRigq85A3y/RZi4Z/PrS44KJxz3DV+4qMOICAlG
	 N/jP2NTi9iE+DvXzQvvz62LnwijBg6kIr6n1ymt0rttNLhx6aG6gE6cyI/NLQ+IEIb
	 UGiRtkOwjG1PoD59P1hrpmBw2PkuAbOEPKAJ/S7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 090/220] dt-bindings: net: Fix Tegra234 MGBE PTP clock
Date: Mon, 20 Apr 2026 17:40:31 +0200
Message-ID: <20260420153937.276091689@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239428-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 70F5943091E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit fb22b1fc5bca3c0aad95388933497ceb30f1fb26 ]

The PTP clock for the Tegra234 MGBE device is incorrectly named
'ptp-ref' and should be 'ptp_ref'. This is causing the following
warning to be observed on Tegra234 platforms that use this device:

 ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
 WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed

Although this constitutes an ABI breakage in the binding for this
device, PTP support has clearly never worked and so fix this now
so we can correct the device-tree for this device. Note that the
MGBE driver still supports the legacy 'ptp-ref' clock name and so
older/existing device-trees will still work, but given that this
is not the correct name, there is no point to advertise this in the
binding.

Fixes: 189c2e5c7669 ("dt-bindings: net: Add Tegra234 MGBE")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260401102941.17466-3-jonathanh@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/net/nvidia,tegra234-mgbe.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
index 2bd3efff2485e..215f14d1897d2 100644
--- a/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
+++ b/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml
@@ -42,7 +42,7 @@ properties:
       - const: mgbe
       - const: mac
       - const: mac-divider
-      - const: ptp-ref
+      - const: ptp_ref
       - const: rx-input-m
       - const: rx-input
       - const: tx
@@ -133,7 +133,7 @@ examples:
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS_M>,
                  <&bpmp TEGRA234_CLK_MGBE0_RX_PCS>,
                  <&bpmp TEGRA234_CLK_MGBE0_TX_PCS>;
-        clock-names = "mgbe", "mac", "mac-divider", "ptp-ref", "rx-input-m",
+        clock-names = "mgbe", "mac", "mac-divider", "ptp_ref", "rx-input-m",
                       "rx-input", "tx", "eee-pcs", "rx-pcs-input", "rx-pcs-m",
                       "rx-pcs", "tx-pcs";
         resets = <&bpmp TEGRA234_RESET_MGBE0_MAC>,
-- 
2.53.0




