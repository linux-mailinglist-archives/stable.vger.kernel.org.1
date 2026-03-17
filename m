Return-Path: <stable+bounces-226103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOR/BwN0uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:32:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 971022AD168
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 222A9307DC5B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D02D8DC3;
	Tue, 17 Mar 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OgwPPb0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2JH+M2F7"
X-Original-To: stable@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339E273D6D;
	Tue, 17 Mar 2026 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761375; cv=none; b=WdKX5pEgUXyVWKBMJbMIAjyx8Nx47wjvpEtD7HHrcZQBY7RU1yGtj303gggvJ2/4VRHpcWjdrH4ydM/Qs2ZnvaYgK4isZvRIC6mJIraMi4+Ejj9zOWIxOWzmkHLHk+V/lTc7Vmp3KSd/7epvpI1iFEDnkTbdqedH2FmlweYfcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761375; c=relaxed/simple;
	bh=2eJTay2d9EEP26tPfX977a3Jnke4ZtzoPn9A2sDVPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9FVy3dZZx9lXxv/scXP0ZQOGc6ULKYkwzO5lQRj5EpFGw91aW8nO1t3uMGb+BPE3AhBG3XNrnFtItKzvVWMcXhWaWv7uWWpVA0iI9mSVTCi1ZQ/MpPTRc6QAnzwLnXA2LW9gFc67K857LG3F+ROe3cYeeZl1XOpIVaXVPzHGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OgwPPb0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2JH+M2F7; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 30F321380112;
	Tue, 17 Mar 2026 11:29:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 11:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773761372;
	 x=1773768572; bh=Ebmfw7d/8Oqg4qUJ6Zpg4finw6YGv2HcTL29//ngiFQ=; b=
	OgwPPb0NwEtbMDwUIbXN//EqFH8bOfTrF/2EMjQr8U+ClNGxrkhpCRqWeVQ8WR2r
	FIAEmYgJ+a5TEtlwQnPHfSZIqg+HbdvjbXR2YibAquSO813J07xKhPMifxuOc55F
	bDYiXp3RMj3uGKoU2KOA7dVknihiHenZusSDPqclO06yOOHGO+VMNcF7y0Vvdjn/
	FSGCVUp5mO6BwbOC5bVqggUByJE2n2HJUGcdxQEULAKpUJlWc2/Z4XJr4O15oOf9
	CImmZw/PguFhW98l5KgJU7zFcMlDiwFsjtVHWeioK7s1VnIvlIs6Sx0DgeEGOT7e
	smyhL2l/tY7I66nO7jKkVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773761372; x=
	1773768572; bh=Ebmfw7d/8Oqg4qUJ6Zpg4finw6YGv2HcTL29//ngiFQ=; b=2
	JH+M2F7sVf6DzLqFRliU3f/BM6bcapXYTDjjpXz8Rtt/jS+MNMOWwqhtvEisggD3
	7UVwXAtd92aoIOT2+V92e1QByy9i0B2aB8nss6JjBfZuXmOTMHu52qiRN89N3An6
	kKo8DQ3nTtPZCaICs+ev98UgzeCEMUgaEaJDVs5kx0uAwEv4pNq+Adns428Xpuf3
	2D96yg7824iDULkAy0TPc92ndXvOiwEuqLHNIsYudeRxQRdHqcgeaDuKpbxmCrkX
	xGEYfUhGMXodjV1RYDf2DJZtCCPGxagOLtbI3QbHDiD76hGsulQ25x/sMl3167dx
	AjfJUOaVIx/cwJ3oTxrgg==
X-ME-Sender: <xms:W3O5aWTztvP_5jcqRUNJksOD5sbm5F0gNHlqxMpXd8f0ze7asCM7eQ>
    <xme:W3O5adaAilEYgCk6nwcgbA7LFo7Mmff1txX4O_IX2S57sV53WqJeaoOh73VIUZwZy
    kSntZ3rzr3lCNeZLv9oRa2j49mo_VLoSQOOws48zupvbGC8cw>
X-ME-Received: <xmr:W3O5aX4Ew-fxbPtRmWhhR7XplvXVFr9sRcJlulTp0CIpqUD_g5M1bIZFZ2KAnONH1o5NLm1IzNcXFHr6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehje
    ejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhithhlthhlrghtlhhtlhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrohgsihhnrdgtlhgrrhhksehoshhsrdhquhgrlhgt
    ohhmmhdrtghomhdprhgtphhtthhopehluhhmrghgsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrsghhihhnrghvrdhkuhhmrghrsehlihhnuhigrdguvghvpdhrtghpthhtohep
    jhgvshhsiihhrghntddtvdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrghnse
    hpohhorhhlhidrrhhunhdprhgtphhtthhopehmrghrihhjnhdrshhuihhjthgvnhesshho
    mhgrihhnlhhinhgvrdhorhhg
X-ME-Proxy: <xmx:W3O5aYfESxLsRjZ_1gWRXF71QgMmIh2iG9A42VPufiuWO5jqt4NQjg>
    <xmx:W3O5aeeTQuk_e3NPfRzN2Fc0OdMrSbY9YHuu8_Vo9XNsqStjWspkpQ>
    <xmx:W3O5adF2f886kaWhDnpO3WEKdSkEoC-ke4OF654pdUYoAC0tJ_OMsQ>
    <xmx:W3O5adFt3fyILQohATWxi1WWK0r1KXJSlr3nS87UZh_D0whEqcZh6g>
    <xmx:XHO5adVvF1skta8cUfez7csbHMYPAyf6WVpr_COUFpWDxeoRc467F1X5>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 11:29:30 -0400 (EDT)
Date: Tue, 17 Mar 2026 16:29:27 +0100
From: Greg KH <greg@kroah.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/msm/dsi: fix hdisplay calculation when programming
 dsi registers" has been added to the 6.19-stable tree
Message-ID: <2026031721-sauna-unbroken-a8a2@gregkh>
References: <20260315143921.23136-1-sashal@kernel.org>
 <CAH2e8h691mMOC=3FgmvT4QnwynYb8JQ6VM+x17m4xuUHNbOtkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2e8h691mMOC=3FgmvT4QnwynYb8JQ6VM+x17m4xuUHNbOtkQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226103-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,kroah.com:dkim]
X-Rspamd-Queue-Id: 971022AD168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 10:58:00PM +0800, Pengyu Luo wrote:
> On Sun, Mar 15, 2026 at 10:39 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     drm/msm/dsi: fix hdisplay calculation when programming dsi registers
> >
> > to the 6.19-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      drm-msm-dsi-fix-hdisplay-calculation-when-programmin.patch
> > and it can be found in the queue-6.19 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> >
> 
> Please drop it for all stable trees, this patch has an impact on CMD
> panels. Fixes have been submitted, but not merged yet.

Now dropped, thanks.

greg k-h

