Return-Path: <stable+bounces-238488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPinEtU04mm13QAAu9opvQ
	(envelope-from <stable+bounces-238488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:25:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8641B988
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C402E309C22C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA73A3E70;
	Fri, 17 Apr 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="paSCx3Cw"
X-Original-To: stable@vger.kernel.org
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED73A16A7;
	Fri, 17 Apr 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432288; cv=none; b=KXiVdPaZz07wdbyRUzrFd2hhdyR6Je+E1GUfJ0Wv6rOcDZUSxwv9QiAH/Tbrsk2/0v1NnwdpVkhRJgr2IUC42bRMtQzxEIOY2mxK3hdws1KjUFz55Mxps6dbLq3Ca/ckBWoDLlHdOJOpElabQ0HNnQdSiLjux6qSpcfimTDOJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432288; c=relaxed/simple;
	bh=+7NpdMmWYEM3q5sy9cxgH2ACar+KhMk8tlirwg5hLUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUYE76PDHKTNXRCx/Dm0lOMDAbExd2GcDU91KJIf/c2mvQvbfzDOgL7Tm92rkEYY9hkWTxX7r4XVPTbmzCI8KJUOaDFljbaUsU8g164SBvgYrLQS8pdpmbIkk7ukZrPCxVaMgl8pap30UlLmF0YomD23JETp8uD0sZYzSpKQM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=paSCx3Cw; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pSYcOdNIP33VlmJbr9B6GAXWdNfuxXFHPUxe73o1NEc=; b=paSCx3CwSZyCSfmYCZ82bVLLsm
	0NoeMqU92U9GJCrcflhl/sLEQ1fqcX/C9W/YyHUDlp5EwOWgqNdggjIpZNbOR2gh91jhGLH6wGb8t
	uK8MVk4rX0hgkI1ZAHhzKukhLcqflxGx9mD/fWDZ/cbyxtw87PCx8Q/bNG1/0LqsLQCE=;
Received: from mnencia by spark.kcore.it with local (Exim 4.96)
	(envelope-from <mnencia@kcore.it>)
	id 1wDjBV-007w6F-1D;
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
Subject: [PATCH v2 1/2] PCI: Skip Resizable BAR restore on read error
Date: Fri, 17 Apr 2026 15:24:36 +0200
Message-Id: <666cac19b5daa0ab0e0ab64454e76b4d24465dbd.1776429882.git.mnencia@kcore.it>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-238488-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kcore.it:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mnencia@kcore.it,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.298];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,intel.com:email,shazbot.org:email,kcore.it:mid,kcore.it:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91D8641B988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pci_restore_rebar_state() uses the Resizable BAR Control register to
decide how many BARs to restore (nbars) and which BAR each iteration
addresses (bar_idx).

When the device does not respond, config reads return the all-ones
pattern. Both fields are 3 bits wide, so nbars and bar_idx both
evaluate to 7, past the spec's valid ranges for both fields.
pci_resource_n() then returns an unrelated resource slot, whose
size is used to derive a nonsensical value written back to the
Resizable BAR Control register.

Bail out if any Resizable BAR Control read returns the error
pattern. No further BARs are touched, which is safe because a
config read that returns the error pattern indicates the device is
unreachable and restoration is pointless.

Fixes: d3252ace0bc6 ("PCI: Restore resized BAR state on resume")
Cc: stable@vger.kernel.org
Signed-off-by: Marco Nenciarini <mnencia@kcore.it>
---
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Eric Chanudet <echanude@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Lukas Wunner <lukas@wunner.de>

 drivers/pci/rebar.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 39f8cf3b70d57..11965947c4cb5 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -231,6 +231,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
@@ -238,6 +241,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		int bar_idx, size;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pci_resource_n(pdev, bar_idx);
 		size = pci_rebar_bytes_to_size(resource_size(res));
-- 
2.47.3


