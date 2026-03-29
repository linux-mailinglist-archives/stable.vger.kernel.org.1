Return-Path: <stable+bounces-230871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLEpIzrbyGnhrgUAu9opvQ
	(envelope-from <stable+bounces-230871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:56:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8A3512A1
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B032530065F2
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B92D8387;
	Sun, 29 Mar 2026 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z77VwS9Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197D2D7DF3
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774771000; cv=none; b=ZDklnRe9JuXLubQZ1BeHjU8ZLSX7gLzC33eQ+86e8XxoOds5y75LQsjt/bVB0lQ/081h4rt/maRCZmgePUw9Wr9zJj6GUKp7S4EZNZros6JTkY0Vp0N7a9G2blrGFcsrtdWIM8lX9PKQy2BcCqf6xdZVyvabwJ/OGjRT5/5YvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774771000; c=relaxed/simple;
	bh=gh5wRY3GuNNZmcgTQzsOKcHkI2HKKXY09iKeOH2P+RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMPBSpzJM1JKO+yKFmyKFeTSujtg/zEV6LHmilpU+5eBet42KsCpGqiOTF4BxJzVaiwqc1/4ePzzdhEt6YfGq3r1edwEnTaHJdO0lHT0WVYnRGObBpNNk3ZumDYPv8uz7yJwoExPTJ49MDP9MQytsc8yu9GsRq1pOIAY1lM0/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z77VwS9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D023C19424;
	Sun, 29 Mar 2026 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774770999;
	bh=gh5wRY3GuNNZmcgTQzsOKcHkI2HKKXY09iKeOH2P+RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z77VwS9QGTBA8+NdYpiB2geGlXnXOpKjnjGqUgAFR2dcQII2199EVvxNRD2xZIngV
	 nKOYkoawSpcmaekgaM2LeDxu2ZAqw4ubz/qlWZDfshYmQGMnVlGkOk59BlgGWVivEK
	 I2gE9+1PID+eEP5y2/D0tV6Wf/yAj49WRbe6u1p8=
Date: Sun, 29 Mar 2026 09:56:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Changjian Liu <driz2t@qq.com>
Cc: stable@vger.kernel.org,
	syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+77026564530dbc29b854@syzkaller.appspotmail.com,
	syzbot+5054473a31f78f735416@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Junxiao Bi <junxiao.bi@oracle.com>, Jun Piao <piaojun@huawei.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mark@fasheh.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] PATCH] This is a backport for 6.6.y.
Message-ID: <2026032927-graded-singer-06bd@gregkh>
References: <tencent_2A43212936E23BCA7ED345CADA51A8B2390A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2A43212936E23BCA7ED345CADA51A8B2390A@qq.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230871-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,yandex.ru,linux.alibaba.com,oracle.com,huawei.com,gmail.com,suse.com,evilplan.org,fasheh.com,linux-foundation.org];
	TAGGED_RCPT(0.00)[stable,1dd53396e7124586dca9,77026564530dbc29b854,5054473a31f78f735416];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34C8A3512A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:44:22PM +0800, Changjian Liu wrote:
> [ Upstream commit e1c70505ee8158c1108340d9cd67182ade93af4a ]
> 
> ocfs2: add extra consistency checks for chain allocator dinodes

Your subject line is very odd.

And why just this one branch?  What is the reason to do this here?

We obviously can not take a fix for only an older branch but not a newer
one, otherwise you would have a regression when you update to a newer
kernel release, right?

thanks,

greg k-h

