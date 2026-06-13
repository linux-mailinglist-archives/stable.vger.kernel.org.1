Return-Path: <stable+bounces-262982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5Px5NQijLGqIUAQAu9opvQ
	(envelope-from <stable+bounces-262982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 02:23:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636267D41A
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 02:23:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xtn+nvhE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262982-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262982-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E47B7346CE0A
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 00:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC90239085;
	Sat, 13 Jun 2026 00:20:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50121256C;
	Sat, 13 Jun 2026 00:20:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310044; cv=none; b=VmWbkrW1HC/weSfzMF2WEKZo3mnXCCuT0fXFccpkVQ0YeqXpZW+6lHMN0DmDroLH0rZINbIIHzkc9kZkJrJ+7UtEUORW+817tkvcm0eN/fdkbBcxLVpTOtNLax2MxgOFX52E4QHyF5GpF1/g8unWwzC/MAG+Hp6X/WHth82/zEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310044; c=relaxed/simple;
	bh=XhLh+iI/QONB3oW3qacur9cMXq/IPbi9hgDtfjhJjEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm7mjTYDnVFyEUGzHO3sSKcNzrng4J/GH+5qZYRf/PJGOHYTCCEk0YQLK22FwjV9gpXcaFWd7BvkAPC8Y/pq+Q0gqjkLmfXaArvs5MXcQfa+HGSK7ihD8SegOU+wWPc1fS08rq1HkKlViiH89hsstsXGRH47g7YFahiFWHirB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtn+nvhE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BEE1F00A3A;
	Sat, 13 Jun 2026 00:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310038;
	bh=XhLh+iI/QONB3oW3qacur9cMXq/IPbi9hgDtfjhJjEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xtn+nvhEtUmKY9aYa/p0QFigyg93czwUpAavsl7UDTbijmbG85KT7Q+muQPKuvrJR
	 OTDUqgzS8Lg1lPI2oarSwkOol5ioAA0sNMOn7jxjhMEGzLvTOiH3qrFvF6vINMBuZt
	 gQD8GsUGMp6RNnZFjZYAbtinNESBlTc/GBJSLfCUhx4PzMHBycCaplNYq270D8TavG
	 iF76+MTR+Gdee+pR838xC98/D7iRuSBXrTwZkUOWOqtkHthb6HHbxI9EwHBdQgGcYb
	 O1gYGQ89rz/xgFpTtC4M7KD7jzfbneT5LLzJ83xNGbx1T0v0m+hO5Zea/itEk2A1qq
	 kk2eAdHZwMnag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 6.12.y] iomap: don't revert iov_iter on partially completed buffered writes
Date: Fri, 12 Jun 2026 20:20:33 -0400
Message-ID: <20260612233100.1-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612121047.397754-1-bfoster@redhat.com>
References: <20260612121047.397754-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:gleventhal@janestreet.com,m:ehagberg@janestreet.com,m:bfoster@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262982-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9636267D41A

On Fri, Jun 12, 2026 at 08:10:47AM -0400, Brian Foster wrote:
> Finally, note that I'm not intimately familiar with -stable process so
> I'm just sending a 6.12.y version here. Earlier branches can either also
> include this, revert 18e419f6e80a directly, or I can post targeted
> patches if needed. Thoughts, reviews, flames appreciated.

Queued for 6.12.y, 6.6.y and 6.1.y. Thanks!

--
Thanks,
Sasha

