Return-Path: <stable+bounces-142602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAC4AAEB6E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B11526B0C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E197428DF3C;
	Wed,  7 May 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMS/l6hK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8A214813;
	Wed,  7 May 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644759; cv=none; b=FOL/LR/mpuq5l1u3fKfZvqljaikNfl6KfG2lsi1U3LQNtcTl+gXv0Gw4G12NUXfyFZKkNlg5iK9bhRcRxmv7bzL86KgkpfQLThC07uhf5deqKg1LAy/hqRrulcfalJV5c1p3gKtO6sCDXRFiOYI+49ib5yybJNRznU6SC22jIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644759; c=relaxed/simple;
	bh=/rkO6FDU2e9i2/jOdhiSPPzg8ZGWHQw45mN6NA9UbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrrRGmxJj+yYxZIyBWAnBy3kYTFYmKpYUmDKKbXNjp0C0KLinXp8Cs9fBEGTINkgdDp7Ck1HepH5bs4/+b9uacgm4hWHQ7u7j8vBR58mkIloVPZWgrrH8LteBnwLwI3j3FLJAbKqRNd99wUkit30ZjRbSKNUzinZa2MiNcN949g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMS/l6hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF8FC4CEE2;
	Wed,  7 May 2025 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644759;
	bh=/rkO6FDU2e9i2/jOdhiSPPzg8ZGWHQw45mN6NA9UbAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMS/l6hKWB6uUOZ5PaU4vTnejF3n6i62EHlpuTnMkDK4PWvnk9NRez7lVqw+HXTnm
	 OzqAGaTswxAYd0Y6EKbehplVT3oz3/WuGQT+I5/tPvFOAgjiUDdu6hqmVn3Pe9vQk5
	 Fr8ydOZWbPuRCtoHfNzZgILGnUkddXoMnNJwQkIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerrard Tai <gerrard.tai@starlabs.sg>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 147/164] sch_htb: make htb_qlen_notify() idempotent
Date: Wed,  7 May 2025 20:40:32 +0200
Message-ID: <20250507183826.923547159@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 5ba8b837b522d7051ef81bacf3d95383ff8edce5 upstream.

htb_qlen_notify() always deactivates the HTB class and in fact could
trigger a warning if it is already deactivated. Therefore, it is not
idempotent and not friendly to its callers, like fq_codel_dequeue().

Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
life.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250403211033.166059-2-xiyou.wangcong@gmail.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_htb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1485,6 +1485,8 @@ static void htb_qlen_notify(struct Qdisc
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate(qdisc_priv(sch), cl);
 }
 



