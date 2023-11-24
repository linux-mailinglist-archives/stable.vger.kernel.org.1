Return-Path: <stable+bounces-1834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C57F8195
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46825B21B20
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7A3173F;
	Fri, 24 Nov 2023 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tlya6KMS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30A22F1D;
	Fri, 24 Nov 2023 18:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0766C433C9;
	Fri, 24 Nov 2023 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852387;
	bh=gsNDA6FcvMfdA1LWT4GR+aT6huicyZnHYmwHvkXnvO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlya6KMS5h0GxyerdXcK7L57EzPSx4wq43ej4q5FsQL3Ht/GHZUACCqRw/J6WXBAb
	 PDUUPIvfQDUfk032Q+UjXCwHp1rRMxktIN1epBKpKDm0FhWsY74IjHKSzBFw7U7UUe
	 h3zZiKG+NSU2dtAyFXMMbsIT0Pv6jvrGQrKvHaSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 336/372] mptcp: add validity check for sending RM_ADDR
Date: Fri, 24 Nov 2023 17:52:03 +0000
Message-ID: <20231124172021.590633937@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <geliang.tang@suse.com>

commit 8df220b29282e8b450ea57be62e1eccd4996837c upstream.

This patch adds the validity check for sending RM_ADDRs for userspace PM
in mptcp_pm_remove_addrs(), only send a RM_ADDR when the address is in the
anno_list or conn_list.

Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-3-7b9cd6a7b7f4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1557,8 +1557,9 @@ void mptcp_pm_remove_addrs(struct mptcp_
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		remove_anno_list_by_saddr(msk, &entry->addr);
-		if (alist.nr < MPTCP_RM_IDS_MAX)
+		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
+		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 



