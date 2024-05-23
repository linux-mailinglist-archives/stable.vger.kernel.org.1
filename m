Return-Path: <stable+bounces-45905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5517C8CD47E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0289280C75
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C714B954;
	Thu, 23 May 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kd5j3LOt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF214AD38;
	Thu, 23 May 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470700; cv=none; b=rADFmWYDaaFFGOJk3HLXUGzYN1m551gOL6gQ1gwYn79HKWykgKa0dSj1ia7aidJecBoLS5EiYt7syrIGE8BoDCZSfly0pj/yWkoxl+Fws8WppmrLfFJlA0lM1G+0w9uk1/uaw4j6LlK4eSEkIhd3n6uAskCe74blaCvCGFp0ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470700; c=relaxed/simple;
	bh=rKy6NQ/JijREVklffBRBdUGJzsao1OybAmlBrcCY6/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqD6w2b9UmNNCzkHD+18CuQOJbVdNoCMXE62EpUO7t6mu5ybSRzK2Tf9pDKLYxsNox0zaRSjqSFpeqcoi9nh9gzsghDPcU0TslD6rlmYspWWAuNXB55Y4JpQQiTfXlZEFvJ0icsVxh/FceHYhYrBOp8Purp7L5MTy/79S+diXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kd5j3LOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1201C3277B;
	Thu, 23 May 2024 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470700;
	bh=rKy6NQ/JijREVklffBRBdUGJzsao1OybAmlBrcCY6/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kd5j3LOtTzvlgcEr8a01v4UmqbY0IhdupYTcfPoMc4AqeKxx7yKDy4WVmOHc5Sy5P
	 xrnX44V86l4X4Sksv7UAMwAhTSj3TiEThAP8J+dl+AR65q5U6ob5eanZxHfexpmXjL
	 y6Pgzr5bgq2iL7yxb+5oo495useJ8AXdNdft4bq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Alcantara <pc@manguebit.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 050/102] smb: client: Fix a NULL vs IS_ERR() check in wsl_set_xattrs()
Date: Thu, 23 May 2024 15:13:15 +0200
Message-ID: <20240523130344.352331943@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e0e1e09b2c41d383a2483f2ee5227b724860ced1 ]

This was intended to be an IS_ERR() check.  The ea_create_context()
function doesn't return NULL.

Fixes: 1eab17fe485c ("smb: client: add support for WSL reparse points")
Reviewed-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index b240ccc9c887c..24feeaa32280e 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -230,7 +230,7 @@ static int wsl_set_xattrs(struct inode *inode, umode_t _mode,
 	}
 
 	cc = ea_create_context(dlen, &cc_len);
-	if (!cc)
+	if (IS_ERR(cc))
 		return PTR_ERR(cc);
 
 	ea = &cc->ea;
-- 
2.43.0




