Return-Path: <stable+bounces-146220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC6AC2AA5
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 21:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1257A7BFD
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BEC1B87D5;
	Fri, 23 May 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AZKXWgUx"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295921ACEB7
	for <stable@vger.kernel.org>; Fri, 23 May 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748030066; cv=none; b=fhnGIVZPj994gY7zCj8wuxIAARX+lUkZSFx56j2H6Mz8ednO0JCgPNAnI5IBYOHbWzGMk0ijavAPrIja1HZqHfwunAu3NZtjgtFHitMQ6ye9Nf8iVr+zq8/sKFqZX8XSTvekegnxwa9z8eix/XG64PVw/3zSgcZuihtpKcU0yBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748030066; c=relaxed/simple;
	bh=JckrqZ/X2636tFrZExWbukBYoJ5+F9T1SvTVsgXpv7s=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=aWRSq50gJgHQGRUkNtkmi486BCpH1jOHCDhQehczRGR5qig7nnAeCWfh6Q8U/BR/BsT8y5lfWa5YR7nxK7+8OPbaqzT5gNxpit4RFH7KOTss5poHA/QzCc7VbVp6v6gzsX/YVSNBt8XtwG/G6Z7BY0TAsw6l9SneEduoA9xOYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AZKXWgUx; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b3wpZ1389z9sc2;
	Fri, 23 May 2025 21:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748030054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=sOxLISZAx4Kbsd20IFxPiPiDmdOOp3DjjyaHJpq23/Q=;
	b=AZKXWgUxRbY1Bt3YF7GpJUadtqHObSUOnSONI4bLOzhsNf6Fvwfk13kdaD+iSgGUZuxofm
	pnhSDVjwJxG27LE6AiifwwmkeiOQTEBaDKUZfqYRN9vHB4US0gJofGufp6DZ+ARIHXfD19
	g0GAS79yWmFToI7+WOG2XfvWkrwSnwBAHMPoYEdpelf1kbQ2taMq2osHW3x9Zdga+uK3vU
	pybTNWVVB5auIX5zUey40lqzzy5i3gVQN2P7LeToWOIQONI0mQrBYkJ6hJDjJ+6mK2klkn
	GthAk3d1yWYmVZ4KCrc1YGV6pOLseZAJvfTZJGs1723HT9KexeNDJ2c1tsEMAA==
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
From: Rainer Fiebig <jrf@mailbox.org>
Subject: 6.12.30: black screen after waking up from hibernate; bisected
Autocrypt: addr=jrf@mailbox.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <884d3e56-1052-0ca0-2740-f597ba7031c1@mailbox.org>
Date: Fri, 23 May 2025 21:54:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 59qo5maz6qw9cr9nbftanhyohiez3dfu
X-MBO-RS-ID: 7155364bfc2f585e913

With kernel 6.12.30 waking up from hibernate fails in a Ryzen 3 5600G
system with the latest BIOS. At the end of the wake-up procedure the
screen goes black instead of showing the log-in screen and the system
becomes unresponsive.  A hard reset is necessary.

Seeing messages like the following in the system log, I suspected an
amdgpu problem:

May 23 19:09:30 LUX kernel: [16885.524496] amdgpu 0000:30:00.0: [drm]
*ERROR* flip_done timed out
May 23 19:09:30 LUX kernel: [16885.524501] amdgpu 0000:30:00.0: [drm]
*ERROR* [CRTC:73:crtc-0] commit wait timed out

I don't know whether those messages and the problem are really related
but I bisected in 'drivers/gpu/drm/amd' anyway and the result was:

> git bisect bad
25e07c8403f4daad35cffc18d96e32a80a2a3222 is the first bad commit
commit 25e07c8403f4daad35cffc18d96e32a80a2a3222 (HEAD)
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Thu May 1 13:46:46 2025 -0400

    drm/amdgpu: fix pm notifier handling

    commit 4aaffc85751da5722e858e4333e8cf0aa4b6c78f upstream.

    Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
    the resource evictions properly in pm prepare based on whether
    we are suspending or hibernating.  Drop the eviction as processes
    are not frozen at this time, we we can end up getting stuck trying
    to evict VRAM while applications continue to submit work which
    causes the buffers to get pulled back into VRAM.

HTH.  Thanks.

Rainer

-- 
The truth always turns out to be simpler than you thought.
Richard Feynman

