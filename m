Return-Path: <stable+bounces-267599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kzQtEaLHOGrrhwcAu9opvQ
	(envelope-from <stable+bounces-267599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 07:26:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B86ACBE2
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 07:26:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="bwP1AA//";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267599-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267599-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F21B6300CCBE
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 05:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A878357D1D;
	Mon, 22 Jun 2026 05:26:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46E25B0B9;
	Mon, 22 Jun 2026 05:26:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106012; cv=none; b=aI/J0eZCigFtq/+cDK6fyDsVv8qZCRxdYbN05WJthbZpXAYNUiHOmFeB/uBBFOOvxHoJUeO78Of7JGrAO/G0BKz1RdO/d74oexLp1Ehzv5utec1v3W6gNjXCkAfuIqnZNGTo/Cnq2DQ7RdHcSLqvi5asNstMdDkeW6sPmJDrhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106012; c=relaxed/simple;
	bh=zkBrmxXDRdlfvvvpT4AGHF7lIy1EPOMJ4eNfxvt8MjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ts0DGWzIcYFokyHrmFKBshDXWQQLrXIrCz34Iz89Vj2U1uEoyLImGZaCNRVffo/I9xPQT9mxH/minjMfoH3YeeqHLvnL5RxEbk7q6ZcOOxn+297LYwd/gx6CSHxMCpKgZPzu9/fn2QTfaYImBljBmJXAbPXvtN1kPDGgcnEykuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bwP1AA//; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=m5
	hOQO+g/fQV44xgb0eCTwyiLjaZQvXO2Djl5M5BQZo=; b=bwP1AA//l1bYEDunL+
	t96KBaMpccp/pKBsguS2oIRBkX3aOhUyFGo7OAc/ECn6GXVHX0AYIQ/VPBDnTfam
	Xv/VFlIf7JCpZGhFO5+1xkewAIooIVEPYTETAQ4X9TlpkFGQLBzwSf8mu0qEq3Lo
	8LQWNRz1ycfuSGPwnAwmCLDz0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnraCExzhqky3rDg--.47924S2;
	Mon, 22 Jun 2026 13:26:30 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: pawell@cadence.com,
	gregkh@linuxfoundation.org,
	peter.chen@nxp.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdnsp: fix stream context array leak in cdnsp_alloc_stream_info()
Date: Mon, 22 Jun 2026 13:26:27 +0800
Message-Id: <20260622052627.696373-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBnraCExzhqky3rDg--.47924S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr15KFWrWw1fXF4kJF1DKFg_yoWDurcEkr
	4a9rZ3WF12yr4UJwnYqr9I9rWUKr42vF4kWa1aqr1fGFyUuryrZr1xZr4rXr47Ja15Ar4D
	W3W8tay5urn7JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGzuXUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Qa7Kmo4x4YgSwAA3C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267599-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pawell@cadence.com,m:gregkh@linuxfoundation.org,m:peter.chen@nxp.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D2B86ACBE2

cdnsp_alloc_stream_info() allocates stream_info->stream_ctx_array with
cdnsp_alloc_stream_ctx(). If a later stream ring allocation or stream
mapping update fails, the error path frees the allocated stream rings
and stream_rings array, but leaves stream_ctx_array allocated.

Free the stream context array before falling through to the stream_rings
cleanup path.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/cdns3/cdnsp-mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index a2a1b21f2ef8..880097f1007d 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -631,6 +631,8 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
 		}
 	}
 
+	cdnsp_free_stream_ctx(pdev, pep);
+
 cleanup_stream_rings:
 	kfree(pep->stream_info.stream_rings);
 
-- 
2.25.1


