Return-Path: <stable+bounces-105232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8629F6F1E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2037A41DE
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF91FBE8C;
	Wed, 18 Dec 2024 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nahVWgw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079715697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555667; cv=none; b=XI4KP7+f6cjUaEjoPPZOUadWn2MoscnJYB0DJxlMQsNmt6DotJsXXEFb1TtNdwSlyGS93jOK9dlNF3WwKtOYSyfMUqaBR6EeUPA3p6bfuNqlLCtq0NFquuA88y1yRJDHfT/VUfkHtgUOhq9qZM9CO04WEBTowCqqCQKP1y8B5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555667; c=relaxed/simple;
	bh=904IjqbxHXMpQ/AWfsLAHaUQOxRyguOKIsGcZPPwyyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvKXZp2+dj65FjIG5GcvaulXq65O3Ws2X8hPMsT9H8xU5rVt6n8dojyNKny1ZQPZz3LfV01PoY8K2gcVv0pOBh2Qn4mPK3KfreokD7GwRUoStXAfyFAXxLBH/8MS9p9MuUyYrLjw+/etkg0PS4GkwFmGFw+tSwOoUORk7eAiMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nahVWgw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451D5C4CED0;
	Wed, 18 Dec 2024 21:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555666;
	bh=904IjqbxHXMpQ/AWfsLAHaUQOxRyguOKIsGcZPPwyyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nahVWgw+ZJZC1prKMOXFENqn6yyh4m5poDkQ6CyhJj8wE1LNfdkPCd3CITbBO1jHU
	 8odAjQvoP8tBi2rSx0o1bJyoyk3eJxp9BbnqzdrCfZo2Z54ivWjrWmxOZ31Y5gsDZS
	 p6VZmWsyr8q02erWnkrnsXgnJ2z/dTawXEz9711N29n3fJ/oVfyGmnetIWbkCqJJmD
	 7zjt3v+Z0qP32UZvJjFZiTLSTBMoTWZ69SEb127gPBQgQqArMUTDQI80IzVbPyt9jw
	 hZXsUZ/SrBjYr16mUDmZxpQLMfryYvoBk4gdUh8RZ+2jkFi3BxFZyQBzCglD93Doq0
	 1tZky0eUIsSlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 10/17] xfs: fix file_path handling in tracepoints
Date: Wed, 18 Dec 2024 16:01:05 -0500
Message-Id: <20241218154355-f5216c882667f5cb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-11-catherine.hoang@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 19ebc8f84ea12e18dd6c8d3ecaf87bcf4666eee1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Darrick J. Wong <djwong@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  19ebc8f84ea1 ! 1:  0239567068e5 xfs: fix file_path handling in tracepoints
    @@ Metadata
      ## Commit message ##
         xfs: fix file_path handling in tracepoints
     
    +    commit 19ebc8f84ea12e18dd6c8d3ecaf87bcf4666eee1 upstream.
    +
    +    [backport: only apply fix for 3934e8ebb7cc6]
    +
         Since file_path() takes the output buffer as one of its arguments, we
         might as well have it format directly into the tracepoint's char array
         instead of wasting stack space.
    @@ Commit message
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
    +    Acked-by: Darrick J. Wong <djwong@kernel.org>
     
      ## fs/xfs/scrub/trace.h ##
     @@ fs/xfs/scrub/trace.h: TRACE_EVENT(xfile_create,
    @@ fs/xfs/scrub/trace.h: TRACE_EVENT(xfile_create,
      	),
      	TP_printk("xfino 0x%lx path '%s'",
      		  __entry->ino,
    -
    - ## fs/xfs/xfs_trace.h ##
    -@@ fs/xfs/xfs_trace.h: TRACE_EVENT(xmbuf_create,
    - 	TP_STRUCT__entry(
    - 		__field(dev_t, dev)
    - 		__field(unsigned long, ino)
    --		__array(char, pathname, 256)
    -+		__array(char, pathname, MAXNAMELEN)
    - 	),
    - 	TP_fast_assign(
    --		char		pathname[257];
    - 		char		*path;
    - 		struct file	*file = btp->bt_file;
    - 
    - 		__entry->dev = btp->bt_mount->m_super->s_dev;
    - 		__entry->ino = file_inode(file)->i_ino;
    --		memset(pathname, 0, sizeof(pathname));
    --		path = file_path(file, pathname, sizeof(pathname) - 1);
    -+		path = file_path(file, __entry->pathname, MAXNAMELEN);
    - 		if (IS_ERR(path))
    --			path = "(unknown)";
    --		strncpy(__entry->pathname, path, sizeof(__entry->pathname));
    -+			strncpy(__entry->pathname, "(unknown)",
    -+					sizeof(__entry->pathname));
    - 	),
    - 	TP_printk("dev %d:%d xmino 0x%lx path '%s'",
    - 		  MAJOR(__entry->dev), MINOR(__entry->dev),
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

