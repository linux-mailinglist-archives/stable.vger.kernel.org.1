Return-Path: <stable+bounces-212719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ33MPO3emmo9gEAu9opvQ
	(envelope-from <stable+bounces-212719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:29:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD9AAC36
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87AB6303CED9
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11748331A6F;
	Thu, 29 Jan 2026 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao8jMlci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B2326944;
	Thu, 29 Jan 2026 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649687; cv=none; b=UzJ3//WKgF5GQ3vbsl4fGB0gXEtGhpP7q4py9n34QsTrhmUGP80YPYuao8STnnGBlA9TcIqVAgzsxccGStkJRQiZ4WAcYn6pcdtPUrBUS3ZNOCS87RxuoFQlbJnxjb1QPKt0OqNmssYL76G3be4I/ygDz9pdml/KR1N3jOjIplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649687; c=relaxed/simple;
	bh=T131svMu2T3ISOZCqIcwsEXJug1tYGuujwIwl9rBKfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gn0JMSUyLQTfI/PkZfg8V9YHh4kwmaVq1x77wTLnpEOx1D03Zv5HWVoGoAEcAc6Y4nXyQT2DKoV4oe0Qu0Rhazz+NNyx87NHh2SqVerMLzjdFtHT1sE+eiGG6aDiCtWTOX2k88py6ZHGFDyK2Hit2LBkRm29yyoxYOUCqoouC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao8jMlci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA24C4CEF1;
	Thu, 29 Jan 2026 01:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769649687;
	bh=T131svMu2T3ISOZCqIcwsEXJug1tYGuujwIwl9rBKfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ao8jMlciFjG/h68WfinfE4v/z5xPoxsTvbDrKSu69RUh4ufknA8/TMKu1dOPPD9Rn
	 90oj8KngFyQQWlnwJi4Cg/StF5Ri6meN/nUzeC2w3qSwEANpE1LWow3G2e/GI+TiIO
	 rPwFhPtTU3YAjLshLOX/4LejkKHv1VQNTHhVpK8AmSsvXFoslfOsmnLhRAyispehJ0
	 VFSk7tRWvPvHI9tc0WlN/aaij+bBYaZ5WZ3YCLblYaIemSQ8IWKoXWJMBLM5P8wsdK
	 2AdMSjzruOlwhU9Hw24BHx06O7iHSzkBJwFOX0aJRYWO4hNKj4v+LeFCOI9N9yShhJ
	 YGzE64w5KbIkg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 56B0FF40068;
	Wed, 28 Jan 2026 20:21:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 28 Jan 2026 20:21:26 -0500
X-ME-Sender: <xms:FrZ6aQuq_7z7EACVqdZX3ci0zIAyJtueFzEcJKkVNsKWNUxe3NMbSQ>
    <xme:FrZ6ad67b6sAjh6ruihHg7guj8rC0GQA_rpts3DEJKyS20U9H_Iw7doXjrGYnPyzq
    jy6UkjmRDN2HsVH3v0uWPXIRbiXcYb_npdNZX8nAEkLrFAElHjB>
X-ME-Received: <xmr:FrZ6abjh53bP0vL0DOCI0yIXtYoRe1Lhmtsp1TjbcQ9mCK34NteY2In7CdI9YMx77BNXtDz0IHXLt15JecSXq34TZ4I8Vseg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghl
    vhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinh
    huthhrohhnihigrdguvgdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomhdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtth
    hopegsvhgrnhgrshhstghhvgesrggtmhdrohhrghdprhgtphhtthhopehllhhvmheslhhi
    shhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:FrZ6afk6uPE3iywxH1zEpW-gAS1TiDOWABsqlS2c4e0eB4ol6DjlDQ>
    <xmx:FrZ6aavco9ZAoi9BFqVkBJwmFp52-zuLoATMaWzouqnhglAENcVomA>
    <xmx:FrZ6aVD2XQeDR9BA5MORIA-7KYHkUX4L2pjQCBlboQxLQWqEpRF_hA>
    <xmx:FrZ6afVHXxQ7onPhStf0o7jz2oQXqB5leodNkPhnklACBUkSjeSfaA>
    <xmx:FrZ6aWH_mfLUh04kv8p9nTDrvfa2t2B0iEg1Pl3mz0ol8hS9g7yCkf5D>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 20:21:25 -0500 (EST)
Date: Wed, 28 Jan 2026 17:21:24 -0800
From: Boqun Feng <boqun@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>, llvm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: Fix non-atomic __READ_ONCE() with
 CONFIG_LTO=y
Message-ID: <aXq2FOa1va0P_zu8@tardis.local>
References: <20260129005645.747680-1-elver@google.com>
 <20260129005645.747680-2-elver@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129005645.747680-2-elver@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212719-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,linutronix.de,gmail.com,redhat.com,acm.org,lists.linux.dev,arm.com,arndb.de,lists.infradead.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3BDD9AAC36
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 01:52:32AM +0100, Marco Elver wrote:
> The implementation of __READ_ONCE() under CONFIG_LTO=y incorrectly
> qualified the fallback "once" access for types larger than 8 bytes,
> which are not atomic but should still happen "once" and suppress common
> compiler optimizations.
> 
> The cast `volatile typeof(__x)` applied the volatile qualifier to the
> pointer type itself rather than the pointee. This created a volatile
> pointer to a non-volatile type, which violated __READ_ONCE() semantics.
> 
> Fix this by casting to `volatile typeof(*__x) *`.

I guess a `volatile typeof(x) *` also works. Either way, good catch!

Reviewed-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> 
> With a defconfig + LTO + debug options build, we see the following
> functions to be affected:
> 
> 	xen_manage_runstate_time (884 -> 944 bytes)
> 	xen_steal_clock (248 -> 340 bytes)
> 	  ^-- use __READ_ONCE() to load vcpu_runstate_info structs
> 
> Fixes: e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  arch/arm64/include/asm/rwonce.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> index 78beceec10cd..fc0fb42b0b64 100644
> --- a/arch/arm64/include/asm/rwonce.h
> +++ b/arch/arm64/include/asm/rwonce.h
> @@ -58,7 +58,7 @@
>  	default:							\
>  		atomic = 0;						\
>  	}								\
> -	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
> +	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(*__x) *)__x);\
>  })
>  
>  #endif	/* !BUILD_VDSO */
> -- 
> 2.53.0.rc1.217.geba53bf80e-goog
> 

