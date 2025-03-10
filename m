Return-Path: <stable+bounces-121721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47284A59A19
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63DB3AAA77
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099022B5AB;
	Mon, 10 Mar 2025 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LoVB74lO"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76D22AE7C
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620981; cv=none; b=Eu/hyrQQ3IFUhTZu89j4jRM3pDBffSd226Tc3EA4PRyBdyDNwywr5aaIDqDKsMfXY4SVc54dwID5kwEzdB1hJP3XviXQe2O5Tuu/xWD+r1romcHpcFE1ZUpdv9gOC3xynfAVXpUgmWPg8MybQIeQw2m4ts6H1m6SfogCI8I1byM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620981; c=relaxed/simple;
	bh=PdarLH/ShUpZPk6tG2R9LEXj7XfKDsQrqtu2D1KqwSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf0vtMIRFeZ5tRBoJ1sEany4jEWdjj5ztI5ZX4lwbUhIK2erwe9yRh19rdlcLQN2RJ/sV8W3MsyNDGBP8kRsEF2f+A0ABKJG5anKvuZKqrWikjbw6rGj+Ds/KHVkkPzZdU5aSCh6KhM1v6RX+08N8ApXp3O3CRwgLD6X/+1Lzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LoVB74lO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6334A40E0214;
	Mon, 10 Mar 2025 15:36:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CW_IRpUbE5Is; Mon, 10 Mar 2025 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741620969; bh=wauPchqzsx/wOosJuljCuembtM9k2/cGdG7AR5yzXGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoVB74lOWwVAjzFlnzCCWqcfA2TqotDYYD7TY0221/vlxDjlPZs5Vr51OFw1mm5tk
	 Ijn048bNE0Wx48mzkBWyG53Sbs1kMATgKBZWrnVM+QZMSvGbK3izivM7m+8Xcuqb9S
	 OAYovCmS5E2iRX7PHcf5jr+IsZjFoPzZr4HAPw5KGhnTZsDByykOVcjXxPkUlTzfGu
	 EoDnr3wbEA8hTVE3qWMIThl0+5wacpRGZygQ3UYBQfz/uYfysvlO2xzU/qqRaPrIyR
	 LCfUjWF9xlKDeSiOp0bNKEN9T3FFnj8KesgS0hpMNEZ3VOnLVPAr9s38CYV1o5W78l
	 8p4ilZMiQOh6V8afEJmw9X6daQVIJFpnBG8096AJ37VSj6hGij4lWKV+cYv+co6vIi
	 QNucCnqT7cHqVlBGuK5XnlnpY6O2D050prHCgqq03v+Rcd4OfnteNFS8oObYnJCx1/
	 Rul1vF47Ibww1Qg2u63PKPtrpIMQvI8IxEZgYxh6AzS2s6RfshZp112Xj46dxz2Shl
	 7EPxY6g49E97Ru+d41WHjK7upq77ehcnP+GEUwkbAGJFijCSLrajqSD5om8nrXXI9C
	 zaql07QWk4dO4H4zv3IbvvGdQB5py+5TUZH7p4AFpWDuaE4gyXDdVOi1dFc2NqzdSD
	 OZCvk7CsqW9IhV5EGjAO0MMc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7456B40E0202;
	Mon, 10 Mar 2025 15:36:05 +0000 (UTC)
Date: Mon, 10 Mar 2025 16:35:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: aik@amd.com, nikunj@amd.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] virt: sev-guest: Move SNP Guest Request
 data pages handling" failed to apply to 6.13-stable tree
Message-ID: <20250310153559.GPZ88G3-xbn5g71oJr@fat_crate.local>
References: <2025030957-magnetism-lustily-55d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025030957-magnetism-lustily-55d9@gregkh>

On Sun, Mar 09, 2025 at 11:29:57AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.13-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3e385c0d6ce88ac9916dcf84267bd5855d830748
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030957-magnetism-lustily-55d9@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..
> 
> Possible dependencies:

Yeah, aik is going to send you a proper backport here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

