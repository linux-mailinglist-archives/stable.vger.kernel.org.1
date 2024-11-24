Return-Path: <stable+bounces-95128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C849D7387
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5507165BC9
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FB022B4AF;
	Sun, 24 Nov 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6tjF8VH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A122B4A8;
	Sun, 24 Nov 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456091; cv=none; b=uU33DFMfqiyfnly1cgOzj/5Nq2FrJcZQECnnRQundkPf0DUZy3cslXkeonZBJcpaTVrUaR5RziJT6kBAUCCAMYrAmYDQNTZ4G2NRZQaQ+BFvd7yubOz20FIyu1lUmSajpMm5GgfIJN1AeqPshynNgSYra9pRerKdpB3xHn5TfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456091; c=relaxed/simple;
	bh=Cm48ydr7HuUmpf8NLPZ0xlI3ymdHuP7sWgbwamctBOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJou1apLfLNcwmh3Sf+OjuvCPAithlBBqP2/EnF4R7qh4F0r+w3HCRO/Qh+is3XSKCjkwYxC71UkiN3Np4y1vnPW0JdNnI0iGbZ7mhN61XAzCMPNiJPpB6DOarhILY74j8vtZ/GToHOPN32YZIZWHkRE2vmFCuOl3T9AofrvxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6tjF8VH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E48BC4CED1;
	Sun, 24 Nov 2024 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456091;
	bh=Cm48ydr7HuUmpf8NLPZ0xlI3ymdHuP7sWgbwamctBOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6tjF8VHXErjrrV4bQ6eAIRxVnpHXpoi3XrQhAhr/HfVV/aae8bCZnJQYsTc7zoXO
	 1TPJvmmg9CGxTJgE2wXnlCHXI5O3Y9vDPtJRXlYnOrs+OoyDSL3YcLNLQMultnWVAb
	 AVkgErPZ2KXeRszTsl0b7OGlL/4g3cDg20KhKWHhEFUlVSQDFAha3ZT6jmokuognno
	 fgUD933++KtHIKY9vnPX95W46nsihunjvdahauMI9AwgirKXmW1JsZV6qGm0pKRheQ
	 ukmTxEiz+lRLYJv58hHifQ/yv/xToz7GyDo8tWT1DU4d/rScYDK9xaJkucPHsPB9Y/
	 Na2Wp1U/pNg8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 38/61] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sun, 24 Nov 2024 08:45:13 -0500
Message-ID: <20241124134637.3346391-38-sashal@kernel.org>
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

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit ca84a2c9be482836b86d780244f0357e5a778c46 ]

The value of stbl can be sometimes out of bounds due
to a bad filesystem. Added a check with appopriate return
of error code in that case.

Reported-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=65fa06e29859e41a83f3
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dtree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 5d3127ca68a42..69fd936fbdb37 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3086,6 +3086,13 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
 		/* get the leftmost entry */
 		stbl = DT_GETSTBL(p);
+
+		if (stbl[0] < 0 || stbl[0] > 127) {
+			DT_PUTPAGE(mp);
+			jfs_error(ip->i_sb, "stbl[0] out of bound\n");
+			return -EIO;
+		}
+
 		xd = (pxd_t *) & p->slot[stbl[0]];
 
 		/* get the child page block address */
-- 
2.43.0


