Return-Path: <stable+bounces-244842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APL1CCNp/mmIqQAAu9opvQ
	(envelope-from <stable+bounces-244842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:52:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F514FC7E6
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E6B5301D338
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9F43A3E75;
	Fri,  8 May 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHuMjBS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82F3921DD;
	Fri,  8 May 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280730; cv=none; b=BfUKvkJlk7tPGFBRuhO9kiUqwP/SyprSif6MYftftc1z/hXDmrbnroI0mZcLkG95jTKSboQWPUDttBsRTBHWGTClj4HINfsuDr+YKMaiNZ0yt4i+S1oKXzdE2dYkYTvjmfwrzOmeD82jHRumcGlsVhoYHdUuGP39fDhB/qHezsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280730; c=relaxed/simple;
	bh=bhmi7LG89LdMljx+DWl1+hk1ycj+/3RF95+Uws7lk/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBKRl9Sq3wSVzQTyaec7AF/F9UMyKo+11I8/cYMNz/cJD9w1GtCyIMPNkf8YeEBreLxgWs0kdhH11npnZQxUHtUELamrmXTTj+sX1YBJ6YKFhmmCvvk86t0RWre+QiJBgupwbYEZLRtEPpBtxF61i0JuyFw0aTDw39ZBMX/49uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHuMjBS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A1BC2BCF4;
	Fri,  8 May 2026 22:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280729;
	bh=bhmi7LG89LdMljx+DWl1+hk1ycj+/3RF95+Uws7lk/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHuMjBS5Tsq/lJmH7MakJDL75QQcnA26OS5wYJm0+7zQ3fFqegtFMYHg7rkunCFHt
	 w6eaOXDrs3dIJyb+8rC79HaM0A6YWdcWsNozQr3VOFvDH4YmzNfg6Rh1EDHz8P6sqW
	 u/UAMSYPMDYq5d98/bwqe/iO13ReK3LjjlWPNvvSAdMWjiLZTm7ewAferPxfuYpsmp
	 nmBKV2VxUIerFRhWo4/R8zf9lW5RGllw6Z8q1x68/RrDAF7OdrPP9HkFMBct2yhCAn
	 ySLAzLgvycJxVRhovP4CpMCDV0WmPbwDidRs37G6T1oTAQk43JqHvRNqRUmepR+h3U
	 haaL8xUXeIivw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC78DF40088;
	Fri,  8 May 2026 18:52:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 08 May 2026 18:52:08 -0400
X-ME-Sender: <xms:GGn-afmdbuStsZ7fzkp8V3lpVP7nsqvY0aixwGT4AyN5mL9roqHZow>
    <xme:GGn-aTkCBnauEyHxZEJTqw3M2cVnYn_oOm961V0D_QY1d9QlDAmGQc1kOyjF1u8G2
    M5mN-S5kTSj-En_Vq88P6nWW5Q_hFx76rgynp6M9JQin_2YMsN2BCg>
X-ME-Received: <xmr:GGn-aehX305_Hx15uTetnpLe_urT874hphqnU5CAyWeiZPDXmnx1uTEQHA6txQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvggu
    hhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhope
    igkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhm
    pdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepshgrthhhhigrnhgrrhgrhigrnhgrnhdrkhhuphhpuhhsfigrmhihsehl
    ihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkhgrihdrhhhurghnghesihhnth
    gvlhdrtghomh
X-ME-Proxy: <xmx:GGn-afdzkb2aopPKiN_5sneQzyq_61Qw9O0gOXpg_yBzNMw2x5n5RQ>
    <xmx:GGn-ac-MpFn-mTPZB6jOLXytSOvIWqlN3DJL7ZLP9zkXlRXdACBv0A>
    <xmx:GGn-adhdeal6iqmtCOCuXaytwCDWmr35PnzgeKcJgFRSsNTvWKIwsg>
    <xmx:GGn-aY-_8QfSdHchfSdPO66NLNzNA7AeWlRQK4OlZ_xiFQw_ivdyAg>
    <xmx:GGn-aWA_UPg78nmREEaBrrfFEPshNd-JeN9_Qsze7omac1mj3SO5accw>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 18:52:07 -0400 (EDT)
Date: Fri, 8 May 2026 23:52:00 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/tdx: Port I/O emulation fixes
Message-ID: <af5orHTGMRfD5TxP@thinkstation>
References: <20260428125632.129770-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428125632.129770-1-kas@kernel.org>
X-Rspamd-Queue-Id: 91F514FC7E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244842-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,zytor.com,intel.com,linux.intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Apr 28, 2026 at 01:56:30PM +0100, Kiryl Shutsemau (Meta) wrote:
> Kiryl Shutsemau (Meta) (2):
>   x86/tdx: Fix off-by-one in port I/O handling
>   x86/tdx: Fix zero-extension for 32-bit port I/O

Dave, could get them applied?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

