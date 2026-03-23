Return-Path: <stable+bounces-229593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GXUBqlrwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:34:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE12F859D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3988E30BC6E6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9483B9603;
	Mon, 23 Mar 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yKqSpzli"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F33B3C1F;
	Mon, 23 Mar 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282339; cv=none; b=AzsSsFEGh+JSVfPbXgQ+1dpnF0fL0Kpy8H1vaHWy4lxdU/eNDueQXhAGSLNHobrn6OlHO34OZMYRLgLjtr6vRXPGwRGoN/hQtuqDcYznBbMUUZk1foN/SrLoVJKORNfwdVzIAmxYCxesuxt7d32VsjN/3o4q85TYPc0h1RaBIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282339; c=relaxed/simple;
	bh=4ni+CQWZIDtpjfqJ46ucv+OQXX5WKs/rtNf/71zf8SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q82I9SQ1jC6e1k4ClNnRzql5JwiMZgf/HIuAIhiqNWwP1mspYJSXCdjLlL2OevHle46xtV6Bh/BTozfDbmNTq2+cRv8kGP3zC6pCOiZsgRuvidVOTOtMLZQUfcJhBWCU7g5bPlb72ybSobOPWYMAoe5Y16dgKMvs/CabCW+LtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yKqSpzli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86C3C4CEF7;
	Mon, 23 Mar 2026 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282339;
	bh=4ni+CQWZIDtpjfqJ46ucv+OQXX5WKs/rtNf/71zf8SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yKqSpzliSIZzpntsr4WHoNFqwmKu3bBiNsM2XXK8Iu9H9hK/IgnMYBNshmaj4+TSM
	 2yLdr1TIq4UFlvDyzmCbnLHxAPSDJ+dsJGx1FRZztsI1MOC4Eoaq1z0t0JrbCki1vy
	 Lxvd0iW2Duq+hjtWxcLC1MuPSKS0wf9IJO5Noci8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 093/481] scsi: core: Fix refcount leak for tagset_refcnt
Date: Mon, 23 Mar 2026 14:41:15 +0100
Message-ID: <20260323134527.542527245@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229593-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3CCE12F859D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxiao Bi <junxiao.bi@oracle.com>

commit 1ac22c8eae81366101597d48360718dff9b9d980 upstream.

This leak will cause a hang when tearing down the SCSI host. For example,
iscsid hangs with the following call trace:

[130120.652718] scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured

PID: 2528     TASK: ffff9d0408974e00  CPU: 3    COMMAND: "iscsid"
 #0 [ffffb5b9c134b9e0] __schedule at ffffffff860657d4
 #1 [ffffb5b9c134ba28] schedule at ffffffff86065c6f
 #2 [ffffb5b9c134ba40] schedule_timeout at ffffffff86069fb0
 #3 [ffffb5b9c134bab0] __wait_for_common at ffffffff8606674f
 #4 [ffffb5b9c134bb10] scsi_remove_host at ffffffff85bfe84b
 #5 [ffffb5b9c134bb30] iscsi_sw_tcp_session_destroy at ffffffffc03031c4 [iscsi_tcp]
 #6 [ffffb5b9c134bb48] iscsi_if_recv_msg at ffffffffc0292692 [scsi_transport_iscsi]
 #7 [ffffb5b9c134bb98] iscsi_if_rx at ffffffffc02929c2 [scsi_transport_iscsi]
 #8 [ffffb5b9c134bbf0] netlink_unicast at ffffffff85e551d6
 #9 [ffffb5b9c134bc38] netlink_sendmsg at ffffffff85e554ef

Fixes: 8fe4ce5836e9 ("scsi: core: Fix a use-after-free")
Cc: stable@vger.kernel.org
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260223232728.93350-1-junxiao.bi@oracle.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_scan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -355,6 +355,7 @@ static struct scsi_device *scsi_alloc_sd
 	 * since we use this queue depth most of times.
 	 */
 	if (scsi_realloc_sdev_budget_map(sdev, depth)) {
+		kref_put(&sdev->host->tagset_refcnt, scsi_mq_free_tags);
 		put_device(&starget->dev);
 		kfree(sdev);
 		goto out;



