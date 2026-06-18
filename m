Return-Path: <stable+bounces-267174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TojqAH0cNGoqOwYAu9opvQ
	(envelope-from <stable+bounces-267174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:27:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 475606A1967
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 18:27:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hlY5dcHw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267174-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267174-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B6C03033507
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6883019A9;
	Thu, 18 Jun 2026 16:27:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31D1DC985;
	Thu, 18 Jun 2026 16:27:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800057; cv=none; b=dl4qQb529RsglhYlfv9gcfF+ac4FvZ3gEbJcC+zKcHwyFBJhNBfQgmadb8v3JQ/vx2lvTjCSeODjBwZ9XmJW9kNNW6DOOrzAiT9pTm040u5XKiEjZ8tEMuOgeZyfmqq2DFJPPeU+QIs5rdb3psarD2JxomJRdD4g3DY3MgHeQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800057; c=relaxed/simple;
	bh=hDbhm1IAaZUIWZQchTNsmYp0wDA7JG5CsEgKLQo+WeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdMjX3C5QkFXU4QGruLjOp4cETku4SqPOdtqHa6Dqy6vx1rKoO/bWqA7UgoF/44RlXgBTM2GxLMpiFet7QifARnXq90rSBhb7eozGRh9KBCbXxn1wxT/SBcUVDSOX8lAAeNZPTlgKHhrhH22RuA1vWDL+9NA8OqAZ0Ab0F9UUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlY5dcHw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791F21F000E9;
	Thu, 18 Jun 2026 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781800056;
	bh=hDbhm1IAaZUIWZQchTNsmYp0wDA7JG5CsEgKLQo+WeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hlY5dcHwzatI7ydD9NMrwhkmZTZ8k+kfAPV9tGeXFV/z8BBmRyVNpuG4zGSHljfdm
	 IyKJKrUQJYdtL8m5iMGbadW8uPda/Vo15zCBU7VCkEEFcdHxegtGfHzv9hcE+iblJa
	 qrTiLW4NHH8JtBkRxZ3rePqQp3q7KueeiYNUXZu3GAQ3wX6yuz4pXp72s/2OdBeuFg
	 zrZcTwLk9hkLVP60PZ+ydhf+EYQ/G39EHE34QTjZMg9uTlkH+ynyaC3bmPeW37w6oW
	 qDLzgRJx7ik2gneVFDl+H6JkhbV+xNNWykK6sMWNKJ3lX7nu2act/vvbU0K5t7jEFS
	 lR8kmwwLb4PMA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.12 100/261] netfilter: nf_log: validate MAC header was set before dumping it
Date: Thu, 18 Jun 2026 12:27:33 -0400
Message-ID: <20260618134208.nf-log-mac-header-a84b6fedbc97@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9d7e82ba-3f92-4ef4-bba9-c62c019252c9@oracle.com>
References: <20260616145044.869532709@linuxfoundation.org> <20260616145049.667194632@linuxfoundation.org> <ed09740a-561f-41e4-8d7b-ade8f6ae0763@oracle.com> <2026061823-film-pastrami-44cf@gregkh> <9d7e82ba-3f92-4ef4-bba9-c62c019252c9@oracle.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267174-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,asu.edu,netfilter.org,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:harshit.m.mogalapalli@oracle.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:pablo@netfilter.org,m:vegard.nossum@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 475606A1967

On Thu, Jun 18, 2026 at 05:08:46PM +0530, Harshit Mogalapalli wrote:
>Now, this particular backport "[PATCH 6.12 100/261] netfilter: nf_log:
>validate MAC header was set before dumping it" assumes that check is
>already present. Not sure what's the best way to handle it. Drop this as
>well and backport them separately along with the prerequisite:
>62443dc21114 ("netfilter: require Ethernet MAC header before using
>eth_hdr()") ?

you're right that a84b6fedbc97 on its own only covers the fallback path
and leaves the eth_hdr() consumers unguarded without the prereq.

rather than dropping it, i'll queue 62443dc21114 ("netfilter: require
Ethernet MAC header before using eth_hdr()") on top in all the affected
versions (5.15, 6.1, 6.6, 6.12, 6.18, 7.0) so the gap is fully closed.

thanks for catching it.

--
Thanks,
Sasha

