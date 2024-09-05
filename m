Return-Path: <stable+bounces-73145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6696D0A1
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97B41C2297F
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2D192D70;
	Thu,  5 Sep 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="uZnEFek/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OsfJvOO1"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841418A94F
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522180; cv=none; b=OFrKhOt6BbmAJpl+Fh2vMCnqmIYCpUMIniJHGs0sOvwiggSyIlngN9ZzcVHzfOLvKEWB43jY6LFuYyRtyV+UpMPSTly1TQOS2jo4xBeb1xktcmqUnoLp33/DRY3et4cRmxb6oTGrClOuGGht5PlkHgCvUEWDAG+TUHhwLhKSI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522180; c=relaxed/simple;
	bh=HjjpO9x1KUs+ThqiUUDYmN3P85k7f+wyhAyo4y6Bl64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PePStiy/87ZEou2rVtsCWAiEET9JZfcu8aHWcF9sQkfoUaUXvWffuC7fY3OH1CidPNTBWLyjSWdUX/dMXPGeGrKW0h7dJ7/hHCNFJmqOgnbt/QNXp6o9YqS/Nh/i2/Ju14FrBjekSkiUSC7Sa+GNiP+JjX8SQA8OPIukSekdhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=uZnEFek/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OsfJvOO1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C519138024D;
	Thu,  5 Sep 2024 03:42:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Sep 2024 03:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725522177; x=1725608577; bh=ES8uA5Rr32
	B8jUkZn7huDrjuPTnGe3bgR531Tgyj7ww=; b=uZnEFek//42onG6g53da98j4sO
	afR1dbm2QERuXl0VqamgiGCLMOgzDAu3D6gLdvEPLhls/z+A39PzOfDVqq1EceKU
	kAS+mtbEzAwV6353XV+ObQfGFkjBKUadFdstG1wo8JmQYxwZrY+ttm17f2wYTUgR
	XgCpOS7/TBbP6xoNo/ahwL6eub2GhsCpr9n2mGGeZb2Z6+7+/1HHJyDt/df4Di6O
	J9xeyUM/V5YHz93cFdCaOEcdq+uuSe4S2z3M7+d5OMv1/b7lDdlA+L/a4zowRrZg
	ZwJmMuQ0krgPJnINQOtYIdYacWQT/h580ZcAFgap4zUPZGJ+W6wUbrPqTFkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725522177; x=1725608577; bh=ES8uA5Rr32B8jUkZn7huDrjuPTnG
	e3bgR531Tgyj7ww=; b=OsfJvOO1/kp0grGtQuAFP3cCqE/4/XIuyX6kD2ncBvaH
	7/GCesxeAelgjTAzsfQOGfXp5WBO+Egm4DXY4WD7xtbcVB8lLWAK4c2cjS9gEY/2
	pJLpsw1ZJzAP3P6lsXUj0wL3PzJr+tDx1AX0FadKPRJrdM+09esTaRfCqtI91xpk
	kZbIHy/ougyXxX5bNJ/WqIfzr7/j0S4d4sDc9vrwGswts+TtlBlesHGZhTn/c8k7
	2QiG2yxfJla+hz+ppdfx2Rl0zMM8YEGvuo/re7LAdG9kWVOPtKomTI888ZOw7IRe
	4Zev6m8ukxjEgTw/RIYeeotaaS+qRzDigWhMNef1/A==
X-ME-Sender: <xms:AGHZZn8pML5yoFgxtJ6B1lJWNwYBC7lglIY4JjQcOFic61xiw1nw9w>
    <xme:AGHZZjvh0-oKBz7mrg0yDa52EJf5wNv0UlVgBvDlDRvQdcaWYHAwbCKa3ZMzfrQz3
    RjsJeK63dPMxg>
X-ME-Received: <xmr:AGHZZlBAVhwwL3Mzsni0ZaTNBor_bztjBxQ1Bx6qRYJGf0C_tZ4Dbzq7oPxgXRXOqJxUe9CQLvfXZj-ZvUXSX4RLjE7GSVpA6ZxxsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehkedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtteekteevveeiveeviedtgeehfedthfelfedvkeelgeehfeekkeff
    veekheejieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkkehsrdhiohdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegtohhnnhhorhdrohgsrhhivghnsegtrhhofigu
    shhtrhhikhgvrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhkvghllhihsegtrhhofigushhtrhhi
    khgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvght
