Return-Path: <stable+bounces-161768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA10FB0315A
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64D61898607
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBF127815E;
	Sun, 13 Jul 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eezoriYX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8B247DF9
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415840; cv=none; b=mGNY+UNPCVDKupVI2rNcvXNtwoyn0K/tnvrBvSS6ty02EHq4pYlZuGQLTSY8n4qPsAKEu9eEIcrM1G+RBoUAObptro4RykeqhsGicybKk4gRV3VUBy3VgPs5P9Z90inG8zrnmwKHf6wG9sB+ElwgkMyJhHDYD1vNj1pEdblgRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415840; c=relaxed/simple;
	bh=7GmVr36zRep6ZMN5xI/+uqBQoXPeTipUdwdzOLjP6C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX7RyP6tj3YXm1joO7OElKLrKakCbkTRXP5wPP/kTsEljaBjXyrjDaabB07WB1MlJev5Ge5jnY4WtRg5pBpBqmzZfolbhCTibNEIRizWI/I+R6eAFueqF3FHGSaSOAGqThv3+HGUE8O//WxKBVr39SSNKtq05yeHXkyDYRmaq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eezoriYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0292DC4CEF4;
	Sun, 13 Jul 2025 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752415840;
	bh=7GmVr36zRep6ZMN5xI/+uqBQoXPeTipUdwdzOLjP6C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eezoriYXs3exVGa5k6KueelBSQ7bGwRybpqn6B+L+3CoknGVhDsEYbzkeitemMpE5
	 UdK+NHcgnbGJmjSe6yZNJoPhXVskTtfTizHU5Hpzkhy1ATNicPziykS715LkzVmTq4
	 pqXXA2fXv7r1P36sJmSJhqegIrQxL/xxENF41UOw=
Date: Sun, 13 Jul 2025 16:10:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rainer Fiebig <jrf@mailbox.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: TSA-mitigation not working: "no microcode" although
 microcode-revision should suffice
Message-ID: <2025071336-obsession-aching-ded8@gregkh>
References: <66ec28bc-b9db-95e9-b3d4-5faaa03e0f78@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ec28bc-b9db-95e9-b3d4-5faaa03e0f78@mailbox.org>

On Sun, Jul 13, 2025 at 03:12:42PM +0200, Rainer Fiebig wrote:
> Built 6.12.37 with CONFIG_MITIGATION_TSA=y on a Ryzen 5700G system.
> According to [1] the minimum BIOS revision should be
> ComboAM4v2PI 1.2.0.E which is installed.  According to [2] the minimum
> microcode revision required for that CPU is 0x0A500012.  Installed is
> 0x0A500014.  So I think the mitigating should work.  But this is not the
> case:
> 
> ~> dmesg | grep -Ei 'ryzen|microcode'
> [    0.171006] Transient Scheduler Attacks: Vulnerable: Clear CPU
> buffers attempted, no microcode
> [    0.288006] smpboot: CPU0: AMD Ryzen 7 5700G with Radeon Graphics
> (family: 0x19, model: 0x50, stepping: 0x0)
> [    0.480729] microcode: Current revision: 0x0a500014
> 
> I'm wondering why the mitigation isn't working.  Thanks.
> 
> Rainer
> 
> 
> [1]
> https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7029.html
> [2]
> https://www.amd.com/content/dam/amd/en/documents/resources/bulletin/technical-guidance-for-mitigating-transient-scheduler-attacks.pdf

Should be fixed in the next round of kernel releases, see this fix if
you want to grab it now:
	https://lore.kernel.org/r/20250711191844.GIaHFjlJiQi_HxyyWG@fat_crate.local

Let us know if this doesn't solve it for you.

thanks,

greg k-h

