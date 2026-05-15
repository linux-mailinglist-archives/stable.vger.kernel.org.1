Return-Path: <stable+bounces-247794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA20ExsxB2oQswIAu9opvQ
	(envelope-from <stable+bounces-247794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:43:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D1551A14
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97263301A080
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7973D39EF39;
	Fri, 15 May 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmZUEdJw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B5318EF6
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855472; cv=none; b=giJD2y0O3PrDqqKnbCsK4MD/QheeC6Z6lWZ8D+MKhFLM3Q/letZYqsbP9iAlUliUwFqN48aLHz5wtOlk0L8W5ssROhObFZgYKacMMD80pQBjAbrDyWAum9fenSulHTUy5H4RxoEI1mVefHhy/6t2Q8isk8/nnAqjken818DjZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855472; c=relaxed/simple;
	bh=bV1JeOldTkErlaOe7mZv8IxdkFPY30ISl0S82QP7r9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nl5yrE0JRxdpGq8FHlse7cndbbHjvLI5FYnK+6BDj96vCabji25DFDIJ5xPKxXGAJWn3xYaQ4/8o2wsIQeNCkksx1vu7fw6BrrYIG0KUNdx2fI0rS65uXFbeViLjPSicUv4oKDMjoon1ZpiVeDG6EhfBB6hZUpL9SeNV7z1rPUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmZUEdJw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48e82c23840so51492635e9.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855469; x=1779460269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oRruk2hRCiEL2H/Lc0ikHTSfdx/PqADfnZnuck3Ni8=;
        b=KmZUEdJwyJ4RTk7ScnujzA+IuLqyja3NISvYqPL7OFT1l/ASWiwyBA/N9S0oz2p1i0
         nq2Q+JBwTm8auLpQ8DFMxtKHih38pT0UnRsLecoODflPnXFHtqagKbWJ4Gv8Cl8b2FBs
         3QRGT955MkD9N+ORFO50oHkorrF9IFJIHJYqVolvy2rb74zwUqglrgCsIHe32ob70015
         5YwL7LQSuHY8Zdxu61TQuijiizhALCyEuELK2MkI+E/UDcmnHtbBBBnVKTJFgdnU6r72
         p7gLVWJU7NntvXjnPRCYBhEaR9eM38Z/Xo3bc1uu059PSgoQkK9yugNx0Mpg8720t6jU
         ezHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855469; x=1779460269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oRruk2hRCiEL2H/Lc0ikHTSfdx/PqADfnZnuck3Ni8=;
        b=iCKJlLagfYs2lFxB8jKQzyKs/D45RN0Iz5oa47HtGA22GNnP374/eaQ/HsiEFYWl8N
         HrkbbDQUHCeGGrqToOc1KVR7lToucandk+w5OrKe7MzyFidFlt4cItnpuyLa3WVfRojl
         sLsAYm9mKdW7pIU5/OlLsEEYpw5/rL2wuxIG5CBJBSpn51LgjErgec0aLT5d48eZDXjy
         AfiXlbBT4AU6IuH67LPnp4mw7TO6jUIn+IWA0+XFtHnjm42q2xq2tBiPquhmF1l1l1Il
         jHKesv/rvXkv0o1i0krqXH11dey5dod3+wAZGSGartYmcPu8gj7dZQMFbXgS1Z2K6WwO
         iVVg==
X-Forwarded-Encrypted: i=1; AFNElJ8BGMJTirijsgkC/0Qz2ofj+JnLSc64btUXi0/eA76XIKfbFtv23wrH/oIh7Mehm1o6lw9Y5is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CHWgZg4dEbdsjVlh+Em4AGpGb381UhT+sNYpHJjJWCPhiLhp
	P2f6VWUXBNwwe+mA74NjDecq9XDdlLdHzxkUpVUkGrk26/qzLY3C5UHC
X-Gm-Gg: Acq92OHZsuHGFIYx7JAdGL/p4Td9fYmxQkn9M/F+0DmWjTpd47PlskTsxwHxGze1gpS
	YzdT9n3sUDKhMmGvIws5kV6TOnGP/ZZBeQvVEqhZ4sfwJVqKIIko874U475O9I5bKGloQr7SAIj
	46OZpfPWqG/M9XnysTR3cBwFdGLn7kTeCVS3AnZwV2q2qSeCXqvGmHJRsFRBr0eivjv5gaXAez4
	/bnEkhwhttYB5EWP8hrmv5cvc/F7320dAOjOP6NrOzD1q2L0GJRXu+6si2ZmloLf7ZT31ai7hBE
	ayKVHcNwg77N5PRdQQ4vZLXamCkO2riyeCHaPlPPg7pTAeKwxOMVDi9iPGlIL4jiTiUKp5Psb6w
	UFKsjUPVG3KMJGmKi0GOpN87fRNJC67U8K7GwgJ6W7CRMg7W8rGjg6CAoyjBgjKYcUc7fqvN4+9
	zeWovN2yY0TjmAd82w/iMslAZqxEFfy03YX/5+
X-Received: by 2002:a05:600c:3b0f:b0:48f:e230:72fb with SMTP id 5b1f17b1804b1-48fe6631512mr57952455e9.32.1778855469028;
        Fri, 15 May 2026 07:31:09 -0700 (PDT)
Received: from builder ([2001:9e8:f130:7416:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6aff4sm15024815e9.25.2026.05.15.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:31:08 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: pse-pd: fix sign on -ENOENT check in of_load_pse_pis()
Date: Fri, 15 May 2026 14:31:03 +0000
Message-ID: <20260515143103.1721888-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 562D1551A14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247794-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

of_count_phandle_with_args() returns the count on success and a negative
errno on failure, including -ENOENT when the "pairsets" property is
absent. The existing comparison in of_load_pse_pis() checks against
ENOENT (positive 2) instead of -ENOENT, so the branch is taken for any
error return: legitimate DTs that omit "pairsets" trigger a spurious
"wrong number of pairsets" error and probe fails with -EINVAL.

Compare against -ENOENT so a missing "pairsets" property is correctly
treated as "this PI has no pairsets, continue".

Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 drivers/net/pse-pd/pse_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 87aa4f4e9724..69dbdbde9d71 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -210,7 +210,7 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
 			ret = of_load_pse_pi_pairsets(node, &pi, ret);
 			if (ret)
 				goto out;
-		} else if (ret != ENOENT) {
+		} else if (ret != -ENOENT) {
 			dev_err(pcdev->dev,
 				"error: wrong number of pairsets. Should be 1 or 2, got %d (%pOF)\n",
 				ret, node);

base-commit: 5db89c99566fc4728cc92e941d8e1975711e24b5
-- 
2.51.0


