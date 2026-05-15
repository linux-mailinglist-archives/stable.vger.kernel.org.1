Return-Path: <stable+bounces-247394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCBGMaK3BmocnQIAu9opvQ
	(envelope-from <stable+bounces-247394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:05:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D8549D82
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09282300CCA3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D237755D;
	Fri, 15 May 2026 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="njQS8jWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15E24677B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825117; cv=none; b=BKEcGHmCNpFIYsYY0elXcBvVqkGb8luMCqDgbbi3GX9e6f2VXLW+ucT/XvP+u3eYAc68L2Gyh2lhrOJgVd8oPcGxE09HC8cwHJ099Ph2GgTrqaWqtVRY5s+h8Dg33gLlQJNTeR0uK4YibqQfRlubgXB3baPBUfG8nKckBIr4HiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825117; c=relaxed/simple;
	bh=X9n+qYzLGSM+khkwgW/l+Z6OCZYsGcf9r9gO/W0nI6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNzi6IuL17GwPusG/6F8dM0+/7K243oypmo4ocwWyd62/Vz1knvhyxpGLC7hedPWxWWHDtHckfmzsSihF4VDWYfhyIQsLXkUbrpP0kwG5WRu/33gp5cA+Y/sxdp8WlxySCWZ55mVwbaOTaVEy3QKyptw/kL8wBtdZ5/Q+DIPeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=njQS8jWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D0DC2BCC7;
	Fri, 15 May 2026 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778825117;
	bh=X9n+qYzLGSM+khkwgW/l+Z6OCZYsGcf9r9gO/W0nI6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njQS8jWKeCzem6K/CW9mqH1HWBBlJnBk9HNKurq1HVQoHsUm6oq+vMlzeKvAqVUP6
	 lzBJnV0vI3921uRMkeynb//xvoDiscnN+kVutqJTwZ5tsv8Kqf96xcxGJockms8ivR
	 S8fGwpuIM8tS8rA0LL+xCagwo/rtMBfidbtHOQUY=
Date: Fri, 15 May 2026 08:04:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: stable@vger.kernel.org,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: fixups for Raspberry Pi 5 revision D
Message-ID: <2026051540-lure-grain-5f20@gregkh>
References: <87wlx5epwb.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlx5epwb.fsf@prevas.dk>
X-Rspamd-Queue-Id: 529D8549D82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247394-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 09:45:40PM +0200, Rasmus Villemoes wrote:
> Hi Greg,
> 
> Please consider adding the commits
> 
> aeb078cebc40d ("arm64: dts: broadcom: bcm2712-d-rpi-5-b: add fixes for pinctrl/pinctrl_aon")
> 18d4a06e10051 ("arm64: dts: broadcom: bcm2712-d-rpi-5-b: update uart10 interrupt")
> 
> to the stable trees. Without the first, a Raspberry Pi 5 revision D
> simply fails to boot, ending rather quickly with a

Both now queued up,t hanks.

greg k-h

