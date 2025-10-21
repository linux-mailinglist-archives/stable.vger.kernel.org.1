Return-Path: <stable+bounces-188780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4378BF8A43
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0F65046BD
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407A27990B;
	Tue, 21 Oct 2025 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ak0GYdKH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012B1A3029;
	Tue, 21 Oct 2025 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077494; cv=none; b=bwgYrbWru+rXGyFxPPkTPVy0MVc1mGex+BPzOHFUbFnSFxkYPa1ozzbeUJoiIY0a1MTWfKX3+gZllEsyKwk3ahWyRSzoMlzp+VBnEipyLzWkvOHjTYGFg8PkA8UnURaQPbNkyQUq2e6m+Id+FrcMk7WFkWUmpp6Juam1r6E3aUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077494; c=relaxed/simple;
	bh=ejv6wJqM2mQPGVNf4z5VwKIca9ap4VqPgsU1fhrSfyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrZzKpAm620h4Ca1bZ6zgL6qtJx3McttrKzcaQWzo4vNAAZPtLUgNuxJT5SBcnDS3P3A6iWrz2YdaAHJuI1WWSZXLHyBZXiByDFG9dbn8YGS0y/epCrff6DdiTzwrwXADhNtIB8PZ4aL4wfQSJbwxVD0XXFKU4TvVcrTmzagbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ak0GYdKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963CBC4CEF5;
	Tue, 21 Oct 2025 20:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761077493;
	bh=ejv6wJqM2mQPGVNf4z5VwKIca9ap4VqPgsU1fhrSfyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ak0GYdKHBedHwwv+FXuixTnG6S4rmx90aFbkpMsi8Jkdob4UHW8Xh+04obXutvwcW
	 +KnXZQ3DeCMyVXqIGtjPMbjy5KqQnszbYmw2WfCnWm/nZnyjhk7iMN5Vn7SmRUwsSI
	 /oubi7NW16Pd+vyZFqJes8FsjuwtHfhX95Xdrf6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 122/159] accel/qaic: Treat remaining == 0 as error in find_and_map_user_pages()
Date: Tue, 21 Oct 2025 21:51:39 +0200
Message-ID: <20251021195046.091432028@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
References: <20251021195043.182511864@linuxfoundation.org>
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

From: Youssef Samir <quic_yabdulra@quicinc.com>

[ Upstream commit 11f08c30a3e4157305ba692f1d44cca5fc9a8fca ]

Currently, if find_and_map_user_pages() takes a DMA xfer request from the
user with a length field set to 0, or in a rare case, the host receives
QAIC_TRANS_DMA_XFER_CONT from the device where resources->xferred_dma_size
is equal to the requested transaction size, the function will return 0
before allocating an sgt or setting the fields of the dma_xfer struct.
In that case, encode_addr_size_pairs() will try to access the sgt which
will lead to a general protection fault.

Return an EINVAL in case the user provides a zero-sized ALP, or the device
requests continuation after all of the bytes have been transferred.

Fixes: 96d3c1cadedb ("accel/qaic: Clean up integer overflow checking in map_user_pages()")
Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251007122320.339654-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/qaic/qaic_control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index d8bdab69f8009..b86a8e48e731b 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -407,7 +407,7 @@ static int find_and_map_user_pages(struct qaic_device *qdev,
 		return -EINVAL;
 	remaining = in_trans->size - resources->xferred_dma_size;
 	if (remaining == 0)
-		return 0;
+		return -EINVAL;
 
 	if (check_add_overflow(xfer_start_addr, remaining, &end))
 		return -EINVAL;
-- 
2.51.0




