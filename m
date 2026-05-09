Return-Path: <stable+bounces-244951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DIRN9wt/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF574FFAFB
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2D7306C7FD
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766E1C5D59;
	Sat,  9 May 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfXBJ7hD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635F35CB6F;
	Sat,  9 May 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330858; cv=none; b=K7hOegqfqn229tUDpw59NvjxphdY2SKxPZesdsemBskG8BGK18Jccsbdix+y6X5mwvxvbtehgEMmO7rJpphP4rOrwtgkfcdx9aiu2cUANy5wUEvPpOfKtfvur8I3PLuPQNwT0v/UhPYcgTMRuZjkuvIXvHkFwzlagH5hid0Z/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330858; c=relaxed/simple;
	bh=s9s20yrI2KKTqGgZCeyzz82nQSerkOQ6j0H6UHZ1ypI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxXQxvTzEpGKNGJw+wZX+VWPsLs/+fQwxy9yze8nTmb+q1Tj3zlbHDmv1LV1aj14klkV3X8JqjxHfuiSiuLuHkqYjBEfHKgn0IQPIqg9JwaPKpR+kCCNetfr1rPRH/D+qVZvYeGXQEkT7GadVnS+wkc+h+F/6V8xiqErDJZFvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfXBJ7hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A11C2BCB4;
	Sat,  9 May 2026 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330858;
	bh=s9s20yrI2KKTqGgZCeyzz82nQSerkOQ6j0H6UHZ1ypI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfXBJ7hDarUuK5TCxghT4puLXqWzWu/FvNFVedse/T59wu56Yvq0mDlEzJGoqkBbf
	 SWXh21uTJM4FHkGeLjx8PWUA1NH8bAQ9sZIu/HhAZfTGcIb/Lut251nLSxxAeTymMu
	 IBZ7nUQ9IQWEI8SHO4w2j3HsueBY1rcCg0TWDfKdtciFRV0V7WKevqwM+61tYcwdHa
	 SnAMivkmtfVSrurxmut+JqDttwyqywB9P93Lhf1lnIj1M0uGrvvpbSS22H/2zFVrYQ
	 GvthH+p6qusGM4M3wFmWrFnlv7inwb0+9/BYLeurXLmJIqnyzmh5zInWAKVse2s896
	 NGSySsBB+64Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	metze@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Yi Kuo <yi@yikuo.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH for stable] smb: client/smbdirect: fix MR registration for coalesced SG lists
Date: Sat,  9 May 2026 08:47:01 -0400
Message-ID: <20260509122858.2097e82fa847.re-smbdirect-mr-coalesced-sg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508081546.4177429-2-metze@samba.org>
References: <20260508081546.4177429-2-metze@samba.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACF574FFAFB
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244951-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH for stable] smb: client/smbdirect: fix MR registration for coalesced SG lists

Queued for 7.0.y and 6.18.y, thanks.

The Fixes commit c7398583340a is also present on 6.12/6.6/6.1, but the
patch you sent uses the post-rename mr->sgt/.../mr-> field names that
match 7.0/6.18; on 6.12/6.6 the same code uses smbdirect_mr->... and
6.1 has yet another older variant. Could you send adapted backports
for 6.12.y, 6.6.y and 6.1.y (or let me know if you'd like me to skip
those branches)?

--
Sasha

