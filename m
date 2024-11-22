Return-Path: <stable+bounces-94583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8449D5B44
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 09:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957B51F2313E
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819361BD9C9;
	Fri, 22 Nov 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="Q4Zxz8EQ"
X-Original-To: stable@vger.kernel.org
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55818A6AB
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265293; cv=pass; b=pSMaYYrO9kLpOmBB2h6fU1J1jDAz966FmXJ6w8xvjxzh/LmgVanYC/6GIdTnK5FVquiTl1KZpZiwUX6b3DBdp6158pm+a/LdEXL/YVmsA7RG4Z8CPKR0Hu9FaTHpjTb6FlGlUNjMBMyMbGE0o4N/I4jtiz4WY7omX3we+RgMueU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265293; c=relaxed/simple;
	bh=01ZqHsP1HaI0v83fwf7w+JvCVsz+iTys39ImnW4nzq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfOLxoMmmHs+1sjhDl3B285wYhoPPc/5xVHaBjWGRBce8HQGcf72jrNqpwp5ydxnFdQ1POgIl30ESpzWTDi5CKKmKkT4UctNHGJxHzHMcqJDII0yY/MtUJ1CKP+nqb1qs53QlWfsj16u60v5vMb0sut/VBJtsa1GaToJdzqPuMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=Q4Zxz8EQ; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C25AA942C49
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:48:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-112-135-158.trex-nlb.outbound.svc.cluster.local [100.112.135.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 72340942E17
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:48:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732265285; a=rsa-sha256;
	cv=none;
	b=7qHWWZM3aU2hA/O5YQ1xvKDeJt9+1+IttqPw7q6uobXY+ZaKxXXSZrXCeCEOL2LPSkbh4O
	22sciHUrZLlioshrV1lq6p9Qr4uNi1PTJYZVM2yFKhBSGgTm7NvGBJd9guBM5Mv93tLfVB
	r+0/ukWGvQSi7qf9sHPswQmvvf3GA9OxrboCoynq5WAxWRcj4gVp7gALwgHOW+4It63pO0
	6NOidzA2drb07KpSSzhxjhnSfgFTorSdVWA2JKmNGNnr5FMlaVyYfoZbQSC9bfy5Xy0Fbh
	iZDA80H4csBgnXnFGsbxEZoqC5RDmiiDXgXFXLZPJlGlmVDrXtoqAJz03t3T2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732265285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2Kw/lmLqCq6u0/mL7W0PXaEaVd1ox3PdTzE4P3dN3HI=;
	b=2YEKuHJ3NTzlaTvHPZwrMrG5ndVqnstjul0pLJv5KXFxuCFIMQZ27dD158phVzK6wS7rbW
	6hxL91moksmwq3Ma06zc2vPA2Ql2AVRn77J7N2MK/QgPNLJZRk+610CYxKyEv3fqXYZeWl
	fjnZyL8eJlFJ0dfh+mo3N5WvYJy/y8A7E2T82nBv9H1CjN1DjTltz/6DpmAQ2rBlnzyd+Z
	C3IRTHEVRNLW3RFB3AoHrE2RcPyBbKDF433AtiOgztL7Yruo65ZGVetkOond5lporv/2mx
	ZoSOKYk9IoTTXzXaJZp5MrZTsRFbhl6kHw9rGErniIR3NNlHropSPp70SSWtJw==
ARC-Authentication-Results: i=1;
	rspamd-dcc6979f6-hq5fx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Drop-Occur: 51ed5a0008ac55b1_1732265285694_734603754
X-MC-Loop-Signature: 1732265285694:4162303324
X-MC-Ingress-Time: 1732265285694
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.135.158 (trex/7.0.2);
	Fri, 22 Nov 2024 08:48:05 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Xvpdw6HN2z109
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 00:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1732265284;
	bh=2Kw/lmLqCq6u0/mL7W0PXaEaVd1ox3PdTzE4P3dN3HI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Q4Zxz8EQIXpwhwCvDMAjzXafh6oVDDoMyrWNqT17DjecdSQszQ+pv7HrGmGmFyb7S
	 NcmruqwAZZBuGqUu7Kuyyo3nOoJeTdssJUMusNYY1M5E/69hTAkBDjSOqBPhfgiFfj
	 +Jvp59gOviBqzLqmjqmJvwfMdpL/bpeKRwRClyu26Fd87P7Ik0f0Pn0vTLSUUCMeKH
	 DDSDfI9QSzERK1O2Ja9jczlLZnvHnM2z2HC/BXEFPQG00Xxd2ALHurJMotiHNS1PIZ
	 1vMkp02bIcM9vv2JC2XD6zNl72tXaUE83nX0XLrsO3VEPoCOVEGqCM8pbWKFn+1Nb7
	 WXDZstkSDMJzw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e006b
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 22 Nov 2024 00:48:03 -0800
Date: Fri, 22 Nov 2024 00:48:03 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	David Reaver <me@davidreaver.com>
Subject: [PATCH 5.10.y 2/2] rcu-tasks: Idle tasks on offline CPUs are in
 quiescent states
Message-ID: <69e45347cdb5a256b6e78e77e5bf8da005582b0c.1732238585.git.kjlx@templeofstupid.com>
References: <cover.1732237776.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732237776.git.kjlx@templeofstupid.com>

From: Paul E. McKenney <paulmck@kernel.org>

commit 5c9a9ca44fda41c5e82f50efced5297a9c19760d upstream

Any idle task corresponding to an offline CPU is in an RCU Tasks Trace
quiescent state.  This commit causes rcu_tasks_trace_postscan() to ignore
idle tasks for offline CPUs, which it can do safely due to CPU-hotplug
operations being disabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bede3a4f108e..ea45a2d53a99 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1007,7 +1007,7 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		rcu_tasks_trace_pertask(idle_task(cpu), hop);
 
 	// Re-enable CPU hotplug now that the tasklist scan has completed.
-- 
2.25.1


