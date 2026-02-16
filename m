Return-Path: <stable+bounces-216692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPIpAKsCk2nF0wEAu9opvQ
	(envelope-from <stable+bounces-216692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 12:42:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC77143121
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 12:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58717301477C
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BAC2FFDF7;
	Mon, 16 Feb 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+UobP0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894727055D;
	Mon, 16 Feb 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242152; cv=none; b=oBkacmkGn5VovF4vs/RN28EXrITmBVCZN4BeniSQHkWgSJJMQa0Tc4qme2vxtWkU/tfDJ2Q0Fxjv8cyTqS8KfwaMl2Zhd24V7WI1NQ4xZQXbWsBSYwPP21nShTr7loMdw7Q+nwbweY7b2hmixb9XDpQvMmxOX+cIeum2tAH0kXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242152; c=relaxed/simple;
	bh=Qx+31xXss3wDM1nInZOJ0M/8jEm5MlSdby4C9beFIfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbQ/1XWRI9tUeqeRjGmn7yWCD5hIDP8dqB/QUm9WEIc3EL6dG1a8R2igDJ3rvzBQKme/GEIXhH8OCpcE4xjmRplJadrttWn247FWPJcr16YgJuS4iEaqqriOGYkpZyoJWkqefJUpCyoNsJkfZqB8QDqW6blDcWQWNyBfslMhUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+UobP0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA2FC116C6;
	Mon, 16 Feb 2026 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771242151;
	bh=Qx+31xXss3wDM1nInZOJ0M/8jEm5MlSdby4C9beFIfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+UobP0HGdLyHcZpBnEe64ITgmrdp2Ro1uGK3FvCTnrTYVvWuoiHx7yGiOBswplOb
	 E+mzODRkv+mlRPDVHY471u4jqR0+Nxhrsp8m9MmUc+duAcGYtnZ6XgmBnhIJS2wIJ5
	 /vC2tCCGnUIEV3zjsCA9z6Z9ms9LQyglThJkeiGVsCZ4F5FZTFTrlIiN4wA84DjRaX
	 9fYiJCGz2c5e5ytaV840soJ+WeWSXr1hixbimtQNb8DTYwLrXDyYByFTR6/eyab2sN
	 PBa8KOAo4sZumhPYPc33WNlYnXtWYrROCTZ+VMS9KemNDZI6gG0sIxyhe/Y9XOhMgl
	 iaZRTpYhR8PaQ==
Date: Mon, 16 Feb 2026 06:42:27 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 0/2] kbuild: rpm-pkg: Address -debuginfo build regression
 with RPM < 4.20.0
Message-ID: <20260216114227.GA213868@ax162>
References: <20260210-kbuild-fix-debuginfo-rpm-v1-0-0730b92b14bc@kernel.org>
 <aY8wyR572eZYWVJY@sgarzare-redhat>
 <20260213191138.GA2131983@ax162>
 <CAGxU2F7FFNgb781_A7a1oL63n9Oy8wsyWceKhUpeZ6mLk=focw@mail.gmail.com>
 <20260215212901.GA695045@ax162>
 <aZLTsduMY7H-QoA2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZLTsduMY7H-QoA2@sgarzare-redhat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216692-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EC77143121
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 09:25:25AM +0100, Stefano Garzarella wrote:
> Oh, yeah, I just tried the following change on top of commit cee73b1e840c
> ("Merge tag 'riscv-for-linus-7.0-mw1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux"), so without this
> series applied:
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 0f1c8de1bd95..86ca327ebccf 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -50,6 +50,7 @@ against the %{version} kernel package.
>  %if %{with_debuginfo}
>  %package debuginfo
>  Summary: Debug information package for the Linux kernel
> +AutoReqProv: no
>  %description debuginfo
>  This package provides debug information for the kernel image and modules from the
>  %{version} package.
> 
> And I'm able to generate RPMs too without errors!

Great, thanks for confirming! Does it still work with:

  AutoReq: 0
  AutoProv: 1

as I notice that is what the %_debuginfo_template in /usr/lib/rpm/macros
uses by default. I suspect that the automatic requires is where things
explodes and I think we do want the automatic provides because I believe
that is how the "this package provides this debug build ID" generation
happens.

Cheers,
Nathan

