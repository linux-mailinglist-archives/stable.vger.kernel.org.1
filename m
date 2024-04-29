Return-Path: <stable+bounces-41680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3508B5743
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9ED1C20F95
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D4953385;
	Mon, 29 Apr 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MxmJSaAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77467524D9
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391956; cv=none; b=t1a+5pK0SMkoHX4ipkkBbm6M+sSNLEKdzuBEt+Sexs46BMWdegKFMJ4JXWTyhnuw4b0J1WhDrZghU3bFff9ovyIM95gd6p6Gog/F8i5Am7B2FrCjg03OsUB5vppmecR3oM40O+/v+2YO6q5Zl3b3+j/nkAY8nGTwr+xx16rZFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391956; c=relaxed/simple;
	bh=5ejb2tXW/Q0dvPwVchPVZGxIqEWmn7/A0WXZ1HQvyYo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QWcqWQufuQHdjVSnCsTypFRTjycIhmNwhC+5BQFrYVgv2qvcjJ5pFNfpfmZB9Ftdw4rMbjWjEESbsyPxKUaOJ/3SqVtb/uGSaZKYy8jEWK5BGtShUnoujTPPR8REoMgf774dLKx/AGoyquOpf7eK0O9sMllaG5WKZ9frrY2+m+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MxmJSaAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8824C113CD;
	Mon, 29 Apr 2024 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714391956;
	bh=5ejb2tXW/Q0dvPwVchPVZGxIqEWmn7/A0WXZ1HQvyYo=;
	h=Subject:To:Cc:From:Date:From;
	b=MxmJSaACTTrphPXmzSVI8H0awr2czuJKSd4Rqu5J/MyJyj1XX+qU9OGHnQD0lpR/t
	 lsV/pj2XowEJZvroFjF4STFh9z2T20LiumlzJjXoh+lVa2Vb3j7zN80JoqKS8iMKnX
	 tOAXeomw1zAgvdGq6GesqeVzUAkfkk/F1lLD09xs=
Subject: FAILED: patch "[PATCH] macsec: Enable devices to advertise whether they update" failed to apply to 6.1-stable tree
To: rrameshbabu@nvidia.com,bpoirier@nvidia.com,cratiu@nvidia.com,kuba@kernel.org,sd@queasysnail.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:59:10 +0200
Message-ID: <2024042910-reopen-tiara-5796@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 475747a19316b08e856c666a20503e73d7ed67ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042910-reopen-tiara-5796@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

475747a19316 ("macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads")
a73d8779d61a ("net: macsec: introduce mdo_insert_tx_tag")
eb97b9bd38f9 ("net: macsec: documentation for macsec_context and macsec_ops")
15f1735520f9 ("macsec: add support for IFLA_MACSEC_OFFLOAD in macsec_changelink")
f3b4a00f0f62 ("net: macsec: fix net device access prior to holding a lock")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 475747a19316b08e856c666a20503e73d7ed67ed Mon Sep 17 00:00:00 2001
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Date: Tue, 23 Apr 2024 11:13:02 -0700
Subject: [PATCH] macsec: Enable devices to advertise whether they update
 sk_buff md_dst during offloads

Cannot know whether a Rx skb missing md_dst is intended for MACsec or not
without knowing whether the device is able to update this field during an
offload. Assume that an offload to a MACsec device cannot support updating
md_dst by default. Capable devices can advertise that they do indicate that
an skb is related to a MACsec offloaded packet using the md_dst.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-2-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/include/net/macsec.h b/include/net/macsec.h
index dbd22180cc5c..de216cbc6b05 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -321,6 +321,7 @@ struct macsec_context {
  *	for the TX tag
  * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
  *	TX tag
+ * @rx_uses_md_dst: whether MACsec device offload supports sk_buff md_dst
  */
 struct macsec_ops {
 	/* Device wide */
@@ -352,6 +353,7 @@ struct macsec_ops {
 				 struct sk_buff *skb);
 	unsigned int needed_headroom;
 	unsigned int needed_tailroom;
+	bool rx_uses_md_dst;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);


