Return-Path: <stable+bounces-270139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lHqqNKL4RGon4QoAu9opvQ
	(envelope-from <stable+bounces-270139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:23:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 419B46ECC1C
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 13:23:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=armlinux.org.uk header.s=pandora-2019 header.b=Mra6qpYK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270139-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270139-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=armlinux.org.uk (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74DA931989C8
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC4410D26;
	Wed,  1 Jul 2026 11:10:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56DF3B8413;
	Wed,  1 Jul 2026 11:10:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904226; cv=none; b=JEh0wHYzc6kMiJddIeI2YU4yxq/BQqv6T253EpK2D1weDnQLrRgksqcCvPRGbD3EnDcbDUn2jr/h8+5c7GjqATSwAFGTzQVaicHEs/ysUQvguWCfeUM9Jw6nWxx66ZBrnYFPnsl7m4zQBfvVbITi2onjzrcC6f+Uy1Hi34vH7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904226; c=relaxed/simple;
	bh=J+yRTp+HYPKIfoDrMAvwx0Ax4iSeHCu13rh62RvNZVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixfwc8aVwbJUxx0OgU7GI/QVpEosk6ZNvYVuLhWuylzMltewh7lcVYMMW+iZWKKscNVOCP0iVw2Zd+gsMiXzZlnCY1Y/sfXZlQfYfdp47OuHfWYXUsJmPETf4mTNgU5+moiA4StiLOpmw4i6Wmk/WhAUBZ1k9s8JDbDIE3T/fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Mra6qpYK; arc=none smtp.client-ip=78.32.30.218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fiOT6uiF3NGboaiFTBq263sYJRkFitWRNlZkqixnh6U=; b=Mra6qpYKy00JCbqscUz5b3u1dm
	1bGugawwQ4WvrJbZbPKKzLQeYu3ae1bQIBzTpvbxKl3n9Pn0sdv8f4OSi3FTXyGu/gTjWLffBnei9
	0o+FZ7NsUF1IJWdRCnVJhIZPk1CuabhxyVB5rPXHuADWtOpfTA/j88i6ObbB4cG7geva9boYZtXgR
	TxHIqbmfaURgj7nUbGY2Cw3DV0WSFr5nx5lEovaIXU57RmB4gHMCYbaz4Oz7kfF/53GbwbB7kxohV
	z2yRa0rWo0Ua7h32SYNM+b7G1QAWjpGY+ocaCnnrww+yvhw9OR3BECVwZdTps1n8ECJW+TN2ihzIS
	JFB7nJ9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32952)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wespc-000000008Vo-14Lm;
	Wed, 01 Jul 2026 12:10:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wespa-000000007iL-1NdZ;
	Wed, 01 Jul 2026 12:10:14 +0100
Date: Wed, 1 Jul 2026 12:10:14 +0100
From: Russell King <linux@armlinux.org.uk>
To: Linus Walleij <linusw@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	slipher <slipher@protonmail.com>
Subject: Re: [PATCH v3] ARM: breakpoint: CFI breakpoints only on demand
Message-ID: <akT1lr2iNzbnGEzH@shell.armlinux.org.uk>
References: <20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-arm32-cfi-bug-v3-1-e3c37e2b80a4@kernel.org>
Sender: "Russell King,,," <linux@armlinux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lists.infradead.org,vger.kernel.org,protonmail.com];
	TAGGED_FROM(0.00)[bounces-270139-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:nathan@kernel.org,m:samitolvanen@google.com,m:kees@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:slipher@protonmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,protonmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 419B46ECC1C

On Wed, Jul 01, 2026 at 12:42:09PM +0200, Linus Walleij wrote:
> This removes the stub hw_breakpoint_cfi_handler() from ARM, making
> it not steal breakpoint type 0x03 (ARM_ENTRY_CFI_BREAKPOINT) unless
> CFI is actively used in the kernel.
> 
> When not instrumenting with CFI, we fall through to return 1 from
> hw_breakpoint_pending() "unhandled fault" so userspace can make use
> of this breakpoint.
> 
> This of course does not work if userspace want to use CFI and custom
> breakpoints at the same time, and CONFIG_CFI does exist as something
> users might want to select for their kernel. If this is not good
> acceptable we need to think about other ways for CFI to interfer, such
> as not using BKPT at all (rather something like BUG()) and back out
> the offending patch until the compiler behaviour has changed.
> 
> Fixes: c3f89986fde7 ("ARM: 9391/2: hw_breakpoint: Handle CFI breakpoints")
> Reported-by: slipher <slipher@protonmail.com>
> Closes: https://lore.kernel.org/lkml/kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com/
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Trying to solve the CFI bug. Let's see of this first
> approach is acceptable for the reporter.

Looks fine to me, but will depend whether the reporter has CONFIG_CFI
enabled in their kernel build.

Have the LLVM compiler people responded to this bug yet? What is their
plan with the silly choice of BKPT usage for CFI failure?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

