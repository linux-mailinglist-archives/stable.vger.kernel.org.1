Return-Path: <stable+bounces-244314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDA7HIbH+mnhSgMAu9opvQ
	(envelope-from <stable+bounces-244314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 06:45:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD04D6298
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 06:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B43302AD1C
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 04:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521B2FC89C;
	Wed,  6 May 2026 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxUHxerN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RYTbZ639"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDBC3C465
	for <stable@vger.kernel.org>; Wed,  6 May 2026 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042737; cv=none; b=H0dyP+8weL2ftpgnozn3bQZ+hDyqa75ax47scF+f/bx+d0+WdC0ysuC0/fQh9qJF6vnpYwYwdjGHGyFE89pgJkLEPWzP4ZS5GFZEHpcOivDJdqktL7dflHiNuhuRtgwPqXk0tLf0lbtxYARl0L9p6OKisojBFVbzODKj4yOB7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042737; c=relaxed/simple;
	bh=f21bnwPYLwQFGOrlp1u7eE89ouKQzkhp6GUbiDoJ+Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EI0ZOD3rtzcTh5PI0qrA5wayAkSCHKyGhU+xHrE/U8PjPdUtrJkPnl3CyqZLYLe+RHNDN3GrBbQFagTAzd77klHp7oi8vIMFBzpvhbTM+U/OG/YxlbVL2gWxMSX5z4dftsqYCdkBhRWZd9rfd4SmFd6EU3tCaY7ilmPXWQbDdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxUHxerN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RYTbZ639; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64604UZx248144
	for <stable@vger.kernel.org>; Wed, 6 May 2026 04:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W37kRhirnPcGF9X8nJPDZN
	I5oBwfiWycDGcpi70IxgU=; b=BxUHxerNN9S8uv1rDNrT+6ppr2inC5R7avBbFM
	4WkIVW+yupNW2NJ/iPht7Afu7KwNqwZMUkn7N1ARVrtC37oY1Y5oUiyt1oL26H9W
	XZeNYabTbhhEwA93bsXBowi5PWY/rhl3LsQKec5N1m83S+urj9FLsFvxnInh15mb
	aSS8AHNOT63gJhe25PlbCMhBq0N7rRzFCyob+nCN+vyHWKwsClUjW/Jg9YXBrdaH
	ppqVD9G16cWVTrl1iXCEgwpaH+L3LsymWK8rHGL2Oir2w9Ncqkw7CKsGTI5V/5uO
	33H97hccFYVSYMovMZCAeaCflHvzM+NZGZfM9hdvWtIYayWA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyjq42qmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 06 May 2026 04:45:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba838d3fa4so1625775ad.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778042733; x=1778647533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W37kRhirnPcGF9X8nJPDZNI5oBwfiWycDGcpi70IxgU=;
        b=RYTbZ6397tkOcukftE3it6gDRFOdXqAY/ZdEwjysVGitYCBh3A6S47VuAc65GqdKvs
         RYC2s8upe9WB853mSWhq8Z665fTgQVQpwNoxYplNvPUTsFNR8zJyguuks9QJXezPCoq5
         DHyMSxLNMJwwe/gfDiA5vNezeJusyliiBdWkqquh7QZsmUc1laf+2aqujsTsxGUqajpY
         8eVhDs8QPQs3e3mHkPAgvjfyrBa94r3qqHa2ZEuC0uA57hRZaApLSkAo9u5CT14l08NG
         7ku+NgYHs/GSTmv3uvTn4ukrTaLRN4vhb0rf5ny7p4QlFqO/dkdRY3rtpUv+bkaJR1c6
         2rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778042733; x=1778647533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W37kRhirnPcGF9X8nJPDZNI5oBwfiWycDGcpi70IxgU=;
        b=QGwi5GbXT/CNwrnH+RAwL7LW/kv77Q+rngNPAWlQX9V1Q5JCpyJDruLvSBC77HCGX8
         EsuATEdPes4Z65O/+oNFwrrqTrqeXcCa4NFpiFDXNfixlZrLFuELGxreUeQ7Wan4/kyU
         D8PUL2x2N75qIkdSnNew+N8MHz0TmCDgUW9EiyTetT+0ET2PaUkKYmt6l80MP77rfJBt
         W1ro5ONbWU/QuGDmr3mD1EbLf3Rk3Y1aGNDdEHbSLZ1wNRCl127zwYzg9+0absoYSUF3
         Xhhq90n/Eswe9SV/rZxPfoQGsjZ2go18lXt4HLHuxBLJelBBSEszFuIDRM5rZ8GW0SjQ
         YXeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AgVTmmdpI7xuSjnNDuBrbMgkMjeApI2WL1BvXAUL5G2Q5OkH67MRoY+V0cS3rwnEFnGLT+xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqvO9KSK6lbdFHhX5wF/yrApPvxHmBNSBTlRy9WtSsSYTP20j
	O/JTJ9171fP1OSCT2Hlkc16zsFpsoSIwdWwqDYdAQvK5ZbZNCzrr8PCtrkf4msdPqiYDxdJYZUv
	8fXsdLpSl44NHNb6c8IzOGNN35hNKdNZrzX/xTl2anyEy+7el/P0Zo7aYHKaMWnIsOTU=
X-Gm-Gg: AeBDievM1Goxl1PbgpJe0N5gk4nMalircWdrfC/mY1tADXUgtnIiPtZUAH1+ia7nrzL
	4lyENq1XqYszPXQUIL2n19IxONoW3HFh38hNqPkg3teyEWjiHYizsytH+Wj/HdK+Rp9gVA6/ctO
	B9w8m6/VYYIaHcxX7yZb2R13IEZMn9NiOWrEOG/lKNdOtom6bg7w6UmhzeeKYA2mgyJD+wQ6fAa
	k3OI6cUyRuDGFW4Pjlrn4ju8iuf9F6R4M87P2GU/JQGBthsIiZhD443Ra4rvIp5YLr9w9U+IOOl
	Bpp/om35hb361zfl1hKn29r1krmsLkD1dDaP5vYwBZ+wJI8G6+vprU9e+i7qOphFFgf95hztEz4
	RtyVvSPON5IjFxRdpDTSpyeUUhswcOoEaMSUpJTf1oJ9+RXvh28fadPDnboIRGhdOtzIq
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr17868175ad.13.1778042733016;
        Tue, 05 May 2026 21:45:33 -0700 (PDT)
X-Received: by 2002:a17:903:1d2:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2ba7908bfb1mr17867835ad.13.1778042732503;
        Tue, 05 May 2026 21:45:32 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2e8cfsm10248395ad.30.2026.05.05.21.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 21:45:31 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 06 May 2026 10:15:21 +0530
Subject: [PATCH v1] serial: qcom_geni: fix kfifo underflow when flush
 precedes DMA completion IRQ
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-serial-dma-stale-tx-buf-v1-1-e3ccb360d719@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGHH+mkC/yWMQQqDMBBFryKz7kBiMItepXQxMROdYm3JRBHEu
 xvb5fv893ZQzsIK92aHzKuofOYK9tZAP9I8MEqsDK1pvemMx+tPE8Y3oRaaGMuGYUmYOheDc56
 sI6j2N3OS7Vd+wGrh+d90CS/uy5WE4zgBUe33SX8AAAA=
X-Change-ID: 20260506-serial-dma-stale-tx-buf-f53db336a13a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778042729; l=2812;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=f21bnwPYLwQFGOrlp1u7eE89ouKQzkhp6GUbiDoJ+Vc=;
 b=6wLqgffK/F9OSZbfDbSFnjWU0glIUlKW4LkdwNo9Ygs151R8/jkqkLPaxKZN1a+wH0N3oXkQ3
 k+Tdo/WF8uiBZ7qdLrDH6GHS5VWhmdo+xFpNPLls9/QwB1rRKmuOTjD
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=MYxcfZ/f c=1 sm=1 tr=0 ts=69fac76e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OPMqKeeqv5z9Eww7yPYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA0MiBTYWx0ZWRfX1h/Iz1hT630H
 /IP23LmMLCplurOMTglGiFRoEcMdgpx6qRx58hKDyeqFIGLuVCEMFKUQkZZG+pJ+X/vC8p8DQfo
 0skyn7LsdCmttQMBg8k3rhjwPFct0oa91n5ybcpFt1NsrWd5mLZASImrosicwaS9vtYM8iU1i6c
 KT380ytzcxdaz99WQU+vt0EeDhqwkwaL4wXZ8Vy0VQaBZCMZgR9I11n86P8+G/8X2meWmDwQFWf
 XFyy+sfTHxwTnlUmchsF8/BSKOjjTNuF6JthNiDT2me2Qiq9g9iKddB7hiAVBXTtWTUIwDe53lz
 D5MSMnTP0IUxjU4+5ipyIu7mBWNkE6sfP04oJt5eraWYOb7eha9BJ67Y3FPYD1l8h26J+xXFi5M
 My5IA6+wveFfBRTz7HmKOAC2+3+JUPbViHnYDkLbIrgadf+EuAHgQFn6iQPrgc6I9GZ3tji/OLB
 nbiPnCLFBsA25nucJTQ==
X-Proofpoint-GUID: 5BRQXOiEu_XYNahs43ds9F9q2F3CSRXM
X-Proofpoint-ORIG-GUID: 5BRQXOiEu_XYNahs43ds9F9q2F3CSRXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060042
X-Rspamd-Queue-Id: 1ABD04D6298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244314-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

When uart_flush_buffer() runs before the DMA completion IRQ is delivered,
the following race can occur (all steps serialized by uart_port_lock):

  1. DMA starts: tx_remaining = N, kfifo contains N bytes
  2. DMA completes in hardware; IRQ is pending but not yet delivered
  3. uart_flush_buffer() acquires the port lock and calls kfifo_reset(),
     making kfifo_len() = 0 while tx_remaining remains N
  4. uart_flush_buffer() releases the port lock
  5. DMA IRQ fires; handle_tx_dma() acquires the port lock and calls
     uart_xmit_advance(uport, tx_remaining) on an empty kfifo

uart_xmit_advance() increments kfifo->out by tx_remaining. Since
kfifo_reset() already set both in and out to 0, out wraps past in,
causing kfifo_len() to return UART_XMIT_SIZE - tx_remaining. The next
start_tx_dma() call then submits a DMA transfer of stale buffer data.

Fix this by snapshotting kfifo_len() at the start of handle_tx_dma()
and skipping uart_xmit_advance() when fifo_len < tx_remaining, which
indicates the kfifo was reset by a preceding flush.

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b365dd5da3cb..3c1be7b21290 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1031,8 +1031,20 @@ static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct tty_port *tport = &uport->state->port;
+	unsigned int fifo_len = kfifo_len(&tport->xmit_fifo);
+
+	/*
+	 * Only advance the kfifo if it still contains the bytes that were
+	 * transferred. uart_flush_buffer() may have run before this IRQ
+	 * fired: it calls kfifo_reset() under the port lock, making
+	 * fifo_len = 0 while tx_remaining remains non-zero. Calling
+	 * uart_xmit_advance() in that case would underflow kfifo->out past
+	 * kfifo->in, making kfifo_len() wrap to UART_XMIT_SIZE - tx_remaining
+	 * and triggering a spurious large DMA transfer of stale data.
+	 */
+	if (fifo_len >= port->tx_remaining)
+		uart_xmit_advance(uport, port->tx_remaining);
 
-	uart_xmit_advance(uport, port->tx_remaining);
 	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
 	port->tx_dma_addr = 0;
 	port->tx_remaining = 0;

---
base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
change-id: 20260506-serial-dma-stale-tx-buf-f53db336a13a

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>


