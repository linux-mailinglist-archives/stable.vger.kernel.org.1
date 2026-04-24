Return-Path: <stable+bounces-241002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOzQDrGY62m7OgAAu9opvQ
	(envelope-from <stable+bounces-241002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900D2461434
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB688300A132
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB43D905C;
	Fri, 24 Apr 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhzUtZQe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA662777FC;
	Fri, 24 Apr 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047725; cv=none; b=Fi+VmaOckzNlEzbZtyHcFUztyUjD7ZN3tLYhP4EBY/NigcaJEJ8QjWKkXTd0tD5L/zPYVcCe1V5FgnIsgtH0jsRcmAXxyKy7GhIXMuYpUIKGIMcGmHBTGxUokDz4cGr2sAuKSy0PUl5e4N99h0vHA5qEz/IuCELzCnOramQh2Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047725; c=relaxed/simple;
	bh=nkHrgwH5qeba3QTWRlPfWwE55LXowE6LOmN3m33bzs8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=itzmv0tB/heQCitGK5EgkVihSHi8uBAhCuH+fqKcln++bpW++Ldk8fQ3p/Ak13jNaPY8I32nJnf3F/uy9lKpjlkeoQNzHLVyixwjUJtk7+jUjb/y83tP9Phoh5j9sSQVg9oBTyRfzDRqnso9v66Y41MgMXdx9gdia20DzaNPheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhzUtZQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1059AC19425;
	Fri, 24 Apr 2026 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777047725;
	bh=nkHrgwH5qeba3QTWRlPfWwE55LXowE6LOmN3m33bzs8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QhzUtZQentjxYnghOHBdm0NgCTZ72KPFjURHFZIskggT7+kVavDyOC35A5KrkPTzF
	 ihQVGBZl5DTF7e6Ifqvt9ZmGZitDHDhpnD79IkPvg4ekObdkJK0ApUgn1ugmuVx9sf
	 6zIC1d69ocKCtqLs4F9Cx9DxVpbNM/yPGJQQ+jnL31T6VZoHQ/EcPMTV9WOgtTF2dJ
	 2t5GD0mXx1mYK247rwTJMcKKs6uXHSRhnlyDU1FsDMPsTI8JdRI7fqL9IZQZBB6YAD
	 1RrJFeHfBkL8N4QWrNY2lUb1jmv2ibhEjkvtvQQI0IH2Sr8hRvE4vECjQp4Z6h/5aI
	 h8YXBWTKx4BPw==
Content-Type: multipart/mixed; boundary="===============8303173221313970416=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37d0e232bbf92ccc5b8db490ffe6286db4b33b2df440cd0cf44b3b5cfad6a257@mail.kernel.org>
In-Reply-To: <20260424153905.354922-1-jolsa@kernel.org>
References: <20260424153905.354922-1-jolsa@kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: Do not release trampoline image in case off unregister error
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: stable@vger.kernel.org,bpf@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 16:22:05 +0000 (UTC)
X-Rspamd-Queue-Id: 900D2461434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,gmail.com,kernel.org,iogearbox.net,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241002-lists,stable=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+,1:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18]

--===============8303173221313970416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Do not release trampoline image in case off unregister error

This isn't a bug, but there's a typo in the subject line: "case off"
should be "case of".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24898396843
--===============8303173221313970416==--

