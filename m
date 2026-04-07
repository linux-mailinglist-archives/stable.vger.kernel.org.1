Return-Path: <stable+bounces-233580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAj6G6vs1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F13ADCE0
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33B1D300D1DC
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C73AEF34;
	Tue,  7 Apr 2026 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="G0Cu5rdh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8553AE71B
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561896; cv=none; b=Ek3T9dixwcAKlcXyxe66YIfMeju4+l68J5674lL+6vYfKBlncQDzC5k2rIEObYm+f7xVBsI5WiBX84jvtMrezi+VxSbKGHvNiY21BUT2g++x7QYQVnHW9lDTcsLGXtP7+9YOSJTMG9vTc2vvBwkJ62q5dWkin36C4Y+eDmShsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561896; c=relaxed/simple;
	bh=1979/CJSxIXA7RmUTdWXvRlZvpOvjqJMQrd17oFuwYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+pCykyjrMi7KKrFday8CoGohwQgs7lNPl7Gc7gBNidkIxaWBjGFtn8YSgqum9rv5G8pnKD6KZnwD6AizB3irgT5beprEyke9AKVwKT78buoPlOMbMPBSvjn5GpMaELVfLJrblY/zDygtaUsi/cS52iclnLvf2C++bZYXR+YCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=G0Cu5rdh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48896199cbaso43648485e9.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561893; x=1776166693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvIPhCgM2XSCzyahNiCNaf7wATwZZ9/IkcIJqugHkAw=;
        b=G0Cu5rdhDKJ2YXQgCAVB/fQG7SP1IJCUxNvpfKPuFev+3FKCP4+QnmS2t666/qa7EQ
         Oo3OZrYLt4cqdREpZjAGLsrrYO7+odnoQq8+CC9W7bBRWpGPxjgyB+BZNs6req5nymK4
         TtnLU8ciIJ9/fFmFBowOZL20lRhes+EEteRTVGBVmbJTOfha7MvXTZfg9Qrms9uAoZ7G
         LA1blHq80zgcu/RYv8hA0qOvfEuhDKxauPuIKpNAAr9/Hfd1VYJMWd75pYVXD3JiTYYd
         HGxi8PDI0MUabtDUOK9XRqcc2mYJMFyvHNGt5kD0jE49l1iGYTaueuUzvvJJU3nsRDkY
         TyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561893; x=1776166693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvIPhCgM2XSCzyahNiCNaf7wATwZZ9/IkcIJqugHkAw=;
        b=Lectbmra62e+JcFB5fyIZ6Gb6FAkkxwk9Kl2OA/1kawEd9JjXF6J4v7ge3eWTzZl7v
         Z6kGze6mZOvLE+9vDkS9igvu70hxSqlbj5aP3bDsRTFGoDi6h4Rfo/9i4+rFUhLm+hWj
         3OoyuVQtyOsRb4PvxSxAAE+dZ1cg1mS6ZDebaOa4aZ/aR0BXW8C45m95N08AN8cyRO3G
         ZkXuSjGPGtV6parm3GzrcVM6k5MR+yljS3SkqPLX9q4WsFrvZ0ErZmqPQ25STFOEGTIe
         eFdk21iCVj51sj5AEhSDjrPBp68iDgTLDcfbtsqY9YuKWDGf61YNOheQQ/OvjaSAIQZd
         6i+Q==
X-Gm-Message-State: AOJu0YzaWVTFoXIVE4FaRS6mXlbBSTw6hwDtCQQHxS2gSfGfPWLTpfrU
	bSgU72bfjbiMZ3MQmjPOuGkqO0F8f8KpyqURY3351AfSywoMlKL27sTF6HvS1AAKGylORyP0n3L
	bxpjb
X-Gm-Gg: AeBDiesesqbSmikpsMkLoZRc4RN1RLOFK70QHM8n1hngv4hkI0PiZCZ3pfhJMRUUMzH
	O8shW3CRguZ8DH+qejY7cGJNMbW96LhGSoa7CyBtUVJL+ga/yNrDPVHnl71L5H+BL5Pd0YLQ4zh
	v96XLKh4+i8uXLwTr19z2MgLMGwvJ5RpalQMfV1KPw9b4yRgkavnqbq6viVQ0tspKI/2cj6l22E
	gITdKyW4kartTWCBk+Ii4cRVGw5mo/xNq9YG0AFwk9g8kg81qz4ENp0HCd2mhQuYy1700EA4y1N
	okr+1mHFOYfyh7HfDBRcSfPSne7S1n+k5FoB/hfSNFvEL84ztSXuCIvWVhIsfm2H8dJkQ1P9Zbk
	5G8yf3SmEiWeKhTrPamqE/Rxm/oNla0lB0nLRAXDl72R04WJxySGyFpHN7SCgiZ5faboD4Pxj3a
	+JcRvshCkRqLsNMJuHeC1YRPXMpW1hw2GNBvAse6cRQRScPi/DKkl/
X-Received: by 2002:a05:600c:3b1b:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-488996b02a7mr234740035e9.5.1775561893471;
        Tue, 07 Apr 2026 04:38:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b739e00bsm142181705e9.10.2026.04.07.04.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:38:13 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 4/4] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
Date: Tue,  7 Apr 2026 14:38:07 +0300
Message-ID: <20260407113807.860482-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407113807.860482-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407113807.860482-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233580-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tuxon.dev:dkim,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 504F13ADCE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9ce71e85b29eb63e48e294479742e670513f03a0 upstream.

Assert PLL reset on PHY power off. This saves power.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250507125032.565017-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict in rcar_gen3_phy_usb2_power_off() by
 using spin_lock_irqsave()/spin_unlock_irqrestore() instead of
 scoped_guard()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 0626e00ccea7..7e25c0e053a4 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -540,6 +540,13 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 
 	spin_lock_irqsave(&channel->lock, flags);
 	rphy->powered = false;
+
+	if (rcar_gen3_are_all_rphys_power_off(channel)) {
+		u32 val = readl(channel->base + USB2_USBCTR);
+
+		val |= USB2_USBCTR_PLL_RST;
+		writel(val, channel->base + USB2_USBCTR);
+	}
 	spin_unlock_irqrestore(&channel->lock, flags);
 
 	if (channel->vbus)
-- 
2.43.0


