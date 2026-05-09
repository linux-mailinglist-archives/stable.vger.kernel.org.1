Return-Path: <stable+bounces-244884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMUaGi+X/ml5tAAAu9opvQ
	(envelope-from <stable+bounces-244884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:08:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DFE4FD8A6
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D4D53009CFA
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 02:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09E276049;
	Sat,  9 May 2026 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNCdcpjd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C124B28;
	Sat,  9 May 2026 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292524; cv=none; b=YCmMa83JcWjQx8VP80/ScnUw2NbuZ7XFiWJUASspg4pDb59LfwzxW3mUOlqbfUEsW5vp2P9zfBiOYZyrNV+iXUI8T6xlKG1wn7MBSrAiKkFxFyVFIN6u0+LMRTpYjOdOCH/D96Iv5O6zCcdyCatdZGhZRGK3uN36UQU49bIgV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292524; c=relaxed/simple;
	bh=PWb/8pCuWmCJG+nVLKaEaMBPk2nfmeH5Kmbn10R4gPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8mDBqx3L9+zHuVZV+6uJ6MCl4Go7h7fCtdSxTDg+cKkk1Ofx3jmwBw3zua9olzgRPiD8qjRAqhxyDyWTVieeNv00wDJ6tGA2TIQd5onit6Iddq6tFuDKJQ8ufxiwJC1h729BActjV6tuf2ZsvDjklgnWnbglGCXMq4iT+NcbnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNCdcpjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06698C2BCB0;
	Sat,  9 May 2026 02:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292524;
	bh=PWb/8pCuWmCJG+nVLKaEaMBPk2nfmeH5Kmbn10R4gPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNCdcpjdAQu5VCpW3RqA4eBTNGRtWeXp1I7HZL1DVMXAUZ8NlstN9bGWgHMzujNQB
	 qPZmjQ635nHRnYCVpye+nr/hpP4A1l9VXAaugF3ZwUsNRpN6B+gPPr5d4KAhDjilPn
	 uIGoPCuC66m82BEM3Q0A/3t/r0j6Op2BOY06eSCtqLoYGIs2BL3x8Kwzdg1BAIRbWZ
	 6jpxDFXSmGYWMKU9QlBCrkbiHMQ/bXPSBN0jTZMwyywBs9UPlkOahGJVccZ1tHVjF9
	 SI3uO37sRH6Kkz9vw/N0OyA7B10vbxxC9uWsimBy3MmTnx2RBcDKyyRzJWSCMJFC5B
	 Ad6IEkVyLdJkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 5.15] um: virt-pci: Fix build failure
Date: Fri,  8 May 2026 22:08:37 -0400
Message-ID: <20260509015927.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508205241.962178-1-florian.fainelli@broadcom.com>
References: <20260508205241.962178-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03DFE4FD8A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244884-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 01:52:41PM -0700, Florian Fainelli wrote:
> Commit a27e95a6ff3f ("um: virt-pci: properly remove PCI device from
> bus") assumed that virtio_reset_device() is present in the 5.15.y kernel
> but it is not and so backport would now cause a build failure.

Queued for 5.15, thanks.

--
Thanks,
Sasha

