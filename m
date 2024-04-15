Return-Path: <stable+bounces-39561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32298A5337
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747C228866C
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC67581F;
	Mon, 15 Apr 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nq97GEII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D974E11;
	Mon, 15 Apr 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191136; cv=none; b=E6MsOOmKGCS0N3UybtjiSpeiF+KLnn4sPYtKSYDfnuXgoLbCzR4lmvVTA665bUK0JonjKkZUtvOWge/LwyIsSpfHExFYq2abIw1BDoRfcm17Xeb5Ea6jdn/k2T4SD5tCYIGJ4Qxznr99DKRXRnHHk0+eTgXO03vxPpEbDOByEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191136; c=relaxed/simple;
	bh=jSJaN06LqITi125kWY5KRpAzLo46lIx2Ldcsgz2hkes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1FobXDouJwvrB/YxN3Ty83v+SH/pJ/jW+Z9zTOCQ4xdLj++iK8jsAtSHUD24dThbqnq18fzkKOZQFkZsnBPRa/DDL7jdBMtfeJG8UIvd5xf3cgVaLtDJOvird9I6XlWYOETsynVkTRUvGyonDQfWsDJWjVMjHj59cjgqlqll+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nq97GEII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA18C113CC;
	Mon, 15 Apr 2024 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191136;
	bh=jSJaN06LqITi125kWY5KRpAzLo46lIx2Ldcsgz2hkes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nq97GEII+r7egcAqzc56JO2rgYB52woPZbk6gyOY83zSTIbGpA3y3MSFUbg4hPW3a
	 aXqU2n6HBuKr+uIE881eVWTTi6jghtLJFnEDbY79EyTaRb1aH0yOo4AM0is765Qi3M
	 evmhcWpgc8ufPQcy1AOyUea/T5Zaru3KZzDnKtw0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Maximets <i.maximets@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 043/172] net: openvswitch: fix unwanted error log on timeout policy probing
Date: Mon, 15 Apr 2024 16:19:02 +0200
Message-ID: <20240415142001.730808865@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 4539f91f2a801c0c028c252bffae56030cfb2cae ]

On startup, ovs-vswitchd probes different datapath features including
support for timeout policies.  While probing, it tries to execute
certain operations with OVS_PACKET_ATTR_PROBE or OVS_FLOW_ATTR_PROBE
attributes set.  These attributes tell the openvswitch module to not
log any errors when they occur as it is expected that some of the
probes will fail.

For some reason, setting the timeout policy ignores the PROBE attribute
and logs a failure anyway.  This is causing the following kernel log
on each re-start of ovs-vswitchd:

  kernel: Failed to associated timeout policy `ovs_test_tp'

Fix that by using the same logging macro that all other messages are
using.  The message will still be printed at info level when needed
and will be rate limited, but with a net rate limiter instead of
generic printk one.

The nf_ct_set_timeout() itself will still print some info messages,
but at least this change makes logging in openvswitch module more
consistent.

Fixes: 06bd2bdf19d2 ("openvswitch: Add timeout support to ct action")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Link: https://lore.kernel.org/r/20240403203803.2137962-1-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 3019a4406ca4f..74b63cdb59923 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1380,8 +1380,9 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 	if (ct_info.timeout[0]) {
 		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
 				      ct_info.timeout))
-			pr_info_ratelimited("Failed to associated timeout "
-					    "policy `%s'\n", ct_info.timeout);
+			OVS_NLERR(log,
+				  "Failed to associated timeout policy '%s'",
+				  ct_info.timeout);
 		else
 			ct_info.nf_ct_timeout = rcu_dereference(
 				nf_ct_timeout_find(ct_info.ct)->timeout);
-- 
2.43.0




