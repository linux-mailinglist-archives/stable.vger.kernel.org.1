Return-Path: <stable+bounces-95150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE1D9D73B9
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4682166D05
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0B1F7593;
	Sun, 24 Nov 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS2AFyiD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A71F7586;
	Sun, 24 Nov 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456147; cv=none; b=Lklz4m4j4VSn5CFI29Fr3lQvva1I23CjpS23vXO/LN+5AsoqVRXzbmbNzmQ/ZMwwsjqL6KZH1SS9Gjh6NuHIbX0Hp8jSbL9M/C1U+t4COOLKvzrjEQwJ4jhx9AbBKqs0uem1iAbWzs9HzqlCVCEZGmnjAcwTDWXX82wtnkjRaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456147; c=relaxed/simple;
	bh=FChwReR/LLTulLw30aco9ZOTbLdRHtIAMpqFGAcPntk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyVCFGpJfTzPkQr7anDsrLCADujmYDtLPMmzDECDdxdKh4qTVfn/WBAHV3itmMl0jupCGhL31KJM2FIC+XEvyTMWo8ARMrIHINdqf9T7qGC2sTFdYgswNGxfRQybACEBuADR3k3O0Sug3Co7LITK7xs2K6hGVZunLf+ArGqK1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS2AFyiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E285C4CECC;
	Sun, 24 Nov 2024 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456147;
	bh=FChwReR/LLTulLw30aco9ZOTbLdRHtIAMpqFGAcPntk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nS2AFyiD46YhYSogcJD4uVKjbllpeaLgH0KFgUFiKBYYsjrlZTHF7Ha50umjM3RCS
	 IeFjlaLQp7mxvnLHD2Flvn9QvyK1FrEE/BO4ZXTx6w8Xj2ijXun6CZmuTt/fcxGB/N
	 tHJ9tCkceEuc40ylUMhslmx9C3P64lFl75HwZWrAmCLc8u8vIQ8DzuTuvWKLqKUKuo
	 OBpwEi14LZcrl8ei+9jULF23rwPpMpcq4VgfUeh9Aif3KE4B9m8HtGlXB0AFRWgts4
	 I5UWeRBlsmqEeQMlv4zu53CEeD8EU2Vd2gNgJGodSo3cnlejwBXVG6kE4vz+UqE8u5
	 GEEY46Rx88thQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	gnaaman@drivenets.com,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 60/61] net/neighbor: clear error in case strict check is not set
Date: Sun, 24 Nov 2024 08:45:35 -0500
Message-ID: <20241124134637.3346391-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 0de6a472c3b38432b2f184bd64eb70d9ea36d107 ]

Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
data checking") added strict checking. The err variable is not cleared,
so if we find no table to dump we will return the validation error even
if user did not want strict checking.

I think the only way to hit this is to send an buggy request, and ask
for a table which doesn't exist, so there's no point treating this
as a real fix. I only noticed it because a syzbot repro depended on it
to trigger another bug.

Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241115003221.733593-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 552719c3bbc3d..cb0c233e83962 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2875,6 +2875,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.43.0


