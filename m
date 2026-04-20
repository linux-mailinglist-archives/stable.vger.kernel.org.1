Return-Path: <stable+bounces-239404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABicDyxf5mndvQEAu9opvQ
	(envelope-from <stable+bounces-239404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:15:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B41430D31
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6746434AB8B1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7A336EC9;
	Mon, 20 Apr 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ixWnqToT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B23368AF;
	Mon, 20 Apr 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700160; cv=none; b=B0cxmGnYv7v2hkDjQ+9sA13NtgNTpqPxKY/nPX95hF3nEaPptf/mn1WlUlB8VUiEimHHHqWSpKVLr1xh21bsDNuGl8YX3/gqbs0S4gXd6BxAPxPy5KHcT8g2v3RynJyAWDFW932hs4402MJaCqoMDncDVK6ysApub3nde1MemEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700160; c=relaxed/simple;
	bh=/4iw1bszcflLQDnlGji4LaoB8L58WqJwg3pAUUdjzXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey6UUswa5k0uWUkvq1+CMWmKSGYpcOYxQWUEhJsB3d2ydErPy95k09Q9VmyI3W6L+OhuOSgs2Qppd5kbacBXgFsBOkorm8s/yPzk98n+yx22YBGdViwuFN9mbtWo9kjB0gSZ8Upk6rA48g+aK7rxlKH+4F7BakOp4ZNgPAGE1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ixWnqToT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BFFC19425;
	Mon, 20 Apr 2026 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700160;
	bh=/4iw1bszcflLQDnlGji4LaoB8L58WqJwg3pAUUdjzXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixWnqToTybu8lN0fsWqTI9HmV0BJaieeTElg+mP/bGhSkwu/zQQSXLjcu4hcNNRP2
	 +SFZrowbHvL/U9IITVRYz6zOUmVKX2ERaAIm1pVwMYz5qoK7ifB6eiw0521N9iutiR
	 XQIvxL8vX5mtZk0VB2gvqwD723IukPXtQ1jhDpoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mihai Sain <mihai.sain@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 064/220] ARM: dts: microchip: sam9x7: fix gpio-lines count for pioB
Date: Mon, 20 Apr 2026 17:40:05 +0200
Message-ID: <20260420153936.345693133@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239404-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tuxon.dev:email,microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41B41430D31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mihai Sain <mihai.sain@microchip.com>

[ Upstream commit 907150bbe566e23714a25d7bcb910f236c3c44c0 ]

The pioB controller on the SAM9X7 SoC actually supports 27 GPIO lines.
The previous value of 26 was incorrect, leading to the last pin being
unavailable for use by the GPIO subsystem.
Update the #gpio-lines property to reflect
the correct hardware specification.

Fixes: 41af45af8bc3 ("ARM: dts: at91: sam9x7: add device tree for SoC")
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Link: https://lore.kernel.org/r/20260209090735.2016-1-mihai.sain@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/microchip/sam9x7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
index 46dacbbd201dd..d242d7a934d0f 100644
--- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -1226,7 +1226,7 @@ pioB: gpio@fffff600 {
 				interrupt-controller;
 				#gpio-cells = <2>;
 				gpio-controller;
-				#gpio-lines = <26>;
+				#gpio-lines = <27>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 3>;
 			};
 
-- 
2.53.0




