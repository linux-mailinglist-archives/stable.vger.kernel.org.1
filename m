Return-Path: <stable+bounces-34639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850DF89402E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F89928020A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1247A74;
	Mon,  1 Apr 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fm1q+1NB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BE1CA8F;
	Mon,  1 Apr 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988799; cv=none; b=ma2TOyN9RrS2tyCpoCsC5QDxRX/ql6OtlrbG7Nar7PigdTwmDGql+LNKDSA0vZ9ed5bkTQjk3lgqCxop0ACDiSNfYL1wDd6l4S0BF0nuQCEs905u4I786xFHPzjrqCqjN1ki28ktYhy25wqKQoAWhdYxwSQcpfy1QHbX3PQnvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988799; c=relaxed/simple;
	bh=vboLf7Z/7UueYYP30tYYonJBoISuHxE+FTsQbzJbnLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KX7ye30Mr6M5m/fc4OXyJ6wIWSFTS1qs2HycmRkhfkk23zD5AMDS4jUTki4wrVp2Qqmbur/A+8K8WQ+dLp9bbTxXt35SOfwY+UeGRIap0G5Nma7j4Krckq975fphYfjP9Zqp4BY5CMUMsaY8SdbWBHh6kfFLE6EocH/HuDkqDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fm1q+1NB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD05C433C7;
	Mon,  1 Apr 2024 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988799;
	bh=vboLf7Z/7UueYYP30tYYonJBoISuHxE+FTsQbzJbnLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fm1q+1NBVurJAAAoiRhum9R6Bf3zl+cLZASyJB+9HLfeAzSxl9+8IHtPO96B2U5Mt
	 rT7/UGz4+HlFNGO511qRQaROvP+CdveIVH6sFaZMRnwCjj7h/t5ckSRqFw7aPSJKQw
	 M7p1lnvIE+yod1hMeRShs6HwU4igct+nSz1thM7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH 6.7 263/432] usb: gadget: ncm: Fix handling of zero block length packets
Date: Mon,  1 Apr 2024 17:44:10 +0200
Message-ID: <20240401152600.995977071@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krishna Kurapati <quic_kriskura@quicinc.com>

commit f90ce1e04cbcc76639d6cba0fdbd820cd80b3c70 upstream.

While connecting to a Linux host with CDC_NCM_NTB_DEF_SIZE_TX
set to 65536, it has been observed that we receive short packets,
which come at interval of 5-10 seconds sometimes and have block
length zero but still contain 1-2 valid datagrams present.

According to the NCM spec:

"If wBlockLength = 0x0000, the block is terminated by a
short packet. In this case, the USB transfer must still
be shorter than dwNtbInMaxSize or dwNtbOutMaxSize. If
exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent,
and the size is a multiple of wMaxPacketSize for the
given pipe, then no ZLP shall be sent.

wBlockLength= 0x0000 must be used with extreme care, because
of the possibility that the host and device may get out of
sync, and because of test issues.

wBlockLength = 0x0000 allows the sender to reduce latency by
starting to send a very large NTB, and then shortening it when
the sender discovers that there’s not sufficient data to justify
sending a large NTB"

However, there is a potential issue with the current implementation,
as it checks for the occurrence of multiple NTBs in a single
giveback by verifying if the leftover bytes to be processed is zero
or not. If the block length reads zero, we would process the same
NTB infintely because the leftover bytes is never zero and it leads
to a crash. Fix this by bailing out if block length reads zero.

Cc: stable@vger.kernel.org
Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Link: https://lore.kernel.org/r/20240228115441.2105585-1-quic_kriskura@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_ncm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1333,7 +1333,7 @@ parse_ntb:
 	if (to_process == 1 &&
 	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
 		to_process--;
-	} else if (to_process > 0) {
+	} else if ((to_process > 0) && (block_len != 0)) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}



