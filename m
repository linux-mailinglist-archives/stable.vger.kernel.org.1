Return-Path: <stable+bounces-244953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBHiEPst/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:52:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9B4FFB0B
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEC4930750B1
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B93890EF;
	Sat,  9 May 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chxmj1Z8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E4E361DBF;
	Sat,  9 May 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330860; cv=none; b=m8dUdm7ZMc1stTFkETrR7RjFebU8X122G2QaVoNhb61gV/zMTCod/Zekp1yIcwDTsyNTcc/hYtQzXTf1cIlgqbwsNJp4l7EqTBFo97kojRJWNcG109n87AXlSQ/MbQSiiqg1yfk2PG7QqVr1/BZyeoUjRUMjxFXRK9AGU1fR/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330860; c=relaxed/simple;
	bh=gmOaICabTFu5sMHYBHGDCm9pI4MjTr/rikRLCLru1W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBmwiuJ+e4dAO97/o6isa0QkfetvvP+3ZLNPMaYgGXplQP1ak7o9LAXj8L6nXxvJ7ZTUwVvuZOPtmiqAN8oVyZmTPEmaY+YsT3G0s0u1LA5p9fzcA1WfHrJbeM+pJ91OKqkKpuy850ZXBKGArBE/vCQx09JWjrcLoBXuOjF4oqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chxmj1Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950F1C2BCF4;
	Sat,  9 May 2026 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330859;
	bh=gmOaICabTFu5sMHYBHGDCm9pI4MjTr/rikRLCLru1W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Chxmj1Z89x3UMb2e5qYM3K5CaRwXMYfI4QNQhqMM2qVnVJJx80dt5Q/T5d492Ejhv
	 sVSszKuErULd4G34OrHnjuW4tDLsNBpueYtHVUHRbbJZMEJAuhxdpFhHWq5Q/dGh5F
	 RueyvzuXyPCApMNtc5GHn/XXpNrKfDmUk3kMJYg9K7vo1dVXFcMPqRjqqxXMcK1vji
	 Xtk5dusHCC367WZLYhZ56mi0v7tV+WvX0mfSrGhPQPoN37SB2P6twUYf6PDRQeocD2
	 TqtCgPDgoh7mO10knzXs0fd9Fx5wFKGH3LeEVI7PVlXlMDh9lDyq2ZqueGWDKs+wml
	 C+mDk2kfWQFXQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com,
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Bin Lan <lanbincn@139.com>
Subject: Re: [PATCH 5.15.y] ext4: avoid infinite loops caused by residual data
Date: Sat,  9 May 2026 08:47:02 -0400
Message-ID: <20260509122858.4575ede3c425.re-ext4-infinite-loops-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506073835.32481-1-lanbincn@139.com>
References: <20260506073835.32481-1-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8EC9B4FFB0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244953-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,qq.com,syzkaller.appspotmail.com,suse.cz,mit.edu,139.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,512459401510e2a9a39f,1659aaaaa8d9d11265d7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 5.15.y] ext4: avoid infinite loops caused by residual data

Holding for now.

I had to revert the 6.1.y backport of upstream 5422fe71d26d
(c66545e83a80) on 2026-04-11 (9594622f8a39) as part of a coordinated
revert of the surrounding ppath-removal series, so the fix is no
longer present on 6.1.y. We can't queue it on 5.15.y while it's
missing from 6.1.y - if you want this on 5.15.y, please also send
a 6.1.y backport (and ideally help untangle the ppath-removal-revert
issue there) so the fix is consistent newest-first.

--
Sasha

