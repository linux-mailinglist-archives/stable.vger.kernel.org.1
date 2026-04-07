Return-Path: <stable+bounces-233576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAOCNajs1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A303ADCC9
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7D7F3004DE4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58413AE1B9;
	Tue,  7 Apr 2026 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MR3W5z53"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C039C00C
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561892; cv=none; b=JvwZfbbEfz/ghdaaFxvcVeOo6+vlUbf0noFqWCEM5LkvbjKrFgVke+55V/PUtNUwdLD03g1jdy3YeR6DTt/UdJ80VOfvx+GNEERspcCOWEEO2i/igOQyItSqwCsVIsLMW5tqVs9oB4kwucz4X32L6udvJOACypDffNqXUrzDI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561892; c=relaxed/simple;
	bh=/5suo+M80wNNZWM3BQhpz3SYiiml/RWzZYccfF/cVig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3AK1VXgFTZZuA4lr00F8YLV/0u8V7hai2ycpZlZNkAeZUcV+wyCxdgsqrwPIcFl6stsrRBOCgmy8w0nl/1anvi5Bqi8R6MyUiU7KNV206i1GrpFWGvkMsSUkMypPqAVf2AwFQDnLBbdSc4JXIYz30wlnG9KhZP9PScb+ZXFoIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MR3W5z53; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso35355445e9.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561889; x=1776166689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4iQL4arVldkbGZ+8XAy1vP8M89SNag+aSv2h74D5CE=;
        b=MR3W5z53ByCd934pxTuKhwMACqKuoVQ/c9+ytw6+tG0bXNB1TAFc03Y5+YnpgAwCbH
         oigp6W+SgUvEmnoOnW+itK0h1pNa9h2MP3v9un044tjVejVIWm/dgcoor968MAE1uv3p
         CtBj9UwGQy7ypbvEbs6YEjKxwPWqx0K6WSJtw9x1HLXDDB6hwDY+Xb9CwvDHMAndHEeb
         o8LFVgfmIokogDx7xF/o4B/BSnvva5O215n0E+In3KQyOWeRX8drknsD4/Vd2X/s1Kyz
         k8iR4Ux7/1gGw6EIbxu/wYMTfl9mpzmIOwTqBixzKXLYuZsSSDCesjjGcl8ScJfayqA3
         W8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561889; x=1776166689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4iQL4arVldkbGZ+8XAy1vP8M89SNag+aSv2h74D5CE=;
        b=o6ObM7DMPpODRO/eudqn3aum0dIPegQj8pL1HGkGbe5FaTXUDDvzceDnwJh2GgP1DU
         HV8wbyBj404BHrNNW8UQeizD/UikZzVO+9gjbOYHCXg0pxAcEWot8279hN8UMmbAJCdf
         T+4whk2v6l+i1jlhdrfAxf+jYj9MbSBKpRMaz0l4PkbK6NbALHCM/W3YDk15sgytcf6D
         kgLBF3OUAXiuZmCowV3vdCkvdnAfImLbioeWvpoboL9v8LpWODXsswxnKgUDGrAUtRsn
         mhoNXS677FQDc2fE2Rb8Jhk0pLgbIDYVstDVtOXYeudWTr2iC1hm08moukLiD8F6PL5C
         tcoA==
X-Gm-Message-State: AOJu0YyO+RehB9s0aN/srQuclfy6g2GuFj1yawJBYypyUYK9CNezAfQM
	g/YwK7tbN/WlA63zrA4Riavb5+PTM/w/vh274dQszmYSYn5CIDc8ln65WK6NHzQbZZfkWz+7gku
	yuryW
X-Gm-Gg: AeBDietHGu6qtMnSDKhWFN93TWFxzyBJlhbGDhaVgSkF1H3x0kYvOuszUBssHxaLlc5
	JxNKxXTMO4vw+mgqORrXGNFqjnk3Yljj/NAOBq9d7R4vxTy/ljXRNjST8I6GEnEcmy+yNOX6HVt
	ukHbobqL9AAIdDrMcgSQ6rsVdjq4Qoz06XKAntCNW+eV8stMC4wGdb+/PNaqQ42vPQoiS9DaY5/
	iLEUjugxyfod5a4i7ycmHCtuqXfipTH8czqkcX6lTt2zH5VMQpl1Y7b3xU4Sqz8FlthZPVxIXvI
	xFQwv2fvTMl1E6YK/NLcQiC1BEVr0AKa2naW3v5O681A2a5RntskByS/sJ9SiqT0Rd+RqY5w6RX
	WvepHf/pA1/vCyxLU4KzEqYCeSiEZhtdwBsVSfsK1cet34x7AAp7GSMYIqPGVOT6JsHybK0X1Yo
	BJjbtDUj72tW4EPt92zWsemYLQm31Fp3U+hi2f5rCiC+EqKEoDyWRN4+YhvO7w0Y0=
X-Received: by 2002:a05:600c:699b:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488998f09dbmr273227135e9.27.1775561889110;
        Tue, 07 Apr 2026 04:38:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b739e00bsm142181705e9.10.2026.04.07.04.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:38:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 0/4] phy: renesas: rcar-gen3-usb2: Fixes for Renesas GEN3 USB2 PHY
Date: Tue,  7 Apr 2026 14:38:03 +0300
Message-ID: <20260407113807.860482-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-233576-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 81A303ADCC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports fixes to the Renesas RCAR GEN3 USB2 PHY driver. Fixes
are already backported to the other stable trees.

Thank you,
Claudiu

Claudiu Beznea (4):
  phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
  phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
  phy: renesas: rcar-gen3-usb2: Lock around hardware registers and
    driver data
  phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 123 +++++++++++++----------
 1 file changed, 71 insertions(+), 52 deletions(-)

-- 
2.43.0


