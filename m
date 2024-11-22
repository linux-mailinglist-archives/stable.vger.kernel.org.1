Return-Path: <stable+bounces-94588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3959D5CDC
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790451F21EF5
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BC1D8A08;
	Fri, 22 Nov 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="fFwTyCiS"
X-Original-To: stable@vger.kernel.org
Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B241C8FD3
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269824; cv=pass; b=CCIfJW66+GuXw36lZ86K0yEwlhQLjt/RtYk4rfGcKBdkCfyO+/hQSuBJMAJ14CI81K7M9tyjjSv0mWS0XHH23yI6NRDlmjb+Yhm6Sa7dRa+ysmNW9Sqm70gflfMgolR65r+Tl1kRmAMHJ4POwocF5JK7wL367HARALaCT/y7J/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269824; c=relaxed/simple;
	bh=zXZVhUhg6UMftYuU/yfEsyfdQ6I3CUmNscYeG0Epq8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SCgEaRfj9vAn8yjWoE0xi8pS3pzPBwt3OlnunfZkhmurEvchpYlER1kx78WM8k40OE+hxbHBbsl8tu9Evw4PgNQ4BJZDMj5DDLwmkDKD8MUYQTDE5rclO8pAixdVlgPZaZs5Trs1e3PSVtYAWEqjPtC67Ws4Ne62JOUSg4/vpJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=fFwTyCiS; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4255D440AB
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:46:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.118.24.228])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EB1D34447D
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 08:46:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732265183; a=rsa-sha256;
	cv=none;
	b=YdkLMUbQ1lwo6+yhwuwKuXcJQyUBPoQHHskr/InQFLYlyO/Nf0mIsynjSVG4Eujpq0jGHB
	OWgj0Hxn26loTLAXsG1yeNW5iiXF/NHkMWZ9+uCLQNfU1SfmmTqdZZwnleMY8IKjFkC/M7
	fRdjUtWoe2NYjBUA37pSipbD0zEY+Gsr+j9yTQoN6rwkF6VhMrXUBIO+JxGMPKctlvThlc
	1ZSWSB12lmu3Rg1WtNHh8N0H8/u4/uDDb1plmWp7+cBTHRegj6OVfPhPaTlgkNXMNnk82B
	xxJSXzPwPf797LK+FTL2Wn8n7r1QQbULaWS3X+HFwkIcUsxAIlL0ZAiRJSlpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732265183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=HZAEqfrjCbTuothITkBDCZ7mGcsd2bpnUTM5j+JGGGQ=;
	b=cpb76luEDbIqXC0dakpaLfHflhcqPxSB1zTg017Fk6Zu8XYp+HtaNPzDUIKnEfLeTefQKd
	KGe9KKUP2iZeh3m7NwgpwjRaij+kmsFT7qoro6+GFvAMEgr+A872dwLhw64OCfu8l/OJxm
	VOIA/zi8hNZmli/bBoLvLoMzmq9rvhCvgKHj9APQS/9BPtzOIbPIaaubSwsKY63e+fZtXH
	MKyJ6TfLEfcWa2s6ZsME4aN/dle2CUPEM1sVxjeREkzHzM2Jrc8IGdgWpGbdclOKcVgiou
	hVMENBfNIijHYxGu6Wt+Iq7ENcize864P3g8uLQSX+MVJ7kej7jNSqHDCyBTvA==
ARC-Authentication-Results: i=1;
	rspamd-868968d99d-w9fng;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Company: 18a2da5a00bb807a_1732265184186_732349599
X-MC-Loop-Signature: 1732265184186:1080469290
X-MC-Ingress-Time: 1732265184186
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.24.228 (trex/7.0.2);
	Fri, 22 Nov 2024 08:46:24 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Xvpbz5GTFzVL
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 00:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1732265183;
	bh=HZAEqfrjCbTuothITkBDCZ7mGcsd2bpnUTM5j+JGGGQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fFwTyCiSpGl5OeJ9E7BkO0AicT7JgL384u2qz0lZTkeT/YzTuzhho/yyIlPNHCkUn
	 HMX6k+0Si2lmKu/4WX/djbP6Xikuk/jpLbU+TlqSQwrdqCterssi+79wbxquAy2qok
	 bdF+4/RYQqo/btpCvS+IzkACSIt/7bbtuqKfN+TR9KXVSqBJwotK7H+1uzqmLfjV7r
	 h6v8oRT0Y4l6z5TRuEWJKIKxh+2t7TIkgFmFynHjL5mxaPioo+0V5QjXejeJ8LnO+i
	 HoF1DwHsWU4xgppJH9/RPyf8G3lndmSdz1NtUxNO/d/k07YwgBszXPM76vdjrEi+Cs
	 0OrKTh11HmVaw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e006b
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 22 Nov 2024 00:46:22 -0800
Date: Fri, 22 Nov 2024 00:46:22 -0800
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
Subject: [PATCH stable 5.15/5.10 0/2] rcu-tasks: Idle tasks on offline CPUs
 are in quiescent states
Message-ID: <cover.1732237776.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Paul, Neeraj, and Stable Team:
I've run into a case with rcu_tasks_postscan where the warning introduced as
part of 46aa886c4("rcu-tasks: Fix IPI failure handling in
trc_wait_for_one_reader") is getting triggered when trc_wait_for_one_reader
sends an IPI to a CPU that is offline.  This is occurring on a platform that has
hotplug slots available but not populated.  I don't believe the bug is caused by
this change, but I do think that Paul's commit that confines the postscan
operation to just the active CPUs would help prevent this from happening.

Would the RCU maintainers be amenable to having this patch backported to the
5.10 and 5.15 branches as well?  I've attached cherry-picks of the relevant
commits to minimize the additional work needed.

Thanks,

-K

Paul E. McKenney (1):
  rcu-tasks: Idle tasks on offline CPUs are in quiescent states

 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1


