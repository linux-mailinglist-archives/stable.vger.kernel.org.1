Return-Path: <stable+bounces-190165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB743C10123
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93991A20611
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E3322A25;
	Mon, 27 Oct 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv3R/uAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8231D37A
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590579; cv=none; b=ACiw7Qv3f0/nrcN9k4+TDlxrtOuQIpKuHj7naSvppsGHgeDF7OsnGGpnYPAmwtuJprtaGJg3rDdM3PQQp4rHXXgsgo8oYaJsmic2I/DYNlQwXiIewKqmd1QdxaKYzL7SYlMkbvIqAHLNvzzKpgfVL7a3D5oDUKd9SandMcl9uMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590579; c=relaxed/simple;
	bh=qX8UeqGGzGYma5mbkzDEJgjH1m9n8kQtk4JRqCXckgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXT5To537kjX8Uq8+UobXZanSxkhAhlf8h1OuXvZadDc54iADbt8JFtUCb7bf2933Q9b1MFKIHkoilLGGmPjzaDHfksbrKuPejAnqxL7QvtyZsJEtsPDf5rWuIA7kvN/AaqlSFJU+LTWNoKSp0H5u8eMxU3srXUAoB695lrkMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv3R/uAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB81C113D0;
	Mon, 27 Oct 2025 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590579;
	bh=qX8UeqGGzGYma5mbkzDEJgjH1m9n8kQtk4JRqCXckgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yv3R/uAbqQ+XO8u8icehrCY+ncwbVOoiJjyBHlVPH4pQDqu131ci/v5tvDPDcyJhE
	 gg52I+bqto7fsnU7E+Px6r3EMxJRXe6QoIxY3AWTKrisc5FsraGlWLcm7LODtnWC41
	 fD/BxDob0fNKw5O+GZlzbyEhf/uxqGz5msvfQtgcTDJKsfczovhjQNXhPykQpw+r5S
	 RAthlb+AqElf4CSlVA8XLBSa6F7TyFpPbCbrH1F/fVmodMH/KRQOLO1zvGVSW1ufec
	 W0hhdfGiB8vdOdupt17/XTct6T0EDVbLhyRbNgvoEkQKjSHNDUFmYmgvGluoE5SKkr
	 /aBnJbqcWCWtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable <stable@kernel.org>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event
Date: Mon, 27 Oct 2025 14:42:52 -0400
Message-ID: <20251027184252.639069-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027184252.639069-1-sashal@kernel.org>
References: <2025102714-patriot-eel-32c8@gregkh>
 <20251027184252.639069-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit f3d12ec847b945d5d65846c85f062d07d5e73164 ]

DbC may add 1024 bogus bytes to the beginneing of the receiving endpoint
if DbC hw triggers a STALL event before any Transfer Blocks (TRBs) for
incoming data are queued, but driver handles the event after it queued
the TRBs.

This is possible as xHCI DbC hardware may trigger spurious STALL transfer
events even if endpoint is empty. The STALL event contains a pointer
to the stalled TRB, and "remaining" untransferred data length.

As there are no TRBs queued yet the STALL event will just point to first
TRB position of the empty ring, with '0' bytes remaining untransferred.

DbC driver is polling for events, and may not handle the STALL event
before /dev/ttyDBC0 is opened and incoming data TRBs are queued.

The DbC event handler will now assume the first queued TRB (length 1024)
has stalled with '0' bytes remaining untransferred, and copies the data

This race situation can be practically mitigated by making sure the event
handler handles all pending transfer events when DbC reaches configured
state, and only then create dev/ttyDbC0, and start queueing transfers.
The event handler can this way detect the STALL events on empty rings
and discard them before any transfers are queued.

This does in practice solve the issue, but still leaves a small possible
gap for the race to trigger.
We still need a way to distinguish spurious STALLs on empty rings with '0'
bytes remaing, from actual STALL events with all bytes transmitted.

Cc: stable <stable@kernel.org>
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 86b1d1b84ed1d..8cd447b6c957d 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -880,7 +880,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC configured\n");
 			portsc = readl(&dbc->regs->portsc);
 			writel(portsc, &dbc->regs->portsc);
-			return EVT_GSER;
+			ret = EVT_GSER;
+			break;
 		}
 
 		return EVT_DONE;
@@ -940,7 +941,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
-			ret = EVT_XFER_DONE;
+			if (ret != EVT_GSER)
+				ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
-- 
2.51.0


