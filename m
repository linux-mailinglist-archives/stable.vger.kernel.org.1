Return-Path: <stable+bounces-215294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMhgCkT2iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE775111526
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D276C3093141
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E321027FB05;
	Mon,  9 Feb 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PqRZBai"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9425DB1C;
	Mon,  9 Feb 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648324; cv=none; b=MWR9qECT2mWc6RntoXC56AwTmbK7k7ResZe3ZkI1CXMaU7c+ot1JHwdcBmI/5PgfXHyIn07HpSLImtW51eekY+BPU8j8ziuKLBDwLZQv/TgWRvkWkDkLWgAwf5DmSi7UysbrVzb6y7FTGLFA4tIg49aCn5G/3D+VkXFUWaJlcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648324; c=relaxed/simple;
	bh=n0jaqpxNrEdhsH1DFcyxPDCcOlM/2R+/Yivvm+e4GWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnHAbrQkUnIPNL9zchh03PuL+AFysrAKTJARIwvyTVCIs/VE3mUF84uxKpoNe01BmA0leTvhNGu7RdGpEITFVl/F5VWcYiZHBn53YC3FGfgQkvIO5+96G5sLe4Q4b0oRykdJWixLrCkYrvk1X59d0j+GJHUJLrGLwVFQ0l6sXIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2PqRZBai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B45C116C6;
	Mon,  9 Feb 2026 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648324;
	bh=n0jaqpxNrEdhsH1DFcyxPDCcOlM/2R+/Yivvm+e4GWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2PqRZBai38Ioqf5WD+vikJ9KeiMKRQ8u2d/lmI4uDJb1yIWLV7U0K3eCZQ/0gfIqL
	 11J5oanLWQhQ92VmwFWqvaiPPRdon1Ik0IYFH7DnlddxCRg4rCrmwj50jMLaHnj63Z
	 uSwvCD4Ta5HQ8HcnBW/Jq7LWnDqIjJI+1gI6+RkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurizio Lombardi <mlombard@redhat.com>,
	Zhaojuan Guo <zguo@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 41/69] scsi: target: iscsi: Fix use-after-free in iscsit_dec_session_usage_count()
Date: Mon,  9 Feb 2026 15:24:09 +0100
Message-ID: <20260209142303.403213083@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215294-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email]
X-Rspamd-Queue-Id: BE775111526
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 84dc6037390b8607c5551047d3970336cb51ba9a ]

In iscsit_dec_session_usage_count(), the function calls complete() while
holding the sess->session_usage_lock. Similar to the connection usage count
logic, the waiter signaled by complete() (e.g., in the session release
path) may wake up and free the iscsit_session structure immediately.

This creates a race condition where the current thread may attempt to
execute spin_unlock_bh() on a session structure that has already been
deallocated, resulting in a KASAN slab-use-after-free.

To resolve this, release the session_usage_lock before calling complete()
to ensure all dereferences of the sess pointer are finished before the
waiter is allowed to proceed with deallocation.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reported-by: Zhaojuan Guo <zguo@redhat.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Link: https://patch.msgid.link/20260112165352.138606-3-mlombard@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target_util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 26dc8ed3045b6..61bcdc33f1230 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -785,8 +785,11 @@ void iscsit_dec_session_usage_count(struct iscsit_session *sess)
 	spin_lock_bh(&sess->session_usage_lock);
 	sess->session_usage_count--;
 
-	if (!sess->session_usage_count && sess->session_waiting_on_uc)
+	if (!sess->session_usage_count && sess->session_waiting_on_uc) {
+		spin_unlock_bh(&sess->session_usage_lock);
 		complete(&sess->session_waiting_on_uc_comp);
+		return;
+	}
 
 	spin_unlock_bh(&sess->session_usage_lock);
 }
-- 
2.51.0




