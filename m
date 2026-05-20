Return-Path: <stable+bounces-250747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNU2NdwTDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-250747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49210599185
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD934357ED35
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DA3A3833;
	Wed, 20 May 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VawPBAso"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763337D101;
	Wed, 20 May 2026 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296212; cv=none; b=CJjtKC3PHRpAQwAFMKuL7BXrAWFu2ybiMFbwVpTzGOv5scIPahaBL6jfcOzcRa2efVUe3WJYp/zuESgjRsbj3973eqT0YRG6gZmiomiW745boPaMBPa13H5VQyvdR4Cc1Ybbn0AfaC7Sy4MS3//OWdZo2FPGVwAgnj0bkQc/rgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296212; c=relaxed/simple;
	bh=3H0fiKbj9vONXRvP+r9CUo1Q20nivkqkbGLasd7Z6hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap/Ukhoc5U08n1u1dUD7aUx/iE71qCAYjU7pmdqhGOxdtMkZuVXWnEhTZivOvjYGlid29yfkNyLSg1+EG7Vn96q3SxDP0fjP9KpN1BN5C8IH/jVPMdt0o3/shMBRTaXZidFSXSwYTKcOfU4XeppeERpf8g/t+oZOnkEN9AWK2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VawPBAso; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116211F00893;
	Wed, 20 May 2026 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296210;
	bh=mY/4iBIGhL558igHASboCTeh0I5apaOldj2h6pM+sZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VawPBAsorevLaUCTRa9XK+OZuETk9VqItMyFPN31hRj1n1M+SVkbKP/XT+IMfyE7T
	 1l1WQdh5pkeHM3vaGt8O53BdRlJBbKvWIhS51QYbtuM1nFgiBwu5TbzcMf7IYShLsR
	 BPN9PjN5Gqv7sbiG5MSTgfP2G2IbtSnQb7QtBWhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0713/1146] scsi: ufs: rockchip,rk3576-ufshc: dt-bindings: Add new mphy reset item
Date: Wed, 20 May 2026 18:16:03 +0200
Message-ID: <20260520162204.324244037@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250747-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 49210599185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit bdce3a69c578090dd5e3c77bcdaaca10c3a41e34 ]

Add the mphy reset property to the devicetree bindings for the Rockchip
RK3576 UFS host controller. The mphy reset signal is used to reset the
physical adapter. Resetting other components while leaving the mphy unreset
may occasionally prevent the UFS controller from successfully linking up
with the device.

This addresses an intermittent hardware bug where the UFS link fails to
establish under specific timing conditions with certain chips. While
difficult to reproduce initially, this issue was consistently observed in
downstream testing and requires explicit mphy reset control for full
stability.

Although this change increases the maxItems for resets and adds a new entry
(which technically alters the binding ABI), it does not break compatibility
for existing Linux systems. The driver uses
devm_reset_control_array_get_exclusive() to manage resets, allowing it to
function correctly with both older Device Trees (without the mphy entry)
and newer ones.

Fixes: d90e92023771 ("scsi: ufs: dt-bindings: Document Rockchip UFS host controller")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/1773368467-109650-1-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml     | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
index c7d17cf4dc42b..e738153a309c8 100644
--- a/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
+++ b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
@@ -41,7 +41,7 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 4
+    maxItems: 5
 
   reset-names:
     items:
@@ -49,6 +49,7 @@ properties:
       - const: sys
       - const: ufs
       - const: grf
+      - const: mphy
 
   reset-gpios:
     maxItems: 1
@@ -98,8 +99,8 @@ examples:
             interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
             power-domains = <&power RK3576_PD_USB>;
             resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>, <&cru SRST_A_UFS>,
-                     <&cru SRST_P_UFS_GRF>;
-            reset-names = "biu", "sys", "ufs", "grf";
+                     <&cru SRST_P_UFS_GRF>, <&cru SRST_MPHY_INIT>;
+            reset-names = "biu", "sys", "ufs", "grf", "mphy";
             reset-gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_LOW>;
         };
     };
-- 
2.53.0




