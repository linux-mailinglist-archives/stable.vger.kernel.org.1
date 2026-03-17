Return-Path: <stable+bounces-226226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH5FCMuEuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8F12AE4A4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01BFC303B822
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A53EFD0C;
	Tue, 17 Mar 2026 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fkc/N0YU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29723EF64F;
	Tue, 17 Mar 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765796; cv=none; b=qSy1eyPgPvmcG2qMlzeqFmx2CZiDevk1xTEqFaagjHTTuHCLSalew789bC3s7enhA6J2hwN3kYkN+GmN5+pOWlDhKwStxlfEKKaQ0+giQiRN5Rzje2RxWXzCeVGdTyv9JJL6ua0f1v84AYuint/YKjq1vB6oDpcGozkaz6lPHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765796; c=relaxed/simple;
	bh=pO//gdvvQQrEGKabTM3TVfulSwq/1JYJ8CZxtbDRE0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of7hOH6lHkqg3IGLswxLvmJjK795w8dY4bQ25nGtsI759ZCIWrHjzawAhOqanV2ei0atnMvvezJpcczmkXvG/7U9BujOybepkffWqDuV729N76UL5pp/Q/+aDFh6QxYrq0EsESAepmUb0savWjFVlKFYgZvbb0fvcCXXnsQ4Sd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fkc/N0YU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2990CC4CEF7;
	Tue, 17 Mar 2026 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765795;
	bh=pO//gdvvQQrEGKabTM3TVfulSwq/1JYJ8CZxtbDRE0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fkc/N0YUHItEpYt215avmATx3Ynf1DnovdyLGxsdxpcuY4I6PDqwgwfZ2KYwmx2zY
	 qQrkN5zrWIysmaCILRAl5U7BszkqLbpUsG1qbMkgX4dFgx4t7CBj/Scmeb652dK2+z
	 TAZHpzzy/nnIYUZWv3IOYJ6aVmfmKyFJE/fiRpnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyue Wang <haiyuewa@163.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 066/378] mctp: i2c: fix skb memory leak in receive path
Date: Tue, 17 Mar 2026 17:30:23 +0100
Message-ID: <20260317163009.439032994@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226226-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,redhat.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: DB8F12AE4A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyue Wang <haiyuewa@163.com>

[ Upstream commit e3f5e0f22cfc2371e7471c9fd5b4da78f9df7c69 ]

When 'midev->allow_rx' is false, the newly allocated skb isn't consumed
by netif_rx(), it needs to free the skb directly.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Signed-off-by: Haiyue Wang <haiyuewa@163.com>
Link: https://patch.msgid.link/20260305143240.97592-1-haiyuewa@163.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mctp/mctp-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 8043b57bdf250..f138b0251313e 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -343,6 +343,7 @@ static int mctp_i2c_recv(struct mctp_i2c_dev *midev)
 	} else {
 		status = NET_RX_DROP;
 		spin_unlock_irqrestore(&midev->lock, flags);
+		kfree_skb(skb);
 	}
 
 	if (status == NET_RX_SUCCESS) {
-- 
2.51.0




