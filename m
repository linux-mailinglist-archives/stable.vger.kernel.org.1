Return-Path: <stable+bounces-128665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEADA7EA43
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36203188D244
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922B261379;
	Mon,  7 Apr 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUHqCR+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F5261368;
	Mon,  7 Apr 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049627; cv=none; b=nEPMr+KXWIJE8ABh4sOG9fkP66oFfpU/H3RVmkV63msKHyxNofgckmHHDfKS3Hv6rnGMMrqwuz4KcO+dntHyQIKk/BDOnYhk5NHHY6xnrROD+ATedUHdfIpTpftOWocUqNL25xKbg2m9ZXY1bio7vIeBSoTwB8mFfQ8upcY04kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049627; c=relaxed/simple;
	bh=GTpLFu7d6p5DuW3yDBDjovkXVzLTCSGIEM38+Xg43uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBgEfybdjCfMOgfXzLqM+hUCjTsDog1KQTttGNvKSMwggZVFY+8U8aXpVgRE0iEalJXc/E8TbDQD5/4VCEzWb1/hypsYs2IEXuZNMEvAPVua2CXXO14ISxO/vctUL4MphCkYhCugo/pXJHa4uM33kxhkXLCghTRKUx4f+xfcWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUHqCR+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A73C4CEDD;
	Mon,  7 Apr 2025 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049626;
	bh=GTpLFu7d6p5DuW3yDBDjovkXVzLTCSGIEM38+Xg43uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUHqCR+Dl0bndzsyb2XurI9pdDUzBmVeMi43Cdm79XUYax53f2MLINBhFOzpC6qfn
	 BV+MhvlhEDZQC8Tovqg52tNWq/clpoBKr+4AaSkZCT0uizzFlF16dyJ/j228KTOQpw
	 42jZ+YKlkDQt9BXkqHSCM58BXpmHFdtvw0/OhHgwBHwbdkypc4o75hjjqX3YGeD+DW
	 WH+v2A+rGK0iw6S8ht6dFeJGIfAnjfBn48IEK0nL6jVIqppDnJJutB/E8gMRQ0DoMC
	 yvUDKJn+60gZvzzHahMN/qsAqpr/vNS1x8WhpI36BQQhopKl35MuxIremtuDVZwOYv
	 FeNwoWvbLwcvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 07/22] usb: xhci: Complete 'error mid TD' transfers when handling Missed Service
Date: Mon,  7 Apr 2025 14:13:17 -0400
Message-Id: <20250407181333.3182622-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit bfa8459942822bdcc86f0e87f237c0723ae64948 ]

Missed Service Error after an error mid TD means that the failed TD has
already been passed by the xHC without acknowledgment of the final TRB,
a known hardware bug. So don't wait any more and give back the TD.

Reproduced on NEC uPD720200 under conditions of ludicrously bad USB link
quality, confirmed to behave as expected using dynamic debug.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250306144954.3507700-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4384b86ea7b66..693b3dd8130ac 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2787,7 +2787,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dbg(xhci,
 			 "Miss service interval error for slot %u ep %u, set skip flag\n",
 			 slot_id, ep_index);
-		return 0;
+		break;
 	case COMP_NO_PING_RESPONSE_ERROR:
 		ep->skip = true;
 		xhci_dbg(xhci,
@@ -2838,6 +2838,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_td_cleanup(xhci, td, ep_ring, td->status);
 	}
 
+	/* Missed TDs will be skipped on the next event */
+	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR)
+		return 0;
+
 	if (list_empty(&ep_ring->td_list)) {
 		/*
 		 * Don't print wanings if ring is empty due to a stopped endpoint generating an
-- 
2.39.5


