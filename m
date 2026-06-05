Return-Path: <stable+bounces-260800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E8y0GLglI2q+jQEAu9opvQ
	(envelope-from <stable+bounces-260800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:38:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0953364AFDD
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:38:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZWLCY6pk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260800-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260800-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 113D8303CFA4
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D4419316;
	Fri,  5 Jun 2026 19:37:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB834071CD;
	Fri,  5 Jun 2026 19:37:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688273; cv=none; b=AQwb7suR/9CuevpIIDhsPFMCPhOqXLg8zrcbIhgZP5MeEx1IX/DYTvVvyrKcj6dK20FseemUlHyddjQPs4N8aUyDoZ2DlsUinmWVdyu6pBaDK+8Aru1V6dATPalqSOjeyORVnWLXQ99PnY5v/gJHGRrL4BmVy1PAlA7URLAUMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688273; c=relaxed/simple;
	bh=mJC3qcoSFMdR/DCxwL5F1cdGaAsS/d9gyWtHOdT8Oqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xw+Bytg7iQpKBNmHRCgD4Jv/BwoBddYPsOjSx/yQLAVed49ELgcKoJ1RIJrVkBpcgrvqsp8xHGwgDT0d6VsYPhEwNp+U/tLbVJtKZicO39j627OwPizAa4SY8CqmhDyNQGqgWgbbRGzTHxUEHQgD6d7SG5tM/qjiFob4ZmHLtZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWLCY6pk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185FA1F00893;
	Fri,  5 Jun 2026 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688272;
	bh=I4JXR3hp6VucfzphrHCgJeqWuX0M2i8SBkIetIFF8kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWLCY6pkgAIH+SJWpyRRKYLIOpLUXyQcBBu3HU7KHIxi0okflHjTxz8bm/r1wiYKz
	 d6k85QkJV0sdesBhg8NxbTZyNz5N2zy4RlAeh0WnDT1yN83pl5ruDfHnGG1Bip7EnU
	 rkBUYm7+rEhKuOAG+JeGd2xlEp7KC+F5j8ybQTcCQ6z7R54dNRvY8LE4zi3mXVwEAT
	 39/1Hnq7J3cUPQzP9FO3KgqdQVYsJLKrnBSLOMXIMz8xL8RwtY6B7s/zB51A8p2u9M
	 /QVSGhsg5827D0h7//j8sqyueB9JT0IKQmN7vzYloVf3Q1oA0YxZp2vp0yfJp9npn9
	 mZDNAhPjUw1kA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	gnoack@google.com,
	mic@digikod.net,
	Christian Brauner <brauner@kernel.org>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Bin Lan <bin.lan.cn@windriver.com>
Subject: Re: [PATCH 6.6.y] landlock: Fix handling of disconnected directories
Date: Fri,  5 Jun 2026 15:37:26 -0400
Message-ID: <20260605-stable-reply-0019@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604101618.939488-1-bin.lan.cn@windriver.com>
References: <20260604101618.939488-1-bin.lan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260800-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:gnoack@google.com,m:mic@digikod.net,m:brauner@kernel.org,m:song@kernel.org,m:m@maowtm.org,m:bin.lan.cn@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0953364AFDD

> [PATCH 6.6.y] landlock: Fix handling of disconnected directories

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha

