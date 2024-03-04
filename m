Return-Path: <stable+bounces-26177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074BA870D70
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36DB11C23E7C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E9878B4C;
	Mon,  4 Mar 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jepz6DsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9D1F60A;
	Mon,  4 Mar 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588042; cv=none; b=PWLJtBa+y9tbJeXC4Rcx1VXEb9GLUuRsUdP2DRT9fCUPvrgsHY7nAOyMAEKoZv1Ual7j3Uq1zPFNnerHWHwHp+3c2IB8H4+ZfnzA5WLYK5sRG8gJdvVZ4SyxSSNE5iRQa2o7HHHAOWnbicUybH/2qMMBIwntuv93BmocGNpnqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588042; c=relaxed/simple;
	bh=7JHSSWSkN2VZQYReShfxtKSpGAcrmghGyCsNX6g/PBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCzfTq8aO4QAOI1UZMffkCHw6fBvCOJMFkRdIPr9tBHkYdB9bQtASiu/GWVMBgXQfvZkeQEaIxYb38MJ08RwRqRDlFERAdyIzl6WlmaukhHbwp9mtF2PGaL/pVgSjkAlG2PTtmTYxdXIWTuCj7SGCv1orTXTFGwEHUT03+Zsfb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jepz6DsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4B0C433F1;
	Mon,  4 Mar 2024 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588042;
	bh=7JHSSWSkN2VZQYReShfxtKSpGAcrmghGyCsNX6g/PBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jepz6DsK4pOGgH+PDCtiJmx1kERpbAfLboki/4GoQ/LXS8UEmEqdlM2UfOp4+l30D
	 KLhjJK7v459VGWcwGZkhSWOxnneZcN7cl8w02vHSYQdPc9jn7t6dx9tzReJPkk1nYG
	 L7Nd2sk0KSYFHToptHiUf9miSR5frkWP1HP/JCbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yunjian Wang <wangyunjian@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 03/25] tun: Fix xdp_rxq_infos queue_index when detaching
Date: Mon,  4 Mar 2024 21:23:39 +0000
Message-ID: <20240304211535.854516610@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211535.741936181@linuxfoundation.org>
References: <20240304211535.741936181@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunjian Wang <wangyunjian@huawei.com>

[ Upstream commit 2a770cdc4382b457ca3d43d03f0f0064f905a0d0 ]

When a queue(tfile) is detached, we only update tfile's queue_index,
but do not update xdp_rxq_info's queue_index. This patch fixes it.

Fixes: 8bf5c4ee1889 ("tun: setup xdp_rxq_info")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Link: https://lore.kernel.org/r/1708398727-46308-1-git-send-email-wangyunjian@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c595262c109ac..47958e6bd77fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -715,6 +715,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
 		ntfile->queue_index = index;
+		ntfile->xdp_rxq.queue_index = index;
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
-- 
2.43.0




