Return-Path: <stable+bounces-238879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOzPGqgt5mliswEAu9opvQ
	(envelope-from <stable+bounces-238879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DC042C318
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF9F13044EEF
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FED63ACA6B;
	Mon, 20 Apr 2026 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7FzuWs/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A73ACA59
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691292; cv=none; b=em8B5N3Axe+ohUp47ha8EJbpdwbCCHNsHKr7ykpTj2l6E/UoQLvWND/I/Qa7E7DJo1YiphhQVaApfCJk+/0Ar/5TitqHeLoxTz3RBlzCfvzvoJI/ZgzGHVnxxX8l8RIFzi1UKKSVva8Ju11tYTjG4GDBPE9oR28Lo/+AkDmlacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691292; c=relaxed/simple;
	bh=oVwuzYzukeQDmwGlU0rmhQA/bH1QRrZVQNaXWeEeZYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lda5+hus5TNhM0NABU/JRChRg0kOb8AnelvoNLSEtGJ3trzNgU4EnbLdWBrdPaYP5C/Zd7+V1KK5stV9HwHVyIDyBMemrZ7Y1qyo6NDFSwZIdOKQAKVh8xkBIh52E2AeV6dX6SRWnBGZdUxdThok5Adzv3epVMdcQC5R8p0kXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7FzuWs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD47C2BCB4;
	Mon, 20 Apr 2026 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691292;
	bh=oVwuzYzukeQDmwGlU0rmhQA/bH1QRrZVQNaXWeEeZYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7FzuWs/TBsI6ZrOSDzQUW8wupTIcWjXaK5agJS0yfBYICaXvMU11peoWA3GAmktX
	 kO8L+T3/pH58m5DquD0IQf72id3H2Uf1VytoCqHBs93TLL36KGR6RVYjBexYkEivPq
	 qJ5GX6wVwYR5ILshNBrEw0OryxgIayg+l5rDBBKcsD8nwPQjYfJbrE/LcWZAhWSDxK
	 BScpLoqXD4hf8K8IoD94LauehfmDZ6QYDc4oKq1mDHPvtfQ5DM7+zvSO7DcXuYMPvr
	 voS51NB+84ar+ahVgpNQydYSj1pYNb3262//QLLfmbMMXRU9m5oqKJe2R2vJ1cgoQu
	 1G/GKtjvoxLaA==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Date: Mon, 20 Apr 2026 09:21:13 -0400
Message-ID: <20260420-stable-reply-amdgpu-bug-on-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417074010.1607496-1-rob_garcia@163.com>
References: <20260417074010.1607496-1-rob_garcia@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238879-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53DC042C318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026, Robert Garcia wrote:
> Backport of 5d55ed19d419 ("drm/amdgpu: remove two invalid BUG_ON()s")
> to 6.1.y.

Queued for 6.1, thanks.

--
Thanks,
Sasha

