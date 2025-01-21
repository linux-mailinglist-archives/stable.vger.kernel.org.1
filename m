Return-Path: <stable+bounces-109642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47383A18292
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75831889BE0
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E51F473A;
	Tue, 21 Jan 2025 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PNRD9Bk0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5A8mN51"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96E91F4727
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737479354; cv=none; b=RWElQHZQAoBKVfKQaY+xM4AiTkX048uEMqhhoxVCu4aEI0cshQz/c5JNV/NoTiy1oT4MnHwrSxuVdXxTVbOfmVp+HOHP5yOTS7OjgH6EyAPQfxIVHc8tJTsx5siH6ufaM3MJwj0Ed1z9LeQmu+H/SKj6cQXIIDxs4GCR6eSjcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737479354; c=relaxed/simple;
	bh=T6y6uW9zmqnh++m1o7BTd8qtKRlOme0Dej6ICqcez2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgfN30tp7K6B0b50OAf3rAGCGaMjtL8mIlkQgX8wOY0tjeWtEfndkznub8GsYebS+I2ETw5PyD5ibzcf/IRiF8bD7fWXVUUCe7wtUjQF7uBcE95oeh2RdHT4vWyAE0jcyv2MSiB5pxgWKVaUtJ+znVWyKU1fv+JGZfBkXkHOR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=PNRD9Bk0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5A8mN51; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBAA31140110;
	Tue, 21 Jan 2025 12:09:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Jan 2025 12:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737479350; x=1737565750; bh=5o7IcmMSRL
	iEfoCUlZqyyPNQsJmjxiDWKmIFfiKcL5A=; b=PNRD9Bk02dntlmXh2EEBWIcldS
	nZOE9/LK081Qz5WE9chqqvfHSCDHTc0/NZ1uJBM7LAvGlZWI9V67cD6+4Xmaf1l5
	qxR+pj+uVKJH6pgVzy9hMYfkOZo7A9PLy1yGjnhWyITpMO1cj/SP0WitvTJkuLeu
	WcL+CP5sJFFTdJgA8RqhsNFYQQVBO/jLEgo3jwc1L2A6c0VPcsyQ7DqkiL1LGF09
	0gYoCAPtrAmDqtcaTnhHaL394PTjF7U3d8H5fuMI6MsBlaybIDcB28YMkQwiFWod
	FmF6/5TAd3iwqhQ0/t3tZw4w/ux+i2nlEsXaIYJggzs2EHLqH+4VcLYO48bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737479350; x=1737565750; bh=5o7IcmMSRLiEfoCUlZqyyPNQsJmjxiDWKmI
	FfiKcL5A=; b=I5A8mN51jJNVSkpQvISbcLQ4LxWkb21Lq2oml18PCC/rTgDr3G1
	8n0Fp70N5n91ydVaj+t0v54kAuA1Hy6muyiE9XwAkAsgkobPVdk5G7EmIOaen0sN
	bPpFUVhuScTIAY4P0VBON7vI4LO7TdZjoX8OoVHHV3AjiKjmMlEJ8JCMJGMfzkWP
	lvtZu2o4z0CoEc/DfUs5iYUloMAXHYGziFDoLsHLA6qk3mGURaaQprd5hNhr6+Df
	2nrRiprkFGIZgAOEu2cYIsfMpC2nq0qaIlO7RqE+anZH7AsUaXSQcQnTAwpkAZDy
	mZOh9Ekq/TOh7l8EOdMxH7qkHGersD/81cQ==
X-ME-Sender: <xms:ttSPZ3eR0c4v_5dJnmK7-QyWx0av4A4r5QZXNL5FEHWBRf6ChDrsVQ>
    <xme:ttSPZ9P1levfUk1GQzgvx5p8Lz9mHwWGUsM8nmMB-ti0bKQFpclxCWhXYoQ-Y9C4v
    TeSH-lCwpyeZA>
