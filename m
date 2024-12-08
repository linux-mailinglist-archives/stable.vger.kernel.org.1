Return-Path: <stable+bounces-100072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07529E85C2
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 16:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3AEA164F38
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8204414C5AF;
	Sun,  8 Dec 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tA5gxY/b"
X-Original-To: stable@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B7208D7
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670839; cv=none; b=IE19sCEun0KhdwWCPLBwkcSQqIitCfytTa5a8JyWCT41Zi40lrYU3Skrd2iW1kUYrzk323QDJY39TKUz5fvmYlxNiD4u3/L3qijTZy3m/qA9DQp1VXJW5dZDusSRFWhqTF+F38rQM9tFLniIaQ5REFkkQxjNt7VR9iltJSAS1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670839; c=relaxed/simple;
	bh=CkJQvnReDSLSTn4ch3u3NkQYpbvbS77PpbeAHCkAxKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=a6e2+dfO+tl1ZE0ehIpNX+vho/nTgCYF/iQRLBCFMUWiwrd4ReenNj6nEqze3WpXjPaPFpoGiGy2i/arGs4pe/Pwxq74OH/mww+VsbZfguuQiPsMGqh+J7D9e4Ajsqe4UdK5QS0JWqmRVZHHlfBTZVXDmXRrKjCL4qNE1DXcfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tA5gxY/b; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241208151352epoutp0478a6ede448bfaf176b088c2d99fe689d~PPG-p3nKK0694206942epoutp04R
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 15:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241208151352epoutp0478a6ede448bfaf176b088c2d99fe689d~PPG-p3nKK0694206942epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733670832;
	bh=235I6kPicedHwlRboGp2aBJ4my88rhMe2fIVTNmR7fU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tA5gxY/baTXrDHFkxAZNst2UD6IC/D/vj4Dg46NPje51w6JzSdPiKUXE28aSosWyo
	 Z0zfmvAnyeiiSKAulnJ/f4HCkmQy+wYgpzSmZmZfM4oD+SoZ5Sf3BbSzY1XWeGMvdN
	 tLBpqMyaIHJRIj+moBaUJ2pw19NNOrQBp9r84Z2I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241208151351epcas5p2746bfdf04c23d10219830ce6d069781c~PPG_iT4VI2463624636epcas5p2K;
	Sun,  8 Dec 2024 15:13:51 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y5pRf3qLdz4x9Pq; Sun,  8 Dec
	2024 15:13:50 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.F0.29212.EA7B5576; Mon,  9 Dec 2024 00:13:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241208151349epcas5p1a94ca45020318f54885072d4987160b3~PPG8Mbjce3020230202epcas5p1x;
	Sun,  8 Dec 2024 15:13:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241208151349epsmtrp2cd3e7a68dab94fd191db992fe8c0d65a~PPG8LlnV23147231472epsmtrp2W;
	Sun,  8 Dec 2024 15:13:49 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-b6-6755b7ae32da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.DB.18729.DA7B5576; Mon,  9 Dec 2024 00:13:49 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241208151346epsmtip1b0991e1038d8971f7e54e5d946d91236~PPG5qH4TH3235832358epsmtip1Y;
	Sun,  8 Dec 2024 15:13:46 +0000 (GMT)
