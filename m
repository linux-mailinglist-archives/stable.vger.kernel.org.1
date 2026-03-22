Return-Path: <stable+bounces-227832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHr5K7Pzv2l7BQQAu9opvQ
	(envelope-from <stable+bounces-227832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:50:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13B2E9849
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE26A302207D
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC2E358373;
	Sun, 22 Mar 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="RwgNt6HM"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EE358364;
	Sun, 22 Mar 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774187387; cv=none; b=ZFiLQNFH8RevCTPW/vE2nI6lUL/s3RL2SP3GOarBIrkTDJQ0A22Zd6g8kycFv9+fvj/c9JcqfTRI7jtFhXCENPRHe8dWPZTkq70xmmcfZADgTYvihvy2ONkB4niIBP6/qxYYEe8FNg1naDvT57+Wx3eqk/4RXmgXRXm+BHKrLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774187387; c=relaxed/simple;
	bh=FVSkFX/IqiP5IlFX9L4xYVKjveHVRLXWHfeKXfoWQps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIWY1Wd7yBUezRLkhG9iQAcU565AijiVfch2JVNpfyECV1ah6NMks6Ksq4Z0UgJUwgKbT0geHzuiGro8Kce61bhVFLM+SanDMlYAIgRBXx/D+vL5I4y6rKRXvM49yDINxDqxiwKb4WmbGklJpcbpbLXxr+ktsuGnyR1jt2i4Igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=RwgNt6HM; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 59CC214C2D6;
	Sun, 22 Mar 2026 14:49:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1774187384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VMfKtiW8+Sifw4U7XzgrxZNwyJwOmTDkHgh5A/ifgf0=;
	b=RwgNt6HMuaPOAHdcU8YhJGrVXhKsNcdq9hy1/Rp3HbQ1W1Y54BbVAkwxghcRxoZ6+bCRxq
	+cohryg5leFymBaYVmxbA4hiun/IK3XCO8vhibIy+yDJC4MG9OzkCxa3iR4pUo4lJcpwBr
	ONdP5BzAKHYMlnhvr0QgdR0yI1L4Ner3Iej5tEPfLKyo1z8r97N9Ponbav4NG+wzEbiJlJ
	n54ZQ0qF9QWlIkL9pRtznspsRq7QxyuVjaHUHRf9liNFf2fs0oXQeh3SPzgbtMufaHe3IT
	xEh9t0209qUIwZcj4SibOg2ElunERI+yUnayC9mNYqv9iZj5OrFGiDpOWcu3Cg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7eb25bd0;
	Sun, 22 Mar 2026 13:49:39 +0000 (UTC)
Date: Sun, 22 Mar 2026 22:49:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hyungjung Joo <jhj140711@gmail.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH 00/11] net/9p/usbg: series of fixes
Message-ID: <ab_zZHWcM0UaIfPC@codewreck.org>
References: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[codewreck.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ionkov.net,crudebyte.com,linuxfoundation.org,gmail.com,lists.linux.dev,vger.kernel.org,pengutronix.de];
	TAGGED_FROM(0.00)[bounces-227832-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 0C13B2E9849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Michael Grzeschik wrote on Thu, Mar 19, 2026 at 10:35:57AM +0100:
> This series contains a bunch of patches to make the trans_usbg
> interface more reliable. It adds some extra checks on critical
> pathes and also solves the overall synchronisation of the daemon
> with the gadget. The forwarder script also gained the daemon mode to
> be run and recover any kind of disconnection.

Thanks for the patches

I don't have much time to review right now, but I'll try to take a
look... I still haven't gotten around to figure out how to make this
work with qemu or taken the time to set it up on $work boards two years
later so I'll have to trust you on actual tests, but it can't hurt to
review.

While I'm buying time here, I'm not one to praise our new robot
overlords but since it made the news I had a look and noticed
sashiko.dev ran on the patches:
https://sashiko.dev/#/patchset/20260319-9pfixes-v1-0-c977a7433185%40pengutronix.de

From a quick look of the above there are a lot of questions raised and I
don't think it's necessarily worth the time to answer all of them, but
if you have time to skim through them and pick up anything interesting
please say so
(as far as I'm concerned the usb setup is intended for a mostly trusted
setup in the first place... But then again this patch series started
with a security concern, so where do we start considering races could be
an issue?)


Thanks,
-- 
Dominique Martinet | Asmadeus

