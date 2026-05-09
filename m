Return-Path: <stable+bounces-244952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAlyDOEt/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E414FFB03
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 824E2306D637
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B0369208;
	Sat,  9 May 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADD+Nh7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640635CBCB;
	Sat,  9 May 2026 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330858; cv=none; b=Aihay3YHYjLRqoNZNd3Y2xXv06lIQY9GaO/N7NnSb/3J8Tuf91AxkKUJc6V98AuVF6wK8fNjQD4LLSJM8Vwv69ou/6rp50uve+mGfauKF9GIISoi4yWzE1ZJDaJoDrorzrbB0MgYUJAWISPx1iJdqMavuNBIYZjducoLEuB9ozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330858; c=relaxed/simple;
	bh=4Y+kOIWycy80wauOgGGe1nlqmEfikfAndulk2yAlNVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsvIRXmzGYC+R1OwW3S170ERGdi348jJZKmDEKTXg9pc7fcYNTJe7tUWtvzAb4lSB6/PC1joMBB3RzCq7ne4mMZUlm7figPN9t+0eSbY1VxkLILbnlsSIDrN1M1tMw3YJFovXE4VX4i5Ibv1EcDxsQoe/ObQbDamHaAkxSUPsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADD+Nh7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF1BC2BCB2;
	Sat,  9 May 2026 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330857;
	bh=4Y+kOIWycy80wauOgGGe1nlqmEfikfAndulk2yAlNVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADD+Nh7IRrescfvVVCTsqlXuvgQJPieogJkbkESFaiwsOd2fIqUpK74l38qWRZtKM
	 Qxq6fB5uHCQg5bqNP+uMXTTfOHOVl4jGaQ91BRb3aHxLyrqYfPJfKL5dumgIhfU0da
	 DrtSA1HHNowVcyG3GdaQReFl/t3e2JzrxehLdwK+phPG+9pToGYKmJVtgZ/cluRfkr
	 icfnMHsVitu9LH+3VtHTTHQJN5kwFOmkrRR5kmhq3gnwnTKb/EdhOlUXii78YKm1UV
	 oRB5lT9mpu7BCOGOGf8BwgOxt+fMQf84/Sy0MDm6H1VDLTmcuKvKTtbvEAGcLONDWV
	 mzZSj5701mz4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jassisinghbrar@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	joonwonkang@google.com,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6.12.y] mailbox: Fix NULL message support in mbox_send_message
Date: Sat,  9 May 2026 08:47:00 -0400
Message-ID: <20260509122858.39c0b4433cc7.re-mailbox-null-msg-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507055117.2466957-1-joonwonkang@google.com>
References: <20260507055117.2466957-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E7E414FFB03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nvidia.com,vger.kernel.org,google.com,chromium.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244952-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.12.y] mailbox: Fix NULL message support in mbox_send_message

Holding both submissions.

The 6.18.y patch you sent doesn't apply because of the pcc.c hunk:
upstream commit 5378bdf6a611 was reverted by f82c3e62b6b8 and that
revert is queued in pending-6.18, so the pcc.c portion no longer has
anything to land on. We can't queue the 6.12.y backport of c58e9456e30c
on its own while 6.18.y is missing it, so I'm holding the 6.12.y
submission too. Could you send a v2 for 6.18.y with the pcc.c hunk
dropped, then a 6.12.y resend? I'll queue them together once both apply.

--
Sasha

