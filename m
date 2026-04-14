Return-Path: <stable+bounces-237860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL18HIQ13mkRpQkAu9opvQ
	(envelope-from <stable+bounces-237860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:39:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E601F3FA0E6
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBD773017502
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F63E6397;
	Tue, 14 Apr 2026 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h822cIK1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262043DB629
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170352; cv=none; b=ozVDtkopcDiwJgrDtdjVLP7m1IXZxegKJD45ZnEmirZHGlW2J//E4VyiwQSOwlb43PIRclKHAn0CBiHD6E1/HmhNd9XIsN8jHKs04js8akm0lyNLEm1PXMIh0TGOQTDg7S9yTpFVXRYfGC2/J6uRsQDkQlbtbQgIZmSQfwMGGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170352; c=relaxed/simple;
	bh=lNn5jvrxlKSG0/5B/U0tSygzuJ+RkoFr9+I8Xu5aVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1tk1X3OPuNsOJCWq8MxF2mNhCA6Mi4Kef/bQ5k4L+rqg8k1LydNcg2ENCYjb6GnLVn5D9U0Is+FwiSMnwH6zV6cSWwbZ+A+mA7hpqikrUE9JrV+SY9NKpxG8SEqeKrraIF0TFuEyOHh/aY1euNeRRv98lmCsvBgwYIPTXwK86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h822cIK1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad9516a653so27245595ad.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170350; x=1776775150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqWzHM9f5XbHVj9TeBcnNeNR71vENRDJp955u8OEAcw=;
        b=h822cIK1k4F3eiz+mJo8fjedaC3pWXPCEdGjKfzrbS4PknOIpBU+cVVx4yj/J01wuT
         tZT1Q1wCCQa2TJXgBZWe9JP32HnTITLbOOM9D6iOOQAxecp0rAGTxywiNH7iq4U6wVD6
         KpYWadKD26DVSw+zM2hVvpDrKhyK/tQT5NULB9qAe+Kp/a/A+qdHvL8SF2tyo8D3HEja
         AxAvkhn19HXItFJC54MwqR9Qg2sOb1Bv4yXAMju9rpFDCknsQJ2sogoxzN9ZVlJ8grVE
         RhHn7+FoLU+4B2Nq8ODuxUn5vgyr1zUIBP9d28SqFKfoDuXFmeimFcbpOgmFJKAhFqtA
         9l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170350; x=1776775150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqWzHM9f5XbHVj9TeBcnNeNR71vENRDJp955u8OEAcw=;
        b=X+ubQAzA2RRGfCHPj4pvJBSzN8VcxbrF8ZNpRPIqym7zegjVkOc8YpNBWM4kZfHx8i
         FQuGJ7azfMPqk9VBvql13pCVQl2/veo4MFeGjEm97UtO5A8aalyx7ca6bQnHwcANf/jM
         iWkqc96BDh40A5EVCrbDLNQvBtwzJWCj1FQYX0xq5kMrmHlxwDTm0il8FuxTp+UQrGif
         lFJVjNp3E9bYbHZnNknZ4flO1Ms5pIox3OjYBgXGx5piTBlZMruobtu5L0mQ79f354lw
         LLFz3XUdDLvkzBC9JoNzR7hLeoG01pPJgQPwiIFGAp2D4AYaezDxbjyCfyFkdxfInX+5
         drWw==
X-Gm-Message-State: AOJu0YzPTpGOoCxBo+BBaIKZvLs+CUiIkVHAOsblnSRvEb6Jqanlh2Uh
	jv1oAjj351HBq16F7usIkOjvrDRBRW0VEB83qoQp5GUgcut/9hXuH9q4
X-Gm-Gg: AeBDietI7WojWKAfy7jkC++IVJu5ItZ5jgAUHsxqhiG9ECkBfvq85Uy0BGnTh16lEKj
	3cYn2AlRAb551UCtBi2fUHEOjRN+a4jGxatJgpHpVQVsn30xXgj8Beaekpktr7GeKR9hNP5o2JF
	poU5BBHOyuNFB6gE/oHuCvnnuduUHS8NudCNQ+1tuWJRu9nj+tyHHZzvniuEHRu+4OWBJ8LNhAH
	zApagTUP5nnl+dXqf6GGnirvgf5OYYUwnxN3lJ2fB5Rla2lB5t5IM9EA/+u7aMBWrSSM0MOIVah
	VRuimTWzLgqv4i+Zl9kC0ttiBRHl3fVcc19CGxm+LIP2NGCcsr17Di2EVc8Udv4FlbQdcOLwpXq
	eXxYU5A2dZAGHVxqPXcrVG/NIMEEx2bzf8q2kqgWngT0dE23TAKJqVrCXFm+eGP/44hZPC4TUoT
	rvF6Oe9PLNbeUwpEpoe5vRKg==
X-Received: by 2002:a17:903:3c2f:b0:2ad:d0ff:2ed4 with SMTP id d9443c01a7336-2b2d591b8cbmr174221755ad.6.1776170350383;
        Tue, 14 Apr 2026 05:39:10 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd610esm145281365ad.20.2026.04.14.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:39:09 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Lukasz Bartosik <lbartosik@marvell.com>,
	Suheil Chandran <schandran@marvell.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] crypto: octeontx2: fix IRQ vector leak in otx2_cptpf_probe()
Date: Tue, 14 Apr 2026 20:38:57 +0800
Message-ID: <20260414123857.3162673-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-237860-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[marvell.com,gondor.apana.org.au,davemloft.net,linux.dev,gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E601F3FA0E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

otx2_cptpf_probe() allocates MSI-X vectors with pci_alloc_irq_vectors()
before initializing the AF-PF mailbox, registering mailbox interrupts
and setting up the PF device.

When cptpf_afpf_mbox_init(), cptpf_register_afpf_mbox_intr(),
cptpf_device_init(), cn10k_cptpf_lmtst_init(),
otx2_cpt_init_eng_grps(), sysfs_create_group() or
otx2_cpt_register_dl() fails after IRQ vectors have been allocated
successfully, the function unwinds mailbox, interrupt and engine group
state, but fails to free the allocated IRQ vectors.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Add a dedicated error path to call
pci_free_irq_vectors() after pci_alloc_irq_vectors() succeeds.

Fixes: 83ffcf78627f ("crypto: octeontx2 - add mailbox communication with AF")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 346d1345f11c..059f702dbf5c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -783,7 +783,7 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 	/* Initialize AF-PF mailbox */
 	err = cptpf_afpf_mbox_init(cptpf);
 	if (err)
-		goto clear_drvdata;
+		goto free_irq_vectors;
 	/* Register mailbox interrupt */
 	err = cptpf_register_afpf_mbox_intr(cptpf);
 	if (err)
@@ -826,6 +826,8 @@ static int otx2_cptpf_probe(struct pci_dev *pdev,
 	cptpf_disable_afpf_mbox_intr(cptpf);
 destroy_afpf_mbox:
 	cptpf_afpf_mbox_destroy(cptpf);
+free_irq_vectors:
+	pci_free_irq_vectors(pdev);
 clear_drvdata:
 	pci_set_drvdata(pdev, NULL);
 	return err;
-- 
2.43.0


