Return-Path: <stable+bounces-245110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOR4K9B5AWqMagEAu9opvQ
	(envelope-from <stable+bounces-245110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:40:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE8508A19
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4971730058CC
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615632B9B5;
	Mon, 11 May 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rexbytes.com header.i=@rexbytes.com header.b="GkivdwWG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9E2F12CF
	for <stable@vger.kernel.org>; Mon, 11 May 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481611; cv=none; b=fv6RPVWiVJ7BtI1AWRyAkU82iaaSLW/9/T1piOQgqeGmXNLtpYUI1UGY0IDTRHkv9B19YOWuKtFfLhfS1O3CayfQmXMAaPf1xu4N0i3GlI0e+d+JqBI8XXLT3AFys/jxesp+OiPKTmCC46/NU79EDDvhPvvsTlefzEk2jRc0zbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481611; c=relaxed/simple;
	bh=Vdot40fHqAmWHDMc4S5qR65znrF+4U8aCDLbFYA4OoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH7YyE5yhjj/787cROQN/z8Xi8G51U0X4FSyakdtJmDTfSs6IpeszU/njFGwz+rRzyf2ayfQS9MPD2TlXVWd8l6Qgqn8pqOBAIL5PxnnCcyyH8Jh4GRjUIVCy5MKxL+AGAMkWRwa9FPrYtr605Ifz5HpBtU5WN2bEEvGSZP2dpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexbytes.com; spf=pass smtp.mailfrom=clientuser.net; dkim=pass (2048-bit key) header.d=rexbytes.com header.i=@rexbytes.com header.b=GkivdwWG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clientuser.net
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd11a3729e8so28267566b.0
        for <stable@vger.kernel.org>; Sun, 10 May 2026 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rexbytes.com; s=google; t=1778481609; x=1779086409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe4i24Rx3aig0PVQ6XGSgaY/eyJZxLK7wIwLHc9rOs8=;
        b=GkivdwWGB8l3bCVOn+TrYl2b5zzqxivy0aym+dw9aivghq5lxa7GxNaxhra/eeDAty
         8esFBSX63/+wKi5iI2Qf5DMEygdaAZMwOjGJEcox2ayppGF/C7Fydaz+veClTvKj9do0
         SNHGftKOHr4jNOWzYn4ZCz2v8W2Gu3o/OFC/hJeB/QUBmmtFzBPseUopionELB0hx+ij
         wZasvXEfms1DbLaCuwEFntWGPAaDpxum6qXHR2BND/COF1QGDgWs12NSWBB0qN98lkkx
         bnA2BqQzABPk6zmRbXs3dLG0MMg4dAlvLxH8fUXVOMuN5JBGU3X3jSd2UG0xAInV0WVF
         Rl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481609; x=1779086409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xe4i24Rx3aig0PVQ6XGSgaY/eyJZxLK7wIwLHc9rOs8=;
        b=FGbDatbYL6e2SBiRaNj01TMUNA3yELYnd2pFwX+3rKxClITIcvAsSUo+mBH1hI0F5F
         xzZ9V8d8GJOFrGfTcU6gA8ak56nQRV72xze3tFH3qalZAn3iqRq/+bj/oARSPaBfo101
         vTehVKPCYO817rJLbpqqtXFAc1BN+bpriztkJtKquLy0DGdVMVy+PGe08pnYswg7EVQn
         fR/ey14yrYNu+M9KYnNuU3AiwNPACVKk+CFU4LH3Jm4NMUbJ7LKne0JoA1Bp+ss5+mlw
         HXwTzuBGt/YQfFLO6kOCz3LJRZ3e9yoifqP29VcGr9ahDM2fYHOvKWKwwKENcBk2RfYv
         NpkA==
X-Forwarded-Encrypted: i=1; AFNElJ+L8Wq2eoU1PRJqnF1SAbkxRAV4sF7zETTz3Lo0HRQ+PhYNusKmqV9KF+P2X8KrZ56dDnKzz7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjwrboDZ3uXO5Z6w6yUZdv39C29Jq8lUnWQ8ac6dTpGzQFLP4
	LtjGEU2/083Ye3YmZ977SwWH2vVwxv8jRBsCbfpKmc4xD1C+wXWk3iUKTjiaFditnb8=
X-Gm-Gg: Acq92OGnb85xPbXDD3pxWtMbykASx1KjCfgAAwZnA+iwicE0giI2BAnJaHyx5w5MRR9
	Dhop6DmEtvAx/m1zHQyJ4V3BiEgrprIoMVKvJhTMfHRkaUEazFKkv/QCftMMoBY57K0TldKy0a6
	z8LfuQ3ZDZgmLT/sNRhAKCRqafHtrd8WO+bTpqd5rnZPVYrWunxFtZMpLAZTiIqrzVN/bEEfT0u
	LAWHiaauWWoiJCa7OdlX84GkFO4ttxDnNJxsN1xjxcc02CpAznaQUhItgyfqBwqk6MxslgLjPTQ
	5pReXC6McKT9tnhECKhUweOJpo7lR+Q00jFQunlrynhXhIRX0chhcPtnfp1/MZoJOB1vhWfOYOL
	EvpSGEXmv6S5RJPHEUQI+u5TyeHz9Yqkm90W8HItLjdqLQHzsBJZ//xTjFYwldna1NTgp7WWNXE
	DiJrBCydz54RhBDdlmj7pyMkoO9j86bBnVoDZQYXUUkzmRgAeGM8sKkRRrZfNGgy10Ef700nfoi
	gt8v2Y=
X-Received: by 2002:a17:907:8303:b0:bcd:bcbd:8ca7 with SMTP id a640c23a62f3a-bcdbcbd8d3bmr172641766b.27.1778481608347;
        Sun, 10 May 2026 23:40:08 -0700 (PDT)
Received: from localhost.localdomain (83-87-100-220.cable.dynamic.v4.ziggo.nl. [83.87.100.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcc384b75b9sm299017866b.21.2026.05.10.23.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:40:07 -0700 (PDT)
From: Zoran Ilievski <goodboy@rexbytes.com>
To: Igor Russkikh <irusskikh@marvell.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled
Date: Mon, 11 May 2026 08:40:02 +0200
Message-ID: <20260511064002.1857-1-goodboy@rexbytes.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506104211.2442-1-goodboy@rexbytes.com>
References: <20260506104211.2442-1-goodboy@rexbytes.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55DE8508A19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[rexbytes.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rexbytes.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245110-lists,stable=lfdr.de];
	DMARC_NA(0.00)[rexbytes.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodboy@rexbytes.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rexbytes.com:email,rexbytes.com:mid,rexbytes.com:dkim]
X-Rspamd-Action: no action

The shutdown handler aq_pci_shutdown() unconditionally calls
pci_wake_from_d3(pdev, false), clearing the PCI PME_En bit even when
wake-on-LAN has been configured. While aq_nic_shutdown() correctly
programs the NIC firmware via aq_nic_set_power() to listen for magic
packets, the PCI subsystem will not propagate the resulting PME wake
event from D3, so the system never wakes after poweroff.

WOL from suspend (S3) is unaffected because aq_suspend_common() does
not touch pci_wake_from_d3() and relies on the PM core's wake
configuration via device_may_wakeup().

This affects all atlantic-supported NICs (AQC107/108/111/112/113);
users have reported that WOL works if the atlantic driver is never
loaded, but breaks once it has run its shutdown path.

Pass the configured WOL state to pci_wake_from_d3() instead of a
literal false, so the PCI PME_En bit is preserved when the user has
armed WOL via ethtool.

Fixes: 90869ddfefeb ("net: aquantia: Implement pci shutdown callback")
Cc: stable@vger.kernel.org
Signed-off-by: Zoran Ilievski <goodboy@rexbytes.com>
---
v2: Repost under real name, no code changes.

 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index baa5f8cc31f2..775cbbc1aa42 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -374,7 +374,7 @@ static void aq_pci_shutdown(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 
 	if (system_state == SYSTEM_POWER_OFF) {
-		pci_wake_from_d3(pdev, false);
+		pci_wake_from_d3(pdev, self->aq_hw->aq_nic_cfg->wol);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
 }
-- 
2.43.0


