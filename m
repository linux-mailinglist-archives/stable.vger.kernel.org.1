Return-Path: <stable+bounces-211111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DdJMTg7cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:46:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C05D89C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CCAC86ACE4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C53D7D70;
	Wed, 21 Jan 2026 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hhm1Dv/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D182D97A2;
	Wed, 21 Jan 2026 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020475; cv=none; b=bgDDfBcCcgEKXxvtNESthK8dM1BGL93IK9mLbBzix+vlXoFcvNaXJdDTb4qwdUKpcgRkNg9C+Tm12JPio02pC5e6aq4ToSkNh9cyWRFhxQYXNJMjIDAR7L7YzUd/pvDPCWy5R7tdwFGfSw4OP55NkKNj3zv3ct6LT8UnMbwuyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020475; c=relaxed/simple;
	bh=ogtxtqgnajGfah/UzdDnNutY4n35/CvlFpwAlckV91A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIIA1tyDIMIHeL25RPP+JbYsuEsCb/AP1eQDWjCAgYAiOaI+j3kD24aYs1OiFgzyUwuZWwNhcFMGGlQG5UqOEUoV3IvnysIziCDokaxl6FhrcoPl8hUDT79AlNhORKMSfPo3hr08C0TMkMWyMX0LcF/WZO2oda1BOY3bLB5aFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hhm1Dv/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4519C16AAE;
	Wed, 21 Jan 2026 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020474;
	bh=ogtxtqgnajGfah/UzdDnNutY4n35/CvlFpwAlckV91A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hhm1Dv/qzdpEhswCnAnlnz/+I3P+Ug+NR2U8vwXohDNw1e80qD/AI5LcNJMMkxQoL
	 wqJldibBnqsVFNujSznPTcE2YRLGRqyRVQ/+d6wt6zWlSSpHnJHITnFLZqUoYPA6q6
	 2MjebwNbW1dQjy2oHl//vAhGC3scjk7dRN1of3kA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Johan Hovold <johan@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 168/198] dmaengine: at_hdmac: fix device leak on of_dma_xlate()
Date: Wed, 21 Jan 2026 19:16:36 +0100
Message-ID: <20260121181424.591945817@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211111-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 610C05D89C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1765,6 +1765,7 @@ static int atc_alloc_chan_resources(stru
 static void atc_free_chan_resources(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
+	struct at_dma_slave	*atslave;
 
 	BUG_ON(atc_chan_is_enabled(atchan));
 
@@ -1774,8 +1775,12 @@ static void atc_free_chan_resources(stru
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



