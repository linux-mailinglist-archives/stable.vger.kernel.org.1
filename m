Return-Path: <stable+bounces-96287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42E9E1A00
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724472841E9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE271E2842;
	Tue,  3 Dec 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e4av4u4g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E41DE3BD
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223209; cv=none; b=cNQp2/BQZlbeqR12i/J1lhi/CoidK4RfmSn0B78PpMV+26Zm6oesoN4ZnfuBPi9W6Z8gDWoEpM+BmJAADDYXCvvLJINxzG57GoAkzHDaZVdYuE04qRI/zA646UXlxqqVxfdCLDtbHjOSJQ2JSZ1EGMOWeWC/btgFmkoksGPJZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223209; c=relaxed/simple;
	bh=iyl8FAWDnfY6mSkYbcGa9DSq700LaT9zuTyJNWes+Ho=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YskqJD5GMYLY8Eb0v+nDjJMn4e/wn+4ruqXf/GlKiH91sqDJ0om0CdeUniAocU0SO7npyAA+G6bA7ZhEA71UvVjmN+rwdVCRW2t6cTuC4hv9lTnajqewpz02IscSPPtBY1Z4rhS6bx9NpmtJRgHbz7PjEFXokSdO89gQaosjBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4av4u4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465D3C4CECF;
	Tue,  3 Dec 2024 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733223208;
	bh=iyl8FAWDnfY6mSkYbcGa9DSq700LaT9zuTyJNWes+Ho=;
	h=Subject:To:Cc:From:Date:From;
	b=e4av4u4g6rI3S6HfNMi/oOtyUwOBd7/dCC9r22THjvl385GPr3hJg39FLCdzVGoQx
	 e6PaBAhyeUap+Af7WXNEPt1bpKlNFIiXEeZTf/opSgjVEl7uNENy+bmkRg6DQGCK4z
	 3Hn3E0UplXWIRazA5jsTaJw65fmDS21QCwNqXxI4=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Fix looping of queued SG entries" failed to apply to 5.4-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:53:25 +0100
Message-ID: <2024120325-flaky-phantom-f755@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b7fc65f5141c24785dc8c19249ca4efcf71b3524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120325-flaky-phantom-f755@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b7fc65f5141c24785dc8c19249ca4efcf71b3524 Mon Sep 17 00:00:00 2001
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Thu, 14 Nov 2024 01:02:18 +0000
Subject: [PATCH] usb: dwc3: gadget: Fix looping of queued SG entries

The dwc3_request->num_queued_sgs is decremented on completion. If a
partially completed request is handled, then the
dwc3_request->num_queued_sgs no longer reflects the total number of
num_queued_sgs (it would be cleared).

Correctly check the number of request SG entries remained to be prepare
and queued. Failure to do this may cause null pointer dereference when
accessing non-existent SG entry.

Cc: stable@vger.kernel.org
Fixes: c96e6725db9d ("usb: dwc3: gadget: Correct the logic for queuing sgs")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/d07a7c4aa0fcf746cdca0515150dbe5c52000af7.1731545781.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 38c3769a6c48..3a5a0d8be33c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1470,8 +1470,8 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	struct scatterlist *s;
 	int		i;
 	unsigned int length = req->request.length;
-	unsigned int remaining = req->request.num_mapped_sgs
-		- req->num_queued_sgs;
+	unsigned int remaining = req->num_pending_sgs;
+	unsigned int num_queued_sgs = req->request.num_mapped_sgs - remaining;
 	unsigned int num_trbs = req->num_trbs;
 	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
 
@@ -1479,7 +1479,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	 * If we resume preparing the request, then get the remaining length of
 	 * the request and resume where we left off.
 	 */
-	for_each_sg(req->request.sg, s, req->num_queued_sgs, i)
+	for_each_sg(req->request.sg, s, num_queued_sgs, i)
 		length -= sg_dma_len(s);
 
 	for_each_sg(sg, s, remaining, i) {


