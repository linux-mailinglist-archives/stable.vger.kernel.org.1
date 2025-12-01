Return-Path: <stable+bounces-197906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33530C97163
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E9254E12A5
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF602D7395;
	Mon,  1 Dec 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vL1VDFsr"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA512D5C91;
	Mon,  1 Dec 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589282; cv=none; b=hIZmGa8YIKyWJs97V45Y+HWKO8Iu7y5FGlxngMzGdhDUBk1PuEYvjMxWlGWN1lQxLPUs/4q0WUJxbUgEQbtOZ/uzjwiKD+8zELGXhe/oDtEPfU6tfyWGdNjEXQqgyBCNv/Q19Kb5NvNpYsKfdTjwIzJ+y/xUPmM1Yiwl5kf6+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589282; c=relaxed/simple;
	bh=xLJmrBaJqJetF3Kw6malLTrrFgKJR1gcJPs0rsaf9Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5aGu7I4h+9fHE83XZEvtYJ3rodUfEKdf/MqEyWJyvIWWxZxlQRIelDCYavB+WufM+gvfIoC94xArzGZvJW51V0/7hRKN52SbNyRDUOoZBXnP+QR+QbIiAowFKPmemytIqUQ8SCZBc/V+23Vb71dZz90ibckzUCjiNfp5B9z2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vL1VDFsr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tu+zEO5TOkBKXFztUIPVXvLAdzZuldCKDdzJCF1ev4M=; b=vL1VDFsrqQNlkN5Oc2T82kOo0u
	ZyfXAi0lr2o+5iAi6NCziRKAomHRQqtpTgOBzxYxQ45eW4jQk/IjNTS+uwp3Sis+7jiZO4nrLXhEQ
	b61kTJHV7wsDbYjlTQ2Tdd5awFC/BysYexfkwArOGWTYUjN7/+Ttdsx8/0+tm27jS1Q5TrsZgXM7R
	7I/iZW4pW2Dh4k+ZW1GWAwrBalOVLmLFDD+arbgAGKZz0+3EcWh82YKEgsouS2aBpLFm/Lj9hFlOq
	MheFo7lliNOJ3OxuHNEF1lK6YS1LAx5NJ3Y3RR2etNfGCaoyxofqg+HSLpaRRO7quFOYE2slaINI3
	9SdcEFGg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vQ2HJ-000bzf-M1; Mon, 01 Dec 2025 11:41:13 +0000
Date: Mon, 1 Dec 2025 03:41:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: akpm@linux-foundation.org, pjw@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, coxu@redhat.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: kernel: initialize missing kexec_buf->random
 field
Message-ID: <guxpoj5tie3qunqn5vsqbc5mtmcq5a77acbwl6wmdbyxf7gjls@m2dlxkiiysl4>
References: <20251201105118.2786335-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201105118.2786335-1-yeoreum.yun@arm.com>
X-Debian-User: leitao

On Mon, Dec 01, 2025 at 10:51:18AM +0000, Yeoreum Yun wrote:
> Commit bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> introduced the kexec_buf->random field to enable random placement of
> kexec_buf.
> 
> However, this field was never properly initialized for kexec images
> that do not need to be placed randomly, leading to the following UBSAN
> warning:
> 
> [  +0.364528] ------------[ cut here ]------------
> [  +0.000019] UBSAN: invalid-load in ./include/linux/kexec.h:210:12
> [  +0.000131] load of value 2 is not a valid value for type 'bool' (aka '_Bool')
> [  +0.000003] CPU: 4 UID: 0 PID: 927 Comm: kexec Not tainted 6.18.0-rc7+ #3 PREEMPT(full)
> [  +0.000002] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [  +0.000000] Call trace:
> [  +0.000001]  show_stack+0x24/0x40 (C)
> [  +0.000006]  __dump_stack+0x28/0x48
> [  +0.000002]  dump_stack_lvl+0x7c/0xb0
> [  +0.000002]  dump_stack+0x18/0x34
> [  +0.000001]  ubsan_epilogue+0x10/0x50
> [  +0.000002]  __ubsan_handle_load_invalid_value+0xc8/0xd0
> [  +0.000003]  locate_mem_hole_callback+0x28c/0x2a0
> [  +0.000003]  kexec_locate_mem_hole+0xf4/0x2f0
> [  +0.000001]  kexec_add_buffer+0xa8/0x178
> [  +0.000002]  image_load+0xf0/0x258
> [  +0.000001]  __arm64_sys_kexec_file_load+0x510/0x718
> [  +0.000002]  invoke_syscall+0x68/0xe8
> [  +0.000001]  el0_svc_common+0xb0/0xf8
> [  +0.000002]  do_el0_svc+0x28/0x48
> [  +0.000001]  el0_svc+0x40/0xe8
> [  +0.000002]  el0t_64_sync_handler+0x84/0x140
> [  +0.000002]  el0t_64_sync+0x1bc/0x1c0
> 
> To address this, initialise kexec_buf->random field properly.
> 
> Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly")
> Suggested-by: Breno Leitao <leitao@debian.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for the fix,
--breno

