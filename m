Return-Path: <stable+bounces-246893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK2MFWiVBGqrLgIAu9opvQ
	(envelope-from <stable+bounces-246893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:14:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D3D535DD3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 782FB3102D2E
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4438E120;
	Wed, 13 May 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CF+aITZd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDA388E45;
	Wed, 13 May 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684212; cv=none; b=dpsYmKpu1MBjMNyQ/vYq6yu9mNnNP1XtY2R//wzUXo+5jGWMvSX9bE0kovEBdxDa8JnT4/YjHWcAA1dvOBQagFTN2UcnSrttPgICXVYIarhvxYPfaJNL8gWECYjD5ScvBonOzmFSdEVYk9Ob08AwwzisfSRa3sTZy0dQVuhuc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684212; c=relaxed/simple;
	bh=XSyN4227EgJzXUPhESPl66rmjv08rHrHLMMNEzphjjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0jtEQN2ZyDSyEvtB1E74Fp/wiRq57hb2/hMf8M1pBOzHDTypj5IyCj8l/8SWEPBPC66Eg0X14x0n0G/aTrZRb1vroPXvjraJD11IZJPwN0NBsc9ub6wGMu/wGv5sjnp+ebeIjJ4tPUbEp/A9eYoMubSGILBud/+LXnHAn3AFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CF+aITZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE677C19425;
	Wed, 13 May 2026 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778684212;
	bh=XSyN4227EgJzXUPhESPl66rmjv08rHrHLMMNEzphjjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CF+aITZdEU7W+CYjVJyXS8ZUYaEoCnXn2++DPmURmsFdczZt2UG6rxZETesMsquUW
	 cWFDyzi8ZONoIJ8zu1DMmsd7/r0s3gIIw/hvhRI/B0KD69UCj005WEj19YQZVnbLoR
	 8IHhn1U8O30cTu1436gmXmHheX1jTS/Mu4ZBMj/4=
Date: Wed, 13 May 2026 16:56:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephano Cetola <stephano@cetola.net>
Cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Chris Mason <clm@meta.com>,
	Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH 7.0 247/307] sched_ext: Skip tasks with stale task_rq in
 bypass_lb_cpu()
Message-ID: <2026051342-canon-apply-bf42@gregkh>
References: <20260512173940.117428952@linuxfoundation.org>
 <20260512173945.338221208@linuxfoundation.org>
 <2f509cbf-f14f-4dfc-8ba9-d53dc10e0aad@kernel.org>
 <2026051301-tusk-parcel-15ee@gregkh>
 <67725402aaddb935a94d2cd751f317e6bb844654.camel@cetola.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67725402aaddb935a94d2cd751f317e6bb844654.camel@cetola.net>
X-Rspamd-Queue-Id: D7D3D535DD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-246893-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 07:39:22AM -0700, Stephano Cetola wrote:
> On Wed, 2026-05-13 at 13:58 +0200, Greg Kroah-Hartman wrote:
> > 
> > This is odd that it doesn't show up in my test builds/runs.  I'll go
> > drop this now, and push out a -rc2, thanks!
> > 
> > greg k-h
> 
> One of my build machines was able to build 7.0.7_rc1 successfully. The
> only difference I see is that it does not have:
> CONFIG_SCHED_CLASS_EXT=y

Which somehow doesn't get enabled with `make allmodconfig` :(

