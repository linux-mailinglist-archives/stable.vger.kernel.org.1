Return-Path: <stable+bounces-191161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6288C1111A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE0C3A61E0
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703D325493;
	Mon, 27 Oct 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4lxCbMG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DF3090CC;
	Mon, 27 Oct 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593167; cv=none; b=BLg+qKu7MYN6wGd4v42cbs3kf0KkCJU4EjZ5VeLMs+2veb/5ir6tbWLHHKgCC+W7NPKqjYQMrsuWmL5x6wz5x0iGQ2+/F2vOszUYRZ+epI7FrevXyAcgG2jPVmduLCtVuUObt/E0v8qLY5aP3KKgxnU0T5lZIa8RV+grDwFuJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593167; c=relaxed/simple;
	bh=2eacnaQdJ/p/QVxkqwuc6SxElgK0Z1TkTtNWDXqiMbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je4+wIhQzjVvwOulB/A3HA0xGsshPnnps3otQlJCW2iNvsAow3dhKKwAyJyjVBtlapznHadS4aV0QpCbCXLwy9gTYWFpo/HG6wLVc6IIXrEAXC2KyTw7R/bOJ1cRgxVtFcn2ehPgpnS97hSuXu9mG2z+g9zLALsa+wX6rK4lS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4lxCbMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFA6C4CEF1;
	Mon, 27 Oct 2025 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593167;
	bh=2eacnaQdJ/p/QVxkqwuc6SxElgK0Z1TkTtNWDXqiMbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4lxCbMGaL+8DUjZSGW1cGQItUP/Dr5WB+gLh4KXmwAvDti2W5xF9ymp7f5rMcQd/
	 6cRyg1mJm2TJZN6DkfwBh2AWywUaMwKLJgM4Cxm0TZmiahBKvYsquUc6NaVov1T22z
	 iaA9czWrtwHtxhSKIDYwDsuJmziqRan3HjI+zTgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 039/184] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Date: Mon, 27 Oct 2025 19:35:21 +0100
Message-ID: <20251027183515.964121251@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit e59bc32df2e989f034623a580e30a2a72af33b3f ]

The ENETC RX ring uses the page halves flipping mechanism, each page is
split into two halves for the RX ring to use. And ENETC_RXB_TRUESIZE is
defined to 2048 to indicate the size of half a page. However, the page
size is configurable, for ARM64 platform, PAGE_SIZE is default to 4K,
but it could be configured to 16K or 64K.

When PAGE_SIZE is set to 16K or 64K, ENETC_RXB_TRUESIZE is not correct,
and the RX ring will always use the first half of the page. This is not
consistent with the description in the relevant kernel doc and commit
messages.

This issue is invisible in most cases, but if users want to increase
PAGE_SIZE to receive a Jumbo frame with a single buffer for some use
cases, it will not work as expected, because the buffer size of each
RX BD is fixed to 2048 bytes.

Based on the above two points, we expect to correct ENETC_RXB_TRUESIZE
to (PAGE_SIZE >> 1), as described in the comment.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Link: https://patch.msgid.link/20251016080131.3127122-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04e..fbc08a18db6d5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -67,7 +67,7 @@ struct enetc_lso_t {
 #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
 
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
-#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
+#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
 	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
-- 
2.51.0




