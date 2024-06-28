Return-Path: <stable+bounces-56067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE8591BDC0
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 13:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D551F23BBB
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31569157A48;
	Fri, 28 Jun 2024 11:47:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22197154433
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575253; cv=none; b=MKAPQa5SMeq9WPFPem/dsDKNuiMGAicNkJbdpJEmitE4kIoR+jPghbByY6U7xATXsGepSuCwhtaZQa3wErTO/LpSjrvKA902VKwscMfiC5JHVciuFaq2BzDDbgf2Qwx7gs0b8VpLTZLBY33K02crwvJYDlCLAYcD+NfZ5JBLHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575253; c=relaxed/simple;
	bh=Om8IpS9dvcebCbOyi3tV9G13SwZJKmbdzmAhpG3gXos=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a8DE5wQ3IHCpCgzbLLHIWePgpIL0Yemq8hUjHIhVFbfmQw2acX7tGZA38Oa9TtAQRYYveJMiTsj1mnmx9qWhlM8AYB8aX5RDDm1RGMnMd9gPe2ZEzNcEmU/nk259n1ovRendmtcjeHTrbUlJ2L4ulWZyJWM6MfGfCH8o96tW4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 4B28C72C8CC;
	Fri, 28 Jun 2024 14:47:23 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 3F0C136D016C;
	Fri, 28 Jun 2024 14:47:23 +0300 (MSK)
Date: Fri, 28 Jun 2024 14:47:23 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Subject: CONFIG_LEGACY_TIOCSTI support in stable branches
Message-ID: <20240628114723.dnrkvdmiweteccrf@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Sasha, Greg,

Can you please backport CONFIG_LEGACY_TIOCSTI support into stable
kernels?

This, perhaps, would include there mainline commits:

  83efeeeb3d04b22aaed1df99bc70a48fe9d22c4d tty: Allow TIOCSTI to be disabled
  5c30f3e4a6e67c88c979ad30554bf4ef9b24fbd0 tty: Move TIOCSTI toggle variable before kerndoc
  b2ea273a477cd6e83daedbfa1981cd1a7468f73a tty: Fix typo in LEGACY_TIOCSTI Kconfig description
  690c8b804ad2eafbd35da5d3c95ad325ca7d5061 TIOCSTI: always enable for CAP_SYS_ADMIN
  3f29d9ee323ae5cda59d144d1f8b0b10ea065be0 TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig
  8d1b43f6a6df7bcea20982ad376a000d90906b42 tty: Restrict access to TIOCLINUX' copy-and-paste subcommands
  
Thanks,


