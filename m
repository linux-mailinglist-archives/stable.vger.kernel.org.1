Return-Path: <stable+bounces-191864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5131AC25712
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 987934F875D
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21A731A7E1;
	Fri, 31 Oct 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6a0CAE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C9221FB6;
	Fri, 31 Oct 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919439; cv=none; b=vGe0eNVHwM2hwsQinP5Q7v9Pwc3Clgb6MULa7u60uHHfdngCd/WFoMY14XMzSP0yjQZULoKxXEKzNOTSMmOWqzBZu6NUuS2nwxx9V4dyDLzStUa9LSQmR+oxkJiGDfi96Edzg6XHPE9b3lL4cXpM0OxXCtGEjTmnjhQFwhbSJpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919439; c=relaxed/simple;
	bh=fttpZVqnGjm+Ydyv/8c3o5uI3M0oxWUFe7faW+aw6BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7UimmCXZOoT8T/YnOiR6NMJuyM3UeZAOIP2UWqpvl9HuK1lhACps2tJakPFUg/2+Icm+EA0T4uDhEoPs+zGvWNP9yUPuN/rL7sHPir68VGzu9VHiToJ713zeDdBbyJAeW+2yO1wptjqkxR/0Y/WV9J2q9DT9c5F+TnFy1kk0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6a0CAE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B0AC4CEE7;
	Fri, 31 Oct 2025 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761919439;
	bh=fttpZVqnGjm+Ydyv/8c3o5uI3M0oxWUFe7faW+aw6BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6a0CAE13FqFa/F6StXIbNmFkigPMbv5VkfHZyJ78S0CZxj8NT5V3yXtBBKbDRGZg
	 W8yHhyEGHiTeg8v1AYQvrDny1duv38nu1dyYpEuEL5W3udBdSg9eHhuBVohjnnnCNz
	 m4Lh6gFyL49ir2YehKVrIWDnUSLXOnXI/2WaGdCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 19/40] btrfs: abort transaction if we fail to update inode in log replay dir fixup
Date: Fri, 31 Oct 2025 15:01:12 +0100
Message-ID: <20251031140044.475408508@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
References: <20251031140043.939381518@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 5a0565cad3ef7cbf4cf43d1dd1e849b156205292 ]

If we fail to update the inode at link_to_fixup_dir(), we don't abort the
transaction and propagate the error up the call chain, which makes it hard
to pinpoint the error to the inode update. So abort the transaction if the
inode update call fails, so that if it happens we known immediately.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b43a7c0c7cb7a..173e13e1d5b88 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1778,6 +1778,8 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 		else
 			inc_nlink(vfs_inode);
 		ret = btrfs_update_inode(trans, inode);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	}
-- 
2.51.0




