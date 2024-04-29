Return-Path: <stable+bounces-41679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1768B5742
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444741C20DDC
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A24853377;
	Mon, 29 Apr 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n+Y6Y+hd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C130524D9
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391953; cv=none; b=rK50Kefwu3TQuXz8Nu9PEuKhIWvAJzTsQflQDRoI2raebLTl+T1WPQ0JedToT0IQnZ4Qlx++I/je/ZThufTcgtZm63p2KI54fzpepgeqDBdBoh8z72D2RZZHH0jgDvMRSFTVkz87Q2FRh6IrhPrliNeOuG0nT8ejsU9ExOS5QkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391953; c=relaxed/simple;
	bh=4DDNgIs5847t1noPTjXSLzeBT8NDmKHgPO1BlQvJD2c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Loo3z7DKfIlCrEoKYjJSNq+dK+J3UuX8iW0V9vgiofHATvDwpJJT2i2RbfqCLV4vQ9oi/Y+Zbazre5IZGwUbgddkLp3qoDxIfafauRubCVht9vUHXjr5L8IGNYaJn6VF/KHVInS6vY82iscPFhm+B7mQJCRAxYCzWuadhTGC7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n+Y6Y+hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89ECC4AF17;
	Mon, 29 Apr 2024 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714391953;
	bh=4DDNgIs5847t1noPTjXSLzeBT8NDmKHgPO1BlQvJD2c=;
	h=Subject:To:Cc:From:Date:From;
	b=n+Y6Y+hdeQ10y4Drg/CMIkH0PzhrQvo3YboqE1yjIzxfTd/OJj6EjhtzFca5+OM6P
	 RBd2EyFJBteuTVwym8N2r/H90ehjSzfpM4/pGuzQpzObE7dd8AVRhgQd+6qbUFxWxm
	 AuaC2D6pdOMDK+qIuTISMBP5cezkYaPpeNeVnek0=
Subject: FAILED: patch "[PATCH] macsec: Enable devices to advertise whether they update" failed to apply to 6.6-stable tree
To: rrameshbabu@nvidia.com,bpoirier@nvidia.com,cratiu@nvidia.com,kuba@kernel.org,sd@queasysnail.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:59:09 +0200
Message-ID: <2024042909-drab-untapped-78a4@gregkh>
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
git cherry-pick -x 475747a19316b08e856c666a20503e73d7ed67ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042909-drab-untapped-78a4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

475747a19316 ("macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads")
a73d8779d61a ("net: macsec: introduce mdo_insert_tx_tag")
eb97b9bd38f9 ("net: macsec: documentation for macsec_context and macsec_ops")

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


