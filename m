Return-Path: <stable+bounces-72830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C78969CF6
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533081C2383F
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558F1C9849;
	Tue,  3 Sep 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DRZSxZ0s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8D1A42A4;
	Tue,  3 Sep 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365266; cv=none; b=P2Upq/vdL0qwUZcA5lMbWDmEwjwzvWyA8RsGKhyAgx2zO/Qxf/Td3W5rAWNJ7VbP2lwnONj031RR27Whl0XpDJMm51Q7XKtGv/FQSD3SjoMXCw049XCCVgkHCR5/DuEcBgLT4q5JQMEr9zmQ4kZxb9XnsUVzjeMT3OSQXTJU5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365266; c=relaxed/simple;
	bh=bT6Zkb9fI31xbhUkgfAbk6IOgwqzzoqCMqunQIcGlkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFxsWlnQLawk84WYvxEMeFoRcvHm7JIulNKR+lp4/evp5PvcvQ1ChQ10IXIdV6UMX0HLQ+wmxdcV8j1zHZbWoqwo+lKSMZnonxc+WFTFfqhWrkMvKBKeMe1ITG2NbHBzil6pVYk3ug5Pm5kiD60bkMvVtz8c7bAXplwqc7huxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DRZSxZ0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23318C4CEC4;
	Tue,  3 Sep 2024 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725365266;
	bh=bT6Zkb9fI31xbhUkgfAbk6IOgwqzzoqCMqunQIcGlkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRZSxZ0sfS1qfQb/YjCljtYvRyEM8SXriRAUJLt6bq8WWmniS3yZFc6P1O5A5DQ1s
	 74lfYEjtImipFDjUgmJJU0ojJ3JSN8a5+jL1oUEmX0bJmxWdYZLjmAsQE2iGOii8a2
	 C5gAJKZLIwTA4kbS4+0xl0xQBvXc6LKg12+mtec8=
Date: Tue, 3 Sep 2024 14:07:43 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in
 udp_lib_get_port().
Message-ID: <2024090305-starfish-hardship-dadc@gregkh>
References: <2024072924-CVE-2024-41041-ae0c@gregkh>
 <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>

On Tue, Sep 03, 2024 at 11:56:17AM +0000, Siddh Raman Pant wrote:
> On Mon, 29 Jul 2024 16:32:36 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
> > 
> > [...]
> > 
> > We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
> > set SOCK_RCU_FREE before inserting socket into hashtable").
> > 
> > Let's apply the same fix for UDP.
> > 
> > [...]
> > 
> > The Linux kernel CVE team has assigned CVE-2024-41041 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.4.280 with commit 7a67c4e47626
> > 	Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.10.222 with commit 9f965684c57c
> 
> These versions don't have the TCP fix backported. Please do so.

What fix backported exactly to where?  Please be more specific.  Better
yet, please provide working, and tested, backports.

confused,

greg k-h

