Return-Path: <stable+bounces-115258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25AA342C3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52F8188D53C
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3D23A9B1;
	Thu, 13 Feb 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sOFzPK36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0B1487FA;
	Thu, 13 Feb 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457434; cv=none; b=HgHJjqTZcxzuwoDHp01GQmzPBBfDLhQ9h3KJ6vHcMuZLELRyRixTrc5BRulZ0HjAhPVEckt6DzT3KFIMMdXr+w0JfEtGymTbnxxK0/6Or24JC0Rt61/H1bP+El4lnDQ8Pc9QRiMlpxuArbQ5+h3beZX13ejmrtnO19Jb52dp6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457434; c=relaxed/simple;
	bh=1TtYllftfTQHqn+NHUQO7nYgMhhdyKOSSXTo1JKeGEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcUD/iMn7Z0n6aKbohVwFtIiMe4kgNTamPFqzyzGTkbv3DaA439/NhwhMVf0JlG96t/AN0tua3G81BOw3E8VvNp7UGw0wojD8rTRIwuFPbax6J2ix/Veo4Gaih0zjUQw1YUZAcEQUYEA0kGSrOaLQfT65y3qzt6KLtJ2rzyESKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sOFzPK36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B096AC4CED1;
	Thu, 13 Feb 2025 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457434;
	bh=1TtYllftfTQHqn+NHUQO7nYgMhhdyKOSSXTo1JKeGEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOFzPK36OQaHYo1cZ+gsUtNj6wYEmwCkTHpnWlLbGuXAKmq/pTwTYjKlFmb6lwAIl
	 noOSmUqnrUVTWNXSs2zZxt9/fUhvBdfZ+9Qpw1oCPgNbbE+97hwnzffm8Cwz/pmQ87
	 KQb4N/7zCHMZFVwSrnNb74kmE3S7TrukUniH8v0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 109/422] ice: Add check for devm_kzalloc()
Date: Thu, 13 Feb 2025 15:24:18 +0100
Message-ID: <20250213142440.762934851@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit a8aa6a6ddce9b5585f2b74f27f3feea1427fb4e7 ]

Add check for the return value of devm_kzalloc() to guarantee the success
of allocation.

Fixes: 42c2eb6b1f43 ("ice: Implement devlink-rate API")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250131013832.24805-1-jiashengjiangcool@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 415445cefdb2a..b1efd287b3309 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -977,6 +977,9 @@ static int ice_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv
 
 	/* preallocate memory for ice_sched_node */
 	node = devm_kzalloc(ice_hw_to_dev(pi->hw), sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
 	*priv = node;
 
 	return 0;
-- 
2.39.5




