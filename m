Return-Path: <stable+bounces-233944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MI+BJCF1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:42:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0923BEFF8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2A57300DA57
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946203CF02A;
	Wed,  8 Apr 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="jZu8AnMs"
X-Original-To: stable@vger.kernel.org
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BC349AFF;
	Wed,  8 Apr 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666374; cv=none; b=alitCWFRpct7U6/+NHjQ3GMibCY68rqah+kpFID3VqBA/CpMCIqx9nDlTvrQHez4DZBHE4un0QYeV1tgCiS0DVckpR0IYp7TXgUPdt+8sUXrZZSQo6NoZ4O6aEHGZCOPTGmK6YTilgzDOGqZWx0kMMPx7FduxbhaSTb/i5vWRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666374; c=relaxed/simple;
	bh=u6aaNp69KxTS+5US/rEwJlQdnHC2yKeTURhPqApbPdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TyXxI7ke+4DTnpKJI1F9n7Ej0ALR+/TVm5bptMxohOHfAAYdf1pt3hMI1CSECOBd/MP9BG+3VyBpp8xqHyoIPD+XtwNH21gre9d1GdQRgbngtVnYC7hSwVdIQDmdApL25YLrSJzQXE9E4RIqNAqmHWfo/5jHz37BxlCdYlJeIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=jZu8AnMs; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I21Y2KDp0LnjyiR5WuBPPxI8t01E0XecHwF5bX7E4ck=; b=jZu8AnMstPCnAr8CC3okbg4G3a
	b9RTy96uCGDpQkXTl685o0d6kGO6FLG6jJVCtjx61iQfTTM+ly0iPuS7FS7x3fN9zX9epppvjQC8O
	tz38Y5yNK/pB+70rA8FeQQRdyiC/YzM+A7UvH3oEMzU9MzRwjL7gKbvnPO9WzO99Ef08=;
Received: from mnencia by spark.kcore.it with local (Exim 4.96)
	(envelope-from <mnencia@kcore.it>)
	id 1wAVw2-007Imd-0E;
	Wed, 08 Apr 2026 18:39:22 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Marco Nenciarini <mnencia@kcore.it>
Subject: [PATCH] PCI/IOV: Fix out-of-bounds access in sriov_restore_vf_rebar_state()
Date: Wed,  8 Apr 2026 18:39:22 +0200
Message-Id: <20260408163922.1740497-1-mnencia@kcore.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[kcore.it:s=spark];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233944-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kcore.it];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mnencia@kcore.it,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kcore.it:-];
	NEURAL_HAM(-0.00)[-0.915];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,kcore.it:email,kcore.it:mid]
X-Rspamd-Queue-Id: 7B0923BEFF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sriov_restore_vf_rebar_state() extracts bar_idx from the VF Resizable
BAR control register using a 3-bit field (PCI_VF_REBAR_CTRL_BAR_IDX,
bits 0-2), which yields values in the range 0-7. This value is then
used to index into dev->sriov->barsz[], which has PCI_SRIOV_NUM_BARS
(6) entries.

If the PCI config space read returns garbage data (e.g. 0xffffffff when
the device is no longer accessible on the bus), bar_idx is 7, causing
an out-of-bounds array access. UBSAN reports this as:

  UBSAN: array-index-out-of-bounds in drivers/pci/iov.c:948:51
  index 7 is out of range for type 'resource_size_t [6]'

This was observed on an NVIDIA RTX PRO 1000 GPU (GB207GLM) that fell
off the PCIe bus during a failed GC6 power state exit. The subsequent
pci_restore_state() call triggered the UBSAN splat in
sriov_restore_vf_rebar_state() since all config space reads returned
0xffffffff.

Add a bounds check on bar_idx before using it as an array index to
prevent the out-of-bounds access.

Fixes: 5a8f77e24a30 ("PCI/IOV: Restore VF resizable BAR state after reset")
Cc: stable@vger.kernel.org
Signed-off-by: Marco Nenciarini <mnencia@kcore.it>
---
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 00784a60b..521f2cb64 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -946,6 +946,8 @@ static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
 
 		pci_read_config_dword(dev, pos + PCI_VF_REBAR_CTRL, &ctrl);
 		bar_idx = FIELD_GET(PCI_VF_REBAR_CTRL_BAR_IDX, ctrl);
+		if (bar_idx >= PCI_SRIOV_NUM_BARS)
+			continue;
 		size = pci_rebar_bytes_to_size(dev->sriov->barsz[bar_idx]);
 		ctrl &= ~PCI_VF_REBAR_CTRL_BAR_SIZE;
 		ctrl |= FIELD_PREP(PCI_VF_REBAR_CTRL_BAR_SIZE, size);
-- 
2.47.3


