Return-Path: <stable+bounces-23467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40586123A
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1171F237CA
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C07E595;
	Fri, 23 Feb 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jFYkctMu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193057AE78
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693628; cv=none; b=HoDugqQgx1c0r0JAj6WiS/6YcQLpUAS5t4XYn9AGquxBwx2wfgF5doLNfw4IipwERJ51HcIt7fjoFXKQWSyvNMeSD5ObehqDGKGmSzsDlu3ZcBmVihA96GHrJmV4KYAL7/QyHXURaqvRwsx6A5HiyA4k9xl20LRL8UUQQi2s42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693628; c=relaxed/simple;
	bh=8gZt050z+v0eCcMuwYfs/Rkdvt+l6RduyVyuFFF7LxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqYyWT4+yvSAoy2Z1BDaZkK6Srk/BRBVqlbsaYWmN2QtnjN5Uvd+PF5Qa43BgdMZppW+dyFopFiogStBUOT0AgMtD2Wts5tSgUCIRkLbnq3fdWl6Cu14I4TkyBs1ox44WcJ5u5nnDQMYkyStxI8TUuJq18Q5Z1kGv9zs77Mc0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jFYkctMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416CBC433C7;
	Fri, 23 Feb 2024 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708693627;
	bh=8gZt050z+v0eCcMuwYfs/Rkdvt+l6RduyVyuFFF7LxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFYkctMujm7AGW5B6HlymtHOYTEChNSBUs6nmOnt/EEUIMH7i/CamFlniXK+0QmoQ
	 I8AjCqZYlaQ09ocFjruJQzcKm4a4EhWBHhTm5NcCPrwCGF9+ErFB55+xlHVQlN/RVg
	 ShAqcQAjUK8HXtyYkZ4KCKRs+MPIVnSlXDK0sNS0=
Date: Fri, 23 Feb 2024 14:07:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
Cc: stable@vger.kernel.org, ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH 5.10.y 0/3] Backport Fixes to 5.10.y
Message-ID: <2024022356-renewable-armhole-93da@gregkh>
References: <20240210201445.3089482-1-guruswamy.basavaiah@broadcom.com>
 <20240210201445.3089482-4-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210201445.3089482-4-guruswamy.basavaiah@broadcom.com>

On Sun, Feb 11, 2024 at 01:44:45AM +0530, Guruswamy Basavaiah wrote:
> Here are the three backported patches aimed at addressing a potential
> crash and an actual crash.
> 
> Patch 1 Fix potential OOB access in receive_encrypted_standard() if
> server returned a large shdr->NextCommand in cifs.
> 
> Patch 2 fix validate offsets and lengths before dereferencing create
> contexts in smb2_parse_contexts().
> 
> Patch 3 fix issue in patch 2.
> 
> The original patches were authored by Paulo Alcantara <pc@manguebit.com>.
> Original Patches:
> 1. eec04ea11969 ("smb: client: fix OOB in receive_encrypted_standard()")
> 2. af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
> 3. 76025cc2285d ("smb: client: fix parsing of SMB3.1.1 POSIX create context")
> 
> Please review and consider applying these patches.

All now qeued up, thanks!

greg k-h

