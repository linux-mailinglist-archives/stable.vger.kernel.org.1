Return-Path: <stable+bounces-163955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D24B0DC91
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8E3B3106
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9B28B507;
	Tue, 22 Jul 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWq4oxwS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2F7263D;
	Tue, 22 Jul 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192765; cv=none; b=jMzZj9YTu6msbmu7rBj5JyDXHLuJV3LGIrgmZSfeyvPaP/UXbZovDiCSUd7Qc2QDI77DqrWrCZr8+emeuEQhGKNFpmDbny6Afi9HL9gtstFVosrHfEv4CFxN3BVHMTESkcWdK2tohryuHfbYMURbqZoZSfEIWx3RDsXMKKf9fUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192765; c=relaxed/simple;
	bh=B3ZVGUxH1Fq1EcWpjCIUvu9Pfunkdc5E3VVj6a8vmUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUnsQAVQk1AzgIROmsxG+a27to1r3fajtCYjIGUCayQyl0IlnWHKq3l7CN3YKBv125TAOdAeh+GZICGpxXSffw5m0FxlV0iY8oSuhzHc3MeiKxLkQpAUXMDRbdK6EUtuDiX9YC5XIl6n1KtkulxAN0yVYHTdlvdzGdgzHsV3w/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWq4oxwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8A7C4CEEB;
	Tue, 22 Jul 2025 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192765;
	bh=B3ZVGUxH1Fq1EcWpjCIUvu9Pfunkdc5E3VVj6a8vmUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWq4oxwSWukhcWPvIiSAagqalKZtA4o543Udub15wvPY7yZDpqO/m1Af2Lo31IMnT
	 /X7ZR+yb6/4yZTawOtktSVmJzl2Dg2hUuEOdTFpEs2qLuBuSCXeq4jo6AGeEzW6GSP
	 3TCLtqCiLl/d5hLhOcKP7zBYBxKQDHm4v1RPs9hU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sean Rhodes <sean@starlabs.systems>
Subject: [PATCH 6.12 050/158] Bluetooth: btintel: Check if controller is ISO capable on btintel_classify_pkt_type
Date: Tue, 22 Jul 2025 15:43:54 +0200
Message-ID: <20250722134342.599709958@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 6ec3185fbc3528f2284c347fb9bd8be6fa672ed4 upstream.

Due to what seem to be a bug with variant version returned by some
firmwares the code may set hdev->classify_pkt_type with
btintel_classify_pkt_type when in fact the controller doesn't even
support ISO channels feature but may use the handle range expected from
a controllers that does causing the packets to be reclassified as ISO
causing several bugs.

To fix the above btintel_classify_pkt_type will attempt to check if the
controller really supports ISO channels and in case it doesn't don't
reclassify even if the handle range is considered to be ISO, this is
considered safer than trying to fix the specific controller/firmware
version as that could change over time and causing similar problems in
the future.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219553
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
Link: https://github.com/StarLabsLtd/firmware/issues/180
Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classification for ISO data")
Cc: stable@vger.kernel.org
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Sean Rhodes <sean@starlabs.systems>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btintel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2656,7 +2656,7 @@ static u8 btintel_classify_pkt_type(stru
 	 * Distinguish ISO data packets form ACL data packets
 	 * based on their connection handle value range.
 	 */
-	if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
+	if (iso_capable(hdev) && hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
 		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
 
 		if (hci_handle(handle) >= BTINTEL_ISODATA_HANDLE_BASE)



