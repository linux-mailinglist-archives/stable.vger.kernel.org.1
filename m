Return-Path: <stable+bounces-225396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJaPDb2NtGnBpgAAu9opvQ
	(envelope-from <stable+bounces-225396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:20:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC5B28A592
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C5AD30D72CF
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CACA376463;
	Fri, 13 Mar 2026 22:20:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net [50.242.207.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA03822BA;
	Fri, 13 Mar 2026 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.242.207.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440440; cv=none; b=IiC5/K9LIKk1bBOHlv4GxZXeDw3J1dyKgN0wmXEjWopUHLRbIjRT1QvSc0D20Ih/mkA25GdGnxTu4XynG5KkWWII0Yv8cPmnmJETpJM0BFqonuKLHQBlTHo/fiMsjyVXhmjnJ80slPG5mwivDXN8HmanFqUeu+eVseEij933p4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440440; c=relaxed/simple;
	bh=yp2G774sbBlAa1YMBD+C9s1yBFXkc7luVGfoz0X+gmE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X1otAO+qhgyYfp2dACvMDb+vveDUvXOETbtNr/vCvOOIn9dtAxH4NiAqbS9xfYNmc1bOfUSCVTCIR0z4oOj2J7dvNNHB4GgVOtOKuNwBOhBs9xI0YOVW0VnbZjhviuQhIyirc8rNQWJjZecVTVFXkzLvgTco7ewPFNHVK7md9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net; spf=pass smtp.mailfrom=absolutedigital.net; arc=none smtp.client-ip=50.242.207.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=absolutedigital.net
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
	by luxor.inet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62DMKImX009816
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 18:20:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by lancer.cnet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62DMKIYg000629
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 13 Mar 2026 18:20:18 -0400
Date: Fri, 13 Mar 2026 18:20:18 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Sasha Levin <sashal@kernel.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, jslaby@suse.cz,
        gregkh@linuxfoundation.org
Subject: Re: Linux 6.18.17 -- build regression
In-Reply-To: <abNdx_cQR_BqMm3z@laps>
Message-ID: <df7fe0-786-bfe7-511f-b147fa6138c@absolutedigital.net>
References: <20260312112454.940017-1-sashal@kernel.org> <b1844e83-80a5-973e-93bd-9e721e27ebb@absolutedigital.net> <abNdx_cQR_BqMm3z@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225396-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[absolutedigital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cp@absolutedigital.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FC5B28A592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026, Sasha Levin wrote:

> Hey,
> 
> Thanks for the report!
> 
> Could you please confirm that cherry-picking 93d0fcdddc9e ("cxl/acpi: Fix
> CXL_ACPI and CXL_PMEM Kconfig tristate mismatch") fixes the issue you're
> seeing?
> 

Hey Sasha, thank you for the reply.

Took me a minute to find that commit :) but, yep, it fixes my build error.

-- 
Cal Peake


