Return-Path: <stable+bounces-96288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BEA9E1AC5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3975B2D94A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945B1E283F;
	Tue,  3 Dec 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OGtYk0KW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FE1E2838
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223214; cv=none; b=Y7Ca6hTQabpKmnMdNr8WpBn0xDQiJ5cBUnaWV7A+Ugn1LCL88gJ67gPHs3lZLQ7oR6mR3ZDJma8FVhOdJe0QL53ZUPxcqJz5eJHHg8Kxcrkg6kjvk/lDteNrWaKXHgGKnbVqDFA5fIzdiimfLeziGq3XnUGEUhxkAr6Xf0nxDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223214; c=relaxed/simple;
	bh=gEhb5Jwzrtg2rl24vU5mZ0BCyZ/cfnWEzh/4Uf8Jn8M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SRaGy6CG+Jo/mzDQh7TgZZxJKRQDda1ehIaF8AFpF6G1VmMP+fMk0NOs99EzMUVr5YdCAn2ve3iTmvev8d7Xu95tor/j+/9Ca456RswRqHMxumRmpmpH09qmn5UaqyqIdBprwWUB6XkBFArAGRXRJwgQQ7VZ00XjHwqy4bHBl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OGtYk0KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E9CC4CECF;
	Tue,  3 Dec 2024 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733223213;
	bh=gEhb5Jwzrtg2rl24vU5mZ0BCyZ/cfnWEzh/4Uf8Jn8M=;
	h=Subject:To:Cc:From:Date:From;
	b=OGtYk0KWWHw6rUWWK5dzGxRxQPBjX+dxB8H2qoWz1gAQp6JwHmCdy7oYI7foRGa/X
	 6U1EvCGVzQ2CBfH+FWaxsaHgZi4k6EqUHTxYEHLmDETzoUzQ52TsfsYxRHX1y3JuQt
	 cxrXIY9bV//HOK/7ssw/tYhJACz5UhshrbIPKzSE=
Subject: FAILED: patch "[PATCH] usb: dwc3: gadget: Fix looping of queued SG entries" failed to apply to 4.19-stable tree
To: Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:53:26 +0100
Message-ID: <2024120326-tactful-stash-66fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b7fc65f5141c24785dc8c19249ca4efcf71b3524
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120326-tactful-stash-66fd@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


