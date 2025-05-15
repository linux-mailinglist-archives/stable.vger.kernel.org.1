Return-Path: <stable+bounces-144523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F32AB8660
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ADA4C0D8D
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45752253EB;
	Thu, 15 May 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="Y9CvUaig"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A74A02;
	Thu, 15 May 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312270; cv=none; b=knBoQLl5tACZGf7SKd9x0RVQfUHTW7bFmRFtgCXw7F+7fYZJwuZ5P6LanFSpclJGxekxTalq/JCqkRxe7zO+rQQK9PM0IBcUdK30doMKwv4ciEoC1yL/ni1sNhig+6uzK9ZjcXRPYzYqxl3VxPiUZBZlGRiYkQjoBC6LqTlgnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312270; c=relaxed/simple;
	bh=PpF+ZRQiOche5sGkaMp31I4/dN3ZsGItlD6ZgVdd9JI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OTT2SzQ7tvnu4iGmfLN+OKozMRFe+bnSRh0wxGwX5X/V61xzypzFmDvTPN+agOSqj0s1IO9xRKtC0HmvH9hBK1A21Tre6CdDcj9MBdgyTiESD1f16UvMi5TJmidASNVekwvu/8Dta0fdZP1lu5/tJ5wsRq1G57Jovun5CEuonHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=Y9CvUaig; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id C32801024C4D;
	Thu, 15 May 2025 15:20:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru C32801024C4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1747311616; bh=MW8t8FQMiTnmW662Mj4TKI/7+oWH12UvPlfRSrGQIbE=;
	h=From:To:CC:Subject:Date:From;
	b=Y9CvUaigTbD5Rmz/XZEpy5vu843MpD9IYnE+3iLpdgNB5rPNMRGDsUYPu+KQtvpzR
	 UJ8lsbSBrrn58mFXYoMpzpMLQThY6tLpGUNs2AYBDlCnmDgBF83hhVhgQXoCznAUdj
	 15/9yh4nKVqp0uvUHCDwRNHeR5WMiOw3YKB5COgM=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id BF608304A47E;
	Thu, 15 May 2025 15:20:15 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Michal
 Luczaj" <mhal@rbox.co>, Arnaldo Carvalho de Melo <acme@mandriva.com>,
	"Stephen Hemminger" <stephen@networkplumber.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net] llc: fix data loss when reading from a socket in
 llc_ui_recvmsg()
Thread-Topic: [PATCH net] llc: fix data loss when reading from a socket in
 llc_ui_recvmsg()
Thread-Index: AQHbxZO2JTyyBukLE0GIAjqYe9um5g==
Date: Thu, 15 May 2025 12:20:15 +0000
Message-ID: <20250515122014.1475447-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/05/15 10:33:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/05/15 10:15:00 #27982467
X-KLMS-AntiVirus-Status: Clean, skipped

For SOCK_STREAM sockets, if user buffer size (len) is less
than skb size (skb->len), the remaining data from skb
will be lost after calling kfree_skb().

To fix this, move the statement for partial reading
above skb deletion.

Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.org)

Fixes: 30a584d944fb ("[LLX]: SOCK_DGRAM interface fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
 net/llc/af_llc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 0259cde394ba..cc77ec5769d8 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -887,15 +887,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct=
 msghdr *msg, size_t len,
 		if (sk->sk_type !=3D SOCK_STREAM)
 			goto copy_uaddr;
=20
+		/* Partial read */
+		if (used + offset < skb_len)
+			continue;
+
 		if (!(flags & MSG_PEEK)) {
 			skb_unlink(skb, &sk->sk_receive_queue);
 			kfree_skb(skb);
 			*seq =3D 0;
 		}
-
-		/* Partial read */
-		if (used + offset < skb_len)
-			continue;
 	} while (len > 0);
=20
 out:
--=20
2.39.5

