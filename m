Return-Path: <stable+bounces-223384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F9gJS0uq2n6aQEAu9opvQ
	(envelope-from <stable+bounces-223384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:42:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D952272AC
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0956301D0EE
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93FF426D0E;
	Fri,  6 Mar 2026 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9q5OTfA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACD3B8BC8
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826155; cv=none; b=N9jXsPyUVk78Tz7Gi5AJ1tTwycxt4QcfSiWdC1Rz4nxuDd8A0NGOh5B6YlL+Onx2jOeqpcHiWsi2uDaxwJjEvl1N/msOPrjgX1hVvCqFE7tgGoiO5RxW5azhJvElHIxzS3xutohMkHKw/HY124s9sCjxll230tvv+efM7JbLRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826155; c=relaxed/simple;
	bh=70rIKj4D0F4khbcx7r1w0/6M5dU+s9g4rcLkkC62EjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPLaD0am1gQNBt9a3HPDcadZ1nCujkGaqrJg4by3nDwWdoODjUyqylIuJu1z82E15+fOnb4iNP5Jh6inPOnJG+VZEaIjJ7bYiG334xZLZK957Jw8wjAJ4GLA1b7LGcrAum8Q4fZj+ZTZcHfQMCAYSeX4dlHuni9vmGFV8mXkpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9q5OTfA; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a12cc20e71so2228246e87.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772826152; x=1773430952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EMut8hOU8AaaPE8q3oPDm4oNwmV3Ip4MdpdKIkHzqs=;
        b=E9q5OTfA6EP46wcZsM4kt0d/VxnEoCIcTYT9MQDBCt7Tn7BTgBTiwa/ntm/3fTGqy7
         GAYdvz3FZC3bl8ZSxXn1VWv7MzUd4tAb9Np8XoMnXl+sHkmB/Qn6oSSNooOm5pBEGX5C
         J2DvLY99YBnl+1MLI1hp7D6p7MQDXrjQHR2C0yQfGtYnHKph06fB2nYI3sFag+8iCziH
         SLn2RtiKVGs69xdsipyeNdlY65owQ0K08KaGOo9U2HtAK5SNTrpAaC8xNxCO2TqN/3Xh
         ZOhBrZPrUndLmhb+3+sIN3LHzYv4Qh4rHKYEtJ6BbMw7Rr7NxqRI8fnm2SceAAO6dM5x
         ZC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826152; x=1773430952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EMut8hOU8AaaPE8q3oPDm4oNwmV3Ip4MdpdKIkHzqs=;
        b=GvcZ81+v9GiSh7IwX8oEjYnJdXq7VMvgyW9BlXchnCayTp8TYlL/aZCzrvBMItDJii
         NE3fk7noPOvTfeAMD3zK7BZ4vH32nZ3omjk68mNpwLfdYDg3G4KGsIza4AeCe8ZnJiCP
         3AefTxeqcStxfVrxOKBPHgSLHUKxnz7QKKivszlJ9TDH5qcrtR0hElvetrjCdoHOaIWj
         DSxmlGSJ6HcAVhB3w0zFrU436WCnJ2nsiYPKlzd5A3FSwz1ndK+/YTiPpy9Kv1p+I5hL
         C59kWfGhchZpW7sGW2MwS3T46V99gmBzK2MWXsUE6JdqufOlUhDo+UXoVO0H9ehXnshG
         kZng==
X-Forwarded-Encrypted: i=1; AJvYcCVUi8Kov2JTEpcMkGlZl/IcPHXAp4/Wkqmz7b57UuaXmBA+tst3ivrOzwdOjk5cRz+C4OEFYQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQmlvxlraJ/uHX4ggAdnEFVTsDS8F6Siu/vZK89g/jIe61Ce9l
	4UoY+rL0hL+rRGcBmaIr+Vp2LnEcO6C0gQxyYrgVX0NnCO7wg0J7RCyv
X-Gm-Gg: ATEYQzznJVxQSkByoF+QTp2Mp/FbWQ9vnyYyRTA6QG84tWKvpwSGeGDh02ZMKGyvqy/
	iNVzItlx+pxuXo3qZVAx820JUSbL7mw9T0qMdR0YB6mN2+v7BIo5kHsuUlUFc4OmW0lz5PwmOsc
	nGkI79Ckj+Zs9d40PlaFgrUk1dRPPSEjllU2IezViPEvtZ0AafdMqKa/MUx7zx70LBRuAq/bO/H
	AM7aeWR28t3Kf9/EhW2+RPvPEekj/t40R1FUv5hokVgBZuZ5SfBy0qlQBf5H0gZJVlrKbP1vqvV
	OLo4M7iYsGhhSUKfxNBLTBZ+OYqv+ZM3jyQTer8OtoPbvG76AePIFWQ8Gl5Nn4Ew7T/M7EPDsIy
	wIyb7ykNY8fOgwg4Va/9El9gpH/pi61qutMQgDwx78ChjSDF9FoCiBHFuy3vhsFWNluCjdRNGdu
	diVV3q
X-Received: by 2002:a05:6512:3b93:b0:5a1:1f9e:8fdf with SMTP id 2adb3069b0e04-5a13caae80fmr1073124e87.5.1772826151804;
        Fri, 06 Mar 2026 11:42:31 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d01cfabsm515709e87.7.2026.03.06.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:42:30 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: alex@dvoretsky.name
Cc: Alex Dvoretsky <advoretsky@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/3] igb: skip reset in igb_tx_timeout() during XDP transition
Date: Fri,  6 Mar 2026 20:42:25 +0100
Message-ID: <20260306194226.995095-3-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306194226.995095-1-advoretsky@gmail.com>
References: <20260306194226.995095-1-advoretsky@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45D952272AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-223384-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

When igb_xdp_setup() transitions between XDP and non-XDP mode on a
running device, it calls igb_close() followed by igb_open(). During
this window the adapter is down and trans_start is stale, so the TX
watchdog can fire a spurious timeout.

The resulting schedule_work(&adapter->reset_task) races with the
igb_open() path: the reset task may run while the device is being
brought back up, or immediately after, causing unexpected ring
reinitialisation and register writes.

Fix this by checking __IGB_DOWN at the top of igb_tx_timeout(). If the
adapter is down (either during normal close or during the XDP close/open
transition), there is nothing useful a reset can do — the subsequent
igb_open() will reinitialise everything.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 223a10cae4a9..ddb7ce9e97bf 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6651,6 +6651,15 @@ static void igb_tx_timeout(struct net_device *netdev, unsigned int __always_unus
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
+	/* Do not schedule a reset if the adapter is already going down or
+	 * being reconfigured (e.g., XDP program transition via igb_close/
+	 * igb_open). The stale trans_start from before the close will
+	 * trigger a spurious timeout that resolves once igb_open()
+	 * completes.
+	 */
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return;
+
 	/* Do the reset outside of interrupt context */
 	adapter->tx_timeout_count++;
 
-- 
2.51.0


