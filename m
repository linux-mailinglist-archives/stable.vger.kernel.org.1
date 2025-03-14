Return-Path: <stable+bounces-124407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F328EA6085E
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511A73ACB47
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBB113D26B;
	Fri, 14 Mar 2025 05:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0e0ub/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6781E86E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930789; cv=none; b=dcx+14yDj/TcmiIlw4fKTB4a3FcCYXweH+H07/m1CJHLgKvGMU2XNjb/pO52f2mpb6UMsJcGj5xRRvZ44MR3yhFLN8hweNgqulIxyoAq8rhx6evcAWxJIgQKq95wiOdbRGm2GdN+S+z3mk56Tk8qs50UB/oLvztNg84UmrXA3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930789; c=relaxed/simple;
	bh=XxJHdsWRFikwHuszEMabmo3HhC5hYC/LY5t+WYb7Oa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERZTwNZ7z+igy/e/J6KqSH0c8jqv2DwT7TgaqGgfz+wb5ek72WicskMSmehPzMzh7HjPp5r77ebt2eYmRM4J7bVg80poeq6Qzcq6ZKPCVUdJthvoofHEh6txXVEltHYjzIwY+7w+SjOhQyxrBrjLVu56IscRpXS2p3x1272OQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0e0ub/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E654C4CEE3;
	Fri, 14 Mar 2025 05:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741930788;
	bh=XxJHdsWRFikwHuszEMabmo3HhC5hYC/LY5t+WYb7Oa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0e0ub/V5tF17m69NtLngU0e9wUmVr1Gma99R6ZFV45VI7wAlgQnCBYayK04PicFk
	 fSmJU2btabyDcFHz1ygBzACXeA/MX/cOIqqeZyKwS17AzmjsqD51oVzEb7HrK/rsbn
	 AyPvGuKzlcFBaT5b0G1P7lEgLrSmcVXih4byDD64=
Date: Fri, 14 Mar 2025 06:39:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
Message-ID: <2025031408-dividers-alphabet-d26c@gregkh>
References: <b39ca723-16a4-42a2-b8ca-b97d0e4bf7f5@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b39ca723-16a4-42a2-b8ca-b97d0e4bf7f5@manjaro.org>

On Fri, Mar 14, 2025 at 08:18:27AM +0700, Philip Müller wrote:
> For some odd reason 5.10 kernel series doesn't compile with a newer
> toolchain since 2025-02-09:
> 
> 2025-02-09T17:32:07.7991299Z   GEN     .version
> 2025-02-09T17:32:07.8270062Z   CHK     include/generated/compile.h
> 2025-02-09T17:32:07.8540777Z   LD      vmlinux.o
> 2025-02-09T17:32:11.7210899Z   MODPOST vmlinux.symvers
> 2025-02-09T17:32:12.0869599Z   MODINFO modules.builtin.modinfo
> 2025-02-09T17:32:12.1403022Z   GEN     modules.builtin
> 2025-02-09T17:32:12.1475659Z   LD      .tmp_vmlinux.btf
> 2025-02-09T17:32:19.6117204Z   BTF     .btf.vmlinux.bin.o
> 2025-02-09T17:32:31.2916650Z   LD      .tmp_vmlinux.kallsyms1
> 2025-02-09T17:32:34.8731104Z   KSYMS   .tmp_vmlinux.kallsyms1.S
> 2025-02-09T17:32:35.4910608Z   AS      .tmp_vmlinux.kallsyms1.o
> 2025-02-09T17:32:35.9662538Z   LD      .tmp_vmlinux.kallsyms2
> 2025-02-09T17:32:39.2595984Z   KSYMS   .tmp_vmlinux.kallsyms2.S
> 2025-02-09T17:32:39.8802028Z   AS      .tmp_vmlinux.kallsyms2.o
> 2025-02-09T17:32:40.3659440Z   LD      vmlinux
> 2025-02-09T17:32:48.0031558Z   BTFIDS  vmlinux
> 2025-02-09T17:32:48.0143553Z FAILED unresolved symbol filp_close
> 2025-02-09T17:32:48.5019928Z make: *** [Makefile:1207: vmlinux] Error 255
> 2025-02-09T17:32:48.5061241Z ==> ERROR: A failure occurred in build().
> 
> 5.10.234 built fine couple of days ago with the older one. There were slight
> changes made. 5.4 and 5.15 still compile.
> 
> Wonder what might be missing here ...

Can you bisect down to the offending commit?

And I think I saw kernelci hit this as well, but I don't have an answer
for it...

greg k-h

