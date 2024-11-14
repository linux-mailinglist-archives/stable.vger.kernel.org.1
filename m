Return-Path: <stable+bounces-93043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D889C9122
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 18:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6951F2330C
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A79018D626;
	Thu, 14 Nov 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z0tJYeTx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2464189F3C
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606732; cv=none; b=nVIpngy2dBujddVi8gn6GFz5b2bpVTvhsX6wAYKG5A0MyH5ZcB3DkrVc+1LKVYS6pQiVe8GO8G8KTU7ptcG+7PvJMB6PN6OuyY5AoMWptvXS1wngBRXfCyJxvlWGQzj7zYkWaY2k7eqbniAdzDRZOn160qyOAUcOC3e+7+wcu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606732; c=relaxed/simple;
	bh=apJSFXQVNjB7nklns7r3B69WAfmXsi7qpL7x89a7NVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bc2EKGiNHGFINtN4UzSMzM310xDyoMTKwXfk0cGKBhAI/motq5EcEyfuarvywQEmI/Wr1kRCw5BzUeqdeZn3yOuuEYkJI7YR6LVdlkWmNz6J6ojFxXKghu2qsjTGuWzk0A4IHSYzvCCAbxy8I2W382Pzci+QFbcE49D2XCui440=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z0tJYeTx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4e481692so733185b3a.1
        for <stable@vger.kernel.org>; Thu, 14 Nov 2024 09:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731606730; x=1732211530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpy3QdHD1PzWkQ/hC0jW+9k3dxQdnK5utepjrrTfjd4=;
        b=Z0tJYeTxLY2SOzcxCG/Imt1hqhcayGy+UVMSvjAAHWM25X/Z0J4BqmjeKTWcaCZnMz
         VO1KgBQu+dpBKU6EJ+k2Q3CQRJThiWAjYt6RTfNha5u4BDo4Z3NotFqhO5ov8/gO1hoy
         kJsR9WfqCkpMUzZun9eNlkVQbRsJ6Yjm6kOug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731606730; x=1732211530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bpy3QdHD1PzWkQ/hC0jW+9k3dxQdnK5utepjrrTfjd4=;
        b=VHlwrdz0c7UrR6AwuxlQ9LtzfzwvscNaRS1vNoBwH607+duSCP5EUHf/9x205tz68Y
         i1Ziczcnvs2yffpnqIbdTSAsSS6eqMxnnFxki+aF4una+dYib3eXJBxLUsjXDnAhhFij
         kohky+XBuhYLsx+AgMiu7l8PYHpZIGYWYGzb94o+p/PrOnvrNGQ9XUP0SZ0JEwyqQfXi
         dHDBBNMZl4RhFM/gxgqkyOSkRlHzTrJ7PLf2cs4/l0MClDv6zaPpxO3OmnyzaHe2y4v8
         CCra8lT1oo5K0wcJFdeJ5VWhoiSlw/vfFQjkxkr7VnvAbI8pT2YQ5TfN+zZed/42iqMj
         LP2w==
X-Forwarded-Encrypted: i=1; AJvYcCX1LVzVz6tgjPNLAs54jk1aQqZ58S7NJAs93uOcU54D26XIUP2QEhxDflduGYuLz9jky0cDhvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG35Rq8wJBmwmsj2Rql6Y4xJCN0NlUHhIP/DeYsIc31HTgbDjg
	WrhlNrXTilE/zgvQ9r+6bVOQ2U8DMZOKBwWOj8nXyN1EAPbBBWID4NJ0aluqZMk=
X-Google-Smtp-Source: AGHT+IEzuOBbg7r/5j57WaldF3llHWkwbSqlB3tC2UE/jWFYwiTb0w9QGbjIr3D5ZFS7w2Dgt5FdwA==
X-Received: by 2002:a05:6a00:1ca6:b0:724:6bac:1003 with SMTP id d2e1a72fcca58-7246bac1753mr3240414b3a.24.1731606729863;
        Thu, 14 Nov 2024 09:52:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bac56sm1559883b3a.141.2024.11.14.09.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:52:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] netdev-genl: Hold rcu_read_lock in napi_get
Date: Thu, 14 Nov 2024 17:51:56 +0000
Message-Id: <20241114175157.16604-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold rcu_read_lock in netdev_nl_napi_get_doit, which calls napi_by_id
and is required to be called under rcu_read_lock.

Cc: stable@vger.kernel.org
Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v3:
   - Separate the patches that were a series in v2 (and earlier) as
     they target different trees.

 v2:
   - Simplified by removing the helper and calling rcu_read_lock /
     unlock directly instead.

 net/core/netdev-genl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1cb954f2d39e..d2baa1af9df0 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -215,6 +215,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -224,6 +225,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	if (err)

base-commit: 5b366eae71937ae7412365340b431064625f9617
-- 
2.25.1


