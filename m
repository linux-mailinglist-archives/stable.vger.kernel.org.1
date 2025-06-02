Return-Path: <stable+bounces-149237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A554ACB1C0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F28119419A2
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333322F77B;
	Mon,  2 Jun 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWAbI9ik"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567F1CBA18;
	Mon,  2 Jun 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873339; cv=none; b=pcIr28uOn3jIpAQZZpmhpK2lWACbhGhJTZhIofTzJRSPdAELNaKox/W0BrrYJtJ+O91WOU0K08vQBTMdSPgnKZwhGVAxLYGnH19yDQBHOfPf6YFymq2b7WdL+uOYz0Irb7gfHdGoQseLdbQtPh4opKyunrZsp0460Jv58CvGLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873339; c=relaxed/simple;
	bh=U/Qs9UbAVCunuTSIULXMQ87Vxu4dKNVBj1+Xm7bIOz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1fCScHJ71eCnoIQ1z2YgyeKQRM2UGmsU7KJSlFTXMmCVbG5FjZdyWfaK/m1YFmBw07ainpJNhQTtyIPOebBopafL/K7FJMI9YlaE025+CotB0XNmG8laN8hGOs0Qzk2842Om1J6ha+srjZP8D4lQABSHXhkXlojMuiXLqwJ1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWAbI9ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5629FC4CEEB;
	Mon,  2 Jun 2025 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873338;
	bh=U/Qs9UbAVCunuTSIULXMQ87Vxu4dKNVBj1+Xm7bIOz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWAbI9ikcAu+S4rOaeuJLhrTTnXpn8qOnQGaRggD54pttnvEsI8MjkutbfI8zBrsG
	 RcuBPXrcw6UaZ2/pXoludd8PhcJ8n1A88+wY1a5xqgbkPRRizVeHbK1Ro2LOPhAGjP
	 nNIqw1aDYrIH1f5frmkR4jssGGcnnIAVovWwAMzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 080/444] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Mon,  2 Jun 2025 15:42:24 +0200
Message-ID: <20250602134344.150983271@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a77749b3e21813566cea050bbb3414ae74562eba ]

When attempting to build a too long path we are currently returning
-ENOMEM, which is very odd and misleading. So update fs_path_ensure_buf()
to return -ENAMETOOLONG instead. Also, while at it, move the WARN_ON()
into the if statement's expression, as it makes it clear what is being
tested and also has the effect of adding 'unlikely' to the statement,
which allows the compiler to generate better code as this condition is
never expected to happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index aa1e6d88a72c7..e2ead36e5be42 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -487,10 +487,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 	if (p->buf_len >= len)
 		return 0;
 
-	if (len > PATH_MAX) {
-		WARN_ON(1);
-		return -ENOMEM;
-	}
+	if (WARN_ON(len > PATH_MAX))
+		return -ENAMETOOLONG;
 
 	path_len = p->end - p->start;
 	old_buf_len = p->buf_len;
-- 
2.39.5




