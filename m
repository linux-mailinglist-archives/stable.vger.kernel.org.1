Return-Path: <stable+bounces-171734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478F1B2B725
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F1C7B2950
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E3D288529;
	Tue, 19 Aug 2025 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3VrGAgY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48C287269
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571227; cv=none; b=ST8toJf6qI+6ZECeWLMdE07AqWSGzjvpTMJYrbFyutM5jTmU4elMukb65PoJqV1meuBZCuIvFOWV0OgWCenb2/k3xmQ6YQNNqqmQQCddscFapTO8zcpDpKBv++QwcfNQN2Yxwp5juqcnM5nZ74dWFvqJ+lHVOyT5PRYgzkdbVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571227; c=relaxed/simple;
	bh=jDtYSc6iuqNNdWJCOYBsxSvtAEK4IFYu6Pt9uVT3D7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq1MV1LGp2pn7zYcxM5Pd3F7sY0gWVTdFyqvxJPFa+JrMSKjHgcpKAfD+/ZciaTPoVVB1tDkcj7MUegS81/4iLL5uVFHT37NekrqVvaX890ssuyAdYiAR/FC4aqcT7DAnqYoXnNm4lZMIy27uhQ237C9MVC4GZmuVd8vPWW+pV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3VrGAgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23697C116C6;
	Tue, 19 Aug 2025 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755571226;
	bh=jDtYSc6iuqNNdWJCOYBsxSvtAEK4IFYu6Pt9uVT3D7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3VrGAgYLLsUAgaE95oWtL4wEi0lKjF7qkUjUQkjcGcqgUMMdvI5MIMdgTVeiyBMT
	 66HSJYgqGmw/XM5oa7q2lMiH6iQTLtKJF2Z/SHqpmNjU0B77hm+GeLIS+KsQO3fduv
	 nJiakEEsyTwq5hkxHMJgPK0PpDOL58FuCSdnWHjbCJwd5ozlomjJ5yqRg9urswXc+Y
	 ixcvAFzv8VDH0i3b1vRz1y9SBbceiKFNS0QzN+XxtlL/yAWefEwD2u5QJQDfMHaUoH
	 7gb02UqQsfQ2dLIecR7/JJkRG3uLC2zoxQvUkVeSxTpcLa4h4UfJI3CnKh1fCNzeOk
	 4Y3a2BJ6b9hEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] btrfs: send: make fs_path_len() inline and constify its argument
Date: Mon, 18 Aug 2025 22:40:20 -0400
Message-ID: <20250819024020.291759-7-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819024020.291759-1-sashal@kernel.org>
References: <2025081840-stomp-enhance-b456@gregkh>
 <20250819024020.291759-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 920e8ee2bfcaf886fd8c0ad9df097a7dddfeb2d8 ]

The helper function fs_path_len() is trivial and doesn't need to change
its path argument, so make it inline and constify the argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a512e1628dc5..c25eb4416a67 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -478,7 +478,7 @@ static void fs_path_free(struct fs_path *p)
 	kfree(p);
 }
 
-static int fs_path_len(struct fs_path *p)
+static inline int fs_path_len(const struct fs_path *p)
 {
 	return p->end - p->start;
 }
-- 
2.50.1


