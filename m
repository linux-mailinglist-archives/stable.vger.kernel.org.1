Return-Path: <stable+bounces-163558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C49B0C210
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44203A5EDE
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C221421D;
	Mon, 21 Jul 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OqhKSs3Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876201EA7EB
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095708; cv=none; b=Brrg9ac2Up4Z1nTxTeewkTM3IuRnW05wPvW23fkOe7P7gK1uDOcgB998kyK/ukFbrLMp13AJhlJwha9OEgpcYcR7R2UHhF86Fb05TCoJjcT6aI4qukx7b9TZwt0gMlLoMgLDKlmeBTyl8QQPtxX04O7W9jom1PgWrep7P+R68pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095708; c=relaxed/simple;
	bh=kP6ofGXQFe7mnV1P/fiYDdy3/+0di3io/5iH0sW7XMc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OMSJ0igbLLCc2+UUcpt0V1fbuxwj5LLL+tADMnasT1tTHBjNU31RgufrGc2bG7rS3qd/7CiJyV/vmnD6C09rODpokbQWcDKq2GKa6xDJOqnusSN8nj1V/SAuZ9ueNelQ//ME0yb1/PREWOEcKY06TpkGc9sBu7qb9920jtmidMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OqhKSs3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4825C4CEF1;
	Mon, 21 Jul 2025 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753095708;
	bh=kP6ofGXQFe7mnV1P/fiYDdy3/+0di3io/5iH0sW7XMc=;
	h=Subject:To:Cc:From:Date:From;
	b=OqhKSs3QL6/hA3Al7ETX+ilsvqQDmfZnqQVFD+6AgubjBUVDXT0NtTgt2JFdixs6P
	 vN35gPRGLsGIUXoe8TK8X+inIbPp1AqmWs9uPlc+Vcs7/iC80ptrxKTiRvBiuT0HfL
	 PRdAqUaZhzjA9zs3hhi6HxmPKadqYDv/ZfLwyJ58=
Subject: FAILED: patch "[PATCH] net: libwx: fix multicast packets received count" failed to apply to 6.12-stable tree
To: jiawenwu@trustnetic.com,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:01:37 +0200
Message-ID: <2025072137-disarm-donator-b329@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072137-disarm-donator-b329@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77 Mon Sep 17 00:00:00 2001
From: Jiawen Wu <jiawenwu@trustnetic.com>
Date: Mon, 14 Jul 2025 09:56:56 +0800
Subject: [PATCH] net: libwx: fix multicast packets received count

Multicast good packets received by PF rings that pass ethternet MAC
address filtering are counted for rtnl_link_stats64.multicast. The
counter is not cleared on read. Fix the duplicate counting on updating
statistics.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 4cce07a69891..f0823aa1ede6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2777,6 +2777,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	/* qmprc is not cleared on read, manual reset it */
+	hwstats->qmprc = 0;
 	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
 	     i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));


