Return-Path: <stable+bounces-240483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFVnIKAT6mmytQIAu9opvQ
	(envelope-from <stable+bounces-240483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:42:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78194521F6
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A29A3009CF1
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EDF3ED5C7;
	Thu, 23 Apr 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fUWwZdYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592DC37EFE7;
	Thu, 23 Apr 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947891; cv=none; b=tR9PVxZc3+MhKkBCJRzdGLodVlvR1GH4R6Ij/2f/M4mLI5NBMJkz1EQPedzJXV96ftIevHbefC3WZ4MRy6m4jBhTgj3i7JJeVkdeiVbTgqnC/QD0f5i7Ah/95cWAiQa9cTt6wEAFPyZ3TVP5/dXfxGg8ftGQ2PE/pxqJpxjGdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947891; c=relaxed/simple;
	bh=0wF3XFc/Pzrua0msqoMlUyluVfOy/Wgtpj3qqMErnHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaK5djAX5LMBRRhQ5FIZdUP/7EnI4fWaO3WF9Ycj/mi9Q8R4eqMMo7tekuz9C27sDSEzJ3vrHEw7sLKcYr/BuPHdXjEvcr4f/pe9AxKTppIe4CnrVKUMIqobY4FXcOcZcg8fyOeraL7wIZZib1vKTw9haTW6ksy/XH+qolbiZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fUWwZdYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21C8C2BCAF;
	Thu, 23 Apr 2026 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776947891;
	bh=0wF3XFc/Pzrua0msqoMlUyluVfOy/Wgtpj3qqMErnHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUWwZdYJXOIeMfmgWW+637SajL/ymLGfyE3FpK96J/cnmS+TKEk4iCJxtbZPj56qZ
	 TGAYk2YzXLUQFa0/xhNPAUhNQiy3vitPOlr0gVGS6BFoD2gaGt9pvC33KbWvmvRC/U
	 l3OK+YDqQKj0lQozNQSQ+XYq53rWFVTc+Dyq85e8=
Date: Thu, 23 Apr 2026 14:38:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <ben@decadent.org.uk>, stable@vger.kernel.org,
	patches@lists.linux.dev,
	syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
Message-ID: <2026042354-doorstep-stray-0fe0@gregkh>
References: <20260413155819.042779211@linuxfoundation.org>
 <20260413155837.438151458@linuxfoundation.org>
 <d4b85e905345dc69e9c660c7f51775703fa83320.camel@decadent.org.uk>
 <d7d521e7-35bb-463b-b1f5-552bb931bdff@kernel.dk>
 <3512c6ae-0b99-4c50-89ed-f1087a558a25@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3512c6ae-0b99-4c50-89ed-f1087a558a25@kernel.dk>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240483-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C78194521F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 04:58:52PM -0600, Jens Axboe wrote:
> On 4/21/26 4:18 PM, Jens Axboe wrote:
> >>> @@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
> >>>  		if (req->poll_update.update_user_data)
> >>>  			preq->user_data = req->poll_update.new_user_data;
> >>>  
> >>> -		ret2 = io_poll_add(preq, issue_flags);
> >>> +		ret2 = __io_poll_add(preq, issue_flags);
> >>>  		/* successfully updated, don't complete poll request */
> >>>  		if (!ret2)
> >>>  			goto out;
> >>> +		preq->result = ret2;
> >>> +
> >>>  	}
> >>> -	req_set_fail(preq);
> >>> -	io_req_complete(preq, -ECANCELED);
> >>> +	if (preq->result < 0)
> >>> +		req_set_fail(preq);
> >>> +	io_req_complete(preq, preq->result);
> >>
> >> If __io_poll_add() returned an events mask then it completed preq, but
> >> then we also complete preq here.  Is that really correct?
> > 
> > Let me take a closer look, I do agree with you that the final result
> > does not look entirely correct.
> 
> As far as I can tell, these two should be applied to 5.10 and 5.15
> stable. The first one fixes an old backporting issue that I didn't
> notice until doing some targeted testing just now. The second one should
> take care of the issues that Ben spotted in the current backport.

Now applied.

> Will be nice when 5.x is finally taken out behind the barn :-)

Totally agree...

greg k-h

