Return-Path: <stable+bounces-138267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DFAAA173B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EF01B64EAE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431DF253924;
	Tue, 29 Apr 2025 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="beL1lGdb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0B253358;
	Tue, 29 Apr 2025 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948713; cv=none; b=IEEmI0eXu+SIpIuNnObW3I1OSh53UKJjlpk2bKinU73HZurf5BmzABHZDo3mc7DFw02uXSUZSkrqikydXur65MeSmBmmrptLWHPjMTLPNpuPABhNiV8jKy7ReiA/9GUEvFeHyFStK/2pC4V0oPiieRFOMyUkNp+CqbUFZwsQ0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948713; c=relaxed/simple;
	bh=6HJT8s8WoGC5/psz9MEzDfD3KFu6f+fVMOEBIhWyoVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKQiHePx660cHOgb9eqg8Kgt5ooES4RAVI6UtChg2Ye8pSKGQIqbWmOL6lsJEDQPuTInKb0d7Jrem9fXGs0Kecda4d+0uxxHDJEjXQJ1l0rx8Ymh5UpF1NCWRZrLZl1ZwqUF8dp+tiTdv8vjGfc2n4y2EtH8GYJvuB8BnDpHl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=beL1lGdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8504EC4CEEE;
	Tue, 29 Apr 2025 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948712;
	bh=6HJT8s8WoGC5/psz9MEzDfD3KFu6f+fVMOEBIhWyoVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beL1lGdbH8O3bSt95EqchtZwveP1LKMKKV9Owqva62kTyH16DSf5lg07Am8ebjHvt
	 L71zkRKoVeMlLeh2FgB+y62A3OOGohw5UrZeNhgDsBCdMUydg6eoKivI4+7FCBo49E
	 BQj6PG9lH+FtUlnEiWvmW32/cQq46dsu3/f4kLz0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15 059/373] media: venus: hfi: add a check to handle OOB in sfr region
Date: Tue, 29 Apr 2025 18:38:56 +0200
Message-ID: <20250429161125.553644404@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vikash Garodia <quic_vgarodia@quicinc.com>

commit f4b211714bcc70effa60c34d9fa613d182e3ef1e upstream.

sfr->buf_size is in shared memory and can be modified by malicious user.
OOB write is possible when the size is made higher than actual sfr data
buffer. Cap the size to allocated size for such cases.

Cc: stable@vger.kernel.org
Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1023,18 +1023,26 @@ static void venus_sfr_print(struct venus
 {
 	struct device *dev = hdev->core->dev;
 	struct hfi_sfr *sfr = hdev->sfr.kva;
+	u32 size;
 	void *p;
 
 	if (!sfr)
 		return;
 
-	p = memchr(sfr->data, '\0', sfr->buf_size);
+	size = sfr->buf_size;
+	if (!size)
+		return;
+
+	if (size > ALIGNED_SFR_SIZE)
+		size = ALIGNED_SFR_SIZE;
+
+	p = memchr(sfr->data, '\0', size);
 	/*
 	 * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
 	 * that Venus is in the process of crashing.
 	 */
 	if (!p)
-		sfr->data[sfr->buf_size - 1] = '\0';
+		sfr->data[size - 1] = '\0';
 
 	dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
 }



