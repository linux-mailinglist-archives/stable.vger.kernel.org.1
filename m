Return-Path: <stable+bounces-118812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCAA41C83
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E7D188D03E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C2263C77;
	Mon, 24 Feb 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpVXWhRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303425B665;
	Mon, 24 Feb 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395873; cv=none; b=kjmrtE0xyVyX/4VwR6pbm1CZbhwYyjDYSTKbOpbNgj7gwMCXqbmFPmQMMSCRlV5KI+kmDz3fH2rcQL9l1Xf1oB8SGCW8e4h7TF4J8v5J7Ep3d85pM2mX1sKbpUB1FdLUXQp/YwuJ8ZVk3FfaQL2ksVXCUYaONfICrfj8oi8eZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395873; c=relaxed/simple;
	bh=m8euqMlkQNRjEjZIszmOR/3lgg/KxoeG745gIeD1LtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKcQkEb7nC8bT2kldIqayfT8IhwLJQPvbQnWr8RbCqVRG7kylLvuKxBI7Xk42trvPVzToH5hp3r3Ea8JWpHia1f/eGD7aDVcTBh3n0mzFgIJjYhv9cuACowYSwnx+cPrPRtcvWGVAUTNyxohNppRFFEahmY3JgA6KXuhLMlYGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpVXWhRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF64C4CEE6;
	Mon, 24 Feb 2025 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395872;
	bh=m8euqMlkQNRjEjZIszmOR/3lgg/KxoeG745gIeD1LtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SpVXWhRJPF/SQYMNC5cSPi5tQ8v8lqU47h+BFOU1poGU2WOGtqQfg/ijiTjNJM8pr
	 lipBPqdDlXhO4145yKYaT/8hH6jYQGcUZM6LJYPgbvioB56x4OWEDQsk4fM0Mz82d7
	 zc7YusoS1RAzK9y/lviVArk7Gg1rDcc/yNwlzABZU7a+McG/P/RQAiYPa5qdfDTjJK
	 Rh2cL1nmeY6cqq2jwyf/1wPdk9Lux1pcRyKbeLlZpIKKwVizRJs+Ozx6F4TqS15QBp
	 m3LeRPfWK9wY3cxS3Hlt4oLL+If8hH34RJ76mO6OwB4yu4YvQccJ8m9RPwsGB8SKE5
	 1xmL5qRjfOPpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.13 28/32] cifs: Throw -EOPNOTSUPP error on unsupported reparse point type from parse_reparse_point()
Date: Mon, 24 Feb 2025 06:16:34 -0500
Message-Id: <20250224111638.2212832-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

[ Upstream commit cad3fc0a4c8cef07b07ceddc137f582267577250 ]

This would help to track and detect by caller if the reparse point type was
processed or not.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index b387dfbaf16b0..a93127c94aff9 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -724,13 +724,12 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 				 le32_to_cpu(buf->ReparseTag));
 			return -EIO;
 		}
-		break;
+		return 0;
 	default:
 		cifs_tcon_dbg(VFS | ONCE, "unhandled reparse tag: 0x%08x\n",
 			      le32_to_cpu(buf->ReparseTag));
-		break;
+		return -EOPNOTSUPP;
 	}
-	return 0;
 }
 
 int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
-- 
2.39.5


