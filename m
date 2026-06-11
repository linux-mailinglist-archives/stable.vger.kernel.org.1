Return-Path: <stable+bounces-262588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oty6Ay8FKmpShQMAu9opvQ
	(envelope-from <stable+bounces-262588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:45:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFAA66D874
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:45:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V6AOqmIh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262588-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262588-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A637F3025F68
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569DD1519B4;
	Thu, 11 Jun 2026 00:45:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E3136358;
	Thu, 11 Jun 2026 00:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138733; cv=none; b=aS2jZxjkNi8XLJaPECqXLbcevDtJlMYpVF6fcdJoyJWTLRzjyaQ+YzbEqmT073osfiGG9gfstz5dko7It6u9otd3cmKBJfNegNv/KjfVXkiRPbykgujtVf9aPi39bq6fqO/Hqbg/Cu4QtZ92wDzHstxamSE6pnhNaM1iS9RJ4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138733; c=relaxed/simple;
	bh=tnstdAhuHJJStqezeTNY3UwWTHrnFd2lI0J81uB62qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es5q49sjPzEhtwnUqtvk1kRSkRgHO7IKSh0wW317zVBNJS4vMffNskBd6z16hhcAExn57w5mfRm847za5hVET0NsySBUaeOiElHQgzKaicJEGjhZ74fo0Grr1LqSb0tbXILq9daRrZQjImE/9/pnNz96TqiLs7EbgFCl1rs6i/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6AOqmIh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8EE1F00898;
	Thu, 11 Jun 2026 00:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138732;
	bh=tnstdAhuHJJStqezeTNY3UwWTHrnFd2lI0J81uB62qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V6AOqmIhGgxy32lGdOb/v/ImSrJaO0hd4AYGcTewtYNvzrVGuYqOf/ukQAGV7j4Wi
	 U3OSvOlnBljJkjelCPE57GRdL3AgSTi3AW3y3i4ZkDAAR9s8cQQilqyV3EEEpBWcis
	 2b6J2djWJ902cDiDJtOJZqkofd2MGqxuKwxbvUMvgp+ULRvQAYqP6M1YtfKr12oAy8
	 uMX9WjID16GnUYMen8pk90oOua4XhkgBiRPLh4R1DxdS2K02a9JU96E+9isT6v3fBc
	 pLC3zemfnJ5uw7fsSNeUM8GpicgFV7VWblG9KVFrupZNyFwYonK3/RvPvGtXZ8zTn3
	 NvJ99+N0uJM9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Edward Lo <loyuantsung@gmail.com>
Subject: Re: [PATCH 5.15/6.1] fs/ntfs3: Return error for inconsistent extended attributes
Date: Wed, 10 Jun 2026 20:45:18 -0400
Message-ID: <20260610-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610085204.21142-1-apanov@astralinux.ru>
References: <20260610085204.21142-1-apanov@astralinux.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262588-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,astralinux.ru,paragon-software.com,lists.linux.dev,vger.kernel.org,linuxtesting.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:apanov@astralinux.ru,m:almaz.alexandrovich@paragon-software.com,m:ntfs3@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:loyuantsung@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EFAA66D874

On Tue, Jun 10, 2026 at 11:52:04AM +0300, Alexey Panov wrote:
> [PATCH 5.15/6.1] fs/ntfs3: Return error for inconsistent extended attributes
> Backport fix for CVE-2023-54125

Queued for 6.1 and 5.15, thanks.

--
Thanks,
Sasha

