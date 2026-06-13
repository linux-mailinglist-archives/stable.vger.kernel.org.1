Return-Path: <stable+bounces-263015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VaNpDsduLWoQgQQAu9opvQ
	(envelope-from <stable+bounces-263015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:52:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0285567ED4F
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 16:52:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jq2UyUfl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263015-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263015-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 556EF305ECEF
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4214E33F58D;
	Sat, 13 Jun 2026 14:51:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203763368BF
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 14:51:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362304; cv=none; b=GlfjEJ6Q6mBMhAQCbZbXSdblDjzukDEvhrIL8GZEdbRcV7XarFoSQxCTNnueFQunqbwRQQtR8fK8mfPVumc3TwI7Ljbtmz7um6PGVZ0duABxCw2GXrCSla15rdrKf3fuC2n2/OkK3Uk65Lxinb04Y8AidklUbzwsnKHTnF67LDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362304; c=relaxed/simple;
	bh=YxcKzlWBR0/NXF7dD9595Lk32P57Q6IUNKkhluQziJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ2iJ27ThUNzJf6w3hEJS+d6BXO362+LCNK/vwmNqn6vq3IZC2QgvYV03KZkz2WFQPL5EbAo/CODEXIOVI8i3Pev7GVY+EK85Lv++tenS1U2N5k5nNfgrRJ53ZFawjSZlesYWt8pgEflTm0PmQBqer9y+Z+P9oREaOJj8vDyqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq2UyUfl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2391F00AC4;
	Sat, 13 Jun 2026 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362300;
	bh=YxcKzlWBR0/NXF7dD9595Lk32P57Q6IUNKkhluQziJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jq2UyUflIAjJ6cteoYW1j0JpRqy6zQWK01TkB5Tl6g+eYpV/pn0I2G4tcegSao3yw
	 cWH7iTLqqE/N4eaHCaBpL5uPIE7dSfEclL8ERhuWPHDfDndCHgdENRTqkeNGhDdJ3b
	 h/yir8qadKNxjHXf90v+boKFE+MRThUYnn271uzAo4K8UcVKGty5I6lTvL3ruHaaUR
	 z+9jnp+ZbR8QKONWrnBqGFjDhiKugGcV9harOAxgLeF2QEGActy0vIUdIW0/pZ0As8
	 dCcbRXyx90DJ8mPmL33WwUCpXWjUzm5IYu57JXxfoFbJOgMJgSLhkhQiULwaz1k3y7
	 LYvgc2RBKd1+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: Please apply e1b849cfa6b61f1c866a908c9e8dd9b5aaab820b to 6.12.y
Date: Sat, 13 Jun 2026 10:51:30 -0400
Message-ID: <20260613143004.0005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612212134.GA3841315@perftesting>
References: <20260612212134.GA3841315@perftesting>
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
	TAGGED_FROM(0.00)[bounces-263015-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:josef@toxicpanda.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0285567ED4F

On Fri, Jun 12, 2026 at 05:21:34PM -0400, Josef Bacik wrote:
> AUTOSEL already grabbed the other two patches in this series, but this one is
> equally important and we're currently hitting problems in production without
> this patch. It applies cleanly to 6.12.y. Thanks,

Queued for 6.12.y, thanks.

Note that e1b849cfa6b6 introduced a use-after-free in
inode_switch_wbs_work_fn() that was fixed later by 6689f01d6740
("writeback: Fix use after free in inode_switch_wbs_work_fn()", which
carries Fixes: e1b849cfa6b6 and Cc: stable). That fix wasn't in 6.12.y
yet either, so I've queued it on top to avoid reintroducing the UAF.

--
Thanks,
Sasha

