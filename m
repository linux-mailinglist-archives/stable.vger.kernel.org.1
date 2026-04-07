Return-Path: <stable+bounces-233575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMOZDq/s1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC22B3ADCED
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9833303A912
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3839C00C;
	Tue,  7 Apr 2026 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="J1JOGoy5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D83A3E73
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561872; cv=none; b=O+hdCdD66liY5KPSlI6ckDFb4qa6mE5O0z14Qq0/J3ygHMWoDpiHTiwmaq4NcLcPmuWsateytJ7qiWEexAz0KMnJfRxDanKr0A81A2Nv1cU6Asz6AsexcAylJRqP0WPE7k6CTh9HQIyGw0V5ejjdr7vE6YXOiaBLieSu4yHplhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561872; c=relaxed/simple;
	bh=QX1rZBTTMgIUI4BGWED7hbmxG3WvXxLMdym6//RJ7Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iziztku9wA4Rz8yoDo0ca9V67dD04O5jpCS9ZeqwVBQh8tn607Cf1f/k2kmCe2Zvd++tALVeDHDLKgna6qLl/X5snTyZDA6me2z5uKrMobpmVnf6C5+C39reQHmMq+uVI7V+u0qpklutME6ImYH+sGNKYf1rFP88BqwDBFCLdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=J1JOGoy5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfb723793so3153433f8f.2
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561869; x=1776166669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDKSxFLon4LZ/+86TVGaffzHFr9NMscPGxz14/wTAUc=;
        b=J1JOGoy5TBIvDvJqhwtiyThW0Vf6iOmsnJdYrAfXFE3W/rhZHoCSEedJHm77JSBV66
         O40rktgyr2sufUPwvPIPEJ0L7cFzN1LUzw1WYLjvTd2jXxm/lUHZj7h9BMrxo3DAxSJJ
         07ZDyi0jHttu0LtwBWIjoVxUDIFybQiFkbMklHnSdT1Eiym+QBR4QLINMt+XeTvvdLdY
         lBFZcjOOi+ixaQhCW+O2mCz9Xfk+yleokTlilW8Cc21IrfgXx552idp6mJxGC09N89/9
         OqHjOYHv5sQ2iss/M+Wiyk3+bHx0PHPENrNC4TzEujbe7vQahbhCYecPSwGdD4W7dESd
         hlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561869; x=1776166669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CDKSxFLon4LZ/+86TVGaffzHFr9NMscPGxz14/wTAUc=;
        b=G8689xclzpylA0E0YbY/ZpSGz4ycbfyRG5wiE9YFgrP89PTsRx3MJFJjUoMfLyuXel
         Y+N1Jm1zUUuzNNjb/svkCBaQCDv0ddyQP7ntPCcxW4fpe5spNRbFKtbV9YefN2ImW6cs
         h/NOoK1cPvWXEFEcK0DvxHr/Ypnugc3jgv6ynoimcqkbPuNWCXdtuWceMYff0+1psJfn
         ym22rg5zV2ZMDPCguihrWNuHzfAbiyG67h2W/vXZwqx2MvnDUlZxkl88T/nBTNlgYDlZ
         r6mmYUDGCpZ5E1EFrq3rDCZbJ/jxLmVAexHbgoBbHrOVw5mi3KICaWKNDkQ8bmulMpsL
         IZ6A==
X-Gm-Message-State: AOJu0YymOdAkOtf3aHU+ZxgSC4a3kSlfsZwsrSSMnItT+ixG7XwFBTI/
	pAgRQLCY/LiMoS3li2AbHEzaiAJXi/9QEZePy3RIX3DZG3UcpG3tHxZ31mga63ReBe4opcls4JT
	75TZ2
X-Gm-Gg: AeBDietc3y1CySy9rmwO9bwED/srEV10gE+Ydni0CeE9hzKBJPCOyQ64GJBZYWQtBw/
	81yjlZ8IT69Jl5uuUbUgvMh2bH8zCg6AT+hVpRZ8Hunt5s7FXtFQf71gSxwR1szKPpX/txAfEjq
	GOE7MlbjnMVnR1TUhglbuDtA8CjTIzIYfFYc6wS+BSX6omRFAl3Yc4iDUclzYvRnFA5+ODIVAG4
	nmASaOp5W2u9vanG8jHTfuAeEsN4QDEZQG8m5WY8XexX/DIjI7KXEF75WOplfVPVKl0kxAYT3r+
	3Gu2aX/12UjaHLrRpNbkCgGo8z28A/BuQWWxJ99j4t3ZGnQenjTjolLlI53Vr9hMSgKsYHKCP5f
	sFXgS1kokSO+OQTsbZiIr5uk0Sn/8Vh8AGotrNbtUN1i5qD23dmFCJ9jbz404aZPkqL/ee3UWz9
	csf4HuTFh0UKVawuIHKP1DTNhEnjGDWMnrKtmI0f2Nomj0nGFP4hm2
X-Received: by 2002:a5d:588c:0:b0:43d:29a:e42a with SMTP id ffacd0b85a97d-43d292e1583mr24688288f8f.29.1775561868697;
        Tue, 07 Apr 2026 04:37:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm50527718f8f.3.2026.04.07.04.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:37:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 4/4] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
Date: Tue,  7 Apr 2026 14:37:42 +0300
Message-ID: <20260407113742.860378-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233575-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC22B3ADCED
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
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 558c07512c05..9fcbde094699 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -516,8 +516,15 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 
 	spin_lock_irqsave(&channel->lock, flags);
 	rphy->powered = false;
-	spin_unlock_irqrestore(&channel->lock, flags);
 
+	if (rcar_gen3_are_all_rphys_power_off(channel)) {
+		u32 val = readl(channel->base + USB2_USBCTR);
+
+		val |= USB2_USBCTR_PLL_RST;
+		writel(val, channel->base + USB2_USBCTR);
+	}
+	spin_unlock_irqrestore(&channel->lock, flags);
+	
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-- 
2.43.0


