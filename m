Return-Path: <stable+bounces-238877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBWOEK0t5mliswEAu9opvQ
	(envelope-from <stable+bounces-238877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D1042C32E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8C02312FCF9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BD33ACA4C;
	Mon, 20 Apr 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joaJRXqv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EB3AC0FF;
	Mon, 20 Apr 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691290; cv=none; b=H0VtYmAEou4hWuDkKYoBZxBnfUYAUB40haOEmax9RPLBVIHiHWC4L4tUoRcN+kdNhuXMAPBjvyp6U1Udq4S8QzNbCSJbv+vvpNtEh9rc6+Udgs/2YoetJhIApMK59XLWZIJY4RpbDMFH6vi7i/z0ovjI/h6hbsH1mWDBloIbuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691290; c=relaxed/simple;
	bh=5s0WCW5ncurEKPR3DliQJ/wktBb9wJvN/Ob3yPyMsOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmLOfa5NoFc2sxYGQAaWqqibppJK1fsUMmMnVuAo4b7jwwsgPjw7P2sZqRIgQkb92iG4ptdruh7+xjHGxwc64RBnoPhobog9BySDEG8y1rPGzBBFpv2HqQkB2++c9Ju+mEcF36G5Zd58Bph/eq9iLYdwvej3Ft+fPzgMf8KmnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joaJRXqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F550C2BCB4;
	Mon, 20 Apr 2026 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691290;
	bh=5s0WCW5ncurEKPR3DliQJ/wktBb9wJvN/Ob3yPyMsOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joaJRXqvlwXjVLJjA69d/Zz39I4UEVUN0LTfxQWleL9jKahMAaIQ2MO2rYqi1BjWG
	 bEwPda650UXLOr8AJ3osMw3l6KPfuO8RzcQRf1dWXgx9SlTfHFg1AEro9vB0YMteu5
	 PXFL9BLrk+RFwfGLkLbByybiGyBtDcP/m4tF4Hm5XFWkyuNm+1TGI8iUoT7p+JYMXl
	 3rxkHjftQNia2zfqR9x+TsTI19dwo++NY/z7D87I+QRaHFzywv4/Tu+4d4GtDBhG7M
	 VWtojjQfRuzi1FJAaCTQJw1nPEyzOaa9Oz7qwvfg+vvLyxpFsVwlXmabmnN4yVWuUQ
	 WChP061I1yPcA==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.6.y] blktrace: fix __this_cpu_read/write in preemptible context
Date: Mon, 20 Apr 2026 09:21:11 -0400
Message-ID: <20260420-stable-reply-blktrace-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416100859.2492-1-681739313@139.com>
References: <20260416100859.2492-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238877-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20D1042C32E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026, Rajani Kantha wrote:
> Backport of da46b5dfef48 ("blktrace: fix __this_cpu_read/write in
> preemptible context") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha

