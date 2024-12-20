Return-Path: <stable+bounces-105515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C09F9ABE
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 20:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571747A363E
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA33222571;
	Fri, 20 Dec 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORJ7m9jj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2792210D2;
	Fri, 20 Dec 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724584; cv=none; b=XL9eKsmCFIEemkF0ADnehCW5MWaj5+Y5jkmUKj9wyB1sBQnFzlHtyL2wtPQRcL9F4VpmVMo6u/XOPJTB1rqddfi4G7gXBOhck18x6mXnR6VsBDLugBOHhhXxApI8xEN7vyVrIsOpXCIGxxq8a2eFCkgwgx3Acf82V9Mm1JA6hLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724584; c=relaxed/simple;
	bh=vnTVylhSiFQTDyTtj7f8xuYwPmWjYCaeETosvftHmso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKOQL08gdnLNDqF2zW9+xlBuQvNjYFghus87MZmajKeZlp6QDG3ko6i+duAv3HAYh36mKtUXrUWsiPS1BTv97xdrZhS2Vra6WkTAbbLOcQOc/QHOah/REw7d3ER0UqNQ1FC6L/GV0lBZk2M+Kw/CCbYneVsXJczzzqBgQEgRa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORJ7m9jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843FDC4CECD;
	Fri, 20 Dec 2024 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734724584;
	bh=vnTVylhSiFQTDyTtj7f8xuYwPmWjYCaeETosvftHmso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORJ7m9jj1KJBCjw9QG1BsJbdXJYYoL/l+myqac6mReU1oH8S0OQdd3ypskP4UKgaw
	 u+dyHP7Vum/h8WlJftywSWP74GsVt0V36vxAkXJ/62z4jSoh7sQgU7p83wjHhVLlJx
	 9qNTZGTJXqxIG1IRDdssujd0jRHtBQY0qa7nA/rSwjW87wGOR3YdTcLq5bcsPKKpyz
	 tMdiet7yLkR2xwkQuHnAbTog2V5pREe7h+fyQyJgd/Ua2cSfBSw/bsgkM6uN9LfRAg
	 f/a/jTutCkzZugapsxDYf/UGYWQT6WA1qYvSoQp2HjW7CjiVBEksIP/9wnR0OT3tHH
	 sfXGvpeprm4Lg==
Date: Fri, 20 Dec 2024 11:56:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kishen Maloor
 <kishen.maloor@intel.com>, Davide Caratti <dcaratti@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/3] netlink: specs: mptcp: fixes for some
 descriptions
Message-ID: <20241220115622.2101e554@kernel.org>
In-Reply-To: <20241220115406.407a4c82@kernel.org>
References: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
	<20241220115406.407a4c82@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 11:54:06 -0800 Jakub Kicinski wrote:
> On Thu, 19 Dec 2024 12:45:26 +0100 Matthieu Baerts (NGI0) wrote:
> > When looking at the MPTCP PM Netlink specs rendered version [1], a few
> > small issues have been found with the descriptions, and fixed here:
> > 
> > - Patch 1: add a missing attribute for two events. For >= v5.19.
> > 
> > - Patch 2: clearly mention the attributes. For >= v6.7.
> > 
> > - Patch 3: fix missing descriptions and replace a wrong one. For >= v6.7.  
> 
> I'm going to treat this as documentation fixes, so perfectly fine for
> net but they don't need Fixes tags. Hope that's okay, and that I'm
> not missing anything.

Ah, these also need a regen since the kdoc has changed!

please run ./tools/net/ynl/ynl-regen.sh

