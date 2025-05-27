Return-Path: <stable+bounces-147483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15749AC57D5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780A37B0448
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CC7280012;
	Tue, 27 May 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="srd54wWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF727FB2A;
	Tue, 27 May 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367476; cv=none; b=d8OHLgfo43DaZVkfzHN4GkoG4fd+/IC7P9JO2aYYIMlYSlrkbHIVZc6buckD24tT/57ZEY8I7QtgZVQhnkCmICthJfUKtoUDNJpTr/70R1eM56ts0vEYa7iB/DJEiF59EYg+FbxYXVAeKqpHWJ4CWCATS8w8wlY2YJ2VYvIgVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367476; c=relaxed/simple;
	bh=eobLFNsQittVpu46kCtpcmKbuByWQBr1aVW6QJSTpAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WU66/8cXAGPOWj3dgnPbXvVEdtHd9qsU0l83XhDww91LRm89XZkkVl6DFIWU+5h6M31oNldT4d01v/8dfbQs+srHl9iFPaPaNIECMQWjBSTYzkObT1A0wXnA5/P2/cgkOtCfJQhpg7xO6mDj4r//luFOwFstwXguIJf/gTJkeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=srd54wWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39317C4CEE9;
	Tue, 27 May 2025 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367476;
	bh=eobLFNsQittVpu46kCtpcmKbuByWQBr1aVW6QJSTpAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srd54wWi74itmdHfIK9TnDQxw3JN5lfpJ8QoXqNEUcjw1hL4yAVk4PGYrYAfwcS6x
	 m4RfoK+BiUf1IVaTXmKWW2Z+MhV99uFhDjRy8BdmnyqhugyiQwFJzdhcgynWg4Hh8A
	 qktlGgB/56vXpQwnAZhqOxtzw6NS6P7gTeumMkWM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Seiderer <ps.report@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 400/783] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
Date: Tue, 27 May 2025 18:23:17 +0200
Message-ID: <20250527162529.383128501@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 425e64440ad0a2f03bdaf04be0ae53dededbaa77 ]

Honour the user given buffer size for the strn_len() calls (otherwise
strn_len() will access memory outside of the user given buffer).

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250219084527.20488-8-ps.report@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 6ea34c95179f4..d3a76e81dd886 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1898,8 +1898,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1929,7 +1929,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	if (!strcmp(name, "add_device")) {
 		char f[32];
 		memset(f, 0, 32);
-		len = strn_len(&user_buffer[i], sizeof(f) - 1);
+		max = min(sizeof(f) - 1, count - i);
+		len = strn_len(&user_buffer[i], max);
 		if (len < 0) {
 			ret = len;
 			goto out;
-- 
2.39.5




