Return-Path: <stable+bounces-253861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BDgFLUbbEGphewYAu9opvQ
	(envelope-from <stable+bounces-253861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 00:40:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADD35BB2A4
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 00:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6D2030022B8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B673911A1;
	Fri, 22 May 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kFtaUk7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pCv5SiD8"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B08255F2C;
	Fri, 22 May 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489598; cv=none; b=stESaEaXMyCtDCIhHBJA34d1H80MCLRNzjT/EfT/YajGPhc/n7wAz4JKGGWT6OnaIIHrmaWrli9x9sDphB5xqzB5MLcrVKbNc26Frt5WHA+Y69vqLaFCMxnqVVSXYItbcOo9zxN69nGfdxSjhLnJ9erc//8FMq7GQFOEDsf9Nv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489598; c=relaxed/simple;
	bh=CttPn8E2TPMMdk0hwN60pM8Lr768iCL+Qf9AMXjLblo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUuKKGbWzLJVyOGECl2YY26cglhDVAl8drpi2eDhR5GuOoJtBZWtQqP/WnbBjrwjl2iPDoiAWsViERqIz68YGxuJyzy/Q6EyykWjQKWCO+91R01vHV8XkcZbhf61uGzgQj9v7fMK+aOXHAqoevEwwgc4nGisP5GfgKnwBfAGS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kFtaUk7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pCv5SiD8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A28CEC0193;
	Fri, 22 May 2026 18:39:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 22 May 2026 18:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779489594;
	 x=1779575994; bh=gfFIxlG9HHja3KQEtD3lr59SmZJPYsTMMcRRfd3BiJ0=; b=
	kFtaUk7tLVW8vScS3M5vjrPdhMe+YlCQNieFZxrt6TCseVgzi5fuvVmx4VmA+AnJ
	uc8zQYMiXhY8eujfreBcndJU0XtuOJe7ecBRtslqROfS3JWOHObpJDWaPFhBjhMB
	qGa6Gx9vnUiduQV442immP6rXEo9iOU/FAEHKE3wqAPPUg3A5r58Ublw6soUaN3H
	2Iqb1d2WMr51l5BCspA8URvkzcBs1k1yU+5qTa8/K/tpvQKvRG6BnG35FSkumSnm
	bRzxUGy/ufuJlG8uYnZ8dZsnGUzkcTJzqhDi/xGPe419v7Yh0j0ih2+WZJZ2/Z83
	P6W1nOuelrLBgCxuFKBRCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779489594; x=
	1779575994; bh=gfFIxlG9HHja3KQEtD3lr59SmZJPYsTMMcRRfd3BiJ0=; b=p
	Cv5SiD8V6VHiYRV8JFV5q5LQ/zg8a+9+eltRu2tAiVV9wlxxPhFoqqfADsVjGZ3v
	BmyfGZPEyV8uG86x2lSNKD5l7U6Wpc/5vxGeyvrUQz0KaalXpLkv5VGV/Rxrk7of
	Cqs4XThAOzNg4BY/puLpz4FE+b/3kfFaB2D0/c20vtTPTT1c9CF6hg1fZHvfL1ed
	OxQzDYeVfTofAvwUY7LMfgNw2OWSwE5PpD4J2Ff4TIktrqjIAvnlZst1G7wbC2nr
	xwJJs0MU/1P+dC/8Sn+n2bmFDXzfVRBq+z/MbQXwAaLPshIvoFP9bYMHAd+wDbIJ
	n8M7KeIYO4ANSdz5OjLOQ==
X-ME-Sender: <xms:OdsQasCTCpkbU7znb6sWN5ENRyqX0U_1MRwShqcJaxWA74WH-TY0LA>
    <xme:OdsQau8e4XCOIPDF75QCQGtUyVIAB-K4f_KJqvMiCmzf54EVKuMqfsqXBrraVU8r1
    32RLu5gFsVHxHZ_-hepJXGLXzV6NcZWueNk41UJx4q94K2rJqMgLA>
X-ME-Received: <xmr:OdsQagTi_-BDoamc68eUXQMXtkSpf-ASv_CaIq2dO5m8jNOiY9f7R1YgOww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrnhgrnhhtrgesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehvihhp
    ihhnshhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrhhhihhlkhgvsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrd
    horhhg
X-ME-Proxy: <xmx:OdsQaqW6fv0rYHrfUq7d_p5ft68yHYeGMbDu-c2NIdDxLWobikdYaw>
    <xmx:OdsQaiTvZ2SAx3tp6VCdkWPHMXWiqCXVjN6W4CmQK1nzEMShDxADYg>
    <xmx:OdsQaq0rwP4PJrpna_eAidWy8mT6OIjcftm23EWaL-volFeMwwKRsQ>
    <xmx:OdsQaqfeqcT03ctoqy4IYDHUPSBV8soJer_W-w3FgN_OkWNpIz5Z9A>
    <xmx:OtsQar-hdseXanXjtXJoiXBwoqiJnGA2Vt62e38j7r_IEa1ptebV58PF>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 18:39:52 -0400 (EDT)
Date: Fri, 22 May 2026 16:39:51 -0600
From: Alex Williamson <alex@shazbot.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>,
 Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jason Gunthorpe
 <jgg@ziepe.ca>, alex@shazbot.org
Subject: Re: [PATCH v2] vfio/pci: Use a private flag to prevent power state
 change with VFs
Message-ID: <20260522163951.4ba46ec6@shazbot.org>
In-Reply-To: <20260514173449.3282188-1-rananta@google.com>
References: <20260514173449.3282188-1-rananta@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253861-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,shazbot.org:email,shazbot.org:mid,shazbot.org:dkim]
X-Rspamd-Queue-Id: CADD35BB2A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 14 May 2026 17:34:49 +0000
Raghavendra Rao Ananta <rananta@google.com> wrote:

> The current implementation uses pci_num_vf() while holding the
> memory_lock to prevent changing the power state of a PF when
> VFs are enabled. This creates a lockdep circular dependency
> warning because memory_lock is held during device probing.
> 
...
> 
> Introduce a private flag 'sriov_active' in the vfio_pci_core_device
> struct. This  allows the driver to track the SR-IOV power state requirement
> without  relying on pci_num_vf() while holding the memory_lock. The lock is
> now  only held to set the flag and ensure the device is in D0, after which
> pci_enable_sriov() can be called without the lock.
> 
> Fixes: f4162eb1e2fc ("vfio/pci: Change the PF power state to D0 before enabling VFs")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 17 ++++++++++++++---
>  include/linux/vfio_pci_core.h    |  1 +
>  2 files changed, 15 insertions(+), 3 deletions(-)

Applied to vfio next branch for v7.2, with the noted bitfield
conversion.  Thanks,

Alex

