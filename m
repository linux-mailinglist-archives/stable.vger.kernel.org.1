Return-Path: <stable+bounces-267907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CsFIIxtTOmqL6AcAu9opvQ
	(envelope-from <stable+bounces-267907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:34:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AC6B5D76
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:34:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=dmlZEJKf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267907-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267907-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5233019BAD
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315D3909AC;
	Tue, 23 Jun 2026 09:34:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C141C71;
	Tue, 23 Jun 2026 09:33:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207243; cv=none; b=IDPrzGcWo8deE9hD7FuwWqOgJK2NGCqRppIWHxH910mBSO4H3Ce/0DajHQVucZ9qUEpbFKHJ57Re5TnkeHXFJBm8zqcwd5wDbOkPgmSy1Go2CAVkoGFhh1iGwS3DRz2sFsCh6NUhycp78XXXNYmBF3XCHp+/OGQNPcbEKQ4/tPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207243; c=relaxed/simple;
	bh=0nSnklP0qJ5Ka2LStImpkmX3ESc42oa1HF9RN2zLUu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6dY20dVxAY+zUBz7BSPze/wAt/pP8j3S47OWyaKxORH2d6aLpiHDsJ66C/VSQpekc0fl5vmJeUVjwWAnlCxoyHkIOcKx9Lzs2bFNQQUzernBu1Jvtyso0MHsRA204CQLIEjWSpryHFVOJk4XX2Q1IW0toIhH9QpWKRvmpvGvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dmlZEJKf; arc=none smtp.client-ip=117.135.210.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=d5
	s92hGEq5208iujjhhC3arh0ICrujvsV1eSvCSTxrs=; b=dmlZEJKfe5gvScPzs5
	iozHUTq94La/sX4p7B/F5s1pcvrOtNwPrhVcLhZ/f62M0+7x/BIVU0Blb0naibk4
	bDHy8gm/+NWJgG8e+uqOdJECkGwHk3QiTo4rC3tDUj+x6V81kWlJuAoxOgIRDGH8
	TJb2U5QcbLFSRg/x3NlUO7HOc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnTyPlUjpq6xXLDg--.19652S2;
	Tue, 23 Jun 2026 17:33:27 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: chunfeng.yun@mediatek.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: mtu3: unmap request DMA on queue failure
Date: Tue, 23 Jun 2026 17:33:25 +0800
Message-Id: <20260623093325.2105323-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnTyPlUjpq6xXLDg--.19652S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWfZr1kXw1xJw1Dtw4rAFb_yoWkGwc_Kw
	nFgrn7GrW0y3sFkr4akr1v934xt3W7WFn5XFs8t3sxAa4YkF4Yywn7Zr95CF1UZF45GF1k
	A3W8G39Yqa1fXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRizuWDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Qf2ZWo6UufmuwAA3B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267907-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chunfeng.yun@mediatek.com,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E1AC6B5D76

mtu3_gadget_queue() maps the request before checking whether
the QMU GPD ring can accept another transfer. the request is
returned with -EAGAIN before it is linked on the endpoint
request list if mtu3_prepare_transfer() fails.

Normal completion and dequeue paths unmap requests from
mtu3_req_complete(), but this error path never reaches that
helper, so the DMA mapping is left active. Unmap the request
before returning from the failed queue path.

Fixes: df2069acb005 ("usb: Add MediaTek USB3 DRD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da29f467943f..f224f2ee379a 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -305,6 +305,7 @@ static int mtu3_gadget_queue(struct usb_ep *ep,
 
 	if (mtu3_prepare_transfer(mep)) {
 		ret = -EAGAIN;
+		usb_gadget_unmap_request(&mtu->g, req, mep->is_in);
 		goto error;
 	}
 
-- 
2.25.1


