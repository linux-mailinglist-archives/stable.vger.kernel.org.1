Return-Path: <stable+bounces-7465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4498172AB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9101BB21D11
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F044236C;
	Mon, 18 Dec 2023 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATroA0W7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39821D123;
	Mon, 18 Dec 2023 14:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56532C433C8;
	Mon, 18 Dec 2023 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908538;
	bh=JBfIAaNItSABKSBdLUvCqgRac+9wayoYGx8zUC0bV7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATroA0W7myiQ1jqCkcqvGssHq/5nQHcio/GCXzAreRTN5Bo8hT0XnhfgowYg6v3FP
	 Q3Wtwpf5rAghUPVmMsVCFsDRCOwz8ltzIRICoMZzhePH1q3U+C9SS42G6dDrzX7+rX
	 i0m1bVOb4Wcu0QcygtYNMgmaT1MfFVc8S4gCU2a4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Agroskin <shayagr@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 17/62] net: ena: Fix XDP redirection error
Date: Mon, 18 Dec 2023 14:51:41 +0100
Message-ID: <20231218135046.993451811@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
References: <20231218135046.178317233@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit 4ab138ca0a340e6d6e7a6a9bd5004bd8f83127ca ]

When sending TX packets, the meta descriptor can be all zeroes
as no meta information is required (as in XDP).

This patch removes the validity check, as when
`disable_meta_caching` is enabled, such TX packets will be
dropped otherwise.

Fixes: 0e3a3f6dacf0 ("net: ena: support new LLQ acceleration mode")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Link: https://lore.kernel.org/r/20231211062801.27891-5-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 032ab9f204388..3af9dbf245f2a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -316,9 +316,6 @@ static int ena_com_create_and_store_tx_meta_desc(struct ena_com_io_sq *io_sq,
 	 * compare it to the stored version, just create the meta
 	 */
 	if (io_sq->disable_meta_caching) {
-		if (unlikely(!ena_tx_ctx->meta_valid))
-			return -EINVAL;
-
 		*have_meta = true;
 		return ena_com_create_meta(io_sq, ena_meta);
 	}
-- 
2.43.0




