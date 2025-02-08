Return-Path: <stable+bounces-114401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44ACA2D7B2
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 18:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7274166F12
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C671F3B83;
	Sat,  8 Feb 2025 17:05:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48269241CB5;
	Sat,  8 Feb 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739034320; cv=none; b=F+6r2SbDkZ84JJY8oYS5FY3E/FsFRmrrDi3M1rQEdq0pqh4012Ep4IRrbLPomFZ58CWr642gK5n85zrWp3n1V2iWBjNmzsLSN3esyt0kD7qXpTwZjlHfrlMenkBFFLh7tj+PwGXWpmdz6KCPNTcDb9f9EtHofCn9POjCrGK0iN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739034320; c=relaxed/simple;
	bh=zuYhn2pZEXodm+71qFxugC5Ci4V4PpwIhddMW96LO5I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QnvPNOkCCQjQTOvQzJPlAw/hsOZ6ODeSGQ5D9Tgi3BNgT0DiOncvN8DtmOSJjW4X3qNRAKN9S6OWp61D9Xc5hJfrvYf+/pxrJdu/CsPeQachzlQuuLoBV5iYQLUR2Pc2ciROKUh3ZYk2LMHBnMRAG7wrRCnHjMBQZ0ajsmpaSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9694192009C; Sat,  8 Feb 2025 18:05:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8F80F92009B;
	Sat,  8 Feb 2025 17:05:16 +0000 (GMT)
Date: Sat, 8 Feb 2025 17:05:16 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
    Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] alpha: stack fixes
In-Reply-To: <20250204223524.6207-1-ink@unseen.parts>
Message-ID: <alpine.DEB.2.21.2502081630030.65342@angie.orcam.me.uk>
References: <20250204223524.6207-1-ink@unseen.parts>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Feb 2025, Ivan Kokshaysky wrote:

> This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
> Thanks to Magnus Lindholm for identifying that remarkably longstanding
> bug.

 Thank you.  TL;DR: I've completed regression testing now and the results 
are looking good, so I have posted my Tested-by: tags now.

 Sadly original verification triggered a glitch which sometimes happens in 
the operation of my server's intranet network card that puts the device 
offline until it's hot-removed and the re-discovered.  I suspect a driver 
bug triggering under higher traffic, but that yet has to be investigated 
and it's a bit of a challenge with a machine that is at a remote location 
and in constant use.

 I have only discovered it once 1023 tests got affected and consequently 
failed due to the inability to reach the target Alpha system.  I concluded 
it was infeasible to run the failed tests by hand and then try to merge 
the results.

 Instead I disabled the extra prolonged tests discussed in the previous  
update and rerun the remaining whole testsuite.  That completed in ~23h 
and produced a few regressions and progressions, the former for the "math" 
and "nptl" test subsets, as well as one "string" test ("test-strnlen").  I 
have therefore verified them by hand and triggered the failures with your 
patchset removed, so I concluded their failed results are not the outcome 
of your changes.

 So this is good to go in as far as I'm concerned, as noted at the top.  
Thank you for taking time to work on this problem.

  Maciej

