Return-Path: <stable+bounces-184347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C5BD3E83
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931713E4028
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD8A30ACE7;
	Mon, 13 Oct 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDsi8s90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB661279DCE;
	Mon, 13 Oct 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367173; cv=none; b=IUm9lSw+EvhXoNPbJqBaZVAAtmV+/hbnzaVOocFnh7p5GHQm9ZGw2ImqcR8EQxbfswIYP0Iqa8uGyQqbcR3QAjUN7jex/DxiyhruDEJPCWEebzj1CWyeGrsYl1gPPRN87RqpNoAiAZO7tfw4B4p+L8ty79WWASm499Mc9XtAE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367173; c=relaxed/simple;
	bh=Gkclo86MUq9vVLmCNmFoEnL5nwmSnWzUdagzseO+XWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WA2xk5mmXlt5W3QSEyekWeiw1DQDXoX/hw76t5AAVLUP5okJazI7DeJs2XtBByg3mvMykIuzPeMQ7KsWKjMQGn6LJdh0miRYqBjV3sMO/KBDEUI7bapbKNrhKjyKz4e2M8KrieFbh9crlPY2LFUzxomzqe2nmXWERtvWWMzxYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDsi8s90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCA5C4CEE7;
	Mon, 13 Oct 2025 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367172;
	bh=Gkclo86MUq9vVLmCNmFoEnL5nwmSnWzUdagzseO+XWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDsi8s90Ght718LRXRb0ZzaokfpEM1OGQ9ppMSAV7tYqe+2XeZo2f75ibJjGZoezI
	 UdjyukMKLRRfKj3nbtWnwIT+vYSRv1goL1yvcuhSyuKNPu29lZNHIHPIn/bR19W+kg
	 5KpCwmOjXv9QsGlDSEZ9ytcwIUAOppd9oxYSUl+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Ian King <colin.i.king@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 116/196] misc: genwqe: Fix incorrect cmd field being reported in error
Date: Mon, 13 Oct 2025 16:44:49 +0200
Message-ID: <20251013144318.894172526@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 6b26053819dccc664120e07c56f107fb6f72f3fa ]

There is a dev_err message that is reporting the value of
cmd->asiv_length when it should be reporting cmd->asv_length
instead. Fix this.

Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20250902113712.2624743-1-colin.i.king@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/genwqe/card_ddcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 500b1feaf1f6f..fd7d5cd50d396 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -923,7 +923,7 @@ int __genwqe_execute_raw_ddcb(struct genwqe_dev *cd,
 	}
 	if (cmd->asv_length > DDCB_ASV_LENGTH) {
 		dev_err(&pci_dev->dev, "[%s] err: wrong asv_length of %d\n",
-			__func__, cmd->asiv_length);
+			__func__, cmd->asv_length);
 		return -EINVAL;
 	}
 	rc = __genwqe_enqueue_ddcb(cd, req, f_flags);
-- 
2.51.0




