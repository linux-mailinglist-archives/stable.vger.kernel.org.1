Return-Path: <stable+bounces-226107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAo/I0h1uWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:37:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8862AD257
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47903079B93
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A73EB80A;
	Tue, 17 Mar 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kfOSXxW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571C3EAC7E
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761804; cv=none; b=uwWSxtRegJ2TMqkenuIw+u/0HgwI2/WCIE3olZvamFjfHkRHYXI6zEDo310GjrjjdU47ZYbNfM5qg+riqlcefS+5FSf7VpBMncp0aJi0Tx1JTOXLk5RK6uxt1kOruK/PMSVOeadkq1O9HFgfXps/3ZzkLf7fBlR/MGXWJMyBgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761804; c=relaxed/simple;
	bh=x7t1tPHMU7TpXHv+G+WIFbUxKol2DlKwnbUy56i8r7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvBaD3vi3gdNG/mDz8wMty5COiHJeh2S0jgKYFA+TkDptVHz9WoxkNhaNfFbpdap0w4R7jt4FlRwNxtwU9Vi4AQcR4hqMDqcETXcr/fS6keDf040Mur0OtKAtUSNECh8LshsTsVB7b1fq2SV5GcPiQPvk5SvpM/DzCGLAvNlg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfOSXxW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F094C2BCB1;
	Tue, 17 Mar 2026 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773761803;
	bh=x7t1tPHMU7TpXHv+G+WIFbUxKol2DlKwnbUy56i8r7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfOSXxW6p2F1UW/nvAj8TXFEQ+GSb7MT77+3iTSUwiINFHABNlI9LrVmuqwSmgt5i
	 i9pJ/Vx7Si9IOq8aZCn+Ku3LwGvHGIASiCtfOk7Q8kxu/XlC537H89P0rLsjiWsjoT
	 nQSc3wEmAVW45uEwFO4mtxS22O93FHSf/BGkhCDU=
Date: Tue, 17 Mar 2026 16:36:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, naup96721@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure ctx->rings is stable for
 task work flags" failed to apply to 6.18-stable tree
Message-ID: <2026031733-machine-curator-b544@gregkh>
References: <2026031718-sulfur-overflow-96fd@gregkh>
 <07f88e01-d7d7-4e13-88de-76f460f60c50@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f88e01-d7d7-4e13-88de-76f460f60c50@kernel.dk>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226107-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.841];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 1F8862AD257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 07:03:07AM -0600, Jens Axboe wrote:
> On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> This one and the following one, for 6.18.

Now applied, thanks!

greg k-h

