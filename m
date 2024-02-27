Return-Path: <stable+bounces-24295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBF28693C3
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7901F241CA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C13145B13;
	Tue, 27 Feb 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svA21sZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A313B78F;
	Tue, 27 Feb 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041591; cv=none; b=YxJpndP90yFCG1zraVLfg7SwGts4Mw0PieyXngD+Wtjn2TV0//k94FZ7dF9xnnRQsst3u7HZJbJr6lr07ClMXZSUpxBqUGqzKI6+cv9UgqVz2r4FTxBTAAm3iUPsgEBlA1+yzOrGuaDIWeSqI8iZL6uQTtiHTyaBSe6gylErL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041591; c=relaxed/simple;
	bh=VRQpZvELbvFAP77PUSphEXFOjcuBAOLTqqdzCvMkl4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBjbGyCI4FO0X9Oby/g+WJyG8lE77rPstF+XoR+/P4SZz+4068w5gJkRtERbzNPivPnc7wp1iUoQB/DroCgWqImjNvrJi8wylALGCpTvvOd/MyuIjRDRaRI77EBNODNX2MPuSLEnYW5P0N7nv3Rdqy+0esAjGR6+KKKDap4ROU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svA21sZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C50C433C7;
	Tue, 27 Feb 2024 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041591;
	bh=VRQpZvELbvFAP77PUSphEXFOjcuBAOLTqqdzCvMkl4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svA21sZCxQM2yU3Y46Kk3MncuUjtWZQVydn6D0l+YXGHgPlH61cq1Q2n66oR8/Bls
	 2I1z9kt5HVzUmtk3+lES7j+X95ruzmgSA2PXSy1zWEZ/irkXa6q90ocP416M0EEWv0
	 ei9Jh5LIT7arUseOmWYCYxnwIdoHA7a7JnwHtzSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH 4.19 33/52] usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
Date: Tue, 27 Feb 2024 14:26:20 +0100
Message-ID: <20240227131549.620852538@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
References: <20240227131548.514622258@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krishna Kurapati <quic_kriskura@quicinc.com>

commit 76c51146820c5dac629f21deafab0a7039bc3ccd upstream.

It is observed sometimes when tethering is used over NCM with Windows 11
as host, at some instances, the gadget_giveback has one byte appended at
the end of a proper NTB. When the NTB is parsed, unwrap call looks for
any leftover bytes in SKB provided by u_ether and if there are any pending
bytes, it treats them as a separate NTB and parses it. But in case the
second NTB (as per unwrap call) is faulty/corrupt, all the datagrams that
were parsed properly in the first NTB and saved in rx_list are dropped.

Adding a few custom traces showed the following:
[002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
req 000000003868811a length 1025/16384 zsI ==> 0
[002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: 1025
[002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x400
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x10
[002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames

In this case, the giveback is of 1025 bytes and block length is 1024.
The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
all datagrams in rx_list.

Same is case with packets of size 2048:
[002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
req 0000000011dfd96e length 2049/16384 zsI ==> 0
[002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
[002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x800

Lecroy shows one byte coming in extra confirming that the byte is coming
in from PC:

 Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
 - Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
 --- Packet 4063861
       Data(1024 bytes)
       Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
 --- Packet 4063863
       Data(1 byte)
       Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)

According to Windows driver, no ZLP is needed if wBlockLength is non-zero,
because the non-zero wBlockLength has already told the function side the
size of transfer to be expected. However, there are in-market NCM devices
that rely on ZLP as long as the wBlockLength is multiple of wMaxPacketSize.
To deal with such devices, it pads an extra 0 at end so the transfer is no
longer multiple of wMaxPacketSize.

Cc: <stable@vger.kernel.org>
Fixes: 9f6ce4240a2b ("usb: gadget: f_ncm.c added")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Link: https://lore.kernel.org/r/20240205074650.200304-1-quic_kriskura@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_ncm.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1349,7 +1349,15 @@ parse_ntb:
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
 	to_process -= block_len;
-	if (to_process != 0) {
+
+	/*
+	 * Windows NCM driver avoids USB ZLPs by adding a 1-byte
+	 * zero pad as needed.
+	 */
+	if (to_process == 1 &&
+	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
+		to_process--;
+	} else if (to_process > 0) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}



