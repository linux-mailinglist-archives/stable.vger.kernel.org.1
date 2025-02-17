Return-Path: <stable+bounces-115365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78FA34366
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EA53A38C1
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5A54F218;
	Thu, 13 Feb 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cYFDC8Gt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C260281369;
	Thu, 13 Feb 2025 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457802; cv=none; b=LW/aI3QdMd4fl0855oM1WclEQMxgUOjAj77TLnGtelu/7xWJvXx4a4iKzObqGfr9PlQM+PLv01SuMjgEq/rHLv0IVBiw65F1UuZsnb9XBJKxCsrASHpqoe8qwZULBmVWCsWtcWUYppp4qx5B+Tt3KyKb7ICs+6oOwBpGFVJ63E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457802; c=relaxed/simple;
	bh=Ss7pi1Sm77iBoDhICKhIWzJ+myJ0noLVbhz1GZVfv/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa5sAnwjqx7Lidohih5Tzc0quS0Wmjb7bm1HDEGPgPKlli3rvtYUUjItBocOwi8TxIkdHxDILLJomGTyt+4uQOiZKpqgLzOss+8TARwZ6/x3tNvWd825mcmRLP+IHaHG1mlvrlAvoS2N0BHS4PurkxpdLaAn97QZGuRjG1UlSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cYFDC8Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2B8C4CED1;
	Thu, 13 Feb 2025 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457801;
	bh=Ss7pi1Sm77iBoDhICKhIWzJ+myJ0noLVbhz1GZVfv/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYFDC8GtyAf5OWdi4aAT7sg/wiK9RMa21D/V/rqxDjyGaNaLEdLp0W/xgromZaD/i
	 GSxmmeP47u2+pzsVrEsGO9LGW+g4H2u9vnAKvaqVOchD0rVw8mS5My+pss6q4Sza/h
	 VWk/918QO/Dn/tbbeadJVL8ZgB5P0XG+K5MIoJ1Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Foster Snowhill <forst@pen.gy>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 216/422] usbnet: ipheth: break up NCM header size computation
Date: Thu, 13 Feb 2025 15:26:05 +0100
Message-ID: <20250213142444.872533959@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

From: Foster Snowhill <forst@pen.gy>

commit efcbc678a14be268040ffc1fa33c98faf2d55141 upstream.

Originally, the total NCM header size was computed as the sum of two
vaguely labelled constants. While accurate, it wasn't particularly clear
where they were coming from.

Use sizes of existing NCM structs where available. Define the total
NDP16 size based on the maximum amount of DPEs that can fit into the
iOS-specific fixed-size header.

This change does not fix any particular issue. Rather, it introduces
intermediate constants that will simplify subsequent commits.
It should also make it clearer for the reader where the constant values
come from.

Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Foster Snowhill <forst@pen.gy>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/ipheth.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -61,7 +61,18 @@
 #define IPHETH_USBINTF_PROTO    1
 
 #define IPHETH_IP_ALIGN		2	/* padding at front of URB */
-#define IPHETH_NCM_HEADER_SIZE  (12 + 96) /* NCMH + NCM0 */
+/* On iOS devices, NCM headers in RX have a fixed size regardless of DPE count:
+ * - NTH16 (NCMH): 12 bytes, as per CDC NCM 1.0 spec
+ * - NDP16 (NCM0): 96 bytes, of which
+ *    - NDP16 fixed header: 8 bytes
+ *    - maximum of 22 DPEs (21 datagrams + trailer), 4 bytes each
+ */
+#define IPHETH_NDP16_MAX_DPE	22
+#define IPHETH_NDP16_HEADER_SIZE (sizeof(struct usb_cdc_ncm_ndp16) + \
+				  IPHETH_NDP16_MAX_DPE * \
+				  sizeof(struct usb_cdc_ncm_dpe16))
+#define IPHETH_NCM_HEADER_SIZE	(sizeof(struct usb_cdc_ncm_nth16) + \
+				 IPHETH_NDP16_HEADER_SIZE)
 #define IPHETH_TX_BUF_SIZE      ETH_FRAME_LEN
 #define IPHETH_RX_BUF_SIZE_LEGACY (IPHETH_IP_ALIGN + ETH_FRAME_LEN)
 #define IPHETH_RX_BUF_SIZE_NCM	65536



