Return-Path: <stable+bounces-149144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F49ACB137
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FB83BC08B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105D242928;
	Mon,  2 Jun 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SfhU9E6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A324291E;
	Mon,  2 Jun 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873036; cv=none; b=QzD1BpEnVva6SVQwJrTPzX/TPPyWpvGPYiRp0Yli1EnvCcRVFfGH4dzFm7CHIMILVSK/FkJN3+O9Tr72Zn51v2JUR0KtFH2FNRzfrkRxmUwh5P8NgPYwHAa++eQprfo1u/InNw/BiFLGEzzdRtD+fWxbSYwgwvhfeprxftQ5q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873036; c=relaxed/simple;
	bh=bXzF4LwKHZRVwx3j0bORqV8lRWcFRcNIAXpfQWHqn/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLtqVnopI+PqugTAZPjObAnhVeb1R0rXxvuVK6w9LkdqmMXiKsiTjgobiOIMBF4CKXrL/1GHMq3XLop6EluXmeqhUjhUj7FE28b58AAUroCK/AIDE9KK+ZgVHBJnRJM6E6sIfThHj7Qy3ib95fosmxIvIMk4ztvFmuzjZGyyzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SfhU9E6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A068BC4CEEB;
	Mon,  2 Jun 2025 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873036;
	bh=bXzF4LwKHZRVwx3j0bORqV8lRWcFRcNIAXpfQWHqn/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfhU9E6bo4MYQXsOV/ILfRXtbAF3A3eMtL96djXk0QQRf5FWq8NuzkcNZHILut8F+
	 cTcNJ0vHcUcNDrb+6dYBCSTV4rEXuPDmjOvj566SiRevQZ+71hio2vIaScyq1XDOJW
	 USgKE+RChjRWLXooq7wwVFL68ukwAaPB/y/XSoCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 018/444] scsi: target: iscsi: Fix timeout on deleted connection
Date: Mon,  2 Jun 2025 15:41:22 +0200
Message-ID: <20250602134341.652203219@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

[ Upstream commit 7f533cc5ee4c4436cee51dc58e81dfd9c3384418 ]

NOPIN response timer may expire on a deleted connection and crash with
such logs:

Did not receive response to NOPIN on CID: 0, failing connection for I_T Nexus (null),i,0x00023d000125,iqn.2017-01.com.iscsi.target,t,0x3d

BUG: Kernel NULL pointer dereference on read at 0x00000000
NIP  strlcpy+0x8/0xb0
LR iscsit_fill_cxn_timeout_err_stats+0x5c/0xc0 [iscsi_target_mod]
Call Trace:
 iscsit_handle_nopin_response_timeout+0xfc/0x120 [iscsi_target_mod]
 call_timer_fn+0x58/0x1f0
 run_timer_softirq+0x740/0x860
 __do_softirq+0x16c/0x420
 irq_exit+0x188/0x1c0
 timer_interrupt+0x184/0x410

That is because nopin response timer may be re-started on nopin timer
expiration.

Stop nopin timer before stopping the nopin response timer to be sure
that no one of them will be re-started.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Link: https://lore.kernel.org/r/20241224101757.32300-1-d.bogdanov@yadro.com
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index b516c2893420b..b756d4cfecfe9 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4323,8 +4323,8 @@ int iscsit_close_connection(
 	spin_unlock(&iscsit_global->ts_bitmap_lock);
 
 	iscsit_stop_timers_for_cmds(conn);
-	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
+	iscsit_stop_nopin_response_timer(conn);
 
 	if (conn->conn_transport->iscsit_wait_conn)
 		conn->conn_transport->iscsit_wait_conn(conn);
-- 
2.39.5




