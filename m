Return-Path: <stable+bounces-247816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGL5HSY5B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:17:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E95BC552030
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84824302D1A5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F63A961A;
	Fri, 15 May 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KGzEdeeQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vUUYdJJV"
X-Original-To: stable@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44931717D;
	Fri, 15 May 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857784; cv=none; b=fHeQp8V1e2iopfJq8QO+E2IaTPy41KcaN2HpVDzw9ic3lxFtFTZoVdVxrLusDpxuA5hU3ZUd4W32rHP/EMhUD0I3SOr7otMaSjxOtuM7qllPE3ItakNCKbQWtPbWtmE0sCYqcGdEaFgktitaBYj5bZ22r1CxiO52KyJFWs/LhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857784; c=relaxed/simple;
	bh=dkn0TtI1JIYmVtLXucZcaKg6rPFYOdSY2dvK/U8IBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeMfPHXeR0YJ9Rc8iGQP1EsNX4xUd6zCk5DZW4B3Y5RoDs0sHlClZSRpfAy4XDjT/YPzjxHhZHQGTJBOPaUH5jLeDPJkv2GjLSHF6EwUEnA0feG9EEorToZwcfUa/5KtAmPtjegcmIh7SHrnyiJZmFiW4hNUyuCowAlhmBx4joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KGzEdeeQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vUUYdJJV; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 9610D1380407;
	Fri, 15 May 2026 11:09:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 15 May 2026 11:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778857782; x=1778864982; bh=6+an2USdyD
	9t0kgsNTq9hUpwB+SKKvHxpjWKIph/mlA=; b=KGzEdeeQavICjW/L3u3Z93W2g8
	NAxIjNbOg8evVayx7N1VVfB7a2juK3pM1a//LIl3FmSqp5F1DMJBaUQGyL+19yMa
	B7+Ed3WgDLqB3ZTceDTfDiMoh+J4xIVVASRwY50MUzt8ztc1EwJGu5VviQiw5pKD
	MvPA4G8H+Tw2/EPjSoxVmp75Xh5xyU816ITRNEyujJFobcVbLMnbaPoXoSfdG8ER
	qPvDXiyPkK69U9FNwxBWfTYqOLJPJtCVHO0wkDCrUekvS7OB9jhpDeImmqksNoo5
	1Sd+Kh56lUXUT9gYZcZbw1t2tNissveJpJ747VOiov4raFYMH5NmX3ghu/ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778857782; x=1778864982; bh=6+an2USdyD9t0kgsNTq9hUpwB+SKKvHxpjW
	KIph/mlA=; b=vUUYdJJVvh5OK+i2gylaeiyDEMAXACk1sATJPY8dhMCzjdBxFgg
	hmMo1AbgSpk29vPC4KSkn2CInPRj3c/qxF+W5xYBPDwSLDOODqN47KM6iQmPCg5t
	GYNijgCBaLnAdic+mhBP03guaePTJy/hbMzYSyIdkHyVhqi7vGuTaq1BwUURePKy
	py/NBZGofXszH8b5RsaifW93/BA+h0eEm002YQy+RHIKU3asDwqgexsfr52UDFCU
	yhLEued3eECb2E1VPej9JCIOXk5KTdkTLnqs1CFL1vM6kSaXT2BajjO5UPCyUcN/
	oqxuQnt5NjqIXWyu0wvuOFYW7UIw0+b+t2A==
X-ME-Sender: <xms:NTcHaje7IIqBxVKZPAAzW4V_LOQ7X-Z7lDScjGGDUx2PN7ujce6ThQ>
    <xme:NTcHaqZz-r1Y7X6OSmO3q6IOARRj_N2fn-9Mzu1IWdz9gt_Ex9zwszVKqTwA-TEFl
    6vebV2RKYJJ0p6IOyNPLnhDIUlRNN-OOXe5MLn0WAeja8yyPQ>
X-ME-Received: <xmr:NTcHas9LTV1JdCaUQn3NGJCamgUR8vdIwJxR2mM0uSmBOBY-mDC5RzHXhyMSfSOZp_5PsX77EYXKi4igqo4Ifw925g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
    dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepvdeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopeifudehfedtfeejgeeitdeivdesudeifedr
    tghomhdprhgtphhtthhopehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtoh
    hmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgt
    phhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrg
    drshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhh
    ohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrug
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgv
    rdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NTcHauXEJA1qP7mTKyzVroESBYpnF3U4eoKqj83czwDsh-7SfGSYqA>
    <xmx:NTcHalf7Duf17mC4s7AxmtNXF9Oh5SzyVhb2CaWV_qVCTSnHt4_YJQ>
    <xmx:NTcHajUObWtXqhtOvuYYO505ENApFTyI212b5lehZGIi_aRzFiotiA>
    <xmx:NTcHasUI5cG930eI6MKcOysUDGNJF1Qw_O3DMif7eNhE0lw6pNOMWA>
    <xmx:NjcHal-kYPCNLu6CUnLfCgl18ln9nyoGAj8XklDYFLojdbAypt-_bTbX>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 11:09:40 -0400 (EDT)
Date: Fri, 15 May 2026 17:09:46 +0200
From: Greg KH <greg@kroah.com>
To: w15303746062@163.com
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
	melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable and
 timer callback
Message-ID: <2026051557-thermal-petite-7da0@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515131826.388154-1-w15303746062@163.com>
X-Rspamd-Queue-Id: E95BC552030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247816-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	FREEMAIL_TO(0.00)[163.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kroah.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.807];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,kroah.com:dkim,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 09:18:26PM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> [Note: This patch addresses a legacy VKMS implementation deadlock specific
> to older stable trees (e.g., 6.18.y). Mainline has removed this code during
> the generic DRM_CRTC_VBLANK_TIMER_FUNCS refactoring.]

Why not apply those upstream commits here as well?  No need to diverge
from Linus's tree, otherwise we will end up having a mess that nothing
can ever be backported to.

How many commits need to be backported?  Have you tried?

thanks,

greg k-h

