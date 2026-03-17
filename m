Return-Path: <stable+bounces-226127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG1oGAGCuWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:32:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE62AE051
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C36B3012214
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB4376493;
	Tue, 17 Mar 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdgAG40w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9936C0B9
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765119; cv=none; b=cYpKU+qhmNcg+wOYPuUS7nQHc9mGx9iROwFJo7+n5xPFz3DQF291568lU6T2a1iWwhBCX0t2P2i/XvtyTYvZDRIoVVxApcFJf/u6uWkbwypeniXFtOu7OHWgL5YbZHEGJrxILKx3aK7rm9RNINkpA0jcpv4Evbihnoe72JYWXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765119; c=relaxed/simple;
	bh=zquTNZu/l1FixYNVvBaedBoUjj3mjfpveT0rzLv4w9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUpFNw7PrUs5C+sb/2dfdBEDtrj4cExwfeZyhLO6cT1VvjrLYwvaLcXYdc9H4g53e28BxlBw0Klcc1GZhHiHRVVo4JuAKstVTD+b/S4y7sKmgfxsr3f6Qu1mv2f7MeH3xOUOHWtLucTZtffWEuY4SOOoWdDGyvIcWjq2OrlsNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdgAG40w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF06BC4CEF7;
	Tue, 17 Mar 2026 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765119;
	bh=zquTNZu/l1FixYNVvBaedBoUjj3mjfpveT0rzLv4w9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdgAG40w3NcCKjAzZ5sCT5ZpjTIbu6tZxN+BnJMTQhEHWfGkSe4b764dhyfoMBzFv
	 hp+oKHmOjNifNtbpTlkvF8Ik7jgF1SBI6/IO33yVwQ/W+W4ybLIXmzRVFT8QqOvMsF
	 IhnLH3avS4hPGG7idmMiR8KG5cli2InF0z6jLOBo=
Date: Tue, 17 Mar 2026 17:31:54 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>
Cc: "Brost, Matthew" <matthew.brost@intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially
 initialized sync on parse" failed to apply to 6.12-stable tree
Message-ID: <2026031748-huskiness-autistic-5186@gregkh>
References: <2026031732-size-unfasten-2bf3@gregkh>
 <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226127-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 0FDE62AE051
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:27:46PM +0000, Lin, Shuicheng wrote:
> On Tue, Mar 17, 2026 4:48 AM gregkh wrote:
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm tree,
> > then please email the backport, including the original git commit id to
> > <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> > linux-6.12.y git checkout FETCH_HEAD git cherry-pick -x
> > 1bfd7575092420ba5a0b944953c95b74a5646ff8
> > # <resolve conflicts, build, test, etc.> git commit -s git send-email --to
> > '<stable@vger.kernel.org>' --in-reply-to '2026031732-size-unfasten-
> > 2bf3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> I cannot reproduce the failure with upper cmd.
> The patch could be applied successfully without conflict.
> Anyway, I follow the instructions re-send the patch.
> Let me know if it still has issue.

Try building it after it is applied and notice how it breaks the build :(

thanks,

greg k-h

