Return-Path: <stable+bounces-4474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DDC8047A2
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC071C20E55
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB88F79;
	Tue,  5 Dec 2023 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dK5x52hX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F06FB1;
	Tue,  5 Dec 2023 03:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0700C433C8;
	Tue,  5 Dec 2023 03:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747646;
	bh=StYV/eO8uDhM4EvBeh/vzY0Mc28+t+7G0iPrJOg/tEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dK5x52hXica2w3IhZcbo2+VN7toUSWKxRpyrwn5tx2RczhwuyWaI/biVD4TFD+Xvu
	 qB5o/SjlUr4bNuqZx3AyhmyHU0Y6YYaBYdxlpacZ75QYkMXqfGwIgi2Wu+UCa9hDFT
	 7AY3e8O/D1ND/MjzsM6ibH0FGv7UL6Ag6CBL3AiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 08/67] mmc: block: Do not lose cache flush during CQE error recovery
Date: Tue,  5 Dec 2023 12:16:53 +0900
Message-ID: <20231205031520.308307080@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 174925d340aac55296318e43fd96c0e1d196e105 upstream.

During CQE error recovery, error-free data commands get requeued if there
is any data left to transfer, but non-data commands are completed even
though they have not been processed.  Requeue them instead.

Note the only non-data command is cache flush, which would have resulted in
a cache flush being lost if it was queued at the time of CQE recovery.

Fixes: 1e8e55b67030 ("mmc: block: Add CQE support")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20231103084720.6886-2-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1465,6 +1465,8 @@ static void mmc_blk_cqe_complete_rq(stru
 			blk_mq_requeue_request(req, true);
 		else
 			__blk_mq_end_request(req, BLK_STS_OK);
+	} else if (mq->in_recovery) {
+		blk_mq_requeue_request(req, true);
 	} else {
 		blk_mq_end_request(req, BLK_STS_OK);
 	}