X-ME-Received: <xmr:ttSPZwiVmZkMr6dtxGLa9cgaaUceA_i46aQEYM1G2g-oevKGbrvxEX7KI9a1-oOePS5RHTydcNhBf3llriLoeG5_f1Ucpi-iAZYLrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhsh
    himhgvlhhivghrvgdrohhpvghnshhouhhrtggvseifihhtvghkihhordgtohhmpdhrtghp
    thhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgi
    hukhhuohhhrghisehhuhgrfigvihdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepsghruhhnohdrvhgvrhhnrgihsehsvgdrtghomh
X-ME-Proxy: <xmx:ttSPZ48QjfoN4DRsOaVxT-R6nSbL8zL8cZ92luvchOg8sYEPHcp1Nw>
    <xmx:ttSPZztLCO1KHA_AOfs-Z_of-mxq-p0MbrcPj5AZpydrpc6lFF5V8g>
    <xmx:ttSPZ3GmaWVDbXMOJMzQcol4Lsyind0SCeOPD2wlyb1Q4IXhjp9vQg>
    <xmx:ttSPZ6P1TvqLcUYh_66ABWeUMx1heehCwq1cp6Bgm77rvQ3-8jnr0A>
    <xmx:ttSPZ8Gkf0B9KVHGX1663oqhaheVUWTOJF229g-OenWkcX1iO99DRoRM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 12:09:09 -0500 (EST)
Date: Tue, 21 Jan 2025 18:09:08 +0100
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to
 different hooks
Message-ID: <2025012138-quarrel-uneaten-83da@gregkh>
References: <2025011224-liberty-habitable-1332@gregkh>
 <20250121154117.205334-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121154117.205334-1-hsimeliere.opensource@witekio.com>

On Tue, Jan 21, 2025 at 04:41:17PM +0100, hsimeliere.opensource@witekio.com wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> [ Upstream commit 28ead3eaabc16ecc907cfb71876da028080f6356 ]
> 
> bpf progs can be attached to kernel functions, and the attached functions
> can take different parameters or return different return values. If
> prog attached to one kernel function tail calls prog attached to another
> kernel function, the ctx access or return value verification could be
> bypassed.
> 
> For example, if prog1 is attached to func1 which takes only 1 parameter
> and prog2 is attached to func2 which takes two parameters. Since verifier
> assumes the bpf ctx passed to prog2 is constructed based on func2's
> prototype, verifier allows prog2 to access the second parameter from
> the bpf ctx passed to it. The problem is that verifier does not prevent
> prog1 from passing its bpf ctx to prog2 via tail call. In this case,
> the bpf ctx passed to prog2 is constructed from func1 instead of func2,
> that is, the assumption for ctx access verification is bypassed.
> 
> Another example, if BPF LSM prog1 is attached to hook file_alloc_security,
> and BPF LSM prog2 is attached to hook bpf_lsm_audit_rule_known. Verifier
> knows the return value rules for these two hooks, e.g. it is legal for
> bpf_lsm_audit_rule_known to return positive number 1, and it is illegal
> for file_alloc_security to return positive number. So verifier allows
> prog2 to return positive number 1, but does not allow prog1 to return
> positive number. The problem is that verifier does not prevent prog1
> from calling prog2 via tail call. In this case, prog2's return value 1
> will be used as the return value for prog1's hook file_alloc_security.
> That is, the return value rule is bypassed.
> 
> This patch adds restriction for tail call to prevent such bypasses.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Link: https://lore.kernel.org/r/20240719110059.797546-4-xukuohai@huaweicloud.com
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [ Deletion of the patch line on the condition using bpf_prog_is_dev_bound as
>  it was added by commit 3d76a4d3d4e591af3e789698affaad88a5a8e8ab which is not
>  present in version 6.1 ]
> Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  include/linux/bpf.h |  1 +
>  kernel/bpf/core.c   | 19 +++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)

Why is this commit needed in the 6.1.y kernel tree?

confused,

greg k-h

