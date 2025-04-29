Return-Path: <stable+bounces-138359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579BAA17A8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCA04C4450
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837924BD02;
	Tue, 29 Apr 2025 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQMKAIbo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649F21ABC1;
	Tue, 29 Apr 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948978; cv=none; b=OwUGKWS4i/4DIXycqSyC3o25PKgnR7aJUJA7mOlI0AnzUGOOft/RTyNS7Dg7FRhwLbjg4XpYO/QK9vgILoCwlFsr+sMTZC5hmpStsqgms5s5fUWZKDi2ThjtB6G38TUbp9tM4Pf7ELN/5KB0eKPiH9Mg/KKn5IzY+EtdJLe1VgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948978; c=relaxed/simple;
	bh=YPowWJL0VFpcoAINT4eN1r3gK4qzNpfch+9bAI2xGps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbtjoQq9CA1wHqkmC/8+ForAuau0zdWky8vsC+UPD82Ixo9+s8cfCn9/eI7GrGVbJzmoWE8KJxwom13j/oDXiWv0EP9Jt9R6LLIWdtjvlrU3kOvnE+C+02ugOD4hDlqnfgK3vc3/tlvK4FBoFUSRloGY3wa9aK8lurQ5TC3UQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQMKAIbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46854C4CEE3;
	Tue, 29 Apr 2025 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948977;
	bh=YPowWJL0VFpcoAINT4eN1r3gK4qzNpfch+9bAI2xGps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQMKAIboyp3NGL0dpjDZiy6IqVwkl+k52mQD7/e2wVbvz5267AV6G/U6lwqNvqQ1D
	 CbGTRmn7Uwb80OOy6kI/V8ZxM8116TnY4xs/4Npqd1kG/yEovsrOg3o3kBalxCqlDM
	 qBwlMJ6bNOsp6XoHNl8V4s4zv4OVSItjghhCYUfc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 154/373] writeback: fix false warning in inode_to_wb()
Date: Tue, 29 Apr 2025 18:40:31 +0200
Message-ID: <20250429161129.488156590@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 9e888998ea4d22257b07ce911576509486fa0667 upstream.

inode_to_wb() is used also for filesystems that don't support cgroup
writeback.  For these filesystems inode->i_wb is stable during the
lifetime of the inode (it points to bdi->wb) and there's no need to hold
locks protecting the inode->i_wb dereference.  Improve the warning in
inode_to_wb() to not trigger for these filesystems.

Link: https://lkml.kernel.org/r/20250412163914.3773459-3-agruenba@redhat.com
Fixes: aaa2cacf8184 ("writeback: add lockdep annotation to inode_to_wb()")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/backing-dev.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -283,6 +283,7 @@ static inline struct bdi_writeback *inod
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));



