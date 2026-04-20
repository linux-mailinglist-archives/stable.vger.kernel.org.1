Return-Path: <stable+bounces-238882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEHfMqQu5mliswEAu9opvQ
	(envelope-from <stable+bounces-238882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:48:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A04DB42C4A7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77B830A8F13
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C53ACF01;
	Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfICTpvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B883ACEF7;
	Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691294; cv=none; b=AMQqzm1411EC7ZLNXZC9P4ZbivPxzrFTwtn0WWWtqG9MyANoZsQDoRu07T5Dlz6dDRFlU+4RrUyHYXn3iyKGVbdK7GtHVRTGXe/Od/cjDPsFXC+iEb3lCttX1ATwaMQNhMyvcOWtTZVWNOuahghrvnbUxgFYM2p9YEpE8zetlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691294; c=relaxed/simple;
	bh=Zh4WkJNPK4ITr7gcL6u3wTDVNpltY3SCEZKW2Nmmtp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf5mRTylx2tbcRGqPvLHuqsFNhEkSfgnWudJ3s1jJnHZ+F1b4W6B29msdz48uoxJTWaNbp8q0k65ezquP+i7z8WFGqIz0ZKObNskFHCVrEzE8ZvASHnpXiGJMLzp8P4DNGHKV+gQ9eI2OR36lO7oCcJfEyeMK7/Y1eiolzCZ8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfICTpvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAFDC2BCB4;
	Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691294;
	bh=Zh4WkJNPK4ITr7gcL6u3wTDVNpltY3SCEZKW2Nmmtp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfICTpvBpmvjYZV3GAMVK8B0RjNQ3vF75BZVAh25kNJD9R18pqovaLWufhdDcYMdu
	 FUxpMOOzaoXISOTu7LmSDBdIz8uoV5x2Zewjm0W2Cg1d5Vi4oHyvo8xcw5tHwOvxTJ
	 0vZwE/UPnd4y4Cid50m6a3KYBSWJBChjVyaRhUXclsIxMVU9+3AjZKlLhV5bn0jhPL
	 SiQ4AECOqMxuLE8oHgj0oUjfjQuxPZdfhYb2BCbktGZMY1GnOirLuHTZ7hRCLK8/+o
	 kEj+0glx2fgdX1HhjqA9bOLWGypxZFUQhO/DUza+95dIhD9nbtB+p0IoL4Xp85xBlZ
	 A0043jrRjt7Xg==
From: Sasha Levin <sashal@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10 010/491] bus: fsl-mc: fix use-after-free in driver_override_show()
Date: Mon, 20 Apr 2026 09:21:16 -0400
Message-ID: <20260420-stable-reply-fsl-mc-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALbr=LaxfRiP8totK7_K_ErH8EbYcBxTTZ5dYaXZeo2UCVNSMQ@mail.gmail.com>
References: <CALbr=LaxfRiP8totK7_K_ErH8EbYcBxTTZ5dYaXZeo2UCVNSMQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238882-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A04DB42C4A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 14, 2026, Gui-Dong Han wrote:
> The fsl-mc UAF fix needs its prerequisite driver_set_override()
> conversion to be present on 5.15.

5688f212e98a ("fsl-mc: Use driver_set_override() instead of
open-coding") is now queued for 5.15 as e55e4a769526.  This unblocks
the UAF fix on 5.15.

--
Thanks,
Sasha

