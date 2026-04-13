Return-Path: <stable+bounces-235901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOKVEz9x3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 231233E7493
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59813064944
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAC38F954;
	Mon, 13 Apr 2026 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwCxuBkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7137CD55
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053646; cv=none; b=pxRr9KriYEFau9nqL+AsTOyIfQMjpwp2sQDvgvR5ekEGIVf08M+wPsP5E/I12dDxDy9mdfOmNLzOf/Lh6ZVn0rEduBQ0Qy01xp2EyRmfrAJtBdjtYeZLyf2dtYVjLynKRGxzKme2mnvJoJcRjF1pGx0tbvh0ThSd4uY8pNiXSd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053646; c=relaxed/simple;
	bh=Q2zzcdXfJ7s/dJiTtkE2b0mUlMNItsUXKCp+GBK8Jhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIMrDmOddBAIVmxcvX07KH2eHsyomm+PhxgLf/o/1nb1P9MMBPvcV75X+2Yl03UmBVRW1XjhqkVoA3o/3ca1uHHXMIHAh8HanWtkftcLFeNyFNOPJR3WCiB6H8ud6SCfhqOT0yxX8EAbp0YiN2G4v9vnz2RRo2LpiY+cp9ZUamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwCxuBkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE3C4AF09;
	Mon, 13 Apr 2026 04:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053645;
	bh=Q2zzcdXfJ7s/dJiTtkE2b0mUlMNItsUXKCp+GBK8Jhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwCxuBkWPH+xobRgJ5wQ/CsIJRdAQCH4X5QLeyjk+Ww6nbLy5DGr1DNWn6bqUeQsZ
	 p4WyNMI8e93uLvPja74qaPgZx4zqw4ykFPW63hPOHn4l/awbT5VvIJrKM5ktVtdA6a
	 xAc+SaPhv8Nm3xVnzoJ3AwlZ30lQ5qzTHlPVWWF0eSFNvEp2B759WE9VzhRwq1uvbf
	 e1XC2+lDvI2gsTl5FhWEfK+ZQKQp0eGQAIyzUPpK1B1wRWGu3/bRY6gDIYpSDR96VY
	 lgIsGnBqS3hUXu5ni1N7tBfUWkAerelJXaBGBXUIdYOUlarnZWDRbaXqkpf+2fOL6g
	 tRQPVBHP48MpQ==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5.15.y] iio: adc: ad7923: Fix buffer overflow for tx_buf and ring_xfer
Date: Mon, 13 Apr 2026 00:14:03 -0400
Message-ID: <20260412120103.iio-ad7923-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409065147.136824-1-rob_garcia@163.com>
References: <20260409065147.136824-1-rob_garcia@163.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235901-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 231233E7493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 5.15.y] iio: adc: ad7923: Fix buffer overflow for tx_buf
> and ring_xfer

Queued for 5.15, thanks.

