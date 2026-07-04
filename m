Return-Path: <stable+bounces-271909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oTNSAiNrSGpwqAAAu9opvQ
	(envelope-from <stable+bounces-271909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:08:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D221B706764
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:08:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dskAemq9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271909-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271909-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41C7D306406F
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC33603C3;
	Sat,  4 Jul 2026 02:06:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33737268A;
	Sat,  4 Jul 2026 02:06:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130762; cv=none; b=a4sQW7aZqdCPkFTuOxkfhD2pJuUl9SktqaU5tYpobPVDK037t4+39AllxAyaci0+fidM86NUTNYq59xnCkARJHAEVbPrU9MDH/v4QML72287RrRVVT4XNuLfstCqx5qHcmX5PEWhcpAwWnIrTlwLLjSAXAXJLX36CRnmmA4OKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130762; c=relaxed/simple;
	bh=mPoTzXaUo0J2ploYZkataSjwbXDrTJTHnlTfiRHIceg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b50x4bBQ1YrtnCRQAzoTNFUV5pFzQ8TaoM6qVhK7UwE0+YRIo4RNfriyb8sgV/Tra07r8J5ShPB0lprW572jr6UdGySZhFdiIMT5bsfJi70n3UtCMVGB4lzZKZ1lbJvkNHgReKlmaITDBwJox9l3x+AA4F37kbyO1c+filoCv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dskAemq9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6771F000E9;
	Sat,  4 Jul 2026 02:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130760;
	bh=ZhlFBf+aQDkOCPTHx+pDOGswxTyJxVn1vIePmFWPaqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dskAemq92I5Jeo+tbjHWif3dO93wuvyjWshG8Tvur8V+IhXdQExnMschOnZY2sOe/
	 U4k2yu8VfqappQAiJKOLJPw7r8cKzarHaHet+GnenZY6rCRg/RRgQw13AVi1RHG0CA
	 xZP0gTvMTxgbykn4yJdczzDKQRIli8Ng6Dqz9V25xBG1MCnXKbvjSH6Eqf/AK8Jtae
	 +U32CZvRVV9xCNm+kt+IPKFHwRBFFY/aK2xyRAqYAgaVEufVvwBMNujKirVMwGZz8k
	 XRfuT0goU9uj6byi2HrdPeVrS7MVXWOAUVWNKv/4eIPJ4brUbay14SyUKPl+wrKVVy
	 Hr/UnrinpkHEg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	00107082@163.com,
	guanwentao@uniontech.com,
	iklatzco@gmail.com,
	patches@lists.linux.dev,
	peterz@infradead.org,
	stable@vger.kernel.org,
	yeoreum.yun@arm.com
Subject: Re: [PATCH 6.6.y] perf: Fix dangling cgroup pointer in cpuctx backport
Date: Fri,  3 Jul 2026 22:05:20 -0400
Message-ID: <2026070315-stable-reply-0026@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702164553.498397-1-guanwentao@uniontech.com>
References: <20260702164553.498397-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271909-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,163.com,uniontech.com,gmail.com,lists.linux.dev,infradead.org,vger.kernel.org,arm.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:00107082@163.com,m:guanwentao@uniontech.com,m:iklatzco@gmail.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D221B706764

On Fri, Jul 03, 2026 at 12:45:54AM +0800, Wentao Guan wrote:
> recently backport of ("perf: Fix dangling cgroup pointer in cpuctx")
> use a middle version, so aligned with the upstream commit:
> commit 3b7a34aebbdf ("perf: Fix dangling cgroup pointer in cpuctx")
>
> This is a fix for stable v6.6.143 backport commit, so no upstream commit.

Queued for 6.6.y, thanks!

-- 
Thanks,
Sasha

