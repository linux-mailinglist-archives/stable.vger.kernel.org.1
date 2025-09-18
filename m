Return-Path: <stable+bounces-175294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549EB366CE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CA057B7907
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507B34DCC4;
	Tue, 26 Aug 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1NkXuvw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9622DFA7;
	Tue, 26 Aug 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216656; cv=none; b=S1e+Vl+TU+S/qgONxHLlwIeYM3om9XixfvaRt2QjPKZdHQQxhXGOZ5xhxv1vCTeg74XmYEd4FNj6YxJgpcqsmaHpTWrzUsRPB5tNf14+GY7pvdi1rouUY3eIuQXkALFKWpiGg/Ep4D8bRRpxcq6ohydGLuubKbjjLoY/zVKHlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216656; c=relaxed/simple;
	bh=iOtAc/oVwPBnT5I7WpNN/AivqaSunLBeEalY1uGEu9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl5Y5CchqLjnna3zhAZVLnA6LbOZdTWwgspQ7XUCMbaym9Q6LvCm61cbgO2ShNCPjwhfASvCe3zhcyctVCU+ClQcHdwcfW3KNVcnjq90/+ixPTWfHk0ek7K0AisiEMcMLRsruVE1jpfYXsftySDejDoqtsze6fT/44iRGbBe+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n1NkXuvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C13C4CEF1;
	Tue, 26 Aug 2025 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216656;
	bh=iOtAc/oVwPBnT5I7WpNN/AivqaSunLBeEalY1uGEu9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1NkXuvwDdK/SEPkpb3+XU+kC5VQ8OfHaIlbp6hSe6q7FKBXTt2ifub7mJmScmnXi
	 4DSL7MfJNUwH8XJ4Pl+/c271G5jNcREvQC+1R59Hf7WpQN/tJpj4XAli3EUinhjB4r
	 S5/5M4KPD4dCI+8QTMekJd9w09PnDZO5Q8m1pP8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Bryan ODonoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15 493/644] media: venus: Add a check for packet size after reading from shared memory
Date: Tue, 26 Aug 2025 13:09:44 +0200
Message-ID: <20250826110958.710549477@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

From: Vedang Nagar <quic_vnagar@quicinc.com>

commit 49befc830daa743e051a65468c05c2ff9e8580e6 upstream.

Add a check to ensure that the packet size does not exceed the number of
available words after reading the packet header from shared memory. This
ensures that the size provided by the firmware is safe to process and
prevent potential out-of-bounds memory access.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Cc: stable@vger.kernel.org
Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -239,6 +239,7 @@ static int venus_write_queue(struct venu
 static int venus_read_queue(struct venus_hfi_device *hdev,
 			    struct iface_queue *queue, void *pkt, u32 *tx_req)
 {
+	struct hfi_pkt_hdr *pkt_hdr = NULL;
 	struct hfi_queue_header *qhdr;
 	u32 dwords, new_rd_idx;
 	u32 rd_idx, wr_idx, type, qsize;
@@ -304,6 +305,9 @@ static int venus_read_queue(struct venus
 			memcpy(pkt, rd_ptr, len);
 			memcpy(pkt + len, queue->qmem.kva, new_rd_idx << 2);
 		}
+		pkt_hdr = (struct hfi_pkt_hdr *)(pkt);
+		if ((pkt_hdr->size >> 2) != dwords)
+			return -EINVAL;
 	} else {
 		/* bad packet received, dropping */
 		new_rd_idx = qhdr->write_idx;