From: Faraz Ata <faraz.ata@samsung.com>
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
Date: Sun,  8 Dec 2024 20:43:13 +0530
Message-ID: <20241208151314.1625-1-faraz.ata@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUxUVxT2vm0epIOvA4QbtDh9jaUYlpky4GXT2pJmghpRoo1aO7zCc4bC
	LJ1FuxAjoSiQgmWTAMM4VaLJoFDosMhi4zhKa4tdqK0JYJHYxiAgBWWpMXQeT1v/feec75zv
	fufeS+Oyi1QonWOw8mYDl8dS/kTnlYjwqJau3VqFvTYE1Z5sI9HkTReJxhydFBpxnsTQ9XNf
	YqjwTCuFKvs6CDR6Z5FALVM/kmiox06h02eLcOQ+9iuGZq8uk6jAPUoiV4mdQN5zf2NoaOEi
	jpxt4wBVXg5+I1Dd7iqh1N80npeor90bkKhPPFGoK/qOqMvdLqCeaw9Ll+zLTdbxXDZvlvOG
	LGN2jkGbwm7N0LyliYtXKKOUCWgjKzdwej6FTd2WHvV2Tp7PCSs/xOXZfKl0zmJhYzYlm402
	Ky/XGS3WFJY3ZeeZVKZoC6e32AzaaANvTVQqFK/H+YiZubrh4z2EqS3gI89YMXYUnHihFPjR
	kFHBb2frgIBlTB+A7VXhpcDfh2cBLDs1h4mFeQAnR5OfNTwqd1AiqR/AhsG7mBgsAFgzOUMK
	LIoJh3W3vIRQCBLGDt52S4QAZ3ox6Br7QyKwAhkedtzsXxEnmPXws6+9vrk0LWUS4NLSh6Jc
	BLzQ37dyDCnzIvyu7i4hYJxZBws7GnBhJmS6adi7eAkXG1Lhn43DlIgD4cSAWyLiUDg33f80
	vw1WXZ0HghZkdHDkQpCY3gybnT+QQhr36bb2xIhSAbDssWBSYEth8TGZyF4PrxcMPR24Bt5u
	+o0UsRpOzlwhxMUdgBPjrZIvQFj9cwbqnzNQ/7+YE+AuEMqbLHotnxVnUkYZ+MP/3WWWUd8O
	Vt7whvRu0PzVk2gPwGjgAZDG2SApvXW3VibN5j7+hDcbNWZbHm/xgDjfVivw0OAso+8TGKwa
	pSpBoYqPj1clxMYr2RDp/aLGbBmj5ax8Ls+bePOzPoz2Cz2KvboqDf2040xTrvFeUre3ev5A
	1ZGRWPnaamlzwwdUV1riZOfPul3XUOoNmk2UKXpLkzDnnodv5i/eSokko9KazC7HuMZct5Sm
	AcMP9zQevlyxPAxj3k2qyZ/eoffuW9MQ1mj5vhaURfOXMjI34kOzDybIvjtq21qnI6Tzr9hy
	237dO6c8lcx0gB3XrHZPOTL9FnauSjLt8h98z76d9C4+/h0FR26pjiiZf183nLicsWl/7H3d
	Lz2byfbq7pZ/HvkRXU7KWnTw5ZoH7s/LBgrbZkoce9dxU5H2s1Z4KCdEXpu15YZnb8bBlwpe
	M6zePo2hT8eJCur4eTIxLL84JfIVlrDoOOUG3Gzh/gXhjFNvTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnO7a7aHpBjdXsllMn7aR1eLN1VWs
	Fg/mbWOzuLNgGpPFqeULmSyaF69ns5i0ZyuLxd2HP1gs1r09z2pxedccNotFy1qZLba0XWGy
	+HT0P6tF45a7rBarOuewWBxZ/pHJ4vL3ncwWCzY+YrSYdFDUQdhj06pONo/9c9ewexx7cZzd
	o/+vgcfEPXUefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlXG7fRdLwUa+ikMPOpgaGPt5uhg5
	OSQETCS+9s1j62Lk4hAS2M0o0fhxKgtEQlri9awuRghbWGLlv+fsEEVfGSU6/39gA0mwCahL
	zLxxhAUkISJwhFFi9f+brCAOs8BJJonmr4/ARgkLJEtMbbsJ1sEioCrRsvkIkM3BwStgKfHz
	ZyHEBk2JtXv3MIHYvAKCEidnPgFrZRaQl2jeOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnFhsW
	GOallusVJ+YWl+al6yXn525iBMeLluYOxu2rPugdYmTiYDzEKMHBrCTCy+Edmi7Em5JYWZVa
	lB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qBKepfyjYW1RmTmo2tezhe
	vJ33+9C2jPlRVTnzdm9drZJ1Ll/U1UGiZvqlSc3JG1smdTyYJmnoPJX7+627+3R01uuU3JT9
	/f3rJHlLocs6k2JWPWoIvH2vciPHnSQbb78FS38+bLU88uXfjHcK3R9LnrNXL8y5e2gqQ0T2
	CSnd7etvt6nHeguaSLy456Y4obexd2WeBa+asKimbMtH/dbTAp43ZswpYZ3M1CtpFFpbXsU/
	6cJz32ZprpyX5qbrmf6YcU74sdiraGuyrcqMa10NGibPjm5PfH1BTLlSZW+t0I+VNd1NfHob
	Nm0/E3liy5azLpfTKvh0ejY0v2usnBMmVbPe28qzT+WUVO4055YpSizFGYmGWsxFxYkAqr4/
	ewYDAAA=
X-CMS-MailID: 20241208151349epcas5p1a94ca45020318f54885072d4987160b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208151349epcas5p1a94ca45020318f54885072d4987160b3
References: <CGME20241208151349epcas5p1a94ca45020318f54885072d4987160b3@epcas5p1.samsung.com>

From: Selvarasu Ganesan <selvarasu.g@samsung.com>

The current implementation sets the wMaxPacketSize of bulk in/out
endpoints to 1024 bytes at the end of the f_midi_bind function. However,
in cases where there is a failure in the first midi bind attempt,
consider rebinding. This scenario may encounter an f_midi_bind issue due
to the previous bind setting the bulk endpoint's wMaxPacketSize to 1024
bytes, which exceeds the ep->maxpacket_limit where configured TX/RX
FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
speed only.
This commit addresses this issue by resetting the wMaxPacketSize before
endpoint claim

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


