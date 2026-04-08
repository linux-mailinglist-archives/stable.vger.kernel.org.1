Return-Path: <stable+bounces-234182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKJhOjyc1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:19:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D73C06E7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D863053DE0
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2E3A16A0;
	Wed,  8 Apr 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kJPyQKjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65ECB67E;
	Wed,  8 Apr 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672195; cv=none; b=UUW513zCCTRw75zx42LnHLN7StNSG/dlrYzjpVyz3Lf70iB8V1N+THAXF2SfKB5zgONLUCQWzp9jP63B1UDq3gT8epJAoQVf0AiHO1EnRfY0Oa2aFrpo7ABLo72xBqWR2i03QrBGxLVLX8uUVPelJfKnCsX//gCEQl5EWbUkR7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672195; c=relaxed/simple;
	bh=cwctjBHK6+vrXV9koSqNkn/ugV4O8of1iUhAUCd0lMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo9bvmJ6Rwmn3Ratqwm0lvx1Vg6YzDDmXWU553RO35osKbtUoi8Mrn0nYo7TImSv3VGH1F6EgfW8pIqoRg7Ir/S4U8cL5Cp4x02LSqVcgQuFAC0KbZIKmTxyM43FpCS/UpkmZAak4h4XOMovaW15/SOqj3J0X7iCf8nQlOvrrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kJPyQKjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A1C19421;
	Wed,  8 Apr 2026 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672195;
	bh=cwctjBHK6+vrXV9koSqNkn/ugV4O8of1iUhAUCd0lMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJPyQKjUqWzVnnyxE2kuZwtXYyqgRPumvLyuaaquqoBf/9v1lfXQ7Vd4g3VN7Obxf
	 Sp0ipFdCKLpfXXcbkMa5Kay6QQlBQiQ/ylGFHw9Niaoo4AVB+YEL5QUYs1bxmcXZhD
	 IEkBUDVCAj5sLEcGkzJIHKn5xDav0dNY/GA+piOU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 194/312] dt-bindings: gpio: fix microchip #interrupt-cells
Date: Wed,  8 Apr 2026 20:01:51 +0200
Message-ID: <20260408175941.003593052@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234182-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:email,microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 4B4D73C06E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamie Gibbons <jamie.gibbons@microchip.com>

[ Upstream commit 6b5ef8c88854b343b733b574ea8754c9dab61f41 ]

The GPIO controller on PolarFire SoC supports more than one type of
interrupt and needs two interrupt cells.

Fixes: 735806d8a68e9 ("dt-bindings: gpio: add bindings for microchip mpfs gpio")
Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260326-wise-gumdrop-49217723a72a@spud
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/gpio/microchip,mpfs-gpio.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
index d481e78958a74..2c7355e9547a1 100644
--- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
@@ -33,7 +33,7 @@ properties:
     const: 2
 
   "#interrupt-cells":
-    const: 1
+    const: 2
 
   ngpios:
     description:
@@ -84,7 +84,7 @@ examples:
         gpio-controller;
         #gpio-cells = <2>;
         interrupt-controller;
-        #interrupt-cells = <1>;
+        #interrupt-cells = <2>;
         interrupts = <53>, <53>, <53>, <53>,
                      <53>, <53>, <53>, <53>,
                      <53>, <53>, <53>, <53>,
-- 
2.53.0




