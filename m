Return-Path: <stable+bounces-47724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A798D4EF4
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 17:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB458B23FB9
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74D18757D;
	Thu, 30 May 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WI2EPLYT"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEE187541;
	Thu, 30 May 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082490; cv=none; b=aDeQ28shSApOTHZKrOcRl3HukVr3tzrnf3FtueQzyKNJWFXQ05qywV7LOSlPilZbQ06kN+5s1yjuTdeRm8NZ1+UNQ22LzqrkntsBPNooSOuK3CUU6UN/Co/rj44uW9smc9OQbv9nSdjbj+uFDFqk0g9yctXmBTeqxv2IYoIyVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082490; c=relaxed/simple;
	bh=U5TgF7VIYvKSRNdp67128508jDwSIOgx0w/UYpTd0Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyBRJJ9pchn78u3nZjznyqU6EJrBRK7sbH1hgyhC/4G4yVoQC4i8xBS1viKLPFZaJ2tfAxx4delDGTyVGyOY7c6oBKxKYdJCPRJ3DBL0qLNCFYoZYRZxIYiKPJNHwGj6e9ennGiqWiKUQtB7vXusF/gjBybfrvGfrSNISB7YZ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=WI2EPLYT; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id CaEesLOmjSLKxChaksA1PE; Thu, 30 May 2024 15:21:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ChajsMX6R9zHMChajs3G13; Thu, 30 May 2024 15:21:21 +0000
X-Authority-Analysis: v=2.4 cv=fo4XZ04f c=1 sm=1 tr=0 ts=66589971
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=7eglLlv4HFOW3sTsDH6Jqg==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=VjqEAW4Pdxq5hPAZ8QEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U5TgF7VIYvKSRNdp67128508jDwSIOgx0w/UYpTd0Uo=; b=WI2EPLYTdZl9H0MLSza743CvOT
	1xSH/pmM1S9t7kmGMjm2n0Be+KYEmaP6IrWjZrupFcuKsoHRKMRmIhYkFQPfxNgXiiIyvfCvN+Fvx
	3a9gI9uwjVPIX+WncjfkZwfz9OP/ygWuJf+B/AlUnvWqqBBfEXGvIDDo9Fcc+s0h8jFw1yY73TvdF
	9RnhV6p5q+F4BZK+a7D0OI6csw1ffZhGzrDMu0WM1KkB9me+LMHlgWJBrkgO4uXV448+vuC9Bdjgc
	6ev6XphlrZ5D6syOHR2rNh6EYQXK3zIudkhLSUDKSLSmLOjFWaw7OgF7+7BenED2BWq63+OAIre3P
	or6LJIFg==;
Received: from d58c58c2.rev.dansknet.dk ([213.140.88.194]:46746 helo=[10.0.0.182])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sCbQI-000zIv-2W;
	Thu, 30 May 2024 03:46:10 -0500
Message-ID: <bee7240b-d143-4613-bde4-822d9c598834@embeddedor.com>
Date: Thu, 30 May 2024 10:46:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: mxser: Remove __counted_by from mxser_board.ports[]
To: Bill Wendling <morbo@google.com>, Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Justin Stitt <justinstitt@google.com>, linux-serial@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
 patches@lists.linux.dev, stable@vger.kernel.org
References: <20240529-drop-counted-by-ports-mxser-board-v1-1-0ab217f4da6d@kernel.org>
 <d7c19866-6883-4f98-b178-a5ccf8726895@kernel.org>
 <2024053008-sadly-skydiver-92be@gregkh>
 <09445a96-4f86-4d34-9984-4769bd6f4bc1@embeddedor.com>
 <68293959-9141-4184-a436-ea67efa9aa7c@kernel.org>
 <6170ad64-ee1c-4049-97d3-33ce26b4b715@kernel.org>
 <CAGG=3QU6kREyhAoRC+68UFX4txAKK-qK-HNvgzeqphj5-1te_g@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAGG=3QU6kREyhAoRC+68UFX4txAKK-qK-HNvgzeqphj5-1te_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 213.140.88.194
X-Source-L: No
X-Exim-ID: 1sCbQI-000zIv-2W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d58c58c2.rev.dansknet.dk ([10.0.0.182]) [213.140.88.194]:46746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAhf2r85ew2rJnWMrEcRvPwxDdCzQQhBJ52/4J2JitPgC5WhNBqatcvSUZqTvSs5BSImn0vV+rmTA9do1L8kHzBUelBjBEVqJFd6BmgzYlDbJs5kIDB1
 0i0k588Iw2m7+wwaHMC2RkEGOhffYrePS1I/RvD3ad/x/ai/N5UewN4nkTSAgWhfIPX+8vm9ttgGg93yWijn64eoLOA4D4r6h3Fa4n3yvGIkzscGNnjXcR0z
 i6s9mpZ7b84QBa62rhjnwI43QvmF85rn14CvCmTtvc3sUPBmWxN9n8+Pks/vCVqv


>> So we should get rid of all those. Sooner than later.
>>
> Yes! Please do this.

Definitely, we are working on that already[1]. :)

--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=-Wflex-array-member-not-at-end

