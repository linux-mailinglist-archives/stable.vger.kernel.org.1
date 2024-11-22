Return-Path: <stable+bounces-94582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393299D5B3E
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 09:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3341283596
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456291BBBDC;
	Fri, 22 Nov 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="V6lqABV5"
X-Original-To: stable@vger.kernel.org
Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C815099D
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265233; cv=pass; b=UR9jj/MNTN9VBUZX5qRUvQTx8P5j1dhjBB48Shnixzavc9HCU7z85qFOXMPg+L1um6ULmjafY5IPes95e85RMiMiAG5RKtlfbdizJtU0byE3ZWj+UcWMZdDn47lSvfNM/3E2avAPFw5TgjUOF4Wjl4BflPiC/xGd1PpAT4Vm/Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265233; c=relaxed/simple;
	bh=mfnjIkwEMwoAK8Hl/BGSZ5EwNX49jHCs8zSU5Kh6aAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL4317ulPvxx8iKWSHHdOjASp0odssDeShK96u5V+fHmjD4VgZiFPN5Vr8aMmDs1UUOWh8Mx4dmmCgSicliqGS30ZZxe2DIZiVZpGIv1C3LgYq8HPG5xEKEePmxP7DEXe68pZHsBTDB3QbTleQnc0vVDcZsGCnNv0L2EE583FpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=V6lqABV5; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 14C381A4410
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:47:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-14.trex.outbound.svc.cluster.local [100.118.31.163])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BB4611A404B
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:47:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732265230; a=rsa-sha256;
	cv=none;
	b=g7SuX2VdSabQJCO9pyLuFeeQIzqJmoTVeecYK+lPmDzTeqCoG4xXigBBK4woeJYewOoEip
	Hl9LsLXQm15SCo17bFcWO/xcvjrFj3pjbAe7nzAHBmKltLVoESJRR+WQLRRFxbI1qcl1Un
	4e9rGw/33BKxhIXidLOH1aJDMuEDroCkAANvhyEBjcy7AGae8pbCMWAqhh/xwlzuHp/EB0
	qJcbS0+Gfo3lHc/GGF3o8ofZCIUjfhHQ0yUXQCzdIYblowGyn3OQ8RLbGsW04mZ756TugN
	KRmpoYMInzxW2xqRk3nj18Ag2e+NacOLLnOvnrc7CnE6PJi6A+L53pDBqnJxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732265230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FySjOuyh1KSKgHAF3MyH1EoL3y42VBfUevuuuW3PI/E=;
	b=LEW9YKtbmKdPWWGUVnPKHsBDieZZPQzM8OY4WIEL7oDTovID+6j9fNp+LPVbN5Tb36MPIz
	Y7v/2s0hvrY94qyNoaErgWY0Y5nxzQ0AaRHBoRUmsxjUHcwiszfwMVRkaC0JZTe7rtP2o+
	bfJeJ206YFgkT+ZNxNscJazbxprd56hb+riB//UBCsJ5w6AF8Y/kzRCOT/jmZrkN558Hhe
	YAkh5RqSOdwIDeb02HhD5/2ckbywXvVRYkDElZlMxI9T3xXEbONb5Cq+ET5jHlX1la36by
	Bs2n9lS78hOx4N6/mFB5kVXFpfHqqSsl9pjGvXyx8dWlzLPt3KjsKD4UilZIxw==
ARC-Authentication-Results: i=1;
	rspamd-868968d99d-w9fng;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Invention-Drop: 5b68be2961beca06_1732265230968_1575834441
X-MC-Loop-Signature: 1732265230967:4011309330
X-MC-Ingress-Time: 1732265230967
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.31.163 (trex/7.0.2);
	Fri, 22 Nov 2024 08:47:10 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Xvpct0jKfzVL
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 00:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1732265230;
	bh=FySjOuyh1KSKgHAF3MyH1EoL3y42VBfUevuuuW3PI/E=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=V6lqABV54ECT9V7KKr6BLs8jaAw5kE3vDN6QG9HeboJCBBEzDfAVkGwRMmhmB2+id
	 uVspxuFJY60gAitvStl4shrqNnIei5vhpxKzcDkbC/5I3zRYgcARaJdW3TJwh5Lmus
	 pA3Li/evmLN7FlODmgnGccr5DOW8Apz/sGQGBpszMyDlFehkfelZ3/DitassLkwvUj
	 oXM9SJrIuXsVHmgy/FeGVeSyP6oBGvA99V74hZ7obTiYASAoXmZZ4c5MVOAtKnbICk
	 NtaW7LlNoZzTll/LNxsRatlmRXLHyfLdiWFAZYrCwRyUE8+sIjf35wTwnZ6jglp7Jq
	 kuji71BSgVJrg==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e006b
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 22 Nov 2024 00:47:08 -0800
Date: Fri, 22 Nov 2024 00:47:08 -0800
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
Subject: [PATCH 5.15.y 1/2] rcu-tasks: Idle tasks on offline CPUs are in
 quiescent states
Message-ID: <c56243da5c8b4451097b39468166248790f9a1de.1732237776.git.kjlx@templeofstupid.com>
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
index 5528c172570b..8648685e7dfa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1090,7 +1090,7 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		rcu_tasks_trace_pertask(idle_task(cpu), hop);
 
 	// Re-enable CPU hotplug now that the tasklist scan has completed.
-- 
2.25.1


