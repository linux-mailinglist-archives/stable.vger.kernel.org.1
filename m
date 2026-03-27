Return-Path: <stable+bounces-230591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGg5MkUdxmnvGgUAu9opvQ
	(envelope-from <stable+bounces-230591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 07:01:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77433F598
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 07:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72CB3035D53
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665D27FD75;
	Fri, 27 Mar 2026 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="KEK9ifUU"
X-Original-To: stable@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF42FD1B6
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774591206; cv=none; b=NPB5k8ezUGbas2jzrkGbhgd41CBHNUHxm4QaORHhjdT8OrlYQW+UCku3Ke2QvHdKOirRoKs7qtOh8P28cji7xEa5JZTiGHsJB5s9YhUYm1S7OB/con69b3JEb96Y3uyGuj0tYaqG25DrOsK867tmuJ1o2G7h+w/BWYJsBaCHqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774591206; c=relaxed/simple;
	bh=gNPN+lsNLG2GUPRQKoAWKY0ykON4ZP/tO61Pm6Pb82Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fhxk4vpPsBFnuAeJOSRlOV0i4aFmMRk1AAZW2iTyEBXhRF4Kbt3WZxZEv1sCc3VvCKFM8f1pBhFc2Zr+IfVWfbj+1ehK6peTdTywMtWJTsFnsm8LN36N+3TZdI4StOQxk7IEEawbWolh5/l7K6mkR+nZiXYlrRNAS7j/CC5G090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=KEK9ifUU; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774591203;
	bh=fJ+PW7eX9qy32TknMnIEOu3LYMXyYnqf2Eu5m31NLNc=;
	h=From:Subject:Date:Message-Id;
	b=KEK9ifUU/f6TSGcoKgp+B22pU+p6U/cjIli7zJLMqoA03v0p1DgQnlY+T+eOKiUYX
	 +JJOXanBglSAeFR4J4XnwRhoIZkd/Ezy+8NPsXcfyAHlNt/zl8UCa7JdixxmZOUacK
	 NbOX/EGLYhdgIUCocSdzB2IOWgIXxrKPFN4auVPk=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.23) with ESMTP
	id 69C61CD700001811; Fri, 27 Mar 2026 13:59:53 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 3599558913296
X-SMAIL-UIID: 758896704EBF4874B582EB967FDEA279-20260327-135953-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexey Nepomnyashih <sdl@nppct.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()
Date: Fri, 27 Mar 2026 13:59:50 +0800
Message-Id: <20260327055950.2618928-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230591-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nppct.ru,kernel.org,sina.com];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nppct.ru:email]
X-Rspamd-Queue-Id: 3B77433F598
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexey Nepomnyashih <sdl@nppct.ru>

[ Upstream commit cc3628dcd851ddd8d418bf0c897024b4621ddc92 ]

The function xdp_convert_buff_to_frame() may return NULL if it fails
to correctly convert the XDP buffer into an XDP frame due to memory
constraints, internal errors, or invalid data. Failing to check for NULL
may lead to a NULL pointer dereference if the result is used later in
processing, potentially causing crashes, data corruption, or undefined
behavior.

On XDP redirect failure, the associated page must be released explicitly
if it was previously retained via get_page(). Failing to do so may result
in a memory leak, as the pages reference count is not decremented.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
Link: https://patch.msgid.link/20250417122118.1009824-1-sdl@nppct.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/net/xen-netfront.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 4b19d54fa2e2..310bc1f7d404 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -982,20 +982,27 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_TX:
-		get_page(pdata);
 		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			trace_xdp_exception(queue->info->netdev, prog, act);
+			break;
+		}
+		get_page(pdata);
 		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
-		if (unlikely(!err))
+		if (unlikely(err <= 0)) {
+			if (err < 0)
+				trace_xdp_exception(queue->info->netdev, prog, act);
 			xdp_return_frame_rx_napi(xdpf);
-		else if (unlikely(err < 0))
-			trace_xdp_exception(queue->info->netdev, prog, act);
+		}
 		break;
 	case XDP_REDIRECT:
 		get_page(pdata);
 		err = xdp_do_redirect(queue->info->netdev, xdp, prog);
 		*need_xdp_flush = true;
-		if (unlikely(err))
+		if (unlikely(err)) {
 			trace_xdp_exception(queue->info->netdev, prog, act);
+			xdp_return_buff(xdp);
+		}
 		break;
 	case XDP_PASS:
 	case XDP_DROP:
-- 
2.34.1


