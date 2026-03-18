Return-Path: <stable+bounces-227100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CLUNRPDumkGbgIAu9opvQ
	(envelope-from <stable+bounces-227100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:21:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981E2BE198
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06BB73256123
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750513E1212;
	Wed, 18 Mar 2026 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOJhrXtC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E05221FCF
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846651; cv=none; b=ux/lv35LMDkTiNyoqaHzMzZRTGmyB9EfTNPuQ4gWHtIW+pLMXW7ONuHLfGmIRhSbb+Bt7vQlDLPpnRU1tfsosFrhpuhmH74DvA3Nsh2yVvWuv5e2UizDkp3lu2M0pINAQhpE9nTATNhzKvAmQCjJYcPbD6rOFwD/PUK4kOdZ6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846651; c=relaxed/simple;
	bh=QG2BtrENZ1xORdkNqsDB6dpPSvjNG1S30qT6a0FlLMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kM1WTGCf3UDAIGoVMJziKwYCJI5ReIYoq3XDm33fBwMUgtKWHxaoVfWIYiMMr/4L1px+hrTAlRlwLdfG7YD3KHAZ9mJvstkCCsraG3KOwjPLiDHCL2AojEl8AZaRIONja1uIIs0kIvL0/5pP3LtOZIx4ACoykScmZf3O8BRJlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOJhrXtC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82a655cfab5so36367b3a.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773846649; x=1774451449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3RkPnsLYSDbKLEv/BKhHIWIll2IYC1YAGuzM3YXuSw=;
        b=VOJhrXtCM03xnJ2IfuxoTlqAVuzKpLmEjqqPKPINQ9M5MHaasEIcFOfwmaSugv3Bsf
         rNMMwBD9OnQDskrbV/UAbmoIzp+vOgeslUbux4sru4BG7+fVjljuNix7JJO5p8Y9uZS6
         /WfXLpKcSYfjpeFT8N0e+wmWTSbrGvMAMbQMr84yS/7OGEaVDpRlox7WcDyd0QRwbeZb
         JQIZpog8kjLljS/1XfCfZ4H24IRDLdLKtzmKcCgY7pYjyots+IQNDOzjn0O4YD4eNpNs
         QYMzrisFI+d4gWgpp50CPHk0USXPvAOkySP0pBZvbEZeb54PWpMfRnmg8lgXZOIUXn1O
         0B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846649; x=1774451449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3RkPnsLYSDbKLEv/BKhHIWIll2IYC1YAGuzM3YXuSw=;
        b=VasGpsKTdSaoh42N3JNb3yv5EjOLPRTWupCdDbjSSyuWHQTFPIMRkY3uJiU6S9i8Hk
         Iz6ifU0SoZr+R98H0w7DfFZCTb2XHrXnutaucpy68zV05gTs4UdHFRWmf5QRZaXsvWJ4
         hMW4JRkIivMKBeyqehgbEga43Q6cr7UcvGzFnBzcNkwuExP45BOcQXQ+klpgCSVohwV5
         ibi9QXWtNZ398RXyQwAKP4CHdnwe6f4GUZE2pRfYXuf3kIKlNVISsrNqkSk/ul/W9DpL
         nsomciK//6Zpb01c4X9X536llcsx1noGskpI7rDzAEAbo9mkMBbcFAmWMfuoYumxU47J
         Z+vA==
X-Forwarded-Encrypted: i=1; AJvYcCVEXx674Tyux4WTxM1s7tvvV1whT80fL4I/54sEjSVWx0dSCG5Oc9SswfVlgEWfkP4pGTAFRgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhU6b+5ksgDrrw9aPqG3ynyJWrb59Qqhe0WIwrw3SY4eLWGBa8
	A5ue2uNDeRqsrog9cjaOCwUlTJumw9A0OdFVNoMiDrXS8/Fh7jYRj6vq
X-Gm-Gg: ATEYQzwPvQyanv4DPRFPWlVhLXty+FAVCoqyHl1+Mzrn1ZjKOzE4Qv9NTLu+ymvLIp9
	WAfnqul0HZEU+8n66DvnnYHqM3HK8filwE21jpIzbcTLWcbc419hm7p3RMTqzg/mrmmC+G/Ghq5
	xdF9hqzYmR8af1kcTUGhTeIuqS/fChrAFy3/AEiNzFaD6dMa3PzpidFGQji+2B+5XhX0Udkk1vX
	T9ITGZiH49sGcWWl8ErllO37QAOkcnbMhBM5Rbvz6j6UVWr3KFtWsyi7qyJJd4hEA5bV2sN5hkB
	J4J6iMRtGHOGFCCogjmo3WFVW/MopOB56uP49qgfuRrpgaBk9ohag85BVWP215Yy9atpwwfehnt
	MYd8IP7CaFywihgqtmMlgODmXwP1Mygf8qQicayzjxYZIwvL166SDIpB1WNAInHQ3V+BBJSHAyk
	ln/e5uSRmXB5kPW90mvgyl
X-Received: by 2002:a05:6a00:3698:b0:824:9848:b020 with SMTP id d2e1a72fcca58-82a6b26e7a3mr3339406b3a.52.1773846649082;
        Wed, 18 Mar 2026 08:10:49 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bef2fdbsm3090533b3a.56.2026.03.18.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:10:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ice: fix double free in ice_sf_eth_activate() error path
Date: Wed, 18 Mar 2026 23:10:28 +0800
Message-ID: <20260318151028.634828-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-227100-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.861];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4981E2BE198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).

The device release callback ice_sf_dev_release() frees sf_dev, but
the current error path falls through to sf_dev_free and calls
kfree(sf_dev) again, causing a double free.

Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
avoid falling through to sf_dev_free after auxiliary_device_uninit().

Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink ops")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 1a2c94375ca7..ec6020338b9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -305,6 +305,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 
 aux_dev_uninit:
 	auxiliary_device_uninit(&sf_dev->adev);
+	goto xa_erase;
 sf_dev_free:
 	kfree(sf_dev);
 xa_erase:
-- 
2.43.0


