Return-Path: <stable+bounces-241844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPLKLbfD8WkbkQEAu9opvQ
	(envelope-from <stable+bounces-241844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:39:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24138491444
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 018EB300645A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B53B0AF1;
	Wed, 29 Apr 2026 08:39:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8037A494;
	Wed, 29 Apr 2026 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451953; cv=none; b=jc5jyB/i5fEpqUFIftvtlKe7+smACTOnl7CUlN/faTSP6OSOdt/O8QBdPSj1UOdIvU4bnwje6EOHPG7mY0dE14Hzc/lwbkvI85i9dxJNGLTB7mcKhocPxXaI6pxItSE0ffL7EqIjM9jHxYWnD7mnJUJLLdlU187MaANIXS8AbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451953; c=relaxed/simple;
	bh=pwZI+Wi6wyw5IfLMCoALecdqKTdTrP3HOiHP35jv+Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUZYgHc/iHz6L0ojArB/CnnPEgTm0/czQt6tOw0GfiHjAOR1tt+jexkLgfR7vOrYYAlrFBkzx/nmbrDmu64yy0TDt0XGy643a3ANcF/ccdrULy6RJKS69cu+T9OlTHv6fwnci0hi/XU6R0y1ME+C7uAX0/kctk0PiraNC6tThAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1777451887t57a78d8a
X-QQ-Originating-IP: fSps1ZI6Jcae7ux/p/gvKgU6avO9QRFKo56ynkofpLk=
Received: from w-MS-7E16.trustnetic.com ( [36.24.191.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Apr 2026 16:37:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16571850513645495144
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: libwx: fix VF illegal register access
Date: Wed, 29 Apr 2026 16:37:42 +0800
Message-ID: <4D1F4452D21DE107+20260429083743.88961-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M//muKyjQOU4HpFh4VqgsmTq/maQpjbQZnxwFjWcSOap8bupHYiUc6c9
	SAs9fmG5w910HqDPIw2NW8MLvgOKoX+qUc/oC9VwhvE517yPXf1E4UavkZRdyKZndjRr5k4
	2Tq90O66dnFp6s8RdgvcOp/HrBie9FORBzG//pDA35cHK7o80ywVqqNQ1Pb3PCgwDgteWZG
	0pM4Ppic+A5fQz9tgeLkeLJ0Q48BSAs05k20gl80hAxR+XLUQEliy64PVBlr+V0G3o47oSS
	oYM2qOeVZyMA/nIhqS0unxgAb7Dr0Emi9LwyvSYsawJlmbZ/MrL4gAmFTpAGlbOEXtdsn3U
	nIOVf/CDi2AUa6N/ZmG0ItkRQp1fsRFt8jGF5mxaPrAC0GblelxHf5hbbYfCNjDo8cbALHs
	PO5zb6X7hfQsUf+LPgMeyvChfmWZTfv9LD9cmuEXkH9tVBCmJlplCeJdtuAJEk4ICa73dW1
	FRkcq2o5fCtl7jhgmK/7RKZDKU2SVFISi78GtBDHPpxU4OdmEmpkNl6MHiG3CkJ+5CAPLYJ
	mZm2WLzbkDJi3dNfCzoutrZVEIqvVazJjCULs1V+nt82LL+wavje9R/6o4JzWQSINwoCYv5
	2ZZ7JVLmjjMjju0jqpXIUqkjjzqAtZdn+imuyxJDeRahAuCRN2lAaKs4Z534kNx2ByMyoue
	+/99r1NgIoJ9ZRU4a4puaH/eboZ+hc5y/g7ayhurVfDhGvD0iVsuGkyddKL6mkqtLPZZ8GH
	2ic57dpiJXEEnJ4LQ8sJ0/sbIN+zwI2EcnJFBif2402pUh/qDugSn5v6dwjETIymqOhajoF
	+DVtJ+JYV5RrKrjsbiW6lhR2EbyxM+qppDSht7WsyaX2OU3CqM5x7jEOcv7SM41dvbX7soF
	gQ4Sz2XMlDqndgwGF87xFTDBlPZt6ioPiDqMXGk3Q+Gm/e2mdgwLooBrKmEJDl2feqgQNjY
	gqZOiP1wIaQGvA8503b9UcPJXIWV2dVA0VNWTzRlzHNhLLraVcVfsigRsSBMsteFXD9hDRJ
	vOQ60CFTIn3v17lxAAUoXLGmCmryhl6CvVUYQSg4PsemPOJMhECx2r4MpMNu8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 24138491444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241844-lists,stable=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.595];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Register WX_CFG_PORT_ST is a PF restricted register. When a VF is
initialized, attempting to read this register triggers an illegal
register access, which lead to a system hang.

When the device is VF, the bus function ID can be obtained directly from
the PCI_FUNC(pdev->devfn).

Fixes: a04ea57aae37 ("net: libwx: fix device bus LAN ID")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index d3772d01e00b..2451f6b20b11 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2480,8 +2480,11 @@ int wx_sw_init(struct wx *wx)
 	wx->oem_svid = pdev->subsystem_vendor;
 	wx->oem_ssid = pdev->subsystem_device;
 	wx->bus.device = PCI_SLOT(pdev->devfn);
-	wx->bus.func = FIELD_GET(WX_CFG_PORT_ST_LANID,
-				 rd32(wx, WX_CFG_PORT_ST));
+	if (pdev->is_virtfn)
+		wx->bus.func = PCI_FUNC(pdev->devfn);
+	else
+		wx->bus.func = FIELD_GET(WX_CFG_PORT_ST_LANID,
+					 rd32(wx, WX_CFG_PORT_ST));
 
 	if (wx->oem_svid == PCI_VENDOR_ID_WANGXUN ||
 	    pdev->is_virtfn) {
-- 
2.51.0


