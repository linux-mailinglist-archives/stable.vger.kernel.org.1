Return-Path: <stable+bounces-238489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAMFHt404mm13QAAu9opvQ
	(envelope-from <stable+bounces-238489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:25:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 200CE41B996
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66DE5309EC2C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED53A3E7F;
	Fri, 17 Apr 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="MnCbf17X"
X-Original-To: stable@vger.kernel.org
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622C3A16B4;
	Fri, 17 Apr 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432288; cv=none; b=aR/ggDXadbzzg1TBIRsA/TwjOFv3acnTUuN6ROV341KcgV32NsUedPA/VOdqzzziDIJ1SVyQT6ZJe3JU/ohbuIfDRfDNylxlZqmlzZm9hsZh51asemYv8Gw8WADcCWBgmCj8IVLgtUI7Q+LCloMcdrm661iiJqzIk/6xO+6Z53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432288; c=relaxed/simple;
	bh=LiqyxA4Fqp3E5PM/AtVrIZtpsvNwmNVzRuiijmPLyWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT+t4xhlEXlPI1J/JO6Cp7GuUXS7b3z4+ytreMoKBm9cQN4es8u7EyiKmFq70V2voxe4VuePfPRSoWe8Gamzp6YSDdzkGM1rYv4MlG11XAyrw4rKmBJZJPxCTJt3cwKVZafs4u4ATCMecyFEpZj0YPRe0gKH4s4pCPpnPypiKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=MnCbf17X; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SXo38i+4gu74nYK9SMz135VuFHiRnpB/1O9Er+Qdjtk=; b=MnCbf17XcrLEfgEFC9OpnFaLzg
	DSEjzpzQLsaOr1e2GO5BQEEj2hVEsIdqeX7sZ+d31L4oVTcu9sE3WFRmybjkMqVaiEYfd9nS+b3oa
	9RJkYmDDPaTi+mno7dRUKQM2cIuV59dTWarDTJzfVAorxg7NcNcQq1Yq86dLlerVZp20=;
Received: from mnencia by spark.kcore.it with local (Exim 4.96)
	(envelope-from <mnencia@kcore.it>)
	id 1wDjBV-007w6I-1I;
	Fri, 17 Apr 2026 15:24:37 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Marco Nenciarini <mnencia@kcore.it>,
	stable@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 2/2] PCI/IOV: Skip VF Resizable BAR restore on read error
Date: Fri, 17 Apr 2026 15:24:37 +0200
Message-Id: <44a4ae53ec2825816b816c85cd378430d9a95cc6.1776429882.git.mnencia@kcore.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1776429882.git.mnencia@kcore.it>
References: <20260408163922.1740497-1-mnencia@kcore.it> <cover.1776429882.git.mnencia@kcore.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[kcore.it:s=spark];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kcore.it];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kcore.it,intel.com,linux.intel.com,kernel.org,redhat.com,shazbot.org,wunner.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238489-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kcore.it:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mnencia@kcore.it,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.336];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kcore.it:mid,kcore.it:email,shazbot.org:email,intel.com:email,wunner.de:email]
X-Rspamd-Queue-Id: 200CE41B996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sriov_restore_vf_rebar_state() uses the VF Resizable BAR Control
register to decide how many VF BARs to restore (nbars) and which
VF BAR each iteration addresses (bar_idx). bar_idx indexes into
dev->sriov->barsz[], which has only PCI_SRIOV_NUM_BARS (6) entries.

When the device does not respond, config reads return the all-ones
pattern. Both fields are 3 bits wide, so nbars and bar_idx both
evaluate to 7. The barsz[] access then goes out of bounds. UBSAN
reports this as:

  UBSAN: array-index-out-of-bounds in drivers/pci/iov.c:948:51
  index 7 is out of range for type 'resource_size_t [6]'

Observed on an NVIDIA RTX PRO 1000 GPU (GB207GLM) that fell off the
PCIe bus during a failed GC6 power state exit. The subsequent
pci_restore_state() invoked sriov_restore_vf_rebar_state() while
config reads returned 0xffffffff, triggering the splat.

Bail out if any VF Resizable BAR Control read returns the error
pattern. No further VF BARs are touched, which is safe because a
config read that returns the error pattern indicates the device is
unreachable and restoration is pointless. This mirrors the guard
in pci_restore_rebar_state().

Fixes: 5a8f77e24a30 ("PCI/IOV: Restore VF resizable BAR state after reset")
Cc: stable@vger.kernel.org
Signed-off-by: Marco Nenciarini <mnencia@kcore.it>
---
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Eric Chanudet <echanude@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Lukas Wunner <lukas@wunner.de>

 drivers/pci/iov.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..08df9bace13d1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -938,12 +938,18 @@ static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
 		return;
 
 	pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_VF_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
 		int bar_idx, size;
 
 		pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = FIELD_GET(PCI_VF_REBAR_CTRL_BAR_IDX, ctrl);
 		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
 		ctrl &= ~PCI_VF_REBAR_CTRL_BAR_SIZE;
-- 
2.47.3


