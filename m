Return-Path: <stable+bounces-169899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D162B294EA
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 22:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2052E17B46F
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF8921CA00;
	Sun, 17 Aug 2025 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4yfuoQB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973D86352
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755460939; cv=none; b=CwyyfQv/v0KD4Yor67neuVXBTn1CYSbtt8X3uCO2d/yCcp5xnJIjUxFwvoBiuJB2QwapRXeuBIgTnM5O0cCf9kB99Pmlv4rQ1k/nDpv+2anQl3csc+22X9Eyf5Ay7iu1SCiydqKReG0JmA1SHsyLnC2qlrcSqawmSjcV6lJoNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755460939; c=relaxed/simple;
	bh=cxDZnAuT/tCoK2elc8lz7BRoJ2wpJSc6R3pRHXPeB8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHY64xcBexkA2fESc2ro57xjM8h7DzclbcpmyIpVJryY+ncx6kUrNu/HHoEa8b7vRO3FTJdtcrhWfyC/65ztMf0dg4TER/R+8pDoEsRn16lY1Tl0a8zP0fq/u1U2e+wCcifh0qKBjZ6/Tm6F7QYN1ryAldv8djzDcHnB7nVWSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4yfuoQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2908EC4CEEB;
	Sun, 17 Aug 2025 20:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755460938;
	bh=cxDZnAuT/tCoK2elc8lz7BRoJ2wpJSc6R3pRHXPeB8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4yfuoQBxnG6vafUYK6IlTjbmQfGLtpVd6maVbzTrmDZZtPqC5/twB201lyfhY9rW
	 3UP33n37EqKEXoCB6MP3n8YumEmn+V7ipmGHNgkFdApuwFyh0i4SC7bbf4KLdtmasn
	 CD/Gx4fcrvC8XeNlluPPXCNtO3Ze4JOsMFwpQ4pDHKR88eQJ0/9Qtv7lxqBHlJP0xp
	 Odda6Afd+u5xuuAyW6N07LDapKpuS17pYB0QQSl5tNE6mLwlY2R42HR+ta9zTleSNN
	 6sc3eRLkOQclbYtfUjClAtEdMJDWzGIH5OBNc4b7zCkZiMQDxraB8P/3N/W8ksw92n
	 CiACrGL6lHOhA==
Date: Sun, 17 Aug 2025 16:02:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: queue/5.15 kernel build failure
Message-ID: <aKI1SJ6YrFiQpR9o@laps>
References: <1f29bdc8-986c-4765-ba82-9d7ca2181968@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f29bdc8-986c-4765-ba82-9d7ca2181968@oracle.com>

On Sun, Aug 17, 2025 at 01:11:14PM -0400, Chuck Lever wrote:
>Hi-
>
>Building on RHEL 9.6, I encountered this build failure:
>
>arch/x86/kernel/smp.o: warning: objtool: fred_sysvec_reboot()+0x52:
>unreachable instruction
>drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
>vmw_port_hb_out()+0xbf: stack state mismatch: cfa1=5+16 cfa2=4+8
>drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
>vmw_port_hb_in()+0xb4: stack state mismatch: cfa1=5+16 cfa2=4+8
>drivers/vfio/vfio_iommu_type1.c: In function ‘vfio_pin_pages_remote’:
>drivers/vfio/vfio_iommu_type1.c:707:25: error: ISO C90 forbids mixed
>declarations and code [-Werror=declaration-after-statement]
>  707 |                         long req_pages = min_t(long, npage,
>batch->capacity);
>      |                         ^~~~
>cc1: all warnings being treated as errors
>gmake[2]: *** [scripts/Makefile.build:289:
>drivers/vfio/vfio_iommu_type1.o] Error 1
>gmake[1]: *** [scripts/Makefile.build:552: drivers/vfio] Error 2
>gmake[1]: *** Waiting for unfinished jobs....
>gmake: *** [Makefile:1926: drivers] Error 2
>
>Appears to be due to:
>
>commit 5c87f3aff907e72fa6759c9dc66eb609dec1815c

I've dropped this, thanks for the report.

It's a bit funny - my version of gcc treats it as a warning, and it actually
gives me quite a few mote "mixed decrlataions" warnings in the 5.15
allmodconfig build.

Compilers are hard :)

-- 
Thanks,
Sasha

