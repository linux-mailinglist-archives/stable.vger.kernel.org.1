Return-Path: <stable+bounces-231104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKnYBOxGymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:48:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882FD358828
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DC8E3036090
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55E388365;
	Mon, 30 Mar 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pvRrsAjH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C003815C0
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863678; cv=none; b=nPPvYz0KX7oiePcO+UINSEetj7yWA7hMJBHdBjjXWInkSwbYtqz1Oc1orYlnVd7Zm6gxIgMY598EKZ2t1cG/JugiHzwmBEY/DBKWsmN39Iy+hKA6NA/ze2ib1O9qjcATOojJ8z+TKBIVJs72wBIH3mEScH/A9jqfl3VXIIMtTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863678; c=relaxed/simple;
	bh=jBNvgPtDS7MLwV6mqJ28OzvNM7MK3/3dEHHLfF5yzBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZX2wCtoQFHNDClpKgvptJS1N7sgbEl456OVByC9xMw//fNunX7uru8xwZEqQf2G0lvVA3aAcisKWX3NWRVUefoMdWDRomJUxh9ruly+AHBC9D63G3/AVnua+jOrhfZbKbHCBu8mkptUqHpHZjBpt+aa9VCGEpdbCX/LgvxF+8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pvRrsAjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691C5C4CEF7;
	Mon, 30 Mar 2026 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863677;
	bh=jBNvgPtDS7MLwV6mqJ28OzvNM7MK3/3dEHHLfF5yzBI=;
	h=Subject:To:Cc:From:Date:From;
	b=pvRrsAjH/Xt9c/Yfra3Ws9CMiN4cECZ5oAFelAcG/9yt12hZ09GpfbJpVOMOBgJOB
	 cSnnN/nxROs6xUp9v9ht24Qwb/7YYT5j51BzbNdvVI9KpPltbNQxzuxoYso2FtXwkd
	 9FKORQ4JOk0n1/JPyfcw59XMcYlp6GdIvcTbk/uE=
Subject: FAILED: patch "[PATCH] dmaengine: fsl-edma: fix channel parameter config for fixed" failed to apply to 6.6-stable tree
To: joy.zou@nxp.com,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:41:14 +0200
Message-ID: <2026033014-jitters-makeshift-a3d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231104-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,nxp.com:email,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 882FD358828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2e7b5cf72e51c9cf9c8b75190189c757df31ddd9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033014-jitters-makeshift-a3d2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e7b5cf72e51c9cf9c8b75190189c757df31ddd9 Mon Sep 17 00:00:00 2001
From: Joy Zou <joy.zou@nxp.com>
Date: Wed, 17 Sep 2025 17:53:42 +0800
Subject: [PATCH] dmaengine: fsl-edma: fix channel parameter config for fixed
 channel requests

Configure only the requested channel when a fixed channel is specified
to avoid modifying other channels unintentionally.

Fix parameter configuration when a fixed DMA channel is requested on
i.MX9 AON domain and i.MX8QM/QXP/DXL platforms. When a client requests
a fixed channel (e.g., channel 6), the driver traverses channels 0-5
and may unintentionally modify their configuration if they are unused.

This leads to issues such as setting the `is_multi_fifo` flag unexpectedly,
causing memcpy tests to fail when using the dmatest tool.

Only affect edma memcpy test when the channel is fixed.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250917-b4-edma-chanconf-v1-1-886486e02e91@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index dbcdd1e68319..b596baa0a182 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -317,10 +317,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 			return NULL;
 		i = fsl_chan - fsl_edma->chans;
 
-		fsl_chan->priority = dma_spec->args[1];
-		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
-		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
-		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
+		if (!b_chmux && i != dma_spec->args[0])
+			continue;
 
 		if ((dma_spec->args[2] & FSL_EDMA_EVEN_CH) && (i & 0x1))
 			continue;
@@ -328,17 +326,15 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		if ((dma_spec->args[2] & FSL_EDMA_ODD_CH) && !(i & 0x1))
 			continue;
 
-		if (!b_chmux && i == dma_spec->args[0]) {
-			chan = dma_get_slave_channel(chan);
-			chan->device->privatecnt++;
-			return chan;
-		} else if (b_chmux && !fsl_chan->srcid) {
-			/* if controller support channel mux, choose a free channel */
-			chan = dma_get_slave_channel(chan);
-			chan->device->privatecnt++;
-			fsl_chan->srcid = dma_spec->args[0];
-			return chan;
-		}
+		fsl_chan->srcid = dma_spec->args[0];
+		fsl_chan->priority = dma_spec->args[1];
+		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
+		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
+		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
+
+		chan = dma_get_slave_channel(chan);
+		chan->device->privatecnt++;
+		return chan;
 	}
 	return NULL;
 }


