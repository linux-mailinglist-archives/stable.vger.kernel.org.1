Return-Path: <stable+bounces-94591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE59D5DFB
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 12:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F120285ACD
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8671DED55;
	Fri, 22 Nov 2024 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="l1n1FQiV"
X-Original-To: stable@vger.kernel.org
Received: from egyptian.ash.relay.mailchannels.net (egyptian.ash.relay.mailchannels.net [23.83.222.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFBE1D7E4A
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274556; cv=pass; b=QKhFdcFPDW55KLgjbouC+unl+VhcDZ6AXgRdoShWRgkCZ+rDUIiUpwnSB7dmq8cqrQMqaBDgy5fwRRVPMHcV0Gw3zKCD50NGbtmB0f59R9lB95VjfTqP9NDJ46SooBtHjvMohTf262NZ6KTIRMTqNXBkv8oOFvQisKqJWMKi+Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274556; c=relaxed/simple;
	bh=zXZVhUhg6UMftYuU/yfEsyfdQ6I3CUmNscYeG0Epq8E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=umBYkiQgLUt7SIh6UgsbrhqzoojDUdZCn7b8ggJPIkPkpJ+x8JcB/rUnkKbatfNuOCJ2IBXrgyvySU+m7K8I9VsYujyHtRmF98OCl0uN+OE2llpxTmIguRvVqJJcENsIvEXJUaTGC+njJJaGd3icfMgT/QmRBhpcwDns9FDY6ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=l1n1FQiV; arc=pass smtp.client-ip=23.83.222.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 04A44182E30
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 09:01:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-121-72-155.trex-nlb.outbound.svc.cluster.local [100.121.72.155])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 96924182D83
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 09:01:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732266100; a=rsa-sha256;
	cv=none;
	b=0xthYXEZXu4/F18tpYZ13r5GBN21EHVEJT8jAiLlv3MhdjGaY0TTYk2uxnipnQe2ogfpZF
	vqyGSsHzMDygpciSXBM8JivDcDYQ/eXToqwYVcsOSeyvQkdquF4bL0CwL+aljfWhNoM8pq
	4eGtUQqn1jTllDZzE/9+YjQrh6JMysHVf7MbB+Rwe0h36aOzEizuDvx4veI6kwQs33WACL
	wt6zqGkZcfXXiIDIuIlSiB6GLnF/nAkTIXBM5dyzMnS4qYLry0wdUiagP0dQCHEh88r1f/
	2AMZqC6UuAJx8rWscO9MW9fdLC39LlaLMU+4yaiuy26UHvOVO4zNBRRnhuMxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732266100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 resent-to:resent-from:resent-message-id:dkim-signature;
	bh=HZAEqfrjCbTuothITkBDCZ7mGcsd2bpnUTM5j+JGGGQ=;
	b=ZZVdoJ4QpyTEYXdAF1HpdpV38K1o9Xqu0wsKyKW6y+Eh0zX5GvgT5w96KmeMpp3LUsJLlp
	jxOcf0y1/UJzMn72L1KHWgil1Hf+98gkBrC45zKFCTL+ZsdlYkZqm8cUrVRAuyjzcgo3ak
	cfmK3HO4m4SDB7uUPHzy7dssvqINpgQKNfN/TjuEAJ86nyys1mSOaTZuzgQqNt0J4KoIC+
	w+Luq6RpF2fznRBWpm4U3DRhQOLsPb7eR9WEWizNtgQnJYkqOxJG82mynE/TBikn7TZyRY
	tolCGEtL8rjUEGhHRDBeb2/p9GaQiJefKkLllx520kBXgpX9Mkp40KNb5SQ0fA==
ARC-Authentication-Results: i=1;
	rspamd-dcc6979f6-4v8g6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=johansen@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Lyrical: 2d42463d551d5802_1732266100829_70467117
X-MC-Loop-Signature: 1732266100829:2610732643
X-MC-Ingress-Time: 1732266100829
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.72.155 (trex/7.0.2);
	Fri, 22 Nov 2024 09:01:40 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Xvpxc2wmZzJB
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 01:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1732266100;
	bh=HZAEqfrjCbTuothITkBDCZ7mGcsd2bpnUTM5j+JGGGQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=l1n1FQiVoErhYVUV/QxpOuEsE2/w7v9EKl+6jqH/oP01xMjnZJlQpO5BXL21px1+Q
	 kzpAbPLs7KcFOPNocpXwSgF3262d4w1cu8w9zVIdi7GnD0nL4rPCW/n5H11XW/sHC4
	 O5B6ccoPH6UbtWxIijOuXnWyhZwKFtX2LqQw3l6eybCzEp33hr5Jqr2iqhW/a95Kcr
	 gybRTa0MsocMTHm4Ll1hUWTg/5r/iOTDPmxtWAr5CMr8BYXkbbI71IW+jqxqfvt1od
	 GnEyJk29I9IBX4bJqn7d8umfqEUdFYkYAWNQu6PdgxxGgInnsdNMAXbpbwdzYJ3t0v
	 3cdPhoQCVNqjw==
Received: from johansen (uid 1000)
	(envelope-from johansen@templeofstupid.com)
	id e006b
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 22 Nov 2024 01:01:39 -0800
Resent-From: Krister Johansen <johansen@templeofstupid.com>
Resent-Date: Fri, 22 Nov 2024 01:01:39 -0800
Resent-Message-ID: <20241122090139.GB7186@templeofstupid.com>
Resent-To: stable@vger.kernel.org
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


