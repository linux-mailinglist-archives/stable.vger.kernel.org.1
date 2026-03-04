Return-Path: <stable+bounces-223150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMVmJB20qGliwgAAu9opvQ
	(envelope-from <stable+bounces-223150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:37:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21384208B81
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62F023029C10
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233D39479F;
	Wed,  4 Mar 2026 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaDa/En1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529D388E4F;
	Wed,  4 Mar 2026 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663819; cv=none; b=MDBq1kkzIyunpP8OZRbXSTd7McIEVrjrvyA98nhnSBBGR+AxErSgs8NizklGrJ/O/Sh8EPJQbe7LZNQiEeSbGbX2Xsisxbe9stQYPW7mKmgOwssugIJrSJGml6K0qbOnS5ueKQQuqNOWuve8aNgUy23SecOmaThnDwIylBwFeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663819; c=relaxed/simple;
	bh=Rp/5lHW78DY0oe8mjuAP3YaSaDxOxON/7UJrAe3wzKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5kzjhuZ1Aq845cds/hrK96iqZ8wrki1SGWmAG+52eoE3dQ12o9UxdV6c5dxYTYOWbktA52qNFPREm4I7xVofMgAOM2uC6K2iSzMSGb3S8krv20riD7UbfamXihowKtpS6eTpUwsZWNc55WSSaKemz6JiN4gBjyzySzT6oOvxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaDa/En1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772663818; x=1804199818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rp/5lHW78DY0oe8mjuAP3YaSaDxOxON/7UJrAe3wzKk=;
  b=AaDa/En1Mpd31NBj4rs1+dEsOwYrGZfNLr5tYiRSqWnVVyx6ln05e2UJ
   9XFLKSZt8FLG89SPZHd67weFG1GSIKMv/wwqXks1ho0V+2xzovTYhI+NJ
   Gn7M1JcNunAlpU+sm4yoYoH+eMu+a/wX8/KF4+g5Ke1tk3nnWOkwHFkS9
   9qqkfI8hZc6xHBOx6JyiZW4tOOUHpAQVwEa9UYx8ZfIRpNLnPXWjN/mC3
   7F51QN0+hKyvuhhIUy9JFcGSMX0DOEpx8YAnCWXWyuUs5a24pkWtRuaSQ
   npFNiAyxJtzafCZ3FlkL6ZsVPSZ48AIMXEv9dwH2iKJwuPJvmtWs8UwxK
   Q==;
X-CSE-ConnectionGUID: FXKTaa9oSni7AE5Hs41YHw==
X-CSE-MsgGUID: a+B5fkYbS/m+m2CnMzJqdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72938941"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72938941"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:36:58 -0800
X-CSE-ConnectionGUID: nj5gRJ3+R+uPx1eowrsplA==
X-CSE-MsgGUID: V0E4dXk/S0qX2eCJYc4AAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223148896"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:36:56 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] xhci: Fix NULL pointer dereference when reading portli debugfs files
Date: Thu,  5 Mar 2026 00:36:39 +0200
Message-ID: <20260304223639.3882398-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304223639.3882398-1-mathias.nyman@linux.intel.com>
References: <20260304223639.3882398-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 21384208B81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223150-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

Michal reported and debgged a NULL pointer dereference bug in the
recently added portli debugfs files

Oops is caused when there are more port registers counted in
xhci->max_ports than ports reported by Supported Protocol capabilities.
This is possible if max_ports is more than maximum port number, or
if there are gaps between ports of different speeds the 'Supported
Protocol' capabilities.

In such cases port->rhub will be NULL so we can't reach xhci behind it.
Add an explicit NULL check for this case, and print portli in hex
without dereferencing port->rhub.

Reported-by: Michal Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/linux-usb/20260304103856.48b785fd.michal.pecio@gmail.com
Fixes: 384c57ec7205 ("usb: xhci: Add debugfs support for xHCI Port Link Info (PORTLI) register.")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-debugfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 890fc5e892f1..ade178ab34a7 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -386,11 +386,19 @@ static const struct file_operations port_fops = {
 static int xhci_portli_show(struct seq_file *s, void *unused)
 {
 	struct xhci_port	*port = s->private;
-	struct xhci_hcd		*xhci = hcd_to_xhci(port->rhub->hcd);
+	struct xhci_hcd		*xhci;
 	u32			portli;
 
 	portli = readl(&port->port_reg->portli);
 
+	/* port without protocol capability isn't added to a roothub */
+	if (!port->rhub) {
+		seq_printf(s, "0x%08x\n", portli);
+		return 0;
+	}
+
+	xhci = hcd_to_xhci(port->rhub->hcd);
+
 	/* PORTLI fields are valid if port is a USB3 or eUSB2V2 port */
 	if (port->rhub == &xhci->usb3_rhub)
 		seq_printf(s, "0x%08x LEC=%u RLC=%u TLC=%u\n", portli,
-- 
2.43.0


