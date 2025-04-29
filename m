Return-Path: <stable+bounces-137761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A971AA14CD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56844C2F27
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F16253332;
	Tue, 29 Apr 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s9HzIEIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C1251791;
	Tue, 29 Apr 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947048; cv=none; b=J0SuF8f39xxz1+7Lk9MjQXx/h8qb4Entx5Q1vIBIFMOZj4vM0zwJP2rg7Km81tsppUyE0jrgU+PXJ6jCGHdxcRnRcoesvvRsbw0kXnakqSe+1HdlaO5zb3901FApo4ip/ortK585ez7mtLfa2aisAmbVwDhAm0fj0hgs5qWmKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947048; c=relaxed/simple;
	bh=d0zeJLmSN0WgSLNDKFxri5E7PBucN/3uQp5Q8BWh84A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+wOdmJNy7uASzv67LyenBc3Me9uz5dhjvkZOwg5iwUYt9B4Uepn/qnzz/tq/fuauYALMCMRjmUuVluFQM/8Pt/wLCGzTk5d3LBmxg2muVIhNWNvycAb24qvM7QfhdGtJKqsqqAN89D1XLIi8f0IZcan6JIKopNSLEnczFKgJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s9HzIEIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD94AC4CEE3;
	Tue, 29 Apr 2025 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947048;
	bh=d0zeJLmSN0WgSLNDKFxri5E7PBucN/3uQp5Q8BWh84A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9HzIEIBh5vKR+YuyA+UOfZTLXr6C2DutSBxfpiyL4tBvefDwA31+p5ggKDs7UXRl
	 ZAcs0QOZdn511QgdmaAumTgag7/1XDWKGw6oc08z8dUu+1lNLKcHm9Otcu1lBKdlrL
	 0MuvKqNcqZdXlrXMY6dnenumrV98Njin9kTOm4LU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Cliff Liu <donghua.liu@windriver.com>,
	He Zhe <Zhe.He@windriver.com>
Subject: [PATCH 5.10 154/286] nvme: avoid double free special payload
Date: Tue, 29 Apr 2025 18:40:58 +0200
Message-ID: <20250429161114.220843796@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunguang Xu <chunguang.xu@shopee.com>

commit e5d574ab37f5f2e7937405613d9b1a724811e5ad upstream.

If a discard request needs to be retried, and that retry may fail before
a new special payload is added, a double free will result. Clear the
RQF_SPECIAL_LOAD when the request is cleaned.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[Minor context change fixed]
Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -850,6 +850,7 @@ void nvme_cleanup_cmd(struct request *re
 			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
 		else
 			kfree(page_address(page) + req->special_vec.bv_offset);
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);



