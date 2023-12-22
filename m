Return-Path: <stable+bounces-8344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD3981CEED
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA11F239AB
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94F2E651;
	Fri, 22 Dec 2023 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hatguy.io header.i=@hatguy.io header.b="X22y/UrF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="NpP1rlyw";
	dkim=pass (2048-bit key) header.d=hatguy.io header.i=@hatguy.io header.b="jl2/DO4l"
X-Original-To: stable@vger.kernel.org
Received: from a3i634.smtp2go.com (a3i634.smtp2go.com [203.31.38.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373182E648
	for <stable@vger.kernel.org>; Fri, 22 Dec 2023 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hatguy.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em868002.hatguy.io
Received: from [10.149.244.204] (helo=hatguy.io)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96.1-S2G)
	(envelope-from <a2brenna@hatguy.io>)
	id 1rGlYn-ynpLyW-2f
	for stable@vger.kernel.org;
	Fri, 22 Dec 2023 19:51:54 +0000
Received: by hatguy.io (Postfix, from userid 1000)
	id 3A71A60B45; Fri, 22 Dec 2023 14:51:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hatguy.io; s=201907;
	t=1703274712; bh=c7WdpiydgeDzIXLUYsm0D+DklbOEIyuRcRE00Om+fxM=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=X22y/UrFhiY2DQXlU1Y/nycx+QBtRZr8tAaGeZNRS9r1Am/okGTzROAAyjWFh0vHJ
	 wk4EUpDN4+joOA4Uz49wWkoDnFMnvWI0l/IwjxluNmlDKYHhVYuTGrrGfK+BP4A2w8
	 YKV4W7FWk3wl8KIJ5JQDJU7/LdhgY1hdzPro7CiIS/V1unvUVKeL/O/nq/6ij9jAV7
	 bfCgcF1/pDFsceHSvBqS6DevTp7QR/LciDi9NwQ9zxhS4NAEFwTDMzyLJNF0Qw3BFi
	 6qx2ESMID5fgAIT7HNIL/CiE2YuVdYcAcw8/rP++AvP3Bkdu/oqZtvUZ6tbEKBDdBD
	 xKKvqwK1k/QxQ==
Date: Fri, 22 Dec 2023 14:51:52 -0500
From: Anthony Brennan <a2brenna@hatguy.io>
To: stable@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Fix missing xas_retry() calls in xarray
 iteration
Message-ID: <20231222195152.GB8982@hatguy.io>
References: <20231222013229.GA1202@hatguy.io>
 <2023122200-outsell-renewal-525d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023122200-outsell-renewal-525d@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-smtpcorp-track: 1rG_YnynpLyW2f.hQMYiNZ73MIR8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1703274715; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=qReoceekiP7kBfddHbhTkAuuMEcqM/nfSjCN6uFZUms=;
 b=NpP1rlywf7TauNxPUcoQ5hkS7gxwfUkaQtuoTjs1M9DOu30kOXIb0VCU4R81xqd+WWuZZ
 xDpVSPwkRjYML9HmOX/HtyypFRBcU1+dCI/8oqz1MoLVJ4wR8U41NhYdN1Fb43+FxDPNzXU
 b1yaXyLhp/Nl9ZFs2PvAXaifpe9djNUHCL7ZA1JQYazeGUVXNL2NTSWUN9x5azYCJsJHPk0
 sZDk1aPsRD8X7pQTn8tLFXEIa6xbre27p/JsNfCL1XDPvZ2HJgsO9KgaqgZegxuVhqcyIgk
 OS8Je/7Ud00VkLf+5I8Q3V1IVc4DL694Pf7bMMVvYM7DAmzb1QjO8bJBE2gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hatguy.io;
 i=@hatguy.io; q=dns/txt; s=s868002; t=1703274715; h=from : subject :
 to : message-id : date;
 bh=qReoceekiP7kBfddHbhTkAuuMEcqM/nfSjCN6uFZUms=;
 b=jl2/DO4l1VacT1amDbPvp0u0IC19wiAvM4BjxpwYtRWyCy50STkF4Cx/HtQ4jJOrkc13i
 ohVYKTEcxqyiWbFfK6MYCkRND+1peqqGyysjZ0Nsm8QEx74K2RpCP6BUh/99DOCU5JseBhJ
 wWJBXnS1x3GaxbNDCOGlDv/splD6lrp3KTy4zuosCPYiRIVYxYUDQMaIcoG6JOLG8VNCye0
 L4WiiF8fIOflAgGWymT8c46F6SVQhaVkmpdDJlRaLfaXf82MCQ9V8HR4zIuF43CCthPDN14
 xsEmZmBjLGVYfC3eD/KGCYkOvVM5jJ+935iT4I1MJE7hOTEsj3BGWy4Ifz2w==

On Fri, Dec 22, 2023 at 07:26:23AM +0100, Greg KH wrote:
> On Thu, Dec 21, 2023 at 08:32:29PM -0500, Anthony Brennan wrote:
> > To be applied to linux-5.15.y.
> > 
> > commit 59d0d52c30d4991ac4b329f049cc37118e00f5b0 upstream
> 
> That is not this commit at all :(
> 

Thank you for your time.

From what I can tell, the upstream commit merged by Linus includes two
unrelated sets of changes: handling xas_retry, and fixes to "dodgy
maths".  I discarded the fixes to dodgy maths for two reasons, first the
commit log says they solve a theoretical potential problem and the
guidelines for submissions to the stable kernel say to avoid such
patches, and second, I lack the expertise to be confident those fixes
are correct when working with pages and not folios.

Unsure what I should have done here.

