Return-Path: <stable+bounces-118936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2810A4224B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D27421BD6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07036248882;
	Mon, 24 Feb 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="a22G0JyG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBExPfXX"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8114233735
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405343; cv=none; b=ZCP3YAa37+31NSkXyehZbwfxnk5ExRR1PkfoNDl5mjiTivvQzdLPf2frQ6etwmUwJmvsc7VvmUzSdI7MGWdAzcmkbtPP9EccGrMRFRk6xvkGNPMMXCSvBJiV54leaaupVusPABDLdNvBldJUTuheQd1mBnOhY34I2Z0U6xTv2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405343; c=relaxed/simple;
	bh=O3MgAEd6qXnxQ09CEjXQ1jAQMk5fxdJYlsv5FXy+ua4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql2m4A+693mhMCdWem4un1mqZcfL1zMTlpF/pk8sMv/MmNK3QP6C3QHnRX4cqHOp8cwQHG4PK0mu6utVsJeKwHmQtOHdB9OVnBRDDbDkBnIwQDqOzypAacMsKMwYCK+NBRjse7qtpeGz9phufxw1WdcxtKwGANWH+GSmFg6y984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=a22G0JyG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBExPfXX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A9BC114011C;
	Mon, 24 Feb 2025 08:55:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 24 Feb 2025 08:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740405339;
	 x=1740491739; bh=xymwM1QA5G2JPOvikpqoIB8ihxBXR1HBnzWdev5pSb4=; b=
	a22G0JyGtuivr1d4d8MQaTfyu/3zNZxBiW8VSdxrFdZmPJ0Ze5wFNONX6aay/n+K
	QKe7tgbQyXsPsudh9yKpJabMowXTgmxHe5lX8ZxWGgl1z6LNLhR+W6Q7BUySZYlz
	aTl92XgNckUFlK22tSFlKBRY49B9EbQx0IQ1ZmlGqIvv2U930S/x7ifrHSJ7mcsN
	IBa2ber3SIXhxNFAZJHJ+t1ZM+MO6hVr9soZPVNbJA/1B9uxEKNpayncGY81pNkq
	5FvZoPHmPy0Tz4cDNEFHtZ9WnIv6lcQMhEKv0BsKsc9Z30up5bistGy8OS3BhesI
	/28l7CbMhBZaiPLCytKVRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740405339; x=
	1740491739; bh=xymwM1QA5G2JPOvikpqoIB8ihxBXR1HBnzWdev5pSb4=; b=c
	BExPfXXyb7eppMjsDIt8jZLcUuu208pPRdhL+jUpTO1VC8oN5h3cWlrDDooUrCOc
	tP5kv4lFsVoM0b4Z0Mcs3zb6uvGt4sgmZKV/wOlbC0xPh7KzahuNXnw7DMwjKp34
	gJ0TkW6OhGQQsl7fa75FbYGZG/rtQ8ou8O6M+fMtVkr1cs6Taswmxhe6QB5+k/tW
	gzaUigx2XHED6cCznJN82F0TfCr4HIXvikTB5qSYosCAP/EffyI/MpkGMK+p68PY
	q8RIo9dE1dradbmh+gEY5yv8kQIwFZzFU0ltQixaTyJ80PIjcL//fYEtYZOoaONJ
	/XHIVRZV2HU98wdbLGmdQ==
X-ME-Sender: <xms:W3q8Z_NB_cr8r5-jDOZ7XpBSK1_kt7034gERNBkf2iyp5LNYXT3rVA>
    <xme:W3q8Z5-CD8XgL0S2zigQCHgY6HIBiY9g4fU7APXyp8vybIEg0RG32_odN-hSHs-Qk
    7LShG3a9i9-9w>
