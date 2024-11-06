Return-Path: <stable+bounces-90369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9C9BE7F9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFA92850DE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B821DF73C;
	Wed,  6 Nov 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bRNutuAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABB1DED49;
	Wed,  6 Nov 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895567; cv=none; b=OKKaA6r9l/6L9JYFDCHFiopi78mNaHrmm4HlRQ0mGiJd6LWU6gEvxDHW/vRXImznEwVifpyg3RLARK3sFZ8VTh3LqPhAaR1toCVjZeR8utj9d+RU/Xeq1ZxNYT1YpJqAsjSPJkoHuwn9mvdnukzff1YZ1u0whucoE0mWipNdHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895567; c=relaxed/simple;
	bh=uulWi80EZGoTeBdhqSFlvoSAAu1KKmPrMcWPJ6VUSdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di7xH4c0Te0UTNQJtSE30MnAERvzOHI91ErMe8r2nI7JxbN4F77R+EGRMRhz26UEulS6EsibeEFp0sRe3sdEXMmKRLj1nIE6u/wvm/fUzHCL25Cc/Ow4zmyEAhpURAvBI248khAsXatzfcKfjeUm90FZ2g+cCkFrky8lFFAMWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bRNutuAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAABC4CECD;
	Wed,  6 Nov 2024 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895567;
	bh=uulWi80EZGoTeBdhqSFlvoSAAu1KKmPrMcWPJ6VUSdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRNutuAkKJPT83GPVLiWa/D1gEtxCxlYkeyJm64tDnCMsRPf/bVcRI9Ek4T2rmPhf
	 mypYHzDEOOBLihbVgxKZNIYQp7uxErJzVPfTtmxuegVtmMq9BwSbJsBnBJqGgKWfq0
	 i0D7iWVhyLzGYeBDsI2ofyiBpPbsvJl4qjCQORFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 262/350] CDC-NCM: avoid overflow in sanity checking
Date: Wed,  6 Nov 2024 13:03:10 +0100
Message-ID: <20241106120327.374331349@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 8d2b1a1ec9f559d30b724877da4ce592edc41fdc upstream.

A broken device may give an extreme offset like 0xFFF0
and a reasonable length for a fragment. In the sanity
check as formulated now, this will create an integer
overflow, defeating the sanity check. Both offset
and offset + len need to be checked in such a manner
that no overflow can occur.
And those quantities should be unsigned.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ncm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1708,10 +1708,10 @@ int cdc_ncm_rx_fixup(struct usbnet *dev,
 {
 	struct sk_buff *skb;
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
-	int len;
+	unsigned int len;
 	int nframes;
 	int x;
-	int offset;
+	unsigned int offset;
 	union {
 		struct usb_cdc_ncm_ndp16 *ndp16;
 		struct usb_cdc_ncm_ndp32 *ndp32;
@@ -1783,8 +1783,8 @@ next_ndp:
 			break;
 		}
 
-		/* sanity checking */
-		if (((offset + len) > skb_in->len) ||
+		/* sanity checking - watch out for integer wrap*/
+		if ((offset > skb_in->len) || (len > skb_in->len - offset) ||
 				(len > ctx->rx_max) || (len < ETH_HLEN)) {
 			netif_dbg(dev, rx_err, dev->net,
 				  "invalid frame detected (ignored) offset[%u]=%u, length=%u, skb=%p\n",



