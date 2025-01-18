Return-Path: <stable+bounces-109426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE094A15B95
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 07:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4108D188A815
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 06:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD57DA62;
	Sat, 18 Jan 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jToTrW5I"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1173FC7
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737180136; cv=none; b=IrYTCsfXphMmecKhWvXWFtvZCAkHvrJd87nTMjMKNwYinhiJbpL7xlFkx+Dc8wEv+uFnWEATb3MviFfg1wHzMyzsqzyJ4sDX+F645qDWcwKNbObCtVtTsaWjxmC7LbIY4WecYYUhH0x0Ij2YGjJ8yuQ259ijdZwfxuIGAlurwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737180136; c=relaxed/simple;
	bh=SHjHMgP0mEsYIiXZcNAWcXvwhAIZ6q5lhsEC5bjudAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=qV0oYNOOWZIenjHFyumVIjLZyieK4QGl4FZlK1yx/9JHyMNUIm0Tf8UQbt+UeNF52lI7tW/LUEXdnA8CCvgJ/fCikW0+lJ0UgoM/nJLrVQBF4wEjcpsglRmhw7TYtXEloEAxU9fyTF1iEJmSQsUTiHDYTvqkMj6L0qnqjH0ka5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jToTrW5I; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250118060210epoutp017c4a3733ccb8b314ab4af68e78090f5b~btB-9_4l-3141631416epoutp01w
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 06:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250118060210epoutp017c4a3733ccb8b314ab4af68e78090f5b~btB-9_4l-3141631416epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737180130;
	bh=aJIcZaF9gfjXZSD2suY3PLYZ3dh+c40cF1sIJyeeA5c=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jToTrW5ILqb/3isRgjQpduAZeZr8JdHdDXDnfgrL+PuTNeTUhO23Hs+HFVfGs2GpB
	 ym4VvT5CbrA/z8j/IOZmq+P1gqFnxDmN7spIq6oRbo5dM3nFVWZPTxqHFa+r03NTi6
	 25URqnjXH+mTC4Uh6k5th2WD8OkfuPbHRBt7ogmw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250118060210epcas5p1775e193d5ddb0b98afc9c6cbacf6fa1c~btB-UYnX60607106071epcas5p1I;
	Sat, 18 Jan 2025 06:02:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YZmG81w4Rz4x9Pv; Sat, 18 Jan
	2025 06:02:08 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.11.19933.0E34B876; Sat, 18 Jan 2025 15:02:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250118060207epcas5p3913957a1c5ec9b029f1d4953f6b29751~btB8_9fbx1852418524epcas5p3c;
	Sat, 18 Jan 2025 06:02:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250118060207epsmtrp13403209dbcbc0695fc14804e2d77ede2~btB8_HYqk0555005550epsmtrp1-;
	Sat, 18 Jan 2025 06:02:07 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-d0-678b43e0b514
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.C5.23488.FD34B876; Sat, 18 Jan 2025 15:02:07 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250118060204epsmtip267f5c761e1fbcd9827168ee16b7b02d5~btB6PdFZw2169021690epsmtip2G;
	Sat, 18 Jan 2025 06:02:04 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: gregkh@linuxfoundation.org, m.grzeschik@pengutronix.de, kees@kernel.org,
	abdul.rahim@myyahoo.com, quic_jjohnson@quicinc.com,
	quic_linyyuan@quicinc.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alim.akhtar@samsung.com, thiagu.r@samsung.com, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Date: Sat, 18 Jan 2025 11:31:33 +0530
Message-ID: <20250118060134.927-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmuu4D5+50g/VPuC2mT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVot11zcxWqzqnMNicWT5RyaLy993Mlss2PiI0WLSQVGLFc2tzA6iHptWdbJ5
	7J+7ht3j2Ivj7B79fw08Ju6p8+jbsorR4/MmuQD2qGybjNTElNQihdS85PyUzLx0WyXv4Hjn
	eFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCflBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2
	SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGfcWLGYuaBOruHqym6WBca1QFyMnh4SA
	icSKrn+MXYxcHEICuxkl1m/7xgzhfGKUeDJzJytIlZDAN0aJB2uzYTp2HznNBFG0l1Hi0Ozj
	rBDOd0aJphkzgTIcHGwChhLPTtiANIgI3GSUmHZAGqSGWeAik0T3usdgNcICGRKdPQEgNSwC
	qhLnVh9hBLF5Bawktm76xwyxTFNi7d49TBBxQYmTM5+wgNjMAvISzVtng10qIXCEQ2Ld+QlQ
	DS4SD9e/ZoOwhSVeHd/CDmFLSbzsb4OykyX2TPoCZWdIHFp1CKrXXmL1gjOsILcxAy1ev0sf
	YhefRO/vJ2AnSwjwSnS0QUNOVeJU42WoTdIS95ZcY4WwPSSOb+ligYRbrMSDQ3NYJzDKzULy
	wSwkH8xCWLaAkXkVo2RqQXFuemqxaYFRXmo5PCqT83M3MYITs5bXDsaHDz7oHWJk4mA8xCjB
	wawkwpv2uyNdiDclsbIqtSg/vqg0J7X4EKMpMFgnMkuJJucDc0NeSbyhiaWBiZmZmYmlsZmh
	kjhv886WdCGB9MSS1OzU1ILUIpg+Jg5OqQamvmnL7a9s28EmcuuQqVPRL4Y9dYWFbpl/gsRv
	P19nkdxolrRVtkHynYyeW7Ok2vInsQsfXT3x/m7Kkv9dD+4EyAYsM+j4URvjGPl99S2Ga94x
	Z7tTjxes+u7EuXV9+bV9AaE2OW9/z/TdMLuw3p5jxu2cSVb7VVSFN3Ntcz62lCnTr3XTkqVP
	l73IcGVdpFa/KC129jMGQVO/e0/LFYx19y7fuXxPkMHNl69dC/+fsai4WL7v1bQVLBus10nl
	zngoYPxs/jvpwoa0rV4bp374FNghYLNGft+vj/u+pVn4L1m/J/lAoom6FL9DV7jmTi2DtGMh
	IV2MN8XjfyS7x+U7+Z5vfP0wcKqg462D804XKrEUZyQaajEXFScCAHWdHV1VBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvO595+50g387ZCymT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbNi9ezWUzas5XF4u7DHywW696eZ7W4vGsOm8WiZa3MFlvarjBZ
	fDr6n9WicctdVot11zcxWqzqnMNicWT5RyaLy993Mlss2PiI0WLSQVGLFc2tzA6iHptWdbJ5
	7J+7ht3j2Ivj7B79fw08Ju6p8+jbsorR4/MmuQD2KC6blNSczLLUIn27BK6MewsWMxe0iVVc
	PdnN0sC4VqiLkZNDQsBEYveR00xdjFwcQgK7GSXm909ihEhIS7ye1QVlC0us/PecHaLoK6PE
	kytzWboYOTjYBAwlnp2wAYmLCDxklHixpIcRxGEWeMgk0XhgLQtIt7BAmsTpp61MIDaLgKrE
	udVHwKbyClhJbN30jxlig6bE2r17mCDighInZz4B62UWkJdo3jqbeQIj3ywkqVlIUgsYmVYx
	SqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgTHkJbGDsZ335r0DzEycTAeYpTgYFYS4U37
	3ZEuxJuSWFmVWpQfX1Sak1p8iFGag0VJnHelYUS6kEB6YklqdmpqQWoRTJaJg1OqganT8tCs
	bL+/ptHq6ufyrmkuSBJruPJrnk6r0LXV6xoneUz7Y2mwM2/LzfbLLFpp83IlU3f3+291OS0l
	sWteBnN20YOAWzXJsQ+9EteXzX6w02l31Oo7q05dbvza5JGVwBVbXCq2w21D/pS/LxNmiOrP
	unD9XfhDs53zdvyQdg366Kn2MN6we0WnId/24pJ3pry3JRjtd8y8ysC01sfwYfBh7RuGm+Mn
	X+RiMZP3+y998sIWZx7rGT+lD3WuZHOfH+gdeFEvVYbRwyZO6txVf7XEAx47t5ZOTpW7P6Hn
	y+Rg1SKXY8Vyr1hnLFbKYnoRvCXJeOdZ/0+GISF3ZNTunNpTEaCrdSS/4G5XS4SiuhJLcUai
	oRZzUXEiAKiQcc0QAwAA
X-CMS-MailID: 20250118060207epcas5p3913957a1c5ec9b029f1d4953f6b29751
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250118060207epcas5p3913957a1c5ec9b029f1d4953f6b29751
References: <CGME20250118060207epcas5p3913957a1c5ec9b029f1d4953f6b29751@epcas5p3.samsung.com>

The current implementation sets the wMaxPacketSize of bulk in/out
endpoints to 1024 bytes at the end of the f_midi_bind function. However,
in cases where there is a failure in the first midi bind attempt,
consider rebinding. This scenario may encounter an f_midi_bind issue due
to the previous bind setting the bulk endpoint's wMaxPacketSize to 1024
bytes, which exceeds the ep->maxpacket_limit where configured dwc3 TX/RX
FIFO's maxpacket size of 512 bytes for IN/OUT endpoints in support HS
speed only.

Here the term "rebind" in this context refers to attempting to bind the
MIDI function a second time in certain scenarios. The situations where
rebinding is considered include:

 * When there is a failure in the first UDC write attempt, which may be
   caused by other functions bind along with MIDI.
 * Runtime composition change : Example : MIDI,ADB to MIDI. Or MIDI to
   MIDI,ADB.

This commit addresses this issue by resetting the wMaxPacketSize before
endpoint claim. And here there is no need to reset all values in the usb
endpoint descriptor structure, as all members except wMaxPacketSize and
bEndpointAddress have predefined values.

This ensures that restores the endpoint to its expected configuration,
and preventing conflicts with value of ep->maxpacket_limit. It also
aligns with the approach used in other function drivers, which treat
endpoint descriptors as if they were full speed before endpoint claim.

Fixes: 46decc82ffd5 ("usb: gadget: unconditionally allocate hs/ss descriptor in bind operation")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Changes in v2:
 - Expanded changelog as per the comment from Greg KH.
 - Link to v1: https://lore.kernel.org/all/20241208152322.1653-1-selvarasu.g@samsung.com/
---
 drivers/usb/gadget/function/f_midi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 837fcdfa3840..9b991cf5b0f8 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -907,6 +907,15 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = -ENODEV;
 
+	/*
+	 * Reset wMaxPacketSize with maximum packet size of FS bulk transfer before
+	 * endpoint claim. This ensures that the wMaxPacketSize does not exceed the
+	 * limit during bind retries where configured dwc3 TX/RX FIFO's maxpacket
+	 * size of 512 bytes for IN/OUT endpoints in support HS speed only.
+	 */
+	bulk_in_desc.wMaxPacketSize = cpu_to_le16(64);
+	bulk_out_desc.wMaxPacketSize = cpu_to_le16(64);
+
 	/* allocate instance-specific endpoints */
 	midi->in_ep = usb_ep_autoconfig(cdev->gadget, &bulk_in_desc);
 	if (!midi->in_ep)
-- 
2.17.1


