Return-Path: <stable+bounces-233832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJbCIwY01mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:55:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E283BAFCA
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21432304A94C
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215E3BA258;
	Wed,  8 Apr 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/+83GUz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D23BA23D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645526; cv=none; b=kDyKzDOzlWPvb+2rXWm0TQ4IfM3rm8rc9IXBjNIGxYJO12Opdb9ZN6n2QcOYMd9gGQUcGtVTALpsDnl8o9hQoZLjalKv6TohtFYAiXgCVuyqr3PYONxiFwY0dHMhaRONZfeYXKL5DmjyNwt57uJx0K8bTqe/ZnV4PaW3arQX5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645526; c=relaxed/simple;
	bh=+WQAKg2bdjluAeHtEEPHZ+G5Wg7RDSQLeuaDyC7VZb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j71BwkOZVMks0riNRS/KTf7rSgKnmluPKLghAZWt4ctzEIgs2vcdDHm93ev2TJDhPjcZeRTAeIAKUZS7vqa6YYZp+mbydnjGBfS2GfREfvDUsS4lFD8Eq1wNF6IX2w7Nj1ORZtfPd9+XHm9824H4bT1li5TidHagqQn9xG9HMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/+83GUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6F7C19421;
	Wed,  8 Apr 2026 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645526;
	bh=+WQAKg2bdjluAeHtEEPHZ+G5Wg7RDSQLeuaDyC7VZb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/+83GUz3D7LsRb1KozIShFUMBBSmUuWUmOddNeSjQrsh4eLbpezP5wYXNFaS7noG
	 bAkuOT7f6KoQ6EGRkAExWU3/TjFydr0VszUy5L6MXkhfQm4zjShjGrY6iHjwXL9lqK
	 LEXE/CaQ0YRYduMWbICJXEqJEIRN90flYHyv7K346xq4W9fdP9yrqdUhUB8NGxgbkh
	 ZufaJpRO5yDsBIp1yzUQJSM55ZztxSbydxEGmdk+dYkl1dG9fMxH3Eo0ogSCZVcdDS
	 4Fx+b2ULXYwr0plKmfPrfuSUNM31HVGemmFzfE4CxyF54IAnqA6tXXuJvcN0pun8Su
	 T3bUSorAHnusg==
From: Sasha Levin <sashal@kernel.org>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: stable@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>
Subject: Re: [PATCH 6.1.y v2 0/6] nvme: correctly fix admin request_queue lifetime
Date: Wed,  8 Apr 2026 06:52:04 -0400
Message-ID: <20260408105204.946410-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402-moral-jockey-f072379b@mheyne-amazon>
References: <20260402-moral-jockey-f072379b@mheyne-amazon>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233832-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16E283BAFCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The initial attempt to backport upstream commit 03b3bcd319b3 ("nvme: fix
> admin request_queue lifetime") was not correct leading to refcount
> underflows and not even fixing the problem.

All 6 patches queued for 6.1, thanks.

