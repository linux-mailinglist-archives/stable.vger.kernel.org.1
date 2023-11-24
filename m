Return-Path: <stable+bounces-1591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BE7F8071
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28D61C21595
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831992EAEA;
	Fri, 24 Nov 2023 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTx/nBOc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF033CC7;
	Fri, 24 Nov 2023 18:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FC8C433C8;
	Fri, 24 Nov 2023 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851783;
	bh=hxCXnZUnLvrc6mZKpC+m4w64c781CnmboYn9Y6sAHPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTx/nBOcIl5Vsrzb5l7Y+ly1VUe2eXdIIJ2MtlwVQloXGu9HS2tjPmqSgGc910t8h
	 gA2HyWPouJNlJG8A2+gSO5qAvg0mN+JGT2vQRAH0dnXVH7ny+N6rTD7Y/U87w/IRiY
	 OaCfF+h7/wmtvDuuUMjxquwzNAl0VGqv6oHD+ZR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/372] i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler
Date: Fri, 24 Nov 2023 17:48:01 +0000
Message-ID: <20231124172013.671927660@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit 45a832f989e520095429589d5b01b0c65da9b574 ]

Do not loop over ring headers in hci_dma_irq_handler() that are not
allocated and enabled in hci_dma_init(). Otherwise out of bounds access
will occur from rings->headers[i] access when i >= number of allocated
ring headers.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20230921055704.1087277-5-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 2990ac9eaade7..71b5dbe45c45c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -734,7 +734,7 @@ static bool hci_dma_irq_handler(struct i3c_hci *hci, unsigned int mask)
 	unsigned int i;
 	bool handled = false;
 
-	for (i = 0; mask && i < 8; i++) {
+	for (i = 0; mask && i < rings->total; i++) {
 		struct hci_rh_data *rh;
 		u32 status;
 
-- 
2.42.0




