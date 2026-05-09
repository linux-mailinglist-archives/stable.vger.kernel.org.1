Return-Path: <stable+bounces-244988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNl2HEWs/2lX9AAAu9opvQ
	(envelope-from <stable+bounces-244988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 23:51:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C350196B
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 23:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65073300D633
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F73D1CD7;
	Sat,  9 May 2026 21:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW32ZTS/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98813CCA02
	for <stable@vger.kernel.org>; Sat,  9 May 2026 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363456; cv=none; b=ASjnXMDPZrSLDGuN7ecK7Xn6eCvXHst7duIUJPI9JXfUdG2CdjohCByGs2QyLDZ1Oq5QAya9JIkmCJYPUkLf9Y20+/u1LZThgdsucY80J4ZsoDNdQ6bxBWEXE6zSuyjSx76v2/T0kJ53uDJmN/mlznPmvMYuny0UjtF7tIZGX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363456; c=relaxed/simple;
	bh=zZ4zRaKGq3lXVJHzulsLNYmFoDhtm/d3hxn8G7IHlb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmmeODb0KrQnjcxxXR7ePoFOxLNP3qKuUbIWc5wf7NIr3FoO4PzfNy1xsDYw2lkkPH0TtKvM4qMZvy9o+KCCDdLyFpHNUTXEQ0gpK4ciNs1GGMZuRaAtdQqOTj432nbwhU1UQHpVf/6hz8u+OdTtI68/ehDp3IHHz/TAvebsQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW32ZTS/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso28592335e9.3
        for <stable@vger.kernel.org>; Sat, 09 May 2026 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778363451; x=1778968251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvqluUKCfP5Ei1uU539utS8CTMy0nMi+hBfXFQXhHRY=;
        b=QW32ZTS/DAak+S0VHi54BQZ0fyp71bh2NvPX9fDbN4XLgZMeKd0oJ15sgh4gnKYvA5
         vRbDayEUc2PtHZ1+oOvBJpTIoUQ0/LunOlYKvkO+5qexDjyPWx2e7Y5HmlzVR4r+qkTa
         Bhif+gBjUrUB0nRZtY1rvl2BBztlfsV5Uo4alYftiQqMqUTsqCjEnuX0+dF44y2T968R
         Gq+DWWnT8phNKHoT0+bb07kCsghjI0wipiRgF2LoqQMtYTksfK0fiuMHDWknn/w9Cgh6
         0iySToaUXACAxpFTwHGFIvxfIDDjt6OvB2bp4CpssjcB4xc6pzsHnLJqkPkeum7jtEda
         ES3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363451; x=1778968251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvqluUKCfP5Ei1uU539utS8CTMy0nMi+hBfXFQXhHRY=;
        b=kqnSoFfiDV0dKQVywOOML+IV9egUSvgU0asCaou0lhhVGt5IfxB94qr5/j0GonVI02
         R0q16kSgjQYJAw6I0fm/L81DRBbqxypkVpm8f9M0iqYbBsL1KWAi1JMrhsYUKKK6MJLa
         OhYRE3tLFaIgJPPhoaz12ICAgHvE9BchZD9+UZDXHcFuw9Clif1RmsM30ze2sTHrkO8v
         OJqWfvB2mO4+WAssaCuf51/Ba71K6VwAkImgt3QHTMKMOrsjxcuTIPDAw7cjAFyzRoZH
         zPFp92/dEoiAhgOkoPelPGYeKJ32ElwjrlvazI48k7SBKZu29MRCgxKhh/VxekS8YWDd
         JseA==
X-Forwarded-Encrypted: i=1; AFNElJ9hTruMQq9G0f8m86fjXGNYQAhGgZlXoBk89vw+TJOu01Oyihcu129JTS65lCztjQ/JL0yEijU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS71/obY1cSU9FsrankmMFXVRo+Cabja+lAs8TXSBZbR8wSXyh
	zy+CisP2enGF48KUKWrh2MWi7D3SUoKPgoz775t+VZ7oLQLEbN25a4JT
X-Gm-Gg: Acq92OEWGlryAU4dn7DLeOGqU3+L1p+L2Z23DbP7gj+Xm9qom9Dql9vlaBomFnYL5/I
	FvnNXs4z5GScUPduEV4wFnaG4rbFuJqLWLZuYUtc+ZNwbkicDLGkWFPzNzgyG6CV296xT6J83mD
	KehnAEcPVBLftPmJsXmLU2urHOaNgMGBZKgALQeLECOpXrXqK1U97KK4aGexaix5m8f+05TMDoO
	zz39M5AvTY5r6qzmFs4L6RW1y8ksQVwUqKbHSDbvEFaMpQnKUlA7jUbkfBcgOB1cmegD+luiRrP
	/hN9z8l7FQ1VD/WNTxSeyyhvfB7lL4yB1zui5gX71pBdOQuzT2T8xGO6MCr326kE7Cd7IDXzTba
	baFId1sJlEA57XWQzTwSOT0Mb6WsN/619YPYayiYH16OEvh5TwbTa4CgKtkEFO61R3ofgVF69iO
	Fgv0yTqZ7bC8stk6GJRDwielMyiUbr/ChiVdbhhfqr/h4ski/4xhTI+y1hliv8huR+713gtkZZb
	r/y4HJhwiSjHKknuG3EHg==
X-Received: by 2002:a05:600c:17d2:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48e51e0a8b9mr172833435e9.5.1778363451396;
        Sat, 09 May 2026 14:50:51 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec426sm71076565e9.10.2026.05.09.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:50:51 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] net: ethtool: phy: avoid NULL deref when PHY driver is unbound
Date: Sat,  9 May 2026 22:50:46 +0100
Message-ID: <20260509215046.107157-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E32C350196B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,armlinux.org.uk,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244988-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

phydev->drv can become NULL while the phy_device is still attached to
its net_device, namely after the PHY driver is unbound via sysfs:

	echo <mdio_id> > /sys/bus/mdio_bus/drivers/<phy_drv>/unbind

phy_remove() clears phydev->drv but doesn't call phy_detach(), so the
phy_device stays in the link topology xarray and ethnl_req_get_phydev()
still hands it back. ETHTOOL_MSG_PHY_GET then oopses on:

	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);

drvname is already treated as optional by phy_reply_size(),
phy_fill_reply() and phy_cleanup_data(), so just skip the allocation
when there is no driver bound.

Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
Cc: stable@vger.kernel.org # 6.13.x
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/ethtool/phy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index f76d94d848d6..ddc6eab701ed 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -94,10 +94,12 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	if (!rep_data->name)
 		return -ENOMEM;
 
-	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
-	if (!rep_data->drvname) {
-		ret = -ENOMEM;
-		goto err_free_name;
+	if (phydev->drv) {
+		rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
+		if (!rep_data->drvname) {
+			ret = -ENOMEM;
+			goto err_free_name;
+		}
 	}
 
 	rep_data->upstream_type = pdn->upstream_type;
-- 
2.53.0


