Return-Path: <stable+bounces-100073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733D9E85E5
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 16:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3263C281200
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249214F9F8;
	Sun,  8 Dec 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Uz4+OS9B"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148D158DAC
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671431; cv=none; b=lWgVOmb27Y4cD881w7OV3zVlOU98Irw/ZIduur+n0EL92hviNzpS17kV/tRuYupdrLRAWC2jS9VS2Nr1asW2ggZMi2LSbNmEro7NGvxFvun0nj21Qzd4Qajfs3b0PEn08C5xclBMYDTLONBTpkrf4ufCsndk+UGWY75y5b8ZjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671431; c=relaxed/simple;
	bh=KA0vAU8DTDx3H/wl4aFnQ1yYDnMCnHQfCNIMY1kw10I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=Q8ffRgEJimC9kR2Ix6mm9rVwa6sK4vvFAIb0+yOAnFy+Uv8Y7MJ1AKmq85tvrXU9lO/1YSPqC31RvHeTBCnY9GSwgBc97xranZnWOKF7WWJWzZ5Gb1AOH+SSw5R87Zge9eb/EsxdulYqkc3rW+Pq62m0JX5LK/SLr0uXP+O4GK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Uz4+OS9B; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241208152341epoutp0104b95c73fa09565c649b0174170615cc~PPPj7fCMo0746807468epoutp01b
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 15:23:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241208152341epoutp0104b95c73fa09565c649b0174170615cc~PPPj7fCMo0746807468epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733671421;
	bh=U9qdsKOaCjfcMTnbwTLkPFo4E5Z9Ybaq/tHD+FUaP+g=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Uz4+OS9B7EuvzmL0IZR+PFH13RQo0xR+aaIDOGyPrdVm2P/hf7vcspfqmw3njkDzc
	 Ijia3CC+B6vO7qgbPHHCNOuds4mZqEfUkp/O6nWfOV8qeUKajsX596URCqgDwkYrqa
	 ONRPgMwb3VQPP0yK7i0W0wYcZk63JnQpBnbISDFo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241208152340epcas5p175fbbf749b8d418f8df3d5ebfa14e730~PPPiri99J1686816868epcas5p1N;
	Sun,  8 Dec 2024 15:23:40 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y5pfz1Q64z4x9Pt; Sun,  8 Dec
	2024 15:23:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.65.19956.AF9B5576; Mon,  9 Dec 2024 00:23:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241208152338epcas5p4fde427bb4467414417083221067ac7ab~PPPhMDJJ50061500615epcas5p40;
	Sun,  8 Dec 2024 15:23:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241208152338epsmtrp11d9743579f6d837188082af81474b114~PPPhKgA3_1210012100epsmtrp1S;
	Sun,  8 Dec 2024 15:23:38 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-c9-6755b9faef4c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.BC.18949.AF9B5576; Mon,  9 Dec 2024 00:23:38 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241208152335epsmtip143d565445f23f40887fd6abf32357895~PPPelHNbz2790327903epsmtip1U;
	Sun,  8 Dec 2024 15:23:35 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: gregkh@linuxfoundation.org, quic_jjohnson@quicinc.com, kees@kernel.org,
	abdul.rahim@myyahoo.com, m.grzeschik@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, Selvarasu Ganesan <selvarasu.g@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded issue
 during MIDI bind retries
