Return-Path: <stable+bounces-222435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDCzGp4CpGlVUwUAu9opvQ
	(envelope-from <stable+bounces-222435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 10:10:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7A1CEF2B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 10:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B0263007AEA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AA12D7398;
	Sun,  1 Mar 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="M9Nu7ojd"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB714B08A;
	Sun,  1 Mar 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772356248; cv=pass; b=HNR50WKeysHTnzc2J6N/MqJ8EcNh0XIHJ/DM4ErmGjSpO/mEFjvhIOHJzv+o/KJk+c2veZG1O8dQKrlOriYhMWDLBemhSwaRCOePuHHsZGxTWoIn1ewqLp4ilS+iXPflFWGSv43mTEmhVlrUjnv5zQTVf2WD/D1E0E2GAATAZj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772356248; c=relaxed/simple;
	bh=jeu1yzCdB367pPyMezpBPQ7+WqJ0t782pQmlNmLCjog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCxy7z3xgWYlaqxFR0CxXdZIc6+7SuYsgni23CiAGjga8S3oRHHkZ83l4tSzHfdGqAgOzBI6z52Qa3c2RRGBU4110M6/IU/V27BdtJy9egaVMihD58dtM3fr3xbLDv1v9i6wIG/pC335YZLSHUCeKOPkPK+O/alMy4/KgLkk/cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=M9Nu7ojd; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1772356222; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H1IKPNliLrMbypbW8QEUoKaCsSiqE5SHyQWM4BM3qIm392MJLhPcUjskZJRYxTXh38RYDBz5cLob9d5jT22VjKenGYWTD7xcafN0c4So+EP7fsxTNNHWyut8nNovtZJLS7UvBf6LgpTVf2ZAVB95dga9fuyVf2ByFgJWOnxNmE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772356222; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xpVN/7SJGYAEhI8JRg0mA4wLBi3o2/6MQtSeQfZQmww=; 
	b=Ho8RoCaECzPYAa9OREy8fC4eXIizbuwOarLFtZUj3/o/Yevl+p1URzHjiTXmqG/VvR4bFrjC3OQik4XAx7GV7AT2T3ronSiPthzBLk3si+QKhqRcyvaTPs3p4wKlThbE5sBvkf123nynexfwcj4o81hvukcis829tln/UPZ1jTY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772356222;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=xpVN/7SJGYAEhI8JRg0mA4wLBi3o2/6MQtSeQfZQmww=;
	b=M9Nu7ojdg9EulLWwSXWp84lfyH+HGEzytTIBTcsBHbXzXfEMZXxyYO11qEr3ncPF
	43xa/9UCjXMbVRBR6ml8Szg+yXjXTnGgV1tInX2XlecqA1iYFODPoQkRcJ7dRUMwj03
	PHRuWe41fR40vQOzWHjiX4JKXyAYBEvgdmHqrpeA=
Received: by mx.zohomail.com with SMTPS id 1772356218761346.6666375883094;
	Sun, 1 Mar 2026 01:10:18 -0800 (PST)
Date: Sun, 1 Mar 2026 09:10:08 +0000
From: Yao Zi <me@ziyao.cc>
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Message-ID: <aaQCLOMdJCWNF-dA@pie>
References: <20260228173704.62460-1-me@ziyao.cc>
 <72356849-27d0-46c7-b659-c1a3b260de8c@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72356849-27d0-46c7-b659-c1a3b260de8c@intel.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.84 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222435-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	NEURAL_SPAM(0.00)[0.438];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziyao.cc:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70C7A1CEF2B
X-Rspamd-Action: add header
X-Spam: Yes

On Sat, Feb 28, 2026 at 04:33:18PM -0800, Dave Hansen wrote:
> On 2/28/26 09:37, Yao Zi wrote:
> > Let's disable the feature on this problematic CPU and warn the user
> > about the quirk. x86_model_id is used to match the platform to avoid
> > unexpectedly breaking other CentaurHauls cores with conflicting
> > family/model ID.
> 
> Wait a sec. There are lots of different microarchitectures with the same
> family/model and no other way to identify them but the model id string?
> 
> We've used string in a handful of places, but it's an absolute last
> resort. Are you *sure* there's no stepping or anything?

No. The commit message should be more clear, I have no clue that there
are other designs with the same family/model/stepping combination.
However, C4600 is a design from Zhaoxin instead of VIA but using
CentaurHauls as vendor ID, thus conflicts may happen since they're
different entities. So I take the safest way.

> I kinda think we should keep this like all the other vendors and keep it
> to model/family/stepping. If the vendor has grouped too many
> non-vulnerable CPUs under that, then ... this is going to be a good
> learning to bring back to the CPU design team.
> 
> If you're changing the CPU in a way that it's possible to regress
> things, you *need* to bump the model or stepping. Period. If you don't,
> the baby might get thrown out with the bathwater.
> 
> Please resend this with a normal x86_match_cpu() and x86_cpu_id[] array.

The concerns may be too farsight as there's no clue indicating conflicts
actually happened. I'll take the change in v2 if you still think it's
appropriate.

Regards,
Yao Zi

