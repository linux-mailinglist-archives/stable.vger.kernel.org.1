Return-Path: <stable+bounces-249009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N3znOGmVCGoQwwMAu9opvQ
	(envelope-from <stable+bounces-249009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:03:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690455C84B
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7CA3009CF5
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105E30C62D;
	Sat, 16 May 2026 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOO/jYyq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E8175A9A
	for <stable@vger.kernel.org>; Sat, 16 May 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778947430; cv=none; b=oP+QNoHNSzgaCkJx5+dSWB9NnBq4Y726fY5xVb0qXAs1G2sahChtjpW05hLCDwrWKaRTg2EdQWEfJBA2DbP+5U3ZwxGCSEvAVyuXg/trZR+0K4OJJRrLW9y/6tB/rH8BA5dfC0VVDaU4HPcSrq6yguqVL/A2EWVDQjWFY3PFM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778947430; c=relaxed/simple;
	bh=dqKR01rEouDAHhsseZvRof5fs+jeLLFn+dWZlerZwJk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ZOZpS7UxiQ4oVYQoQvU7VK9FXlrTsk2fuDjZCXsM1Di/2pzSerhmgY/9EIRZ3mAUPeJYS1kbhv0XonDrK5v3qaKqulr/7JapKurFy6dlRGLgkoHwZQKiK8uHAqdyKYsvLvyzrhm3g00dvGaHKI9trUJTqTN1XLgrF3JH7hmEenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOO/jYyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86795C19425;
	Sat, 16 May 2026 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778947429;
	bh=dqKR01rEouDAHhsseZvRof5fs+jeLLFn+dWZlerZwJk=;
	h=Date:From:To:Cc:Subject:From;
	b=VOO/jYyq6/NokRzS4YYFeypn4Cpje5xSdDfPGlB5KYmViHN38l5EFZ/BpZHYv1gaY
	 JI/zHi2FbPbH+EklmUy9J/hFmMLIS7+jY87MBRKDBN4Sh6xHyuqlot/J5PtvAi4Zac
	 e44mbhKvmImDzQiuXslYf3yCRoynn8irEKQjqpSoRz58r92H6P6Rc8AbR3VeIMaMnz
	 PWtTvg2SVU6QA7qpFbxjFfirQ315Hv37e8A7Nt/yKURTkqXKh0ASzYCk98rRaH6vtr
	 MatlljJvg+RIO7z3eD5/dpercEit6Z10VWzsfyBLF3v1lrLyi6H1fFMRLCVPhsFoM1
	 Op3fPTupR96YQ==
Date: Sat, 16 May 2026 18:03:45 +0200
Message-ID: <20260516160138.835556923@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: [patch backport 7.0.y 0/3] rseq: Regression fixes for legacy/tcmalloc
 behaviour
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 6690455C84B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249009-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Greg!

The following three patches are the stable backports for the rseq patches
which rejected against 7.0.y

Thanks,

	tglx

	

