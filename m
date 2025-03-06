Return-Path: <stable+bounces-121251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A074A54E2B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0462C188D9DF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F29188724;
	Thu,  6 Mar 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8hWWQ4U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2E1624E4;
	Thu,  6 Mar 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272572; cv=none; b=XfETX6MchFMxahy0kg3E5y+yWInC71Ik3Bbgwx5d1yjfI1KatcrFbaglJcIHM7H6QHCaB5HauKeiIOkgfCLtkyRJ588HdBeCkSk89saw2b7rrkGmqfSyiCKhlgmoW9TtiTYERzgTn1M6UFz/9Awqn/H7lcNtwJGK+pymu3sDQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272572; c=relaxed/simple;
	bh=0wx40jwKMq+iAK7skI5rEnHpc5MqM8TEkEtfZVhrA5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW8t7XOzcggWK08jiWq1bX5fa2sYQ+xpp78PCS+9N11XFCcVb/Q7mpDPosyQBszaUBMjONGY7lG4hGG3ufbrsDhjTbK1yNPC9U/N1R4v2E0+K5pd16maAEMbreFEjTYuP/G+ZnNJiteXvO1QPKpsv96naUPDPDB2m7/0YFCGD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8hWWQ4U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741272570; x=1772808570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0wx40jwKMq+iAK7skI5rEnHpc5MqM8TEkEtfZVhrA5c=;
  b=V8hWWQ4UoDPVHRZTOMvdS3ePGV9xEFbyP/3qfHpfFh6fb/Id9d93QibL
   NnVGRRXnVQ6iuKFxzz+6AFEVfsbCh1vr8GdyNQ7hkAqVmWzuuPogDwNvH
   HAASoyN6HT+leH+bSDBRgqALttTI5wMsxcTtMBcGjD5ulXTN/P2fmUPUw
   ur7tk2gscJuSydO2RoUEsXWCptChwIIsvn2j4Y3L1HTY0bHGGuKLq4dB2
   ugErS7lYaw+AGrx4h9lBuAisQec3pzLTaviOOLEMY424skCO///FoRrkN
   RXiy+jCADK1bTVwyxQqePpSAY9au7ZAuSg0dALbmTZVoNzp5gYNCtjiUd
   g==;
X-CSE-ConnectionGUID: KMyG8DVMQ+aTkylnlwq0ww==
X-CSE-MsgGUID: lMFPJ4GaSI20nQO2CFFHAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="67657071"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="67657071"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 06:49:30 -0800
X-CSE-ConnectionGUID: Nb3DCXLqQGCZVMRtDywrlg==
X-CSE-MsgGUID: aYX/4QglSCirClTr6iWrHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119954795"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by orviesa008.jf.intel.com with ESMTP; 06 Mar 2025 06:49:28 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 03/15] usb: xhci: Don't skip on Stopped - Length Invalid
Date: Thu,  6 Mar 2025 16:49:42 +0200
Message-ID: <20250306144954.3507700-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306144954.3507700-1-mathias.nyman@linux.intel.com>
References: <20250306144954.3507700-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

Up until commit d56b0b2ab142 ("usb: xhci: ensure skipped isoc TDs are
returned when isoc ring is stopped") in v6.11, the driver didn't skip
missed isochronous TDs when handling Stoppend and Stopped - Length
Invalid events. Instead, it erroneously cleared the skip flag, which
would cause the ring to get stuck, as future events won't match the
missed TD which is never removed from the queue until it's cancelled.

This buggy logic seems to have been in place substantially unchanged
since the 3.x series over 10 years ago, which probably speaks first
and foremost about relative rarity of this case in normal usage, but
by the spec I see no reason why it shouldn't be possible.

After d56b0b2ab142, TDs are immediately skipped when handling those
Stopped events. This poses a potential problem in case of Stopped -
Length Invalid, which occurs either on completed TDs (likely already
given back) or Link and No-Op TRBs. Such event won't be recognized
as matching any TD (unless it's the rare Link TRB inside a TD) and
will result in skipping all pending TDs, giving them back possibly
before they are done, risking isoc data loss and maybe UAF by HW.

As a compromise, don't skip and don't clear the skip flag on this
kind of event. Then the next event will skip missed TDs. A downside
of not handling Stopped - Length Invalid on a Link inside a TD is
that if the TD is cancelled, its actual length will not be updated
to account for TRBs (silently) completed before the TD was stopped.

I had no luck producing this sequence of completion events so there
is no compelling demonstration of any resulting disaster. It may be
a very rare, obscure condition. The sole motivation for this patch
is that if such unlikely event does occur, I'd rather risk reporting
a cancelled partially done isoc frame as empty than gamble with UAF.

This will be fixed more properly by looking at Stopped event's TRB
pointer when making skipping decisions, but such rework is unlikely
to be backported to v6.12, which will stay around for a few years.

Fixes: d56b0b2ab142 ("usb: xhci: ensure skipped isoc TDs are returned when isoc ring is stopped")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 23cf20026359..6fb48d30ec21 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2828,6 +2828,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		if (!ep_seg) {
 
 			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
+				/* this event is unlikely to match any TD, don't skip them all */
+				if (trb_comp_code == COMP_STOPPED_LENGTH_INVALID)
+					return 0;
+
 				skip_isoc_td(xhci, td, ep, status);
 				if (!list_empty(&ep_ring->td_list))
 					continue;
-- 
2.43.0


