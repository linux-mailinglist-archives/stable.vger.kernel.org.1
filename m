Return-Path: <stable+bounces-263092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A5wSN8InL2ph8QQAu9opvQ
	(envelope-from <stable+bounces-263092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 00:14:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68E68263A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 00:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=armlinux.org.uk header.s=pandora-2019 header.b=HIbAbVud;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263092-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263092-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=armlinux.org.uk (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A97143001FD0
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B831E856;
	Sun, 14 Jun 2026 22:14:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B01FC7FB;
	Sun, 14 Jun 2026 22:14:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475262; cv=none; b=jSKj1O0sZfGjHJZtny0giL0lt5UQEAF27V0vAS06fcP8GSZrCymPHe+NR2F/wvW6RAph3/TAyMoAgucP0p/2e9j+7JNYUvR1yoKbo8dv6fLK79X+nq9XxSsQOTFyIsqhNuWVknS585/kQl9Cvn25CE4esPlo/btQV6/HRTfwEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475262; c=relaxed/simple;
	bh=+E3d0LLzA0PaeI1TlJPLlKpJnQsoR1bCRLmFPH3SYuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXAM8LOm1xkKQ0WNrs6w1z7ZrgBSjp3HCiE673tldAovhaq29Lbmg279a38bJ+KFEo4Lwg3LUmWiPWX+E1jIzVwxGTZv9TAW/c01iusnm/RdMoR/tOsN0QL5pb5fnW6oZNWlgRumlgyNNaD0iWgwfdau2dx+EbNAf/6GrjWBzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HIbAbVud; arc=none smtp.client-ip=78.32.30.218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aoouwIl7ENWFJcsKQwFnZPx//JfMbetXKC3Kqh1HdNY=; b=HIbAbVudDeCzIlARtEGn/DlQl9
	2382Mvs6aHVELbjukDg/2u+y9823wKm/qSAsfk4S4d3lrCvRq/HWbcDuBua34khCh6J8VVTlZdbJ4
	r8ynAIJnhdpoSXWgM/oEtBsQAgPcpTJ3W0kOTvnRrkbf+ElP3qehqs6n6OvO1FQUKOt5x7hk/kMt9
	P81xCFQAr4T66cIGXAstuO+3EleyabhEH7Mh1kidvm1mev/VgWSAQXlWgugt8XaiTTiyEiFACdG5t
	927yJaXHunSXsm0nZJ2J7VRRFn0J6cn2sDbRs2VlF3O22P9y7QJGjLiuL5tlnvntMHE3mvysPgwKC
	aj8YdlkQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57636)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wYt5k-000000004xx-2dXf;
	Sun, 14 Jun 2026 23:14:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wYt5h-000000008QG-2EyH;
	Sun, 14 Jun 2026 23:14:05 +0100
Date: Sun, 14 Jun 2026 23:14:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ARM: disable broken eBPF JIT on the Risc PC
Message-ID: <ai8nrc0ZUfPaqC_7@shell.armlinux.org.uk>
References: <20260518014920.135011-1-enelsonmoore@gmail.com>
 <CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com>
 <CADkSEUjsS8bOXDhgZ2EW40xifDZ-pk5y=YqyWT-+vQNd8JikUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUjsS8bOXDhgZ2EW40xifDZ-pk5y=YqyWT-+vQNd8JikUw@mail.gmail.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:linusw@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:arnd@arndb.de,m:kees@kernel.org,m:nathan@kernel.org,m:thomas.weissschuh@linutronix.de,m:peterz@infradead.org,m:illusionist.neo@gmail.com,m:davem@davemloft.net,m:illusionistneo@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,vger.kernel.org,arndb.de,linutronix.de,infradead.org,gmail.com,davemloft.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E68E68263A

On Sat, Jun 13, 2026 at 06:50:40PM -0700, Ethan Nelson-Moore wrote:
> On Mon, May 25, 2026 at 1:18 AM Linus Walleij <linusw@kernel.org> wrote:
> > Looks correct to me.
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> >
> > Please put this into Russell's patch tracker!
> 
> Done!
> 
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9477/1

Should be s/arm\./arm/

Also, you can use:

Link: https://lore.kernel.org/all/CAD++jL=0qYGoygUwGEXQL7C_ROnC7kfpRv8RA+H5tNWwYu+pQA@mail.gmail.com/

in the attributions in the commit message to indicate where more
patch context can be found.

Lastly, too late for v7.1 as a fix, I already sent the pull request
for that, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

