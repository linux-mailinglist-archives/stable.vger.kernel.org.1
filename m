Return-Path: <stable+bounces-119871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E6A48BF8
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 23:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78F916CF08
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0E277818;
	Thu, 27 Feb 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="nUGY9cHs"
X-Original-To: stable@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6250277811
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696408; cv=none; b=tMey/6E5gbknLOteCXkHVio8UIn66nxkV1cmqhniSEMpqtjLMSdK5fZWMxVDhBQpr+xJWanmufnlGiaOaE1UKMpn0rCEzWi/1REfBtbOZyw4imfcXADceog9v1PjIjwRgbuGmetYEaJVihsGwgmsCgikXqOTd8WeixAiJbVm/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696408; c=relaxed/simple;
	bh=KoAelO3UQhx4BiU0JlCnoBne078B35Gbito6xzKiVTs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dn7bC4zVnf04ORm4I4MNxe7aHjcvTvdruYP8xGftkE9A12ybOfuo6jy2znESNIvUIBluhMbq3EkT8IxT1BCv7h92fSz3vfl33UzHtR35BxoZ2xrap7TjEJsY18kNfiLPMUV3UidMKcaJQvYQjaQoF6p5xIBJkvuSw5i+JdvQ7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=nUGY9cHs; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 05059240027
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 23:46:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1740696404; bh=KoAelO3UQhx4BiU0JlCnoBne078B35Gbito6xzKiVTs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:From;
	b=nUGY9cHsWABKWbLI5zl/nQWidunG/8rw1VBANAHdnKyr1IqnZm0km3RyA566lpHKc
	 4PWt1840vUR15MN+wh7Sn1qOAl8PVJFQ6AnHK7lW6VrPOPRZAK6I9mBVF/SccaGPz1
	 XnR0IUxslnuHh+eL86Egp/+SaKQV6xqtZ4trrugbmAqRKOFmmlyzCK1nlvBtDT+N2B
	 LQvnaq4wQ4Tz4qDAaAsw8aN3em1YfeJEmsG9zBMd2OM9LZSoJ4T3NhyB2Ff6oAdLLV
	 3rh1I8YjqGt0P4RXSIVR+qRqKbKkwS3LmkEeVFtsI83gDZQDbsXIjDmbDaHB4dspM5
	 xM9IWSUiGG9OQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z3mfq5GN8z9rxF
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 23:46:43 +0100 (CET)
Received: by df1tl.local.here (Postfix, from userid 200)
	id 7CCDB54A3AD; Thu, 27 Feb 2025 23:46:43 +0100 (CET)
Date: Thu, 27 Feb 2025 22:46:43 +0000
From: Klaus Dittrich <kladit@posteo.de>
To: stable@vger.kernel.org
Subject: Unknown bug in linux-6.13.x running qemu
Message-ID: <Z8DrUymWnXQkJgVt@df1tl.local.here>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I discovered a bug that appears in any 6.13 kernel within quemu
but not in any 6.12 kernel.

I use quemu-9.2.2 to run windows10 in it and there I use a program
called sprint-layout-6.0.

This program saves and loads his files via samba,
so I have them on my linux-ext4 disk and not in the
disk-file quemu uses.

It worked for years now and it still works with all 6.12.x
kernels up to now.

But it does not work with any 6.13.x kernel up to date.

The bug shows up when I try to load a file from within this program,
then the emulated windows10 pops up a window with "exeption 8000004".

I do not know what this is trying to tell me, but under any 6.12.x
and older kernels this did not happen.

So I assume a bug in 6.13.x kernel is the cause.

I also reported this to qemu but got now answer up to now.

Any help is welcome, thanks.

-- 
Best regards
Klaus

