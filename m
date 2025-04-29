Return-Path: <stable+bounces-137453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968BAA1304
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901437B3F1A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6A22A81D;
	Tue, 29 Apr 2025 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCHs9GR+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBA23F413;
	Tue, 29 Apr 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946111; cv=none; b=S0lPXaelVun5cBfdHQapEV/32bLclvU8SNThNpqhA3TJJWMe6M5t9D2NcKN8wJ6YEgv2VEDSIdJuM81WVe1ybZaE8xVBYXxxnqVPNbvdpsm+x3OKd4L3j0O59vqH6I03Pep1SBbKFMreFamJbmzFQVGYlt/WyUuzMgcfl/H1oYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946111; c=relaxed/simple;
	bh=KLxK8pr8YhOoSvrFnK7Gm1+dX9MZ3jFqFQcUg6gqeE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7omFtrb2eoAkdOuwulaW6flQ9AoWsFc5vYL1sdfui7ums2gS07Twxh0rkJn60tc3wlor6q4D08JtiXvKUdrEWQH88tEmG/Qa6gEcc3gnR/EB2uotSwwaNEDco93OQglncHWjkA8DhXLqQ74oYADXIALf9RALcKIupmyTDnNUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCHs9GR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80206C4CEE3;
	Tue, 29 Apr 2025 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946110;
	bh=KLxK8pr8YhOoSvrFnK7Gm1+dX9MZ3jFqFQcUg6gqeE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCHs9GR+J0ws29xYZeW7nK7GkhbrIhIs5IrJWvGw++la/+V+D2HzK35KzFQ04bd+U
	 NOZjYg+2GVFnoGDpvbLdnyYWvluYne9/OS3PR+DnuYQeUWic5zez8jz2FsWfTqf5mJ
	 gFCjb8EKDTkNew8QRv3f+kOzs6OL+bxwZuXTe4O4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Kuangyi Chiang <ki.chiang65@gmail.com>
Subject: [PATCH 6.14 159/311] usb: xhci: Fix invalid pointer dereference in Etron workaround
Date: Tue, 29 Apr 2025 18:39:56 +0200
Message-ID: <20250429161127.544447912@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Pecio <michal.pecio@gmail.com>

commit 1ea050da5562af9b930d17cbbe9632d30f5df43a upstream.

This check is performed before prepare_transfer() and prepare_ring(), so
enqueue can already point at the final link TRB of a segment. And indeed
it will, some 0.4% of times this code is called.

Then enqueue + 1 is an invalid pointer. It will crash the kernel right
away or load some junk which may look like a link TRB and cause the real
link TRB to be replaced with a NOOP. This wouldn't end well.

Use a functionally equivalent test which doesn't dereference the pointer
and always gives correct result.

Something has crashed my machine twice in recent days while playing with
an Etron HC, and a control transfer stress test ran for confirmation has
just crashed it again. The same test passes with this patch applied.

Fixes: 5e1c67abc930 ("xhci: Fix control transfer error on Etron xHCI host")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Reviewed-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Link: https://lore.kernel.org/r/20250410151828.2868740-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-ring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3780,7 +3780,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *
 		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
 		 * TRB to be breaked by the Link TRB.
 		 */
-		if (trb_is_link(ep_ring->enqueue + 1)) {
+		if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue + 1)) {
 			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
 			queue_trb(xhci, ep_ring, false, 0, 0,
 					TRB_INTR_TARGET(0), field);