X-ME-Received: <xmr:W3q8Z-TP6RoncNa8fwccUnH1UTJXGlPbDJrLFEGeAEyJJPRw6PocYi5FgaSDLw40KhBWZkREC33wvOmoHdSuYKamCQx6vpmkDTCgVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgvghcumffjuceoghhr
    vghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeetueeihedvhfffgeeftd
    dvvdejveekfeetjefffefgveeijeeitdffgfdvtefgleenucffohhmrghinhepmhhsghhi
    ugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgtnhesihhgrghlihgrrdgtohhmpdhrtghpth
    htohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghi
    ghgvrghshieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehrvghvvghsthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdguvghvsehighgrlhhirgdr
    tghomh
X-ME-Proxy: <xmx:W3q8ZzvIZykquzhDWcOTIgVjZYMcebo1yBFPrvRfoA-dD9K3jZ7AgQ>
    <xmx:W3q8Z3cHvdvhDmpJNhIPpH3GuBiB7Bo_ihw_KA5ji5RA-ShQqYYxIA>
    <xmx:W3q8Z_2zy_jCOIFClp2iko3sNH_xmZOGtIwwWVK_NV0eu-0KtuQqmg>
    <xmx:W3q8Zz-CSrhQaoa8IyrSBE2vX3xWaLrlr1PACI8t1dNhj7omqEhHsw>
    <xmx:W3q8Z4VlYNeu0AAXVFDZqb0eyUtk-N4pwaoHEolpVEyXr7JHXTq4nsv_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 08:55:38 -0500 (EST)
Date: Mon, 24 Feb 2025 14:55:36 +0100
From: Greg KH <greg@kroah.com>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= Navarro <rcn@igalia.com>
Cc: stable@vger.kernel.org, bigeasy@linutronix.de, revest@google.com,
	kernel-dev@igalia.com
Subject: Re: [PATCH 6.6 1/2] net: Reference bpf_redirect_info via task_struct
 on PREEMPT_RT.
Message-ID: <2025022454-dislike-unengaged-37e5@gregkh>
References: <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-0-de5d47556d96@igalia.com>
 <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-1-de5d47556d96@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v1-1-de5d47556d96@igalia.com>

On Mon, Feb 24, 2025 at 01:00:01PM +0100, Ricardo Cañuelo Navarro wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> [ Upstream commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e ]
> 
> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>   packet and makes decisions. While doing that, the per-CPU variable
>   bpf_redirect_info is used.
> 
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>   and it may also access other per-CPU variables like xskmap_flush_list.
> 
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
> 
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking.
> 
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided.
> 
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it, bpf_net_ctx_clear() removes it again.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info. The returned data structure is zero initialized to
> ensure nothing is leaked from stack. This is done on first usage of the
> struct. bpf_net_ctx_set() sets bpf_redirect_info::kern_flags to 0 to
> note that initialisation is required. First invocation of
> bpf_net_ctx_get_ri() will memset() the data structure and update
> bpf_redirect_info::kern_flags.
> bpf_redirect_info::nh is excluded from memset because it is only used
> once BPF_F_NEIGH is set which also sets the nh member. The kern_flags is
> moved past nh to exclude it from memset.
> 
> The pointer to bpf_net_context is saved task's task_struct. Using
> always the bpf_net_context approach has the advantage that there is
> almost zero differences between PREEMPT_RT and non-PREEMPT_RT builds.
> 
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://patch.msgid.link/20240620132727.660738-15-bigeasy@linutronix.de
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/filter.h | 56 +++++++++++++++++++++++++++++++++++++++++---------
>  include/linux/sched.h  |  3 +++
>  kernel/bpf/cpumap.c    |  3 +++
>  kernel/bpf/devmap.c    |  9 +++++++-
>  kernel/fork.c          |  1 +
>  net/bpf/test_run.c     | 11 +++++++++-
>  net/core/dev.c         | 28 ++++++++++++++++++++++++-
>  net/core/filter.c      | 41 +++++++++++-------------------------
>  net/core/lwt_bpf.c     |  3 +++
>  9 files changed, 113 insertions(+), 42 deletions(-)

You did major changes to this and you didn't sign off and explain what
you did differently from the original commit?  You know we can't take
that...

thanks,

greg k-h