Date: Sun,  8 Dec 2024 20:53:20 +0530
Message-ID: <20241208152322.1653-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjed05Pe3ArORbMPtniSCMhYIAWS/m6wdxFTSP+IFEyZXa1aY8t
	obf1FDZc4uigKGyusyagDAyKk1hnHaWAhRZcB8K4aKRzM1MBCcjmZeuYEwIS19K6+e95L8/7
	vM93IXFeNzuBLNKbaZNeoeWzV7E6fkhJTlvyFKgFzeMYqqttJdCD6w4CTZ7oYKNbTbUYGmo5
	iaGK5gtsZPe2s9DtOwss5Hx4lUCBrgY2OnXGiiN31U8Ymut/SiCL+zaBHNUNLNTX8heGAvMe
	HDW1TgFk/37NW3FSl6OaLe1t/JYjvfzbAEdqWxZIj3gPSL90O4D0b9e6fE5hcY6GVqhoUyKt
	VxpURXp1Lj9vh/xdeZZYIEwTSlA2P1Gv0NG5/M3b89O2FmlDTviJpQptSSiVr2AYfsabOSZD
	iZlO1BgYcy6fNqq0RpExnVHomBK9Ol1Pm18XCgSZWaHGvcUa5x0bZlzmfnzp4hOiHEy9WANi
	SEiJ4NGOu0QNWEXyqG4Ab/k/wyPBHIBz3WPRymMA+078ynpGmWj6M1rwATg5YgeRYB7A4Nnl
	UIUk2ZQQ3h3MCefjKS+Ao+NuTjjAqW4MOiYnOOFRcRQN26/7QBizqCR4tXkGD2Mu9Qb03SjH
	I3Ip8LzPi0Xyq+GPx6dX1sCp12BF+9cry0LKS8Ll0YYoYTMMdN7DIjgO3htwcyI4Af5uq4pi
	JfTaH0WxBvod/ih3EzzXNLLiAA8JX+jKiGjFwsNL01g4DSkuPFTFi3QnwSFLgB3Br8Dx0z8T
	ESyFQ1XzK9N5lAzO9DwmvgLr6p9zUP+cg/r/xZoA7gBraSOjU9NMlnGjnv7ov9tUGnQusPKK
	U/MugqnJYLofYCTwA0ji/HgumVeg5nFVirL9tMkgN5VoacYPskLHegRPWKM0hL6B3iwXiiQC
	kVgsFkk2ioX8l7n3rY0qHqVWmOlimjbSpmc8jIxJKMcCDdTuzF6JXOaraBfQ9VtY0wtt2OmY
	1W+fj8FM70wc2yUJxJTGpx+X7YjdPnttsWC/PbukARdtTTlZGV/eSEmZHufsOZfuilfKcrnx
	/rW9S55ttR+u55Wpijck92htbeBoadcp2YbdNsv9Pdf+CRYSeUTfq/0Lw+bh95P+sByybxpR
	njk8EHu2UHXwg/nk2UFx1fpHftkvbkuvNeU7K0lty5if+MaTnfHFzZda/c4gq1M0pkkdf/h5
	88TorieLiy847QNB66d1aMsnbZf3XFHu9Owd4lZ6BmjZPmtN58H3bgpn8nNMN2xPxWPiuqxh
	7uCByp0PfKYydvW+Sy2STMRnMRqFMBU3MYp/AfbqqXROBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnO6vnaHpBpM65SymT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVotVnXNYLI4s/8hkcfn7TmaLBRsfMVpMOijqIOyxaVUnm8f+uWvYPY69OM7u
	0f/XwGPinjqPvi2rGD0+b5ILYI/isklJzcksSy3St0vgylj3sJ+p4C9vxYEdf1gbGB9xdzFy
	ckgImEjcX/CetYuRi0NIYDejRMuqOawQCWmJ17O6GCFsYYmV/56zQxR9ZZQ4tHsbSxcjBweb
	gKHEsxM2IHERgSOMEqv/3wSbxCxwkkmi+esjFpBuYYFkialtN9lAbBYBVYnzi58yg9i8AtYS
	e280MENs0JRYu3cPE0RcUOLkzCdgvcwC8hLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLD
	AqO81HK94sTc4tK8dL3k/NxNjOB40dLawbhn1Qe9Q4xMHIyHGCU4mJVEeDm8Q9OFeFMSK6tS
	i/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRqYNLm3pe4ekZgr4nK1aMi
	sQsKmz+83tbcNadVb/mJE6ldF9Xa517M/1Z7UXhRc8XKBGm+61zfvrvyOb+fcODTtni9+70v
	r2r99Uh9YcTIY/Pzc5RB5IqUz4bmkceCXs2+IPSxuFQyNWtpn4wS6zSmo6bMS4otlgRxFZ9/
	sdL/+d63uye/Ovu3sMRf9dqdS1OV17M4C206cZbdyerqm5iF/eJCRyyslq4Rndspcl/+YWXv
	su7IEEUHsRPRT+YY6x+LvFrm+zPxbtDhY5cfm1/+19ux4Ez+qrnrIjrX7NnAZuZe/ILv0Fnm
	rAbmn0suXjnpXmTU+tLo7787msu/7mLhmp4kV1bme/2+uJBHpdLRv+VKLMUZiYZazEXFiQB0
	rI0SBgMAAA==
X-CMS-MailID: 20241208152338epcas5p4fde427bb4467414417083221067ac7ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208152338epcas5p4fde427bb4467414417083221067ac7ab
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>

The current implementation sets the wMaxPacketSize of bulk in/out
endpoints to 1024 bytes at the end of the f_midi_bind function. However,
in cases where there is a failure in the first midi bind attempt,
consider rebinding. This scenario may encounter an f_midi_bind issue due
to the previous bind setting the bulk endpoint's wMaxPacketSize to 1024
bytes, which exceeds the ep->maxpacket_limit where configured TX/RX
FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
speed only.
This commit addresses this issue by resetting the wMaxPacketSize before
endpoint claim.

Fixes: 46decc82ffd5 ("usb: gadget: unconditionally allocate hs/ss descriptor in bind operation")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/gadget/function/f_midi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3840..5caa0e4eb07e 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -907,6 +907,15 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = -ENODEV;
 
+	/*
+	 * Reset wMaxPacketSize with maximum packet size of FS bulk transfer before
+	 * endpoint claim. This ensures that the wMaxPacketSize does not exceed the
+	 * limit during bind retries where configured TX/RX FIFO's maxpacket size
+	 * of 512 bytes for IN/OUT endpoints in support HS speed only.
+	 */
+	bulk_in_desc.wMaxPacketSize = cpu_to_le16(64);
+	bulk_out_desc.wMaxPacketSize = cpu_to_le16(64);
+
 	/* allocate instance-specific endpoints */
 	midi->in_ep = usb_ep_autoconfig(cdev->gadget, &bulk_in_desc);
 	if (!midi->in_ep)
-- 
2.17.1


