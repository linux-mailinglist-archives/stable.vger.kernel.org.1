Return-Path: <stable+bounces-133905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB74A92880
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975C9189C1F6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1CD2571DC;
	Thu, 17 Apr 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pf2EHMb+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947C2566D7;
	Thu, 17 Apr 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914502; cv=none; b=hRURkDdfVCyJIrNed66QvuXN/3tl4HsUKBzgeOHx9qqmjFYsFrp3npc8+hsR1ocGrTrxsqoaxkgrYnvdLumgEsRoy7U8Px5/Nz1G6wioPaLhE9n+SGVZhUQz2kOqfJSTRNtBWRLUD/QlixJSqVDNZ0r70vNQpx1+RZz/HIvCG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914502; c=relaxed/simple;
	bh=ZGoDx620c3EEeZ61L5NUM7mQmYaG+SswBH8CdrjEMUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRVBdma7EmwdOzITuFA9uC3xVXDwA0AepmGYMfer3XzLu54Jurdx7vJDlMjtFmeyS2Rch9F4HIIpYQUK2Vz1DmUAe7H+7qGorjycsSlj6WeZTKkbRQ9llrmW0KMo3tqVQrfmIXxoqxa2D2VWHFnletDD7VktTblAzs/xj2ZRLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pf2EHMb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001C0C4CEE4;
	Thu, 17 Apr 2025 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914502;
	bh=ZGoDx620c3EEeZ61L5NUM7mQmYaG+SswBH8CdrjEMUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pf2EHMb+fwvKWMFbYsOUSPEW0gjTcaXmoIPraPP9STxuZ0pfw55vXnjHDiG9LoLy6
	 sifJApfj78Il8EKoK99Cbo/vQc+K5E3DYnAsD6F8P/Cm7w27S1AyOJIfigEFYZJqPl
	 cnro7MO7gKxIv8ydWIChCCCrO3BmOQtgm+4yxTFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.13 236/414] media: venus: hfi_parser: add check to avoid out of bound access
Date: Thu, 17 Apr 2025 19:49:54 +0200
Message-ID: <20250417175120.919941360@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vikash Garodia <quic_vgarodia@quicinc.com>

commit 172bf5a9ef70a399bb227809db78442dc01d9e48 upstream.

There is a possibility that init_codecs is invoked multiple times during
manipulated payload from video firmware. In such case, if codecs_count
can get incremented to value more than MAX_CODEC_NUM, there can be OOB
access. Reset the count so that it always starts from beginning.

Cc: stable@vger.kernel.org
Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/hfi_parser.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -19,6 +19,8 @@ static void init_codecs(struct venus_cor
 	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	core->codecs_count = 0;
+
 	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
 		return;
 



