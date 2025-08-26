Return-Path: <stable+bounces-175003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F45AB365EB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6EB56247A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57A341655;
	Tue, 26 Aug 2025 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NdnW2OZ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25128314A;
	Tue, 26 Aug 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215885; cv=none; b=ALYUfbunyziZFfEBXqUwPp72l2tUezzDHF8F/L9aenUc6YJUZECDyY1bLtTr0P0tv6I8O1Af1wM+ASHNMpw0NrE/bhl3ZXqtZlYnkatT9XGxY+ZQqERyrHeF2bFtZvpYCYVrInLs8kAlabCdYscxR4wai8dYdW3eH6u4507wyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215885; c=relaxed/simple;
	bh=Zq6qgLoauGsh/zUxLi2QThKXJLiMbHnkHD+qyOwqxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIH+lfpXpcemAWMrgpUnu1gGZPdtmMhfXE9WDptA4WnOOW1hqw+bLIHZS2LVCBlGPTFy2xSNWf1KjVPSpuOGHmeUb68zY867LkDuIoeAByOct/C5mLH1i8iwY24HlTqsV1Sebg5Ih7rXC3I2cfy1DDrrUI/IwPcSCW16jQWxHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NdnW2OZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898A2C4CEF1;
	Tue, 26 Aug 2025 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215883;
	bh=Zq6qgLoauGsh/zUxLi2QThKXJLiMbHnkHD+qyOwqxSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdnW2OZ/0Ucgrg5yGXKTW7Q4m3AcnyNVFNUzQ6ESYSDl1aDylUSM1WJA30/MJBe2l
	 Unv3GUDqkWsSPVQ0zJbvsE4whGecRk2AbKNMG/L3fGVzQZs4e48nMEq0U6VO1346GK
	 vnX1Bm1h29MkPLU7n00bnK+5SFwS1FdjOUGLrTDA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 203/644] bpf: Check flow_dissector ctx accesses are aligned
Date: Tue, 26 Aug 2025 13:04:54 +0200
Message-ID: <20250826110951.467259230@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

From: Paul Chaignon <paul.chaignon@gmail.com>

[ Upstream commit ead3d7b2b6afa5ee7958620c4329982a7d9c2b78 ]

flow_dissector_is_valid_access doesn't check that the context access is
aligned. As a consequence, an unaligned access within one of the exposed
field is considered valid and later rejected by
flow_dissector_convert_ctx_access when we try to convert it.

The later rejection is problematic because it's reported as a verifier
bug with a kernel warning and doesn't point to the right instruction in
verifier logs.

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Reported-by: syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ccac90e482b2a81d74aa
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 169d9ba4e7a0..f346f19cf468 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8764,6 +8764,9 @@ static bool flow_dissector_is_valid_access(int off, int size,
 	if (off < 0 || off >= sizeof(struct __sk_buff))
 		return false;
 
+	if (off % size != 0)
+		return false;
+
 	if (type == BPF_WRITE)
 		return false;
 
-- 
2.39.5




