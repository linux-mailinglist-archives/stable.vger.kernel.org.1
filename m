Return-Path: <stable+bounces-249243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KMIFsLeCmpV8wQAu9opvQ
	(envelope-from <stable+bounces-249243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:41:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F6569EA0
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7E4301F752
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B95B3E7155;
	Mon, 18 May 2026 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="AzyIuR7/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uYSDyxbc"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E33E6DD0
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097026; cv=none; b=JMIXf0hdZkV24cQHfhHkCBoAqmqdDx/Fmi8JpIUJxgpD4Ctla8ywqvK17rCvBSmj70Z6jLto1GH0XtCQqI1w9OpyC08TEK0jd5w7xBegHdrpmaxZRnnLSH3tKCscJ6wxNRYLuUywZreZTsb93eTjyf/iFP6c9axOzCUzE6EyOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097026; c=relaxed/simple;
	bh=C2eAUMQzkspgyIYPu7y3O5GELP3olRF7Sx+MxyERIOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z41EClJLxZWHVnPNeocQOc+iurgHGZCQb+5/6aWPPAt7HVC9XFDhc/W1kVR1C4o5vdngjFnWPKY61uMEBBfpx3SJ3MwV8SEp3rBbnRr8RqXbMjRwl2N//id7hzhwSvg+R7z33rBhQNxwVGodgiCOJzGEtamdbhC9h6uTN6hVQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=AzyIuR7/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uYSDyxbc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 982AA14000FE;
	Mon, 18 May 2026 05:37:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 05:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779097024; x=1779183424; bh=C2eAUMQzks
	pgyIYPu7y3O5GELP3olRF7Sx+MxyERIOI=; b=AzyIuR7/SqL1qgRX76dfjdXz9z
	ZrpZTjonGjaFwFo+0egs1/Kw56oTHiYQ3hpMORMy5xF1fQo/xpIElOpJUNYOTpnM
	V4tCws2JyptUo+IK/6/m9b+LOokyk3BffN6T2IAOuF5JsEnwNF8MBfMwDoaq6sMM
	U6yKgIbYuT+aoHeF/twIUJV+NCql6aiv47zUxYk7O234BdlbbNZLGKzQVnMIf7pv
	t35VlyH9wyKqfNQuz4BXIhJ5d2utormtlhnp440s00wyB0KRghW77RxiQnoo/72W
	a138uwVLROgYRJq8EMsbtbKRwdKzKoIvk7TxiFvj6WGK5lT3XBCQiAmF2xcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779097024; x=1779183424; bh=C2eAUMQzkspgyIYPu7y3O5GELP3olRF7Sx+
	MxyERIOI=; b=uYSDyxbc+J4cP/B44simd7aeE53yxpVDdJ0GGrmBDYzAFgW77ZC
	dXS2y3XcXtQXzvYWVdhphZxMW4yd8JoRsMM4/ORK0Dayx1kaoS5HnkEiQAqFX4Jp
	Phk9fRe4Hw4rWgRdbaa1s3Z38B9dRxO7ka19ow3YefMjlQmzRCAp20WuGQUiP0hy
	IssRtF+bRF3yoPRDpVhwtS7d0RnQwjdKvJ4oUiaAcPouUIG37fT9nPuMxK3cAbgz
	NQylNmqtWbSnyx7j08gs2xxKsxkyGf4x2tNpOtIgyy3SkQ16HmKZI4mtuz4DCgsW
	lYdOFUwNbCCsn89l6nJaWbgf12+0oFGHDyw==
X-ME-Sender: <xms:wN0Kant_o2wkLi4-bJRDRIVxrztUsh2X6sFmXsOmju86nAEu6qoUNA>
    <xme:wN0KamTXqS7SacsBbcVi-vyRVjAOevq7iSAJEFBrEn2m2BMiMlzVXo8r0ydgwuNnS
    QNV7-QlgKhofTTzUjv6n6O4rbfZbCL_Zk4OmPZAzN7_qXkg7oQ>
X-ME-Received: <xmr:wN0KalPDRWuapeiSLyjrFxLnk_LB9iI0aTWXHp6zGbWppbGaCWiSBAms4gTFOAwpwx6k153lgUpGRZfhDpNyGyXfuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
    dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigrdhmrghosehsvghnrghrhihtvggt
    hhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wN0KajYKS7OLq14BW58KsGpHYxBsYN2sFA761b3bvW692qXV5flFQw>
    <xmx:wN0Kanzw0ocKc41yda9FJftEymWfg0ihlg7ZT16N2OllNZ23ORwT6A>
    <xmx:wN0KamKzXK7wMJoEEcJcYaKU7gpdQFj_F4RthsG1vRHVQ692YCEDZg>
    <xmx:wN0Kapr_DIRsVausut3eZwlUt7uHGxtY-OX6EbyZwKimUsU8vD2Yuw>
    <xmx:wN0KaiQTQO0tI93m3EZACNjMB39lcT7FK-BGCtd3Ffvuq-dvc2-TLsUG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:37:03 -0400 (EDT)
Date: Mon, 18 May 2026 11:36:18 +0200
From: Greg KH <greg@kroah.com>
To: Mao Weiming <alex.mao@senarytech.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] cpuidle: coupled: Fix use-after-free on device unregister
Message-ID: <2026051853-stomp-attentive-56ac@gregkh>
References: <20260518064324.3240-1-alex.mao@senarytech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518064324.3240-1-alex.mao@senarytech.com>
X-Rspamd-Queue-Id: F05F6569EA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249243-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,senarytech.com:email,kroah.com:dkim]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 06:43:24AM +0000, Mao Weiming wrote:
> From: maoweiming <alex.mao@senarytech.com>

Please use your name here, and for the signed-off-by: line, like you
have above in your "From:" line in your email.

thanks,

greg k-h