X-ME-Proxy: <xmx:AGHZZjeuJH2Sv-kDfAgKaCMUc0_ndkkPB6NFeCsyxaFRXoqUdeRRhQ>
    <xmx:AGHZZsNbG8bk3S2hzs-SopXxkTNZVjsx5HolvZ98gpir93SccLOexg>
    <xmx:AGHZZlngwSDRLcipV-8KY_Z8VQyMbA0gwBN2zcu3v3EnAuyUf2ashQ>
    <xmx:AGHZZmsNxpRT0fHmS04qj9wRw5oL8oU-TGQYPsfIEdu0EspzTm4lFg>
    <xmx:AWHZZtjcVTrnk8cnVWCZAwlfkTDGwMSLFXDWyDhaxbyHtyVM0SAueSUZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 03:42:56 -0400 (EDT)
Date: Thu, 5 Sep 2024 09:42:54 +0200
From: Greg KH <greg@kroah.com>
To: Connor O'Brien <connor.obrien@crowdstrike.com>
Cc: stable@vger.kernel.org, martin.kelly@crowdstrike.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 1/2] bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed
 mode
Message-ID: <2024090546-surcharge-eternal-45fe@gregkh>
References: <20240904012851.58167-1-connor.obrien@crowdstrike.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904012851.58167-1-connor.obrien@crowdstrike.com>

On Tue, Sep 03, 2024 at 06:28:50PM -0700, Connor O'Brien wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> 
> commit 8520e224f547cd070c7c8f97b1fc6d58cff7ccaa upstream.
> 
> Fix cgroup v1 interference when non-root cgroup v2 BPF programs are used.
> Back in the days, commit bd1060a1d671 ("sock, cgroup: add sock->sk_cgroup")
> embedded per-socket cgroup information into sock->sk_cgrp_data and in order
> to save 8 bytes in struct sock made both mutually exclusive, that is, when
> cgroup v1 socket tagging (e.g. net_cls/net_prio) is used, then cgroup v2
> falls back to the root cgroup in sock_cgroup_ptr() (&cgrp_dfl_root.cgrp).
> 
> The assumption made was "there is no reason to mix the two and this is in line
> with how legacy and v2 compatibility is handled" as stated in bd1060a1d671.
> However, with Kubernetes more widely supporting cgroups v2 as well nowadays,
> this assumption no longer holds, and the possibility of the v1/v2 mixed mode
> with the v2 root fallback being hit becomes a real security issue.
> 
> Many of the cgroup v2 BPF programs are also used for policy enforcement, just
> to pick _one_ example, that is, to programmatically deny socket related system
> calls like connect(2) or bind(2). A v2 root fallback would implicitly cause
> a policy bypass for the affected Pods.
> 
> In production environments, we have recently seen this case due to various
> circumstances: i) a different 3rd party agent and/or ii) a container runtime
> such as [0] in the user's environment configuring legacy cgroup v1 net_cls
> tags, which triggered implicitly mentioned root fallback. Another case is
> Kubernetes projects like kind [1] which create Kubernetes nodes in a container
> and also add cgroup namespaces to the mix, meaning programs which are attached
> to the cgroup v2 root of the cgroup namespace get attached to a non-root
> cgroup v2 path from init namespace point of view. And the latter's root is
> out of reach for agents on a kind Kubernetes node to configure. Meaning, any
> entity on the node setting cgroup v1 net_cls tag will trigger the bypass
> despite cgroup v2 BPF programs attached to the namespace root.
> 
> Generally, this mutual exclusiveness does not hold anymore in today's user
> environments and makes cgroup v2 usage from BPF side fragile and unreliable.
> This fix adds proper struct cgroup pointer for the cgroup v2 case to struct
> sock_cgroup_data in order to address these issues; this implicitly also fixes
> the tradeoffs being made back then with regards to races and refcount leaks
> as stated in bd1060a1d671, and removes the fallback, so that cgroup v2 BPF
> programs always operate as expected.
> 
>   [0] https://github.com/nestybox/sysbox/
>   [1] https://kind.sigs.k8s.io/
> 
> Fixes: bd1060a1d671 ("sock, cgroup: add sock->sk_cgroup")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Link: https://lore.kernel.org/bpf/20210913230759.2313-1-daniel@iogearbox.net
> [resolve trivial conflicts]
> Signed-off-by: Connor O'Brien <connor.obrien@crowdstrike.com>
> ---
> 
> Hello,
> 
> Requesting that these patches be applied to 5.10-stable. Tested to confirm that
> the cgroup_v1v2 bpf selftest for this issue passes on 5.10 with the first patch
> applied and fails without it. The syzkaller crash referenced in the second patch
> reproduces on 5.10 after applying just the first patch, but not with both
> patches applied.
> 
> Conflicts were due to unrelated changes to the surrounding context; the actual
> code change remains the same as in the upstream patch.

Both now queued up, thanks.

greg k-h

