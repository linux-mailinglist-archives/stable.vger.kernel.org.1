Return-Path: <stable+bounces-254507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOmXNICpFmr+oAcAu9opvQ
	(envelope-from <stable+bounces-254507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:21:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 812AE5E1032
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD8903012542
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50603D0934;
	Wed, 27 May 2026 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iz4VpIRz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CF3D16F5
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869582; cv=none; b=Nxw5IRm4lwQLmf0zssV7HoE75i0NpPvD0getIsn+7Ah8zFhr/Ksu0grCi35didwg5Z0dJQ1etdi3huJgG32YflAWcmfMak7SUjzeFDuieYwtWJUZk1ovGsWiohww0lAhA3rUGWM29VCl+k3vPaJnq6cH8cG7cXiMzI8GYMJ8mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869582; c=relaxed/simple;
	bh=gcxsf+qt4Ulwu2wvG1tp6iKTckcE6w+hsNAl8lbKJcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBK+GbwXu29PoBcllYt5cu91zg6toTp6+e4yk+ZUGWzx6v6RyZ9k59l2N6DX776hRiacyHV0Q3UY4Gy7ot7iJZCZcmFIuZ+fa9pXTzYdWMxlB2wSVTL5Yhuz1OLxTlUjC8bg1P4OzthAPL+S/PsW3wuAnuzXm/FMnJx2DWfZN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iz4VpIRz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E211F000E9;
	Wed, 27 May 2026 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779869581;
	bh=CTlZo+HFMVD8ZWxH+HuY33bgupUQsV1ORxnBtgYpIfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iz4VpIRztEPyZwrI3wG4FjbWDpfoCZOmzYyZNMNf9AOi6aJbSUJ51UYGsig8o2vNh
	 6tjG/Q8e90GvN2KzdYWnsWyPdcZNntK6q9TyDzzHCtqemJ4ooR8sWRCCkNLc+mCodd
	 XfbYUIbFitQmF+G0sF+h7kMnijGyRs/r8EMJ9r9k=
Date: Wed, 27 May 2026 10:12:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [stable 6.1.y] Will commit 7e96a281fa07 ("perf tools: Fix module
 symbol resolution for non-zero .text sh_addr") be included?
Message-ID: <2026052738-flannels-hardly-40ea@gregkh>
References: <ljz4f536p2oyxrtc2tklh7ymdqg2stcijj2cjepaaheqlw5ddq@vgqf24zcaadv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ljz4f536p2oyxrtc2tklh7ymdqg2stcijj2cjepaaheqlw5ddq@vgqf24zcaadv>
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254507-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.570];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 812AE5E1032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:50:08PM +0200, Franz Schnyder wrote:
> Hello,
> 
> Our OE-Kirkstone builds of linux-6.1.y from linux-stable-rc are failing.
> The problem is that the following commit is queued up:
> 7e96a281fa07 ("perf tools: Fix module symbol resolution for non-zero .text sh_addr")

I do not see that git id in Linus's tree, are you sure that is correct?

thanks,

greg k-h

