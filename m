Return-Path: <stable+bounces-69181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F4D9535E4
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566CD2830A1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45721AD3E5;
	Thu, 15 Aug 2024 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YwWqQpTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE61B3F22;
	Thu, 15 Aug 2024 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732928; cv=none; b=ScyBcrkve/5HGMzk7obWOIPQWlzZ/me6WRob7bxUUmEXvSJXgWfhlMFtTcaV0VE+4ArC2hUPh5hH3sRu2J9h0S7a3Fx3MxmcFuZmr5kC8fVwij2BLLz0wEbeGWMKqNbtM0t0tRJcBn/gZcnjNGOGrS/cva02mGdX7Jd44AoN1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732928; c=relaxed/simple;
	bh=1B/PtJ2D3X6yblwAGos++OgzkpjXugU/bzhLUvzUvmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQsd4toyIqlWS9n4VLOddJ9dMtJ5ZE6hYyGABOKQivi89W1YAmHz9+dd0Bn1NtEvdTpbgJTaB8nYdcn04N/GXl5USCDDSIeckiZI0+/wqg4KZOX/pfGkA+BrAIYfYF7MHhLtNyANn+tf5L8gH24MmOshkFuL+I53oYROYhIVdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YwWqQpTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77085C32786;
	Thu, 15 Aug 2024 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732928;
	bh=1B/PtJ2D3X6yblwAGos++OgzkpjXugU/bzhLUvzUvmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwWqQpTXt8Sq98DggXz9RUROwOO1nwkIUrsnjAiQNripG6O3Cr1q/Rl8b5e5xLwRv
	 tWsdUqBbx+HR4pz5x71CsltaKei1lAVAvSHf/k/xQrK2h9O63XJBKFL5D3F8aMUuC/
	 +G95ZKvRU+d6a7741JdVbOkXSf9Ru9RjzwnYV6S4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 330/352] mptcp: fix NL PM announced address accounting
Date: Thu, 15 Aug 2024 15:26:36 +0200
Message-ID: <20240815131932.211300978@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 4b317e0eb287bd30a1b329513531157c25e8b692 upstream.

Currently the per connection announced address counter is never
decreased. As a consequence, after connection establishment, if
the NL PM deletes an endpoint and adds a new/different one, no
additional subflow is created for the new endpoint even if the
current limits allow that.

Address the issue properly updating the signaled address counter
every time the NL PM removes such addresses.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ Conflicts in pm_netlink.c, because the commit 06faa2271034 ("mptcp:
  remove multi addresses and subflows in PM") is not in this version.
  Only the modification in mptcp_pm_remove_anno_addr() is then needed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -759,6 +759,7 @@ static bool mptcp_pm_remove_anno_addr(st
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, addr->id);
 		spin_unlock_bh(&msk->pm.lock);
 	}



