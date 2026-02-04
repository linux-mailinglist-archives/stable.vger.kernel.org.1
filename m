Return-Path: <stable+bounces-213416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHESGUtbg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:44:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF913E7494
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8BCA300AEF2
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37679410D10;
	Wed,  4 Feb 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zaxQfPEK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B0280A3B;
	Wed,  4 Feb 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216264; cv=none; b=aGY1x6yFzv/dz088rPKKxvujhMUAXebbZ6EPX9yqE+KFF1DG2TC7lXZjjeLD0uW83yvD1G0qde7N0I7mBRYiDCyxAEGIuj+WfiZ+MvvwU0FPSyPp71Xy8lIBsBCNFlqWIFBHdfDqe4kMC1maQnw3hO70GeF0YQCFDppk+BKOzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216264; c=relaxed/simple;
	bh=bWXuKxmXHvoo9uD8NF5jco4r6TwHCQiQF2UVQaXZ7Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSS3WA05e/B/kbpqYvB6nEGwVJdbHx8WNX/8QY++oAQ+82WWAU4PYJcLBWoRGP+8yzpLD59Nxm0YJaXELHjfoENBXo9VRMYfGYSVRr9hpZ10lb9TEeBS+f7YzPLETZEsAymp7yaYgXlq4k5bgSxe9BKkNIPfIFgqCZJ/y9mHgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zaxQfPEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD09C4CEF7;
	Wed,  4 Feb 2026 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216263;
	bh=bWXuKxmXHvoo9uD8NF5jco4r6TwHCQiQF2UVQaXZ7Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zaxQfPEK6HbEARPdcJSA4ILnA4XlHMqqsCOiADv2nHZl6mp3bvK8lQGoh25CzpE3y
	 reNgrrT3LW/SrqDtWA55quEksB7xtVb/Wr7VnJ01GFCBImzGHm1xjMOQVcWaD+Gz1b
	 v5+wi1VIb55mYx2yERFLqcl2HjFftRjFF5h4f6BQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.10 037/161] dmaengine: at_hdmac: fix device leak on of_dma_xlate()
Date: Wed,  4 Feb 2026 15:38:20 +0100
Message-ID: <20260204143853.096025132@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213416-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: CF913E7494
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit b9074b2d7a230b6e28caa23165e9d8bc0677d333 upstream.

Make sure to drop the reference taken when looking up the DMA platform
device during of_dma_xlate() when releasing channel resources.

Note that commit 3832b78b3ec2 ("dmaengine: at_hdmac: add missing
put_device() call in at_dma_xlate()") fixed the leak in a couple of
error paths but the reference is still leaking on successful allocation.

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Fixes: 3832b78b3ec2 ("dmaengine: at_hdmac: add missing put_device() call in at_dma_xlate()")
Cc: stable@vger.kernel.org	# 3.10: 3832b78b3ec2
Cc: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251117161258.10679-2-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/at_hdmac.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1320,6 +1320,7 @@ static int atc_config(struct dma_chan *c
 		      struct dma_slave_config *sconfig)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
+	struct at_dma_slave	*atslave;
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
@@ -1579,8 +1580,12 @@ static void atc_free_chan_resources(stru
 	/*
 	 * Free atslave allocated in at_dma_xlate()
 	 */
-	kfree(chan->private);
-	chan->private = NULL;
+	atslave = chan->private;
+	if (atslave) {
+		put_device(atslave->dma_dev);
+		kfree(atslave);
+		chan->private = NULL;
+	}
 
 	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
 }



