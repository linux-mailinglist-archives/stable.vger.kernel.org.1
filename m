Return-Path: <stable+bounces-245365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFKTCgVyAmowtAEAu9opvQ
	(envelope-from <stable+bounces-245365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:19:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B7517D1F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65342303717A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384281A9FAB;
	Tue, 12 May 2026 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piTczcWP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A8347C7
	for <stable@vger.kernel.org>; Tue, 12 May 2026 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545110; cv=none; b=aot8yFbvFstqZhhcWmnD51yZAOMYRGck/4saTHowqpchvG/WmPSIkxugn91AKT7K6sSLX4Se9LYlvalRlxL1SYLJf4DzaX/r/Pak48Qu1OSOgLcv+aU0Lc9aAAaWmU6JsKLQMSwwjzVPfI1z6WEKy/5MgFt1H3YT4zcPTsf8XIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545110; c=relaxed/simple;
	bh=zJiqeSbU2G2/+WqTtN8Mwar77/Uo9VrkJesOU21+sdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRLyGiyi6TVL7ST8ZLbcYYVxWH2TivnFhLPSZFR+TOaC9VqTgxRVg6tEcvVi5LRM64AR2wVyQhNrUmLU73U0zcqzAwuOcuj+AtfyUGL6CHP8m+Si9X6bvwajb4Ntdvta/mHIWih3YkmQBAPyVG4eGOQe4VzZ4CYN16IIMJehpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piTczcWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACADC2BCF7;
	Tue, 12 May 2026 00:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545109;
	bh=zJiqeSbU2G2/+WqTtN8Mwar77/Uo9VrkJesOU21+sdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=piTczcWPXI2FXAa7X0YgHRW3Ss5NeLkYWjVBDDzdRM6qQeX+McAzrslwlA+JpJuUQ
	 8H04NwyozladF7vjwVpxUmrn5Rg6Mv/LGLoho+hNCNoXNptaf9cCUpwD57ToIBCNpa
	 CkxqyA5Qw05oibcxJplaZLJEp/3OLvVGWS9EHhbjRVf+85eojeFUKolHHKzde+bMCc
	 6zqLZueHYKWGF9vs9Xr2Y6ESty2Ai1fMov18Lw/GCKxNY2JZxoaqtTIH5xNEQOSK3i
	 UJqScUvh3Q2FODa1YjNGv3UImY9KC2ecrstZmZiw1vtSCr+dvFdn7gHgtv8B43Uboz
	 BOIU1wEatt5LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH 5.10.y v3 1/4] Fix error in IPMI SSIF shutdown
Date: Mon, 11 May 2026 20:17:56 -0400
Message-ID: <20260511220000.stable-reply-item006-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511132012.1831026-1-corey@minyard.net>
References: <20260511132012.1831026-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E04B7517D1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245365-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 08:19:38AM -0500, Corey Minyard wrote:
> This is a backport of 75c486cb1bca ("ipmi:ssif: Clean up kthread on
> errors") and other necessary patches with it.
>
> Version 3: Include a8aebe93a493 ("ipmi:ssif: NULL thread on error")
> in the patch set.

Queued all four for 5.10 too, thanks.

-- 
Thanks,
Sasha

