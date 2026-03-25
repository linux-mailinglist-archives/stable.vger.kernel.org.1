Return-Path: <stable+bounces-230292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGGCMDqtw2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:39:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48151322572
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FEA6304DE98
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337EB3254A5;
	Wed, 25 Mar 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hckSUcy8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA221CC5C
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431127; cv=none; b=L+Ou1LrqHOyNA5jkxKb9Mp7Pz6HkAfOoipAfeVgbP1tjnObR7elGUGWPn+2DPTY/1bPPFSFrtaxIKKm0N5HG54afXK7kR3n78RV+gDQooSDv775wP+5zj7sNqlXxdzb4+8/g27O1wb3Qc7s1xXxNr+l9KRJ7qoYzKTCy62KqFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431127; c=relaxed/simple;
	bh=UV41qUpbXMbPJ8oKt5RHwR1kOG1v2llCMlZ+SAex9to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMjpbQ03VV/5CIr9j4SNca1Mg0G96z1wnp/HET8iHZR5O3x6YNEaut1EaxmxsvLO85jjCOnOWcDpnIAeI3sl7Vcl6tPtcJtt2ntRAvqB6JKoL4oKAZD4cHA5KAoBe51brl21tPtabeE6OCHqpyBBkx92TzReBGvIhBVOm3Q8Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hckSUcy8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so52097515e9.3
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774431124; x=1775035924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIsbSfS605Q4eTkbTgnxZvgMorhnFDaqZxn3f2tTBFI=;
        b=hckSUcy80k8ckKuBdK6VOzqEbGcMty/9LRQEs2EJn7ojDc3iadZIRb4LYlRhtK/2j9
         S/Y8Oj4wbausnRL5Ptk2ci6ebqMeJhZoBfwxwy7SX5stXT/O5IrC3BlUqiVtDDrvq/vS
         IGzSWAZ6JPnNmmi065AjwZhnhrY5e3zF7MlREy/mg/9akHM+SagJJGdJanABwxwAuXcQ
         MfU+hgXRASNstGarHJOV6bj9pJ/eNr9vVvhwoTkuN7wE1L3JBwfjhass8fHz1VDANsUi
         gLyPXu+anZK/44SkPVhHqYX985T/75sAPqNnMkAMvn9cY5+BzHQaQyXPXWEySBEu1V3x
         i3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774431124; x=1775035924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIsbSfS605Q4eTkbTgnxZvgMorhnFDaqZxn3f2tTBFI=;
        b=sPQK35dQncYg0dl29koHlLdEm5K9IBWUqxy/Tf+6cYS/XFuIQXhG7IoTaNnEHsq2YR
         Pw1KWacUCDE3MnTwCx23rtjybXlvX3ooBsfCBZH1NZESeBCVNBOosuAGT10/K7gzMMqC
         eXicAcXsEVnk3+g6q0k+KFZ+POkT32oHZJwUSwx9UsrgN92QKuAQ4VYYZlYRRfKJPgnE
         ETwfvfSwKOdnvk4FpBi13rUSD5UKKBwrUReKzho33K6pYdP0hV3G/4lujhkBN56N9yY5
         10NpAsf5DZRzRKzMmIKFOqfgUuqpO762NzjredBSeHav7AFfFUzb+maMuwYTYt/z9rf0
         So3g==
X-Forwarded-Encrypted: i=1; AJvYcCXlks4RXVlwR8DBGPP5ihfSxO647NJsqvs2nGsPcADcvN6Ps0Y4Fba+PYr46gSyVlkRlmHqPws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhe8CjEmr0ifIPzO2sNIXDb1Cm+tTn8tm7Y0Pd70guas9EBnr4
	jT8wCZlCt++g6WnVTsv2Ta0WoqWra9hCsgCN1TW3XKEnC1aeofMqUKrI
X-Gm-Gg: ATEYQzzr/g1Mghrrbh0A6+1+PpLUaYSowToU9iimdi71igeOtk45i7KQ5wjrIhS2Hay
	Jljl1rhXsLJwjGENByaX9ZTUD+4CEDCkq792xGKD2KSuZ80TzboDHP4jvldcxZdqi6unK/4tPxp
	skOenhg1c0ZjgUcpb7vKrCSoK120dL9/YsY3ZJ9PiDGbUgDy7sWyzFhniYB1x5vt63vKa2ET1Ib
	IVGyospTDBbABKG0CxYL08sdbCKNTweD9nbSoBMsDTjOtEIyyRWbkJAX8dpznQIAwornOW8hgdR
	anW+ZqE7o7htc27MVtORlaXCWlxltom09+wtEE8wOipoluwZMSKGGcNs0cYUaKA1LHBL0lnqkEn
	n2kJc/J0bLrZ2JfhTqI7zcm7sgmUxqn9rULL08rPooJRqehh8UfqceLOzMhquNs/Kl+mHU41Bb6
	P1Gmx6QZMhZ2sC2TWs7ESYW25ysSwHBwiFyMlP5U1RSaNc3hshIwGmPo7Vhq42aqwIP8Anx0IqI
	9KjvwwhM35bEfxlxrN3P2Z3vM+6HNU/tV+G0+N/hMObA3yjsmr5/RhP2oEyL3OwQcfjvevBIHII
	xfevwVDttaa1wWlJ9Qzh
X-Received: by 2002:a05:600c:8b88:b0:487:1c2:6a4c with SMTP id 5b1f17b1804b1-48715fbf6a6mr44191015e9.4.1774431123985;
        Wed, 25 Mar 2026 02:32:03 -0700 (PDT)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711764625sm120724195e9.14.2026.03.25.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:32:03 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] PCI: imx6: Fix reference clock source selection
Date: Wed, 25 Mar 2026 10:31:16 +0100
Message-ID: <20260325093118.684142-1-fra.schnyder@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230292-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 48151322572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Franz Schnyder <franz.schnyder@toradex.com>

In the PCIe PHY init for the iMX95, the reference clock source selection
uses a conditional instead of always passing the mask. This currently
breaks functionality if the internal refclk is used.

Pass always IMX95_PCIE_REF_USE_PAD as the mask and clear the bit if
external refclk is not used.

Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 81a7093494c8..e0580d6efa57 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -268,8 +268,8 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
-			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
-			   IMX95_PCIE_REF_USE_PAD);
+			   IMX95_PCIE_REF_USE_PAD,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
-- 
2.43.0


