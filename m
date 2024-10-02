Return-Path: <stable+bounces-79974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41FA98DB26
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5965281AC9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29831D131E;
	Wed,  2 Oct 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgyQKg3I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7401D0DF4;
	Wed,  2 Oct 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879015; cv=none; b=Z1SLEhxaOHSVYMrYiAswWwLCyJKLBYGzt6D0kbj9enwF5OhxxJyyCxV8gvWqVxKdlD6+0lZK15i6wnpL4PQeLUr2EO4RrN6himdKN46JzjuHNdYNbzk1v9ZtCc4Y2BgK1Q00QpJUCawJqBjaj/hsW2iDW3lYkUq+D8WL/lEoltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879015; c=relaxed/simple;
	bh=nL65LefXpN4LctqXzKFTUuyb3JbiMB504BOv/xPMokA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4+b20/s8vU28wbF6vw3Z594bw81UAHRd0FkTBDzabwdjKgrSIEcmP22RsU3xtNs6XSZBnhvtm0WFqpWW/8w+eQcuufVdRtQ2oNQxYltApgOWD1q+Vug5tV9qxjBfo+lBActd61g+XAqNIQs5E3hSgklgxOwdOdKajdquM/aszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgyQKg3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D00C4CEC2;
	Wed,  2 Oct 2024 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879015;
	bh=nL65LefXpN4LctqXzKFTUuyb3JbiMB504BOv/xPMokA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgyQKg3I0iTfIrhZM2tCg9YoKbT8CaWh2hrSa9ycVPfF7rXU5ONUeHp7wRCQsa9e3
	 aRXxRzy8eOic4IUgOsvTtJBOx4o5dMtyvKey67GWmpuLJQBXOq+3ij5n3U5xY7mDzY
	 iWsMKsHBghZG3ZCGo9+i0+fx5vdpo9NgTo1jZYjg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Subject: [PATCH 6.10 578/634] nfs: fix memory leak in error path of nfs4_do_reclaim
Date: Wed,  2 Oct 2024 15:01:18 +0200
Message-ID: <20241002125833.931070831@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Lingfeng <lilingfeng3@huawei.com>

commit 8f6a7c9467eaf39da4c14e5474e46190ab3fb529 upstream.

Commit c77e22834ae9 ("NFSv4: Fix a potential sleep while atomic in
nfs4_do_reclaim()") separate out the freeing of the state owners from
nfs4_purge_state_owners() and finish it outside the rcu lock.
However, the error path is omitted. As a result, the state owners in
"freeme" will not be released.
Fix it by adding freeing in the error path.

Fixes: c77e22834ae9 ("NFSv4: Fix a potential sleep while atomic in nfs4_do_reclaim()")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4state.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1956,6 +1956,7 @@ restart:
 				set_bit(ops->owner_flag_bit, &sp->so_flags);
 				nfs4_put_state_owner(sp);
 				status = nfs4_recovery_handle_error(clp, status);
+				nfs4_free_state_owners(&freeme);
 				return (status != 0) ? status : -EAGAIN;
 			}
 



