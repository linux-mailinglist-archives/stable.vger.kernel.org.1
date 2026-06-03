Return-Path: <stable+bounces-259991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id whEkC8viH2o2rwAAu9opvQ
	(envelope-from <stable+bounces-259991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 10:16:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8E363599F
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 10:16:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=BCTz1VQ1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259991-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259991-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABB1B300CB18
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0403A3807;
	Wed,  3 Jun 2026 08:16:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5913A3E78;
	Wed,  3 Jun 2026 08:15:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474565; cv=none; b=IiyTDltCnKBWzPEkxd0Kc2T93AXmnEiKhYdOM/k2NAcZo4wOijix/MmF/aUvIj6LfEeEa++/3qUpWawu2lZtU6DYhkl3kTSuVvDWMoWiPvuEj6pCxICkiadEOWCTXUevtHyt9u7Svl6HtnOWs+jbFr6lwRgUUo6JUvrSGOjNVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474565; c=relaxed/simple;
	bh=RI6YeFlGQAU6vP+RRBx8i7uMtfZLp5nlvHZnFb3vAFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqGDFYdNvxE2aXYW7hCabCZoZDLzKH7YuQOFrevRYrKrv4HnuDyxIfCBaenG6lVj9807BLPS3jj5ATZHFXUI0CqD7w6JOOZRV8yChQq1agbYBz7gVgt/bFyM3seUaWVqkB6TGuBouknXwuLlW7cRO/0V/DMSDkhi5niZAGAQcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BCTz1VQ1; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9w
	oouAF0An6oG2I77wAgtnEo0aT0iRBw0iUrbijYQKU=; b=BCTz1VQ10iygThUmhr
	iBoec4z8tor/KhJuEK22qa3krofqBPmUsfwi9YHvFi7wubS+gVQs9TEaS06RKZM0
	yhqM3GxFTyfvx0e87QKa9ZpKNqGv5ejAO6+wmwvHBdgMntMotilvmvuCG8ss5ZxC
	P3kbXcU0zNzjH+r8CCdGhqqNU=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3Mm2N4h9qv_h5BA--.18235S2;
	Wed, 03 Jun 2026 16:15:10 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Cc: Steve French <stfrench@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Pavel Shilovsky <pshilov@microsoft.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] smb: client: fix smbdirect_recv_io leak in smbd_negotiate() error path
Date: Wed,  3 Jun 2026 16:15:09 +0800
Message-Id: <20260603081509.2027062-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Mm2N4h9qv_h5BA--.18235S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17JFy3Jw4kJr4rtF17Awb_yoW8GF1kpF
	ZI9wn3Kr409r4xCwsrAF18u3sxWF1vv345ur4UWw4xArWFq345JF4Fya1vga1UKFWrKF4f
	XanFgrWrG3WjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pETa0DUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAQ4+qWof4o6+YwAA3c
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259991-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[samba.org:server fail,vger.kernel.org:server fail,talpey.com:server fail,sto.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:metze@samba.org,m:stfrench@microsoft.com,m:tom@talpey.com,m:longli@microsoft.com,m:linkinjeon@kernel.org,m:pshilov@microsoft.com,m:rob_garcia@163.com,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,talpey.com,kernel.org,163.com,vger.kernel.org,lists.samba.org];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD8E363599F

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit daac51c7032036a0ca5f1aa419ad1b0471d1c6e0 ]

During tests of another unrelated patch I was able to trigger this
error: Objects remaining on __kmem_cache_shutdown()

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/cifs/smbdirect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 48bd879349fb..c9bda34fd2f5 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1084,8 +1084,10 @@ static int smbd_negotiate(struct smbd_connection *info)
 	log_rdma_event(INFO, "smbd_post_recv rc=%d iov.addr=%llx iov.length=%x iov.lkey=%x\n",
 		       rc, response->sge.addr,
 		       response->sge.length, response->sge.lkey);
-	if (rc)
+	if (rc) {
+		put_receive_buffer(info, response);
 		return rc;
+	}
 
 	init_completion(&info->negotiate_completion);
 	info->negotiate_done = false;
-- 
2.34.1


