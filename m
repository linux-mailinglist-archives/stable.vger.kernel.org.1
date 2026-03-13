Return-Path: <stable+bounces-225339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEjwBHQ2tGnTiwAAu9opvQ
	(envelope-from <stable+bounces-225339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:08:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383F286AF5
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B4F3039839
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E41A681C;
	Fri, 13 Mar 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHH/r9pD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D181DF248;
	Fri, 13 Mar 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417731; cv=none; b=hFaHBWE7XCg+bbPSiRmkj2AFMofjClCHBh0SO0GjuTMDRziW75zK1beITuWykZRC7pxg2zAqaaaKSw/qbfUJUWoolcVxQlHklEJE4erBCQX/L+3hSjiojaGFnu3w85+wpV8A45+c2xFxUo+iMs8Wvb4ZihcpNvad+ul+Qn9lmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417731; c=relaxed/simple;
	bh=0SnqGWUTPHdASg+pEp4IE3MUWjnn5ereWTFmJ1KFvv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKSLHOhzKnDhiNx+olqcvuUk6dcdx8PgaBoBFwyZlbb2eTUYXBqXivHSgmhUiopPhXF4t7DCI+atsQ51trjtvleCd8IAQmuIg277UksfPG/l0LBdoq2ks2tfh4QTO71U6xq+wWK4AxcEP337NzLb6/AN7iJs7yJ35uf4CoEE2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHH/r9pD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F825C19421;
	Fri, 13 Mar 2026 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773417731;
	bh=0SnqGWUTPHdASg+pEp4IE3MUWjnn5ereWTFmJ1KFvv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHH/r9pD0O0zp0yo5FE/1g0fP9oEB87GfGwnUF1hzb/vx1Y15Y9Ii3nmdvlGg+IKK
	 x9YtuNWt3Iw38UVWMYm1IgYyWV01ZSXaBdfWBbNkw2xaD91G4GCw5/VFTi1rdSxixg
	 7rSKj17glbVY5Rzcgi8iwxddXy8m2WqOtq47GT78=
Date: Fri, 13 Mar 2026 17:02:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 004/265] KVM: arm64: Advertise support for
 FEAT_SCTLR2
Message-ID: <2026031343-unaudited-tapioca-1005@gregkh>
References: <20260312201018.128816016@linuxfoundation.org>
 <20260312201018.304349696@linuxfoundation.org>
 <87tsukdca9.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsukdca9.wl-maz@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225339-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 9383F286AF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 08:26:54PM +0000, Marc Zyngier wrote:
> On Thu, 12 Mar 2026 20:06:31 +0000,
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> I already objected to this nonsense [1]. This is actively creating a
> security hole. Please drop this patch.
> 
> If you can't drop this single patch and resolve the trivial conflict,
> please drop *all* KVM/arm64 patches.

I've dropped this and resolved the conflict, sorry about that, I thought
it had already been done.

thanks for the review,

greg k-h

