Return-Path: <stable+bounces-76855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5C97DD6B
	for <lists+stable@lfdr.de>; Sat, 21 Sep 2024 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D0D1F21A2D
	for <lists+stable@lfdr.de>; Sat, 21 Sep 2024 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2CF143887;
	Sat, 21 Sep 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="SAnnsd0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSyr5Saj"
X-Original-To: stable@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BD3D64;
	Sat, 21 Sep 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726928293; cv=none; b=HOgXyvS4TIY1kJWmiskfe93mmO/HzPXPSQkk3d5UQSP5tw8uHs5SWFGK9WxsyUFX6GE6Ru/6IV+LP5skmn7ZRcJDXS9r1mjTDNHxVzMto87NX8dVY7yasToLCTM7dPcxUp99MdcNDG23QFsQdAVyAYaCvJt3Y8ikMqZLDRbPiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726928293; c=relaxed/simple;
	bh=1xSNkVCgoXdttsVQU1hXaQ4G6ChXH0I/NQgJDoh/vAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j03oGmarTLFrgvOlMS1TXzibH94Z08g/2VqZhd6zSGlttrYshO9QpCyM0qsUp7QIa96Hcu2i6D303pp4nZJTY0Ndfy8R45wW19f7/O7LvtCRJr2YwYftDV04JBr7z99+Z6bdmeX1w0lW+PCrCq5UoqSSBF8XXZcdnT2pmPiiUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=SAnnsd0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSyr5Saj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7359113801E6;
	Sat, 21 Sep 2024 10:18:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 21 Sep 2024 10:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1726928290; x=1727014690; bh=giKd9Yzx4/
	NYlFb8znG9bVy2N/ZlsJq164ObM2aoCA4=; b=SAnnsd0IXyV5YKnEP5FwJCPEb3
	JKdPI4GDgoJ5NgNnGruG9i9f2IjSArn3anee5E4T0gvHF+2q7K6kBjdXsaZMQxxp
	XNlLVdeTQMW+M09skvuEzJdq/nOP3vysUYpOwpRZvXnnVdMFeXkCyrD1K5eVknyH
	ws7Cp65BwrNY3TTFdjelPhIn45ChRFF5BRUCeUdP5ew4DaqrfTwabj3ognX0WgH0
	4Wy6CnD4FZRwjfh4bHt5q9SOtB+bW+Wwr1b4j4rhni/JuykIcHvLJh94TKEiMK+6
	idoGLUriepuUHu+q7Vqq7p3lnscd0W0rZJJHLtKDp3mhycdbOouun2sgpDOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1726928290; x=1727014690; bh=giKd9Yzx4/NYlFb8znG9bVy2N/Zl
	sJq164ObM2aoCA4=; b=gSyr5SajhClRmaNxcn2+uvFNX2HOt7aSv2/mOC6n6e1T
	WGd59AOf0As3qqhk+La4QofZa/XsR5nz9IJOfKHjWdIrZL0yl/6C84sHyPlPXip1
	W6NkBbwTC16dXdxO7l7NWt47ttLdaQF9by+jAM8ynXeVFNQeephdIr3yxcKLnwBk
	8RxzNw1ksk84my/LPJRPvFfKeqnRx9CY/jI6QZsadZQq9ynaEYdUuRnZ0e+i2j5l
	31XCna5xCZBKKwglJzCNgSjN6WkB5BZOjsNx7hZ0u9WzDvWGXEuybeOW3ehM+GL0
	FVPOXbNVwspbCyTp35QAue4XILjj/nyEsSTgC4956Q==
X-ME-Sender: <xms:oNXuZiPsQRUSqIjX8wFL5r9wIQiKa2XuEYi3sSNBHJ85GA6GFP3eIg>
    <xme:oNXuZg8Zc5nw5LzA5bm5ln1O1PAF9Cg8Rugg0CzTEbRakfufRecAotrhYsOPX2_5T
    tuxDaRst8M79HSSou0>
X-ME-Received: <xmr:oNXuZpR9udFjLxblGqqqk3UIHdEmduz3f790TzdnNmOIhr2MfDosOibxX_U1r7TqBgFlwix1TrFqeaZTjX7iEcKchjy0p9qEtYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelhedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhgrnhhnvgesjhgrnhhnrghurdhnvg
    htqeenucggtffrrghtthgvrhhnpeetkeegfffhhfekhfdtveejueevtdefkeehgeekgeel
    teeluddugeeuvddukeeuffenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrnhhnvgesjhgr
    nhhnrghurdhnvghtpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheprhhosggutghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopegu
    rhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpth
    htoheprhhosggutghlrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheplhhi
    nhgrsegrshgrhhhilhhinhgrrdhnvghtpdhrtghpthhtohepshhtrggslhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhtuhhikhhovhekleesghhmrghilhdr
    tghomhdprhgtphhtthhopehmrghtthhhvgifrdgsrhhoshhtsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oNXuZivcIFTAwJOCzln0lyQPizft33icJ8HXbwj4NUh4aLHDTp7AKw>
    <xmx:oNXuZqcktNUenXy6skZ0jnOfMsN5sQx_1fGB0VySoUh_d6Zdz72aLw>
    <xmx:oNXuZm1BfPOTZoh4DOTwAROW7JeIFST_6s609F2H7dfoMq4PkeQr1Q>
    <xmx:oNXuZu9ayZeaeoZrLWr3W1MVd-DC7vggeZxNpxcn1JfuUIs8cObUSQ>
    <xmx:otXuZl3oT0V2JP4j-_hwn19Pd6C7QOp9AtMrqEPC15IdupnXm0xtCDHg>
Feedback-ID: i449149f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Sep 2024 10:18:08 -0400 (EDT)
Date: Sat, 21 Sep 2024 16:18:06 +0200
From: Janne Grunau <janne@jannau.net>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
	Asahi Lina <lina@asahilina.net>, stable@vger.kernel.org,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/sched: Fix dynamic job-flow control race
Message-ID: <Zu7Vnr7y4fS6KZaY@robin>
References: <20240913202301.16772-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913202301.16772-1-robdclark@gmail.com>

On Fri, Sep 13, 2024 at 01:23:01PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Fixes a race condition reported here: https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609
> 
> The whole premise of lockless access to a single-producer-single-
> consumer queue is that there is just a single producer and single
> consumer.  That means we can't call drm_sched_can_queue() (which is
> about queueing more work to the hw, not to the spsc queue) from
> anywhere other than the consumer (wq).
> 
> This call in the producer is just an optimization to avoid scheduling
> the consuming worker if it cannot yet queue more work to the hw.  It
> is safe to drop this optimization to avoid the race condition.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
> Closes: https://github.com/AsahiLinux/linux/issues/309
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 4 ++--
>  drivers/gpu/drm/scheduler/sched_main.c   | 7 ++-----
>  include/drm/gpu_scheduler.h              | 2 +-
>  3 files changed, 5 insertions(+), 8 deletions(-)

Tested for several hours with CONFIG_PREMPT=y and kasan with a similar
workload as in the github issue without reports or oopses.

Feel free to add
Tested-by: Janne Grunau <j@jannau.net>

thanks,
Janne

