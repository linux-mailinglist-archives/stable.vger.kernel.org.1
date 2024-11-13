Return-Path: <stable+bounces-92883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BA9C672A
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 03:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870B81F21A63
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 02:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026413B5A1;
	Wed, 13 Nov 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FyL92bcT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F4139CE3
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464291; cv=none; b=UPnRVeycUhjnlarSXAxx6IEMp3HRgmVC5wZFWekfbJkmw3Wp3+KkfVBGMXNlRHLGLoP78SOMtX8XJn70Fg4nDfWVGlcP+FTn0wh3wwoFsA9gLEBWmHEdq8re+tncxSBoeRYuJRfMey5gAk46Y0UQR0eT6SteloVzPIEQvjxT3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464291; c=relaxed/simple;
	bh=VBaKG7sS3+bFmnPdr4IqHzNMfBCmbNJFBokvNs/FN3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFA5arFMM/0bnGB3UjLuxjZl3Qp+5BhL8DiCHj3YQXd7DY68M/L2eeree4CPcsETYhKUP9dBXknNFhig3t51MVnDKT5gF2hNkI1jl4jYU0pQwkBszdhqw7pNxhn88LL74+h7uf2Fr/NtVfaPfN9NN5iswG/wLpq+TKd+c63AEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FyL92bcT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c803787abso2235245ad.0
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 18:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731464289; x=1732069089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKBid5QRb/kAhtogYHDhzeEdvI0mEg25tnKEi7AhX6E=;
        b=FyL92bcT5FMc9roNmTkc73hyyelyRZqtesXbJoylmSOcr//jSCHmm2JtwMmg9Ha74u
         WYwzKG5dANmDe5NMjoQ5rWzTK1geMmxoZxZEAvKsqCuzgjLsWR+of2/E9HOn8V1ejvGQ
         HKnYbqnTGpRypf+NBcogpdL62e1It7aRTdImY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731464289; x=1732069089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKBid5QRb/kAhtogYHDhzeEdvI0mEg25tnKEi7AhX6E=;
        b=ggqZBn5XtfMEGQDrSxMTUuRSW+GNGkulJmwWMAGuCIfZg18UQ770PEYowDy3bJzJON
         w7qvo/tN/JOcU8lWFkgl9E+rzHbcYxnjhLRo/tVQ7psWuEo60fVHKAvpl+Wd1Qmn9f9V
         +XJMXIcmT8UkNNkF4JU7gKv2bmw2AWjZr4kqNlv/hgSl87XH0683I7YqORMu7+WeQvW0
         6URDpCEajBElW4BnYXmeFf6YL6z+rf52L725hAsJmD/7djxpPrNbRBTa8KMYUub/Ca22
         iag9M0Mmg3j1xPD9zDOS27c81iWq0+Y1utdGR3kYRtQVW9/Ci/mQ+zJO4cvb6jWTtP5P
         AfXw==
X-Forwarded-Encrypted: i=1; AJvYcCVxI4EhsU4t3jLKd6q8tYST9Up4pgkZnGdKCpDFEZDGUhKRx/bgkdeaW9f8pSup66seY3qNDjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWqmUwRT0p38qqPAPfWOlIaK0EBndmAFPiEOh0ighkEVXgymVv
	2aKLlu0L5VkGNzqCItiYUlRYc1LfQimydbItgtHc+0yNeMzhfpGJLa+8AU3H5LU=
X-Google-Smtp-Source: AGHT+IHI5KSL7qnXQ088ADYDMAiYRAqIH80E+3/aTvBMuDhB8SyMPvP3rnQzeByPamSOepx19J3iNA==
X-Received: by 2002:a17:903:228d:b0:20c:5d5a:af6f with SMTP id d9443c01a7336-211836e6dcemr267759715ad.10.1731464289523;
        Tue, 12 Nov 2024 18:18:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dcb1dfsm100209505ad.14.2024.11.12.18.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:18:09 -0800 (PST)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [net v2 1/2] netdev-genl: Hold rcu_read_lock in napi_get
Date: Wed, 13 Nov 2024 02:17:51 +0000
Message-Id: <20241113021755.11125-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113021755.11125-1-jdamato@fastly.com>
References: <20241113021755.11125-1-jdamato@fastly.com>
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
 v2:
   - Simplified by removing the helper and calling rcu_read_lock /
     unlock directly instead.

 net/core/netdev-genl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 765ce7c9d73b..0b684410b52d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -233,6 +233,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 
 	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -242,6 +243,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	if (err)
-- 
2.25.1


