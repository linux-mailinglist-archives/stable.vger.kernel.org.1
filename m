Return-Path: <stable+bounces-74126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B1972AE5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86851F24B59
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D925B17C231;
	Tue, 10 Sep 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="N4C3rqMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D98PZDiT"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F917C7C1
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953777; cv=none; b=bol17SJKLL+/nnT0iYjf5G1qywBs2VrSWI8ODCJ6M87b/ttZwXQ0sbY7zLUGYc9cAE1fupqCh5MngVEyD8sgdCiGMp+Ro+CSeGC6McxxQ34FHrmgvQxXMiYybCos0OTJMP2/5wU5K17Wh3AdJ7dzJ50bs9EzAWkvthDA0zpYCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953777; c=relaxed/simple;
	bh=xyE0hWh7bvWF/AFvAiWQZX70aayvk84eEIfPnUEfRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tinV0SoGdZ2eYtoa7HraUOv1J95guxLeIwAYVUkrFvCGLU8LboECOBiUljp4ouSlWGX6lTv9EBVYa5WaBHDE1vFjpKdmmhorbVS+cBNaNui5NxB6i7Zm5Bch3mWdM3pGC3pQTR1vMMosDPCqd1TDwHMe5/i74lipeJjXTnexk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=N4C3rqMo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D98PZDiT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62BF1114005B;
	Tue, 10 Sep 2024 03:36:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 10 Sep 2024 03:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725953774; x=1726040174; bh=TrlRQJUWfU
	gmei0F3AF4Wx7yLx5rXARX+Wo7jIJIDSM=; b=N4C3rqMoEe2wQ8mHCLBFtYd8LL
	y/OPXQMqk0oIywy8/QpkZck+UX4CKT5gsMy+er6WjoZX4ZEs4j/qQ9nZRLT8MbsH
	gxFvvxrhtF5lVLlamDuIVO8jUukCzyAZw6qIxrVlpzzVU6edZ3SK2OrJDYHwANRl
	1hPgyZgnMghmz9ZI/+plja6hX3np60VtVmWHkOTaWpiERXTV0NPiI3pXETK3sdYO
	akShSqpYCQJPg1TOAOmMMCi8jJuaekl0+o5GfvZvaNhyKsg1+FEvQXTpiQBMZJ8n
	a5fhapEyDLqdDN9s2kkmHsbucW5eYHCCVdyaGYPQCqWGHPGJjpcM8R3Zl6FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725953774; x=1726040174; bh=TrlRQJUWfUgmei0F3AF4Wx7yLx5r
	XARX+Wo7jIJIDSM=; b=D98PZDiT3QUQGoCRr24gRQyhdUhHRFcFp7Eqp8a/pgkO
	QvqHPCHn2wXp9i06B2e6Q5U4po+nv3e5gQsPyzhwy85QMg5xREyfe9GE+TXhTKQz
	CEblREMPSt5tHFHqQz3GuY8lI2MBQD/ZHyRS7JEUMNkj17W6GcXUOsdeHWLVyQ6M
	/bhUbdUl/vzOpRILpDFO3aqLTNYGRBMDDLwMwC8ITfz6GnXsuHpUHzXBGSWqEnvi
	RYSnovAfDnGEJN9WDaREJMTGXkG45n0rGajsF7xMi/cvKUasMLoZeBgR8Rvu946E
	/Z4CUmbhQ9CtJPp1iQNPFkGFkLZsKk9wBOJowBDpPA==
X-ME-Sender: <xms:7vbfZprD97RaSqzr9J96XGzGcV4oeVTNYdYEkWMJuV-mCBthVkC0WQ>
    <xme:7vbfZrrAKM3Z1_3Vo7Ny6zG2e6htfFK-kjMzMS6Yz18YdMZBqs6ypXm9wH9tS5dnG
    NAZxeEsvnlojg>
X-ME-Received: <xmr:7vbfZmODWeZTHpO3mWM1Blfy0uSd9Y5A2oqSbRwBK_CSLFFaCV-CbgWj4EA4ETCDH45NE5QEnvZ-c_42px1IsW7ExzJrPHHgj71SqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnheptdefledvgeeiudejvdefteehfefflefhledtjedtudffhfekleekffek
    vefhtddvnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpd
    hmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudeipd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehhshhimhgvlhhivghrvgdrohhpvghn
    shhouhhrtggvseifihhtvghkihhordgtohhmpdhrtghpthhtohepshhtrggslhgvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgs
    ohigrdhnvghtpdhrtghpthhtohepuhhsihgvghhltddtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhgvihhlsgesshhushgvrdguvgdprhgtphhtthhopehtrhhonhgumhihsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:7vbfZk5PT76ttZFAcbWe4DQk2VKvt-zoS_ZVwZ0mBTfLNSCCH2n8sw>
    <xmx:7vbfZo6cMEWD6T1yA125XZ60v8VHDEizyooulnA62zQknGIwNQ5-Dw>
    <xmx:7vbfZsjYKBrz_E1ZFPFca-xQ7xsLlL4Czed8yzyGWBGxcTMB1Gv9Bg>
    <xmx:7vbfZq6OJZFTaFmd9okvU779vsl4zbTAxJbVlLQdv1Wtzx1oFZyixw>
    <xmx:7vbfZkr_ynUesKYcH595ugBlfoP5lMhigEK6Cr0S-OOwc884Zx0tN3pz>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 03:36:13 -0400 (EDT)
Date: Tue, 10 Sep 2024 09:36:11 +0200
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>, Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5.15-v5.4] net, sunrpc: Remap EPERM in case of
 connection failure in xs_tcp_setup_socket
Message-ID: <2024091004-finished-dupe-d9b2@gregkh>
References: <20240909161548.255373-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909161548.255373-1-hsimeliere.opensource@witekio.com>

On Mon, Sep 09, 2024 at 06:15:48PM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> 
> commit 626dfed5fa3bfb41e0dffd796032b555b69f9cde upstream.
> 
> When using a BPF program on kernel_connect(), the call can return -EPERM. This
> causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
> the kernel to potentially freeze up.
> 
> Neil suggested:
> 
>   This will propagate -EPERM up into other layers which might not be ready
>   to handle it. It might be safer to map EPERM to an error we would be more
>   likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.
> 
> ECONNREFUSED as error seems reasonable. For programs setting a different error
> can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
> which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
> instead of allow boolean"), thus given that it is better to simply remap for
> consistent behavior. UDP does handle EPERM in xs_udp_send_request().
> 
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Co-developed-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Link: https://github.com/cilium/cilium/issues/33395
> Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
> Link: https://patch.msgid.link/9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  net/sunrpc/xprtsock.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Now queued up, thanks.

greg k-h

