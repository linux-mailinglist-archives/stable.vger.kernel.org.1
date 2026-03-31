Return-Path: <stable+bounces-231736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NsxNRYAzGkJNQYAu9opvQ
	(envelope-from <stable+bounces-231736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:10:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F336E131
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B41316FEC0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DD3E51C7;
	Tue, 31 Mar 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2vYz49n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669933F38A;
	Tue, 31 Mar 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974933; cv=none; b=DeRQHJW6UPHcRvIPkKdpBSliI/4r0CK2mZa5fIibbkxy8CaWwEBQncB1Dff8O2G+igkkeVAAOK100SiT9D2YePsdHrkliuInbZ+Bs6r1I9Qj4h/w1JgWF0KP7zuRvYWk6/DQ4L68zo6AXGzyklkJojB766W5WWgccPzkQ6+TZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974933; c=relaxed/simple;
	bh=2ZFXI/AiUBDN+zxwZ7irpBtBq8qg04CrQDpfUPcOxw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1POzQwcXSkRWETiepRyHpjK4/MliUSiY02R8yeLBJ0mVBiqxk0lMHcbryhev0+6l98RXhx+0rACYuZxp68RO4MzSGkKWE2I8Y6tGD206kdb1p+ZApepHb3yQKnxVRTwCFE6f8rpgT6zqOi7BKZgk7EOsMRZlaf3sZeNn0zv0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2vYz49n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3CBC19423;
	Tue, 31 Mar 2026 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974933;
	bh=2ZFXI/AiUBDN+zxwZ7irpBtBq8qg04CrQDpfUPcOxw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2vYz49nkKALFePQQoNdrOpDpUk2UBCkOh9A032NXP27+HqImkpZePdf3HLdPGWdo
	 OJPhX4CuAq96IcdwtWoX596mBWs2VCtmSx0aBMJQrKtzSuKEbAOznlQjeEa/cg2EbZ
	 HG5tQhfzOOvp02qHs/xg1YT5wztzMwmDmkQ+TfKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Ray <ian.ray@gehealthcare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 101/342] nfc: nci: fix circular locking dependency in nci_close_device
Date: Tue, 31 Mar 2026 18:18:54 +0200
Message-ID: <20260331161802.731076749@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231736-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gehealthcare.com:email]
X-Rspamd-Queue-Id: 5F9F336E131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 4527025d440ce84bf56e75ce1df2e84cb8178616 ]

nci_close_device() flushes rx_wq and tx_wq while holding req_lock.
This causes a circular locking dependency because nci_rx_work()
running on rx_wq can end up taking req_lock too:

  nci_rx_work -> nci_rx_data_packet -> nci_data_exchange_complete
    -> __sk_destruct -> rawsock_destruct -> nfc_deactivate_target
    -> nci_deactivate_target -> nci_request -> mutex_lock(&ndev->req_lock)

Move the flush of rx_wq after req_lock has been released.
This should safe (I think) because NCI_UP has already been cleared
and the transport is closed, so the work will see it and return
-ENETDOWN.

NIPA has been hitting this running the nci selftest with a debug
kernel on roughly 4% of the runs.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>
Link: https://patch.msgid.link/20260317193334.988609-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index d334b7aa8c172..25ba4cbb00e1e 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -579,8 +579,7 @@ static int nci_close_device(struct nci_dev *ndev)
 	skb_queue_purge(&ndev->rx_q);
 	skb_queue_purge(&ndev->tx_q);
 
-	/* Flush RX and TX wq */
-	flush_workqueue(ndev->rx_wq);
+	/* Flush TX wq, RX wq flush can't be under the lock */
 	flush_workqueue(ndev->tx_wq);
 
 	/* Reset device */
@@ -592,13 +591,13 @@ static int nci_close_device(struct nci_dev *ndev)
 		      msecs_to_jiffies(NCI_RESET_TIMEOUT));
 
 	/* After this point our queues are empty
-	 * and no works are scheduled.
+	 * rx work may be running but will see that NCI_UP was cleared
 	 */
 	ndev->ops->close(ndev);
 
 	clear_bit(NCI_INIT, &ndev->flags);
 
-	/* Flush cmd wq */
+	/* Flush cmd and tx wq */
 	flush_workqueue(ndev->cmd_wq);
 
 	timer_delete_sync(&ndev->cmd_timer);
@@ -613,6 +612,9 @@ static int nci_close_device(struct nci_dev *ndev)
 
 	mutex_unlock(&ndev->req_lock);
 
+	/* rx_work may take req_lock via nci_deactivate_target */
+	flush_workqueue(ndev->rx_wq);
+
 	return 0;
 }
 
-- 
2.51.0




