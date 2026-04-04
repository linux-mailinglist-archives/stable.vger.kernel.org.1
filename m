Return-Path: <stable+bounces-233263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CDeMeKu0Gmy+wYAu9opvQ
	(envelope-from <stable+bounces-233263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:25:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A439A1EE
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 08:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85543013784
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E2B376BE0;
	Sat,  4 Apr 2026 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jakRXrjW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+wCtd9i"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEF35A388
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283928; cv=none; b=JOIwQKkn7v9n0N3pF4Jlih/P+GvjGFoK699fVpVXqTU000Br1Te5ckrIwwOmlskGuKjNGCWQIQTaiegaA++w189CM0KuXZxjc+Cu8Gu1BQGUbwh8LXmcCBRSTmlZVHqwn5mOSIEZogfAnGd1R1JiqqJxmMav9DiuZziu+hDJwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283928; c=relaxed/simple;
	bh=WCeqipRgDYX8JFLiQdVCP7EOAjcs6id/xkGu1uHRSDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJcMYtprU1W36OmkGnW6NUff4q4Mf9ox2gm8Nx7SqOlkrTUF3pybiyPtwG9n1ESIrO1Ep//u5s3Jbr+ilGF7+cZXKBUDEA2ctJrMDvRihiI8MSNEiRtQtyakMVmrMKP4AJ1yzVPeIi3d2ZCuz1/mggc+Kp7kQbU2hMLOr/H+i8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jakRXrjW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+wCtd9i; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CBF9FEC0182;
	Sat,  4 Apr 2026 02:25:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 04 Apr 2026 02:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775283925; x=1775370325; bh=B3ILSQhD2/
	QPwvhcbrlGnl8MgvFLn0x6p1EhBCFU7dg=; b=jakRXrjWGTdB4Y4H8qWzWU8GhG
	IiOARdcLl95iD9c0t+yqjIwreO+bPnCYnMJWaFXOu8X7+a1+wKaS7VTzAD3tprBw
	TIG2TT1jHu2cBuh1ge3Bbb4BXpkbsRZEdncZqcdo29Mo2RamEmFZxG8UtmcOX5uZ
	y8s3RUkHbBxNZWuUSizIAvgqhzvXFVSNuRJFxEqS2BAa6Qrci1QL8YXQJXlNplbh
	yLg/tiPbkRchXxgZtG6MAjo3llWhPkTt4GWRq1g2LVIXr5KQc/hikHTXBF7goI1W
	u8xIDXEVZX6sZpfsq+ABs30SQVm9eeAjyTCKxM74hcT7RvE+UocI0osIq80A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775283925; x=1775370325; bh=B3ILSQhD2/QPwvhcbrlGnl8MgvFLn0x6p1E
	hBCFU7dg=; b=a+wCtd9idqpFcY5pzZDHRmzF+WsS82xK4C21cOK1g79Y8O6vpmZ
	rsxt5Dl26rYWOxye287Cxs3+reyne9ioG+SPNu0dQpiyqQo7ubznRVLjsAjqJs8V
	deJ75hIe5OJ1wSCTiPntMv/Dl2ZPx6TlMcUjbtM2rxL6wVkNPNXtPPqmpb0/Ttyg
	Wl6gJ79AEGlmvkD/fco0+kA3yI9DWJmrhAjqvv6K/qoIyzQ3JnCUXeBG2Qmtl5ZM
	ujC1bR178+fGKugADbJ7SNzyemg/io3MewiAr8lo4A1EecRq7eo3rm7St9sZI/ZE
	exfLMyDYLgb02JhtOiU3MLT8aBVIap1UO2w==
X-ME-Sender: <xms:1a7Qab7BHWg-kznqJ9UoUAqh_WhZPRTQmXb0Igsslom2dgwhUAEESw>
    <xme:1a7QaaOh0VMyZROePN6ZM4l5Qyhu05WiH_48o0B6vM45dQWr_2VI4bdZdCd6jorkI
    jKkc9U1_SDHtvMATCa0fgITKpRHMegQbplQi2GZF5rCyO_uQxk>
X-ME-Received: <xmr:1a7QaZsTNMoWpfoKgImPUbhM_l4Fp2y2Vq_ngNLKTiwtOpzIWfSFulSnZqoDqm2hVJiovHUrs91AdtNRrhyMjuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopeguihhpihgvthhssegrmhgriihonhdrih
    htpdhrtghpthhtohepughiphhivghtrhhordhsrghlvhgrthhorhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1a7Qada53e12xiWs-UMsD1D-y6eAHroiCjwrodi-Hq2FNFgPqoS8QQ>
    <xmx:1a7Qabzarm8L8P7MMFIRGprLMPOOwROqMEgUiBRIWARhItm75CRLcQ>
    <xmx:1a7QaVgOFlIdwT9n7zCNckjePj6m36dTLK0RwwxAqH3EV1MfAK45nQ>
    <xmx:1a7QaXkHqzglCkKEBYswOn3OejqDVntOUNSPr-hHEcq2tmpKqWM5Ag>
    <xmx:1a7Qaf6spqsct0PBxRfEQYJetn5E8VDUR9EtI6TKqJbqJolMK9dsWOIp>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Apr 2026 02:25:25 -0400 (EDT)
Date: Sat, 4 Apr 2026 08:25:23 +0200
From: Greg KH <greg@kroah.com>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: dipietro.salvatore@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <2026040413-greedily-backlash-298d@gregkh>
References: <20260403193201.30479-1-dipiets@amazon.it>
 <20260403193201.30479-2-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403193201.30479-2-dipiets@amazon.it>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233263-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.it:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 2A7A439A1EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 07:32:01PM +0000, Salvatore Dipietro wrote:
> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the buffered write
> path. When memory is fragmented, each failed allocation triggers
> compaction and drain_all_pages() via __alloc_pages_slowpath(),
> causing a 0.75x throughput drop on pgbench (simple-update) with 
> 1024 clients on a 96-vCPU arm64 system.
> 
> Strip __GFP_DIRECT_RECLAIM from folio allocations in
> iomap_get_folio() when the order exceeds PAGE_ALLOC_COSTLY_ORDER,
> making them purely opportunistic.
> 
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.it>
> ---
>  fs/iomap/buffered-io.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

