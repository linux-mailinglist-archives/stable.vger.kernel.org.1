Return-Path: <stable+bounces-63414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366B9418D9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E535282FFD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05AE1A619E;
	Tue, 30 Jul 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFzYIwyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB11A6161;
	Tue, 30 Jul 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356758; cv=none; b=dAf1722tbGpWKsVVxkdMaLRbTMRKsDTr8dKe8rOZW3YmftDHPb4KS+45hCt/9f4+xEkwwDh8gUErTFyist+yJpKj49hZkFLSdlBcUUuBWmJd+cLepatXAylbz6LdM34LMYR8vKyFFgqjXN6rFCca5gSIWR4yp62qHRtCx1+m5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356758; c=relaxed/simple;
	bh=RtsQibRJ7Vg4oST+SupU5ZpaRqLZHtCnXKIUauzURcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNIxqYrjHLAxK0v7gSQLXy7+XpPKLnBPJXTQwUSf2eBheqS0mxgbLvxupigf7ORo/H9f1XEUj4hDEdkFG9upHBA3T9fjCcCsG5AWZAzB5BB8Z5fmZIshkdkvgoKfKb2vADooJVG/ryuoJrderyKw+CZQNwxJEj2BwZgjzle1Ysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFzYIwyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05083C32782;
	Tue, 30 Jul 2024 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356758;
	bh=RtsQibRJ7Vg4oST+SupU5ZpaRqLZHtCnXKIUauzURcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFzYIwyT2BNlyrClrtBplGIGBVOQCxkBJrzvahYHMFa6OtEW+iP9ZV3mD9HDTfClS
	 R/GLRcCAfgz+NHyawG+9ucqdvTHPJnzvH2yQqwPgQIWdNd/LIAIZh7NZxq4WDq5+5J
	 yflQEHYeSpGAs44lBOkufI7cp4xeUMrSfnCDzC3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Zubkov <green@qrator.net>,
	Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 184/809] lib: objagg: Fix general protection fault
Date: Tue, 30 Jul 2024 17:41:00 +0200
Message-ID: <20240730151731.877091551@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit b4a3a89fffcdf09702b1f161b914e52abca1894d ]

The library supports aggregation of objects into other objects only if
the parent object does not have a parent itself. That is, nesting is not
supported.

Aggregation happens in two cases: Without and with hints, where hints
are a pre-computed recommendation on how to aggregate the provided
objects.

Nesting is not possible in the first case due to a check that prevents
it, but in the second case there is no check because the assumption is
that nesting cannot happen when creating objects based on hints. The
violation of this assumption leads to various warnings and eventually to
a general protection fault [1].

Before fixing the root cause, error out when nesting happens and warn.

[1]
general protection fault, probably for non-canonical address 0xdead000000000d90: 0000 [#1] PREEMPT SMP PTI
CPU: 1 PID: 1083 Comm: kworker/1:9 Tainted: G        W          6.9.0-rc6-custom-gd9b4f1cca7fb #7
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:mlxsw_sp_acl_erp_bf_insert+0x25/0x80
[...]
Call Trace:
 <TASK>
 mlxsw_sp_acl_atcam_entry_add+0x256/0x3c0
 mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
 mlxsw_sp_acl_tcam_vchunk_migrate_one+0x16b/0x270
 mlxsw_sp_acl_tcam_vregion_rehash_work+0xbe/0x510
 process_one_work+0x151/0x370
 worker_thread+0x2cb/0x3e0
 kthread+0xd0/0x100
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: 9069a3817d82 ("lib: objagg: implement optimization hints assembly and use hints for object creation")
Reported-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/objagg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/objagg.c b/lib/objagg.c
index 1e248629ed643..90f3aa68c30a0 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -167,6 +167,9 @@ static int objagg_obj_parent_assign(struct objagg *objagg,
 {
 	void *delta_priv;
 
+	if (WARN_ON(!objagg_obj_is_root(parent)))
+		return -EINVAL;
+
 	delta_priv = objagg->ops->delta_create(objagg->priv, parent->obj,
 					       objagg_obj->obj);
 	if (IS_ERR(delta_priv))
-- 
2.43.0




