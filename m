Return-Path: <stable+bounces-245811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFAKJWFEA2ri2QEAu9opvQ
	(envelope-from <stable+bounces-245811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:16:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED6523701
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDEEE3368FF0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71F25393B;
	Tue, 12 May 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2KfNE07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC93E1704;
	Tue, 12 May 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597116; cv=none; b=ZYge+MGSBPsUs+njZzZSFqE6xvytIUIum66h/Je16QUrRGchOTBoibZDW4D1dUqDpzYXt0lQWk6D8NvM13/54OxSvA15yKuBIo9bYsaaGlCX2ZzTDUmSj8NusWDvQtHqrO4vKDEzFimt/wy9GU16CZ6kWZHhOw2dssM9LI/H8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597116; c=relaxed/simple;
	bh=PAmP60qAiKjoPlblil7zuoyMTGN8DgSJXkF6ViP4bNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azPG36I3TzkxAYHAInpnm+aiSzJDUO7j8I+SgMtOldzloXc9m5rz8ND+52AsH6OhGtDg0oF9RhwtkEaL4dhCdNkLyi9zA4viiaxItWJV502iMh/cNTNRnAMIYO2sC8THpxyX09u0IrUZjJsPuALD6+bg+JMyeepk7hjd5fvmDJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2KfNE07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A34BC2BCB0;
	Tue, 12 May 2026 14:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597116;
	bh=PAmP60qAiKjoPlblil7zuoyMTGN8DgSJXkF6ViP4bNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2KfNE07+CnTuH5KUoOO9S94KahVZ0CZj1U90mp1bURtDhFR2QbANjg9NQrymLxzX
	 DhZX21iOaZGxEgmeVfyB/ow2rtZEYwfehSOkoo7gfm29Z8UNLxgY+fXEoKUIh4aiAl
	 +PZHKFbvJGI7pj42tPUR+EraKnsjTdVpmqK6XYlQUVA/JEerA7tRqtx5TtD9raQlDK
	 gWN8KsTZ8Rotehu/ppaog+G6JvpiBjVn9DblWNH4dkzm5XOOeNvtElj+L6pU/FK5we
	 NFp76Rmx33K8fWAaRfWP5hbOAQcd1MKIQWIwlpvAuYMgYn7eS7UHepeqOOnKFOgpUZ
	 zTXKRcO+DVNZQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	lanbincn@139.com,
	zhiguo.niu@unisoc.com,
	baocong.liu@unisoc.com,
	chao@kernel.org,
	jaegeuk@kernel.org,
	daehojeong@google.com
Subject: Re: [PATCH 6.1.y 0/2] f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic
Date: Tue, 12 May 2026 10:45:11 -0400
Message-ID: <20260512142400.stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512075010.29584-1-lanbincn@139.com>
References: <20260512075010.29584-1-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68ED6523701
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,139.com,unisoc.com,google.com];
	TAGGED_FROM(0.00)[bounces-245811-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:50:08PM +0800, Bin Lan wrote:
> This series backports a fix, a use-after-free vulnerability
> in the F2FS compressed file decompression path, to linux-6.1.y.
[...]
> Both patches apply cleanly to linux-6.1.170. No logic changes are
> needed beyond replacing F2FS_I_SB(dic->inode) with dic->sbi for v6.1.

Both patches queued for 6.1, thanks.

--
Thanks,
Sasha

