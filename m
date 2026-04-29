Return-Path: <stable+bounces-241901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFztOWId8mm/oAEAu9opvQ
	(envelope-from <stable+bounces-241901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:01:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B1D496730
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41D2E3008C09
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACA376497;
	Wed, 29 Apr 2026 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+nv7TZ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3E36605D
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474863; cv=none; b=n5EfcBWBg3/XB8/83dpBv/ErB0EyBtxFa6Y0pTnO1vru90RAaXKajMHpvBZBm0ShAPGPk+GdyAYoNu67gZHwX7eD2FFs4VAzey52IyOZLUAXdbReAfdQp+j1N1nID2vLe0ZtPGbUdznSzQBSiSNMvOa/5wLUcRDrxjOpEtqCyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474863; c=relaxed/simple;
	bh=FZkPLyz4iy8JIkfq5sjfg8+HsGK+VmVs0AAYqDsVXqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nARj7406nVtnfv3Ejz7i8Ous3WEpLZ1CxkzPeG2WDuWwq/bqvvVcThLPeFqewL2PUNQLGZHReid9xwInKrF0ODecXqu08K91k+6b1Hf6l0J0vrdlTwcteffWRSwuwyrjHlPr1sCRBVqi69WGf6h2ySKZVyzVVgIsgOdYRNQJw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+nv7TZ4; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d4f78fc9f6so1374318085a.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777474860; x=1778079660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2cPAm1wDcQ/uIsNTaahkJXXGkH27N19gjb7Z1QCBIs=;
        b=s+nv7TZ4YxAKM+6KPfBAubVKH2bpnbEmNMu3GPydk+hhcamWYB02sC6L2LGjlnvSDB
         Fddw99SHZWDledbhQI094lK8dZ+E6niNZs8eGHwh+nr27ROMPtFXLq/U0vu5+gJ8yWJI
         gKFhmB9yZGrrQ8b5sm3N+CnabquLm7UotaAD5VrzfHvyhJPc8KWRjZAT2frJQ3jUZ0bZ
         LGgjZJc8fWUEqinUHNFewIlGXy2CvjuQlc3HvNRFARh2dysNSEGNL89hWIdwaX5+FjsN
         gkUy3v1xT/oom0/hHRyeAG2REzgVwKGiLZLVq2MI/ekkXQlc/tDnW+CrZQE8P0+rYv3S
         uJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777474860; x=1778079660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2cPAm1wDcQ/uIsNTaahkJXXGkH27N19gjb7Z1QCBIs=;
        b=l6+T1dHtVvNilq1TV1oeJTngIPVweH8pm/d9rlYZADSxCMdrJw4LCC8I+XvJ8z7A1C
         lDZFa/mSVAEwXQDcNT++4Z70jgPDZTsdqtg2on7N4S6jwOpi6r8NOaJSJaFbX7IilR7I
         0y43hVoHwDmyD3BbPv30kVQVMgUc/1x91WBfvyXP5OSHiyh+t5C5x4kDYr3V8+OuBS+p
         MJtE2DYzDbR5Fd0SQR38O2uQdoG2bIQPfrC6sGhnzqCOnSxVzzmIuYRd5FfDo5nik4df
         gXaxnNP6Ce2Z89b64reEjZdD7lqadb7MOWMeIsibLDvmQc5LMpwiESDinnqUD3Shjy1Q
         6/kg==
X-Forwarded-Encrypted: i=1; AFNElJ+U4V1YWIuALf9HML6Gq0H1e0uMXTNxpzKX9dynNitp8THMxskF1S+kZFkH0pSxujqsBg5h+CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo++FUYDmv25U2HTiKmP2l6WYn5iZfEAndTUJP7LDZuk1wUImZ
	Q1ppIkv/LBjHyjnWMAmX5Tt9M4AawQ+glooXOxa/NF5kXYarz7FVOS2Q
X-Gm-Gg: AeBDiesJBgMswiyjn1ps01bWMREqf9IBhl/GqlFQjmlM7QQX7EnLjOrURwQEIvF24Z1
	DQ3+0cdBBj6n4aH2zxEkTR4oSX9E2bVzLOY5NWnN17Fxk6sXUCHW7qOXNWlgCeynzrQrgdv/3JK
	qLcgOK1HOUwPgOJ4BcaBsTQ6HbRF+HXLv9LpSU78WibfoSb0qKfHPA0rF5Lw1yDImzq4AtCQ1dQ
	TGLkbr3SoYZGCjvH5R9TCfmKqiswb82BuBo+ToyxrXjoOpymVEorXePYhBJefzbJTwzxpjZ1xPI
	J69sNCh3s2cdC9eQ26HQv5aaf0OBMjq8/XCAybKqCXbpq/VUdXm9mH0KRkE/csg2DEzLPv7Xpod
	jSjdopsQxthUfcV0l/JoW02p+tBrIKuzRbCVi666X/3wNBG42G2Dwy4KewF3wR9K5Cm3r0Rh4cO
	UKm3LbzPnna8EdHNHs399Jv9fuWwZNHdDK9Q8UwCQWdaqvqOBnCJrQbYov2mb6vXx97Sc=
X-Received: by 2002:a05:620a:258d:b0:8cf:f215:24c6 with SMTP id af79cd13be357-8f7d7833fa5mr1022963885a.21.1777474852384;
        Wed, 29 Apr 2026 08:00:52 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93f5826f7sm216892285a.30.2026.04.29.08.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:00:51 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Date: Wed, 29 Apr 2026 11:00:49 -0400
Message-ID: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D4B1D496730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241901-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[mikemarciniszyn.gmail.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This patch contains a fix for addr validation in fbnic_mdio_write_pcs().

Cc: stable@vger.kernel.org
Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index 709041f7fc43..d6a124889f52 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -125,7 +125,7 @@ fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
 		addr, regnum, val);
 
 	/* Allow access to both halves of PCS for 50R2 config */
-	if (addr > 2)
+	if (addr >= 2)
 		return;
 
 	/* Skip write for reserved registers */
-- 
2.43.0


