Return-Path: <stable+bounces-197773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3891C96F46
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D40C345AF1
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5D307AE1;
	Mon,  1 Dec 2025 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DObgAqp3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687263081C6;
	Mon,  1 Dec 2025 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588488; cv=none; b=hTBUlyzc57CfN77EdGztXW6YXLcfTIUp9JyVd1gyimrt6baKa39CSplkNtvLpCXNqZc5dTLnS0TTSzJVuPyVk7zGqKYpVffx5ZqsoLy1vwP8GA//6FKPmHA/pby9/91xeQn78ZhbI+wDETU6vOyvj2RoXA9c6LVe2RXWc58HoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588488; c=relaxed/simple;
	bh=W5MfhvDj8WGmWDeFXJZamlenOvjtRYt6MKLY9FWY+Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx7qG5+pANwRyYSxDa3JKCk4fmYT8LslfC9oyUoZpDQv6OZsXufXCLKYjTPzykcwZmDTqOn/Io09uJNlM5qp8ktTwDWBn151K8LdyDqvbW69eG6/IoHVLpjl9r0+MloOKF0q+H7xC3aa+FCKrh1s19miQqUW3KgIxGhpKA3LvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DObgAqp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C5CC113D0;
	Mon,  1 Dec 2025 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764588486;
	bh=W5MfhvDj8WGmWDeFXJZamlenOvjtRYt6MKLY9FWY+Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DObgAqp31DlxPzmijbQNjPul4L8Ok1004TrZ5gYhKJ6qGuRQ/zNVW4Gga0Im3FsaB
	 TpJCLMi0Du/oMq1JQfHnBKHKBMn7GEEyckEXyw+CChGZiCX2MQgPE0wQFhOh9mr6Wj
	 k9xSdbf0vcEV7LVaiwNy8UtNge6u9ejqvyFoRExY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/187] rds: Fix endianness annotation for RDS_MPATH_HASH
Date: Mon,  1 Dec 2025 12:22:53 +0100
Message-ID: <20251201112243.589053833@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ujwal Kundur <ujwal.kundur@gmail.com>

[ Upstream commit 77907a068717fbefb25faf01fecca553aca6ccaa ]

jhash_1word accepts host endian inputs while rs_bound_port is a be16
value (sockaddr_in6.sin6_port). Use ntohs() for consistency.

Flagged by Sparse.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
Link: https://patch.msgid.link/20250820175550.498-4-ujwal.kundur@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/rds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index 2ac5b5e559012..a8ad1e4185eb7 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -94,7 +94,7 @@ enum {
 
 /* Max number of multipaths per RDS connection. Must be a power of 2 */
 #define	RDS_MPATH_WORKERS	8
-#define	RDS_MPATH_HASH(rs, n) (jhash_1word((rs)->rs_bound_port, \
+#define	RDS_MPATH_HASH(rs, n) (jhash_1word(ntohs((rs)->rs_bound_port), \
 			       (rs)->rs_hash_initval) & ((n) - 1))
 
 #define IS_CANONICAL(laddr, faddr) (htonl(laddr) < htonl(faddr))
-- 
2.51.0




