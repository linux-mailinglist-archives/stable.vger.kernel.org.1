Return-Path: <stable+bounces-259410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABf/AofqHGpWUAkAu9opvQ
	(envelope-from <stable+bounces-259410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:12:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58800618C34
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 291293014BCF
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 02:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003031E7660;
	Mon,  1 Jun 2026 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBHlbkJq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93941E5201;
	Mon,  1 Jun 2026 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279895; cv=none; b=chLo46hE2+vOF4njr8F0y87Yl6yz0q5YEZU9jkhrQWVgsaLESCcmUbffPeWcd/ttwl4qDMrQLR8PlOj86DZUFYKkhk3AXZxN5OAbfMqGt6N6JZ58UE7lfUiqySVTODYTDXfP2LpAKypSpiYNsDdv6dBvKbf05ZxqJqmfXHvzFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279895; c=relaxed/simple;
	bh=FVy6UnIyXvnttxqiIkbX0iYQjVbQqivBmy3sYV+PTlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdym4/oRLkfvPTVANeBHZuXVaVCQKFhTCztzFH/Z1GFqGRogYIoICap1EUhksjDyY5QlNIVy020mI/BzilQLu5iYTd3CUBIGVsM68EIoKNmPyD+gwN9uUYwmr+17klKn9swPu415DYylJNpPkJrrs4czZ2k5PU19WYkRePKLLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBHlbkJq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF201F00898;
	Mon,  1 Jun 2026 02:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780279894;
	bh=32GcC6d78qY3EWfUzzJx6rdgdcgMdJ9WWmSvcskMndM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SBHlbkJqHaJfi5gwVywiTuCS+T+T4Uf9M0LqTk1oZdRnPgAbRhajKu/TNi9ZQJ82S
	 gOyPgxprzpJoKTb36UFrqKmYnIGYpGD3o9PmrbyXNQs34atA0Cr2WdRQfZ3dcNYBhP
	 xrfApXHhApg68R+PuvRaPS/SwZcP/nlhTQXAkl3WLovntojW1zTnP0nQbj2FkJ2kU1
	 nU9RTXhDMTkke6yY83vtkxu1CVRobGm4AeeAQ01RnAUhTxoxmap5EWP6KGU5vq5PA9
	 1ZChe6pVZiZXt7kBkyvsi7cwMSQRWc/zoiWJ80ria5vBx8W3sIZ8KYzS918QkijlTg
	 JQepUmj7iyKrw==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10 002/589] ASoC: SOF: topology: reject invalid vendor array size in token parser
Date: Sun, 31 May 2026 22:11:19 -0400
Message-ID: <20260601015021.rc-asoc-sof-array-size@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <daa0df3788560bd8759418d9c333e09c45368aa4.camel@decadent.org.uk>
References: <20260530160224.570625122@linuxfoundation.org> <20260530160224.642881938@linuxfoundation.org> <daa0df3788560bd8759418d9c333e09c45368aa4.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,gmail.com,linux.intel.com,decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-259410-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 58800618C34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-05-30 at 20:51 +0200, Ben Hutchings wrote:
> asize is signed and this comparison coerces it to be unsigned.  So non-
> negative values of asize that are too small will be correctly rejected
> here, but negative values will now be accepted.
>
> I think this creates a worse security problem than it solves.

I've dropped this from the 5.10, 5.15 and 6.1 queues and will pick up the
corrected upstream fix once it lands. Thanks both.

--
Thanks,
Sasha

