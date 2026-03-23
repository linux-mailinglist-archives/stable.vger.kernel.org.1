Return-Path: <stable+bounces-229448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBPfIyJhwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:49:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF252F6FA7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B72EC31AD46F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726723AEF29;
	Mon, 23 Mar 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kNobXHwU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349863B7B69;
	Mon, 23 Mar 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279266; cv=none; b=Ny5RrwHg5K2Ru3mvfgb1vYOQWr4BeOQ9R0ATi7m+aU6VM8cKJKJpM+PybBNzcjUi0RvA1O/CXpxzX1MthzacErA5lM7+yhU9WIZWBLaD6YbvbTwHBS1paY3n+bGJd91cXnOOre6bCS5oPK5jR9QmNwiIME1x87NqWWZRGVUsVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279266; c=relaxed/simple;
	bh=cPe7aiYz+DMMYGmYh5NuQNtgawNNgQXpCTMKjDP8/pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBkYcAFbSGeOyCaIqh1arIHUO7cqxpP7zYoS6KOdV3baNOXCSg9zEYRZIFdJdb7mVzEGeydBSSSguL9rxxGY4ki/KF/x1PINgzZzt+dl754YixUo4tmnZdb3vd+NDxO82ougdYE6hoVOfEuzJd2FvCUUR6sf6MNJEwGLAdGxh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kNobXHwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED8BC4CEF7;
	Mon, 23 Mar 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279266;
	bh=cPe7aiYz+DMMYGmYh5NuQNtgawNNgQXpCTMKjDP8/pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNobXHwUpimh3vvWHQbr3oeJLiVSZl6CVhiI5nqEpeJ5ndnCJUuA/1II0sNGLbM5r
	 7JEGttKFxf641YQOuaBmnD/kkDozKW5cGHdkaWEGv3mRZlZNVi1TuP8vIHs5MNzOOg
	 gip1IdL7NqhqvY+TDRMiExiYVkbV5bHiK3yVjFtE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tobi Gaertner <tob.gaertner@me.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 529/567] net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check
Date: Mon, 23 Mar 2026 14:47:29 +0100
Message-ID: <20260323134547.084529158@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229448-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,me.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,me.com:email]
X-Rspamd-Queue-Id: 2AF252F6FA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobi Gaertner <tob.gaertner@me.com>

[ Upstream commit 77914255155e68a20aa41175edeecf8121dac391 ]

The same bounds-check bug fixed for NDP16 in the previous patch also
exists in cdc_ncm_rx_verify_ndp32(). The DPE array size is validated
against the total skb length without accounting for ndpoffset, allowing
out-of-bounds reads when the NDP32 is placed near the end of the NTB.

Add ndpoffset to the nframes bounds check and use struct_size_t() to
express the NDP-plus-DPE-array size more clearly.

Compile-tested only.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>
Link: https://patch.msgid.link/20260314054640.2895026-3-tob.gaertner@me.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/cdc_ncm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index ae7a2829fe49d..56dfd4cd2aa4f 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1693,6 +1693,7 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 	struct usbnet *dev = netdev_priv(skb_in->dev);
 	struct usb_cdc_ncm_ndp32 *ndp32;
 	int ret = -EINVAL;
+	size_t ndp_len;
 
 	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
@@ -1712,8 +1713,8 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe32));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp32) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {
+	ndp_len = struct_size_t(struct usb_cdc_ncm_ndp32, dpe32, ret);
+	if (ndpoffset + ndp_len > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
-- 
2.51.0




