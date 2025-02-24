Return-Path: <stable+bounces-118929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82223A4207F
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0D23B3579
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC5248899;
	Mon, 24 Feb 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MU6AWnZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10473248865
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403379; cv=none; b=qlBq2IfOvZNrc4YegsLkSK6Lvbbd+io87juhIr89TwXo4g4oNIIuNeeOLWwt/hx6VhuXUyGzdJimIg01ERO+cSIYbhatK065vIrni7MUCCoRY6pFZ8AORar97vnnWRXgzrewNm74DdhpaASFi4UnhTyDtOdx34D/I4JW5M/kr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403379; c=relaxed/simple;
	bh=d7H3AAlv9Rs01GuC/Nnrz04sNLbEshUr01Ub+XZ1Crw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Le7K69amhlDu7LWsmpE6FPPOeVQNrQYzfqGXbKi0d90YhHi9KH1l3agGSzB/QrnSit/u/7jLJgzagkjmDwl8jLZbZZgTM4FWCfVLzZALrAicQz6wuekDwtS+VDAYZgQ9ahOnqFXg2RUn/KYwZ9dRu9us90XlRpNE9XxBAfY/gDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MU6AWnZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1E1C4CED6;
	Mon, 24 Feb 2025 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740403378;
	bh=d7H3AAlv9Rs01GuC/Nnrz04sNLbEshUr01Ub+XZ1Crw=;
	h=Subject:To:Cc:From:Date:From;
	b=MU6AWnZT6l2R0uCRMxCPLtk8TD2GYbmZAuazlcXV6SGDsm02/RlVFKK9qXe2UjMXm
	 qvMwETc/i15ZWEmtCeQAQuJNPTK6kcD8Y3r8iOSXWhB+CCpBxZ42DCe26VWdCRfkD2
	 nZvdfJt8rux/YCWSLMLdfXTY4L9dz7wt/CkTvuCM=
Subject: FAILED: patch "[PATCH] ibmvnic: Inspect header requirements before using scrq direct" failed to apply to 6.6-stable tree
To: nnac123@linux.ibm.com,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 14:22:47 +0100
Message-ID: <2025022447-prelaunch-remnant-9fee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x de390657b5d6f7deb9d1d36aaf45f02ba51ec9dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022447-prelaunch-remnant-9fee@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de390657b5d6f7deb9d1d36aaf45f02ba51ec9dc Mon Sep 17 00:00:00 2001
From: Nick Child <nnac123@linux.ibm.com>
Date: Tue, 1 Oct 2024 11:32:00 -0500
Subject: [PATCH] ibmvnic: Inspect header requirements before using scrq direct

Previously, the TX header requirement for standard frames was ignored.
This requirement is a bitstring sent from the VIOS which maps to the
type of header information needed during TX. If no header information,
is needed then send subcrq direct can be used (which can be more
performant).

This bitstring was previously ignored for standard packets (AKA non LSO,
non CSO) due to the belief that the bitstring was over-cautionary. It
turns out that there are some configurations where the backing device
does need header information for transmission of standard packets. If
the information is not supplied then this causes continuous "Adapter
error" transport events. Therefore, this bitstring should be respected
and observed before considering the use of send subcrq direct.

Fixes: 74839f7a8268 ("ibmvnic: Introduce send sub-crq direct")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241001163200.1802522-2-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 87e693a81433..97425c06e1ed 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2472,9 +2472,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* if we are going to send_subcrq_direct this then we need to
 	 * update the checksum before copying the data into ltb. Essentially
 	 * these packets force disable CSO so that we can guarantee that
-	 * FW does not need header info and we can send direct.
+	 * FW does not need header info and we can send direct. Also, vnic
+	 * server must be able to xmit standard packets without header data
 	 */
-	if (!skb_is_gso(skb) && !ind_bufp->index && !netdev_xmit_more()) {
+	if (*hdrs == 0 && !skb_is_gso(skb) &&
+	    !ind_bufp->index && !netdev_xmit_more()) {
 		use_scrq_send_direct = true;
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
 		    skb_checksum_help(skb))


