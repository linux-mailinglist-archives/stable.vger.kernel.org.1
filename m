Return-Path: <stable+bounces-145098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E1ABD9FB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08499189A3EB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637EC2459ED;
	Tue, 20 May 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tIgjscvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609F242D7D;
	Tue, 20 May 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749147; cv=none; b=MneNXqr3DaCLNw56cr30XMgphmC5RniPJGZqAiFFOzjpYCFs4yMLOuUhE9Y2QVwyleXkYIuBPxLrLfOG8Yl6hgVAuYvT4wWGlZZVhDbd6OwVN41f1iI52VHCx27g56VsmJfvlul7ZRdUpZED4vjsZfDg4wjFXA67hQBm33EwJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749147; c=relaxed/simple;
	bh=F/2onW47zNjmBkuJUNXtdK5O3r6yKcu7bog2ObPgK9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dS40M+lu0Od1gyQ+x1dTF78FOO31krsWy9lYPldJkMQLmq8bfj/RD803qaivGvtX3JX070EHgbzjLV6jtjJ2xu/V45N8T6ANF2t2S84ovUuNi3NMwk72cpmg/adHts78lYd6w4OIR1TkQH1PUL7GD60Xk6IDgavsNQVuKgDAcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tIgjscvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18211C4CEE9;
	Tue, 20 May 2025 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749146;
	bh=F/2onW47zNjmBkuJUNXtdK5O3r6yKcu7bog2ObPgK9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIgjscvnwzs/nfeO2OEiuxu1XXS0lc118ygZ2QGuYkwRltpvR5gIihMjTJnxAsmKq
	 ls+5DcUz092MRYeP6iRaCuMkoyiYMbVXZHrktJ+ZWBIRh4KswNJLlKmKPfFINOPHRY
	 h691Pr8zjc92mB31Lcu/FHf+BwD1542AUJrcETTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 12/59] qlcnic: fix memory leak in qlcnic_sriov_channel_cfg_cmd()
Date: Tue, 20 May 2025 15:50:03 +0200
Message-ID: <20250520125754.319639728@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdun Nihaal <abdun.nihaal@gmail.com>

[ Upstream commit 9d8a99c5a7c7f4f7eca2c168a4ec254409670035 ]

In one of the error paths in qlcnic_sriov_channel_cfg_cmd(), the memory
allocated in qlcnic_sriov_alloc_bc_mbx_args() for mailbox arguments is
not freed. Fix that by jumping to the error path that frees them, by
calling qlcnic_free_mbx_args(). This was found using static analysis.

Fixes: f197a7aa6288 ("qlcnic: VF-PF communication channel implementation")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250512044829.36400-1-abdun.nihaal@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index d7c93c409a776..3bc2f83176d03 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1485,8 +1485,11 @@ static int qlcnic_sriov_channel_cfg_cmd(struct qlcnic_adapter *adapter, u8 cmd_o
 	}
 
 	cmd_op = (cmd.rsp.arg[0] & 0xff);
-	if (cmd.rsp.arg[0] >> 25 == 2)
-		return 2;
+	if (cmd.rsp.arg[0] >> 25 == 2) {
+		ret = 2;
+		goto out;
+	}
+
 	if (cmd_op == QLCNIC_BC_CMD_CHANNEL_INIT)
 		set_bit(QLC_BC_VF_STATE, &vf->state);
 	else
-- 
2.39.5




