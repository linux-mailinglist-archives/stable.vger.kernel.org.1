Return-Path: <stable+bounces-123226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BEAA5C3B4
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FB77A24B8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605672571D8;
	Tue, 11 Mar 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Blk3qBcb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E417C9F1;
	Tue, 11 Mar 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702971; cv=none; b=pGNFpbqDo2HtV0/vdSk2uvggDH1PfsrIddu87IcCPfMdn03ywW7x2GejbVqMsZAijuUFwL8rxbVoMbUUIVkvOkZmejRZQIzFaqgE2BVM4hCbE4HDjByAevEIK6obczuzNzjAfDFMbdIBJYn+YVI0CzJUVdYp3vHUWv765OkTWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702971; c=relaxed/simple;
	bh=lW9JgeTCgja/9QF2Gj21kVDR6N5RMaq482Rv2AlFh9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdzFRidb/ogaMRWi+YHNergwudCoPipmcPhxG2P44wPt5Mozgp8K4KZQ2Q8JMwzks2rx8Yqj1Z6RTe+zTDkgP96DTWQ6e9FpimHuG4+LIrofXwUY+ylnlbPdtXAT5rdLOJcm6G06/T6PRN/CEGlPx6+scecc/FZL2B3YhzUNGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Blk3qBcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CDBC4CEE9;
	Tue, 11 Mar 2025 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741702970;
	bh=lW9JgeTCgja/9QF2Gj21kVDR6N5RMaq482Rv2AlFh9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Blk3qBcbEgQ5bZNcbUSI81pVjM0Gyrj+56eke5K3TPsaKF2o+/qXQzzuncj7BQClz
	 xIzvoSoZS6gINQh76en8c56BGuiy1wskXzSh/H4FaIqCJPbsmPRScsODQ7aoskBgnR
	 7mezpvRsEkiI+G1GmFCPrZcKk7EGVderUIMVFZXc=
Date: Tue, 11 Mar 2025 15:22:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, gus@collabora.com, stable@vger.kernel.org
Subject: Re: [REGRESSION] stable-rc/linux-5.10.y: (build) in vmlinux
 (Makefile:1212) [logspec:kbuild,kbuild.other]
Message-ID: <2025031121-aged-stand-c8f3@gregkh>
References: <CACo-S-0BKPQcA2Qh-7jmuU-YuX9E_wWcHEgr8pDhgwkzt0K5cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACo-S-0BKPQcA2Qh-7jmuU-YuX9E_wWcHEgr8pDhgwkzt0K5cQ@mail.gmail.com>

On Tue, Mar 11, 2025 at 01:47:06PM +0000, KernelCI bot wrote:
> Hello,
> 
> New build issue found on stable-rc/linux-5.10.y:
> 
> ---
>  in vmlinux (Makefile:1212) [logspec:kbuild,kbuild.other]
> ---
> 
> - dashboard: https://d.kernelci.org/issue/maestro:d5c2be698989c7de46471109aae8df0339b713c1
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> - commit HEAD:  a0e8dfa03993fda7b4d4b696c50f69726522abba
> 
> 
> Log excerpt:
> =====================================================
> .lds
> In file included from ./include/linux/kernel.h:15,
> net/ipv6/udp.c: In function ‘udp_v6_send_skb’:
> ./include/linux/minmax.h:20:35: warning: comparison of distinct
> pointer types lacks a cast
> ./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
> ./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
> ./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp’
> net/ipv6/udp.c:1213:28: note: in expansion of macro ‘min’
> In file included from ./include/linux/uaccess.h:7,
> net/ipv4/udp.c: In function ‘udp_send_skb’:
> ./include/linux/minmax.h:20:35: warning: comparison of distinct
> pointer types lacks a cast
> ./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck’
> ./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp’
> ./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp’
> net/ipv4/udp.c:926:28: note: in expansion of macro ‘min’

This warnings I can understand, we'll just have to live with that.

But:

> FAILED unresolved symbol filp_close

What is that from?

Seems to be from 890ed45bde80 ("acct: block access to kernel internal
filesystems")?  If so, that's really odd as this is not a new call to
this function, but just some additional ones.

thanks,

greg k-h

