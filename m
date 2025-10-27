Return-Path: <stable+bounces-190060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53537C0FAC3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE5344F2E96
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD98318131;
	Mon, 27 Oct 2025 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADuME5xT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCB317715
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586354; cv=none; b=PUlqIFK5lQxmv5pVuwqqOi8ijQaQgZFmTVRsxex+WF7wx1L7pL7TupRGJpqadyEA1PemNjJ52jUbu1lzIZFgDQmUDSXyQ/ehxBVsNwqMef/7Zh/otuFfHPbOvuCZ//6sVqnIZUu+LcU4jH9sIpwi+nKeURKzLnlEv/FuIVlSZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586354; c=relaxed/simple;
	bh=r/zx9NYudhhOUqa2UDZ0cIbUUkJFMb11ZNIYAiXD4L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtKOFAN8KBY2kvfTAKFfbwI4hQOZYNnirNACP4xkuW4xiLjfUlFFmO/7X49gFstewea6dkibWT0jvEEbv9DYkxUfLFNSSv4JPNqifvRZvSGs6SFsQMThv4gJ2gmJBQgaF5U0Vh7nPBRsNiePTDlgmZKBl5Ej9m9d0r543CsQKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADuME5xT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2A3C116C6;
	Mon, 27 Oct 2025 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761586353;
	bh=r/zx9NYudhhOUqa2UDZ0cIbUUkJFMb11ZNIYAiXD4L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADuME5xTx2E/KKYezET7ydRJmcqm3j85jmgTwhCKVtyGzDQW4jL9c+DKeJTdtvDMc
	 72pYajQG51kSHfw9P6kSeW0aVRlwH7/KYizzkyP0pj6tdDZgAmXKR2+11DJ0xgZxXI
	 oFWog71tyoB88ghaYr3sZu4XvcpKLONB9fXIdopRefCm7vqp6Yj7w6lwMvIDqEnyWG
	 rlkNZ2R1Y6QZzDMjpxgGMPUV4tExInSvVp6u8sFeIOetkqhJ3SGSse205YWKtUPiU+
	 s4FgAdIbW+mjL2yboYYqyMgtDMQDf3JkX2UYAoh6EbcNOVZHib4m4vglIbKJiN+hKb
	 4OyB5cU3F0lNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable <stable@kernel.org>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 6/6] xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event
Date: Mon, 27 Oct 2025 13:32:26 -0400
Message-ID: <20251027173226.609057-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027173226.609057-1-sashal@kernel.org>
References: <2025102713-cucumber-persevere-aa50@gregkh>
 <20251027173226.609057-1-sashal@kernel.org>
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
index ca541914f7035..92c2c083e1232 100644
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


