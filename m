Return-Path: <stable+bounces-213308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL/5MfdagmlhSwMAu9opvQ
	(envelope-from <stable+bounces-213308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:30:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7EBDE81D
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 21:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F312B3103D64
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0036E483;
	Tue,  3 Feb 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD4MhcRo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924236E466;
	Tue,  3 Feb 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150556; cv=none; b=eDqXk/zw19WTu0QWn8drsuHljns74B9PiGePtxw+V8U7LLc/g8+mJDqXyErQOAFgdF14XH7F5gvyGKeM3PUERvSXNG5yUrU564wRWnsucCs7XF3W68+CiMOJX5AXkStrw9p92vk3zAKy2rGaWljCpMpCYa2UTvcclwdxYLau9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150556; c=relaxed/simple;
	bh=U+/K7urIBk2+sycXClAu7AwekncaEdBfJhVejPJca4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS1VSEJMXPelmC4LvJbTQhNHgSA3+KueP/3ainD4ynd4i83vkCVZMFTVzJXLTXAmtlDXXGRKDELN0xX4AEEOgKqqnMqP07KU6cn8xnH0UC9QzQDLklvaLPFI7J7d6uDUdlliXU/YqCpCkWPNoLbnGr3jynmju1LbXmK7Ugz48wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD4MhcRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFA6C2BC86;
	Tue,  3 Feb 2026 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150556;
	bh=U+/K7urIBk2+sycXClAu7AwekncaEdBfJhVejPJca4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cD4MhcRoaKZ2GZcRSCzIJlet4Wz6amOIez4XNa1i6FNJAJw3AUQbXfejoddG5oLg2
	 qPYAeAKsoudhNO2/z4P/ZUJSAsdlaBKRxiSCqGCzo4MhATScMIRSz1BU6H/QVsxiAx
	 BD20pm2K9Pn0AZ5tcxj9NcwGCsYAAv5VF5sVAnJfeLcjAQvwcLK7MdZxaeTsSj4wf1
	 3Arm00zVnIzIJ2+PbSpZ7kf+K5iVKaEeXKXYM2QmaKgp2esHDjcVehQO9Qx9JNEsX5
	 sCEvgqNjOSZ2lT5ilQ/fKfzqEjpvsBH3jOFYvIRZk41QeJVoG+cTEuZpqVL7gzSljk
	 V8o8VTaSfxYGg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] perf/arm-cmn: Reject unsupported hardware configurations
Date: Tue,  3 Feb 2026 20:29:03 +0000
Message-ID: <177014783384.2669363.15366054878498759959.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <fb6a80013d47936ced4d6398388ed71594d02ee8.1770127120.git.robin.murphy@arm.com>
References: <fb6a80013d47936ced4d6398388ed71594d02ee8.1770127120.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213308-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm64.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D7EBDE81D
X-Rspamd-Action: no action

On Tue, 03 Feb 2026 14:07:29 +0000, Robin Murphy wrote:
> So far we've been fairly lax about accepting both unknown CMN models
> (at least with a warning), and unknown revisions of those which we
> do know, as although things do frequently change between releases,
> typically enough remains the same to be somewhat useful for at least
> some basic bringup checks. However, we also make assumptions of the
> maximum supported sizes and numbers of things in various places, and
> there's no guarantee that something new might not be bigger and lead
> to nasty array overflows. Make sure we only try to run on things that
> actually match our assumptions and so will not risk memory corruption.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] perf/arm-cmn: Reject unsupported hardware configurations
      https://git.kernel.org/arm64/c/36c0de02575c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

