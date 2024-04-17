Return-Path: <stable+bounces-40085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65E8A7EEC
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A3F2818E1
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F1139D01;
	Wed, 17 Apr 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlDwOV5Q"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F166A02E
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344146; cv=none; b=ehHhMYvWHhMjmOW+Vfr6E4ikovmBjx1a5+2ygJpnMDQ5+7sZjuAKn46awhx/0r/+ugxRSIEJdwENjHd3sSr2pSSSn277djfH8KpcS/y3FFEttw8wK5Tig4z7qLUPIcaoaXwf0CaRlmvIJr2w/zRJfRw/JbuCzF74iD8rIDt9j4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344146; c=relaxed/simple;
	bh=3KtL8v+/z1deeegmlCslJhNyGqs44qnUNBL+H3cQXis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlDvJ9nmvYJMQ9Fsk5I8Uv2oSfe0V9PRGI9LbNvB518dYW1t982G8l0XvBONcVCftlVwKrU7YvmfSb/2KxHRNQ9FeyU0OTAJy+uMtStyvwB8Cts2Pz9hbQihQSfX0C/8sc6XmzeKvxm4vRscxjexbxnWa2NmU4EwIywfOTSoPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlDwOV5Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713344144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pQ0sSQeAADn6AXaSn6AcvMvh/Ro6ED1iNBV8xbxjGO0=;
	b=RlDwOV5Q0pikQTd5DbFPSfL3mHtefBxDkFqfKiwtowtcnU8oQ0NppDpI48SShwcHABsXkr
	M3jVXZstG7NNASdvPEBU+Fy0HQvEoQhNE1fRX2xWGQDP+XllzalZAfgM0MQZ0ZmT6T/lpW
	rXGWel4L4c1SALE6CkOuCFWq02WE1SU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-VBJASLQmOlWdBbek0Y9VbQ-1; Wed,
 17 Apr 2024 04:55:39 -0400
X-MC-Unique: VBJASLQmOlWdBbek0Y9VbQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABD9C1C4C394;
	Wed, 17 Apr 2024 08:55:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F55A492BC7;
	Wed, 17 Apr 2024 08:55:36 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org,
	Jarkko Palviainen <jarkko.palviainen@gmail.com>
Subject: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Wed, 17 Apr 2024 10:55:13 +0200
Message-ID: <20240417085524.219532-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
consecutive device resets"), reset operation, in which the default mac
address from the device is read, is not executed from bind operation and
the random address, that is pregenerated just in case, is direclty written
the first time in the device, so the default one from the device is not
even read. This writing is not dangerous because is volatile and the
default mac address is not missed.

In order to avoid this and keep the simplification to have only one
reset and reduce the delays, restore the reset from bind operation and
remove the reset that is commanded from open operation. The behavior is
the same but everything is ready for usbnet_probe.

Tested with ASIX AX88179 USB Gigabit Ethernet devices.
Restore the old behavior for the rest of possible devices because I don't
have the hardware to test.

cc: stable@vger.kernel.org # 6.6+
Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
Reported-by: Jarkko Palviainen <jarkko.palviainen@gmail.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2:
  - Restore reset from bind operation to avoid problems with usbnet_probe.
v1: https://lore.kernel.org/netdev/20240410095603.502566-1-jtornosm@redhat.com/

 drivers/net/usb/ax88179_178a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 69169842fa2f..a493fde1af3f 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1316,6 +1316,8 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	netif_set_tso_max_size(dev->net, 16384);
 
+	ax88179_reset(dev);
+
 	return 0;
 }
 
@@ -1694,7 +1696,6 @@ static const struct driver_info ax88179_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1707,7 +1708,6 @@ static const struct driver_info ax88178a_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
-- 
2.44.0


