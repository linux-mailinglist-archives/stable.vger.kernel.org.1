Return-Path: <stable+bounces-259878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ICUoFx8gH2rqhAAAu9opvQ
	(envelope-from <stable+bounces-259878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:25:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B97936310D5
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YZp8qOl+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259878-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259878-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F033054F6C
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC76397E96;
	Tue,  2 Jun 2026 18:21:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78778397343;
	Tue,  2 Jun 2026 18:21:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424517; cv=none; b=ssEmeF31Dywj62w/cbETowtsSjoXGQG0LXZGag5yWuC0WIZ30HxtdZAEmaAXpYlN3ujGhcsUuQPDwSiBCb0UyGsPdE0TGzyhbH6HEPU0H6PHr8QLkKIGa8k9kI6tO3ZxBJ+7SicV2Bo5vsrNEcv0CNJcC1y6uV/qCRQFkdSguig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424517; c=relaxed/simple;
	bh=lSHL0ykFVpQVPqqFhgG1Y2wZBK5wlkceDpGh0659FOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEM0llz/7jQyp6WPGCW00f2K9hR8Ea7Kvoyls3tIHoyMAzGVO/yF/D1VtCm21cbc0PT063ZEQL9TZNAR4EmLlg2JEwwO0GwSL0Lp54Gx6Xaf2cxdYBvyHYspy86DWC9tLxdfB/GwHgnCE4V24RB4Q4N+eXrjk70mrakx3Q1AHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZp8qOl+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689421F00893;
	Tue,  2 Jun 2026 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424515;
	bh=2OEXLOdDHk0EatAng4WK4yhzsbnaxmTOzJBTGsjUXlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZp8qOl+0KujBRbbShvs5ny9dU1NTVAPY/52SWS+Zo5wAaPzNUUv0P0tBWivXk1d6
	 JjmXRUYUr4l9ZlKEI/1BPj4Cl91TXAMvYx0JTyxIoZj9FcDW2UTwhtGqTYHhiaS8La
	 sDKcxq8p5Wu7ZSj/zRi2//YV1TmY5idQqZJTc170fSnmlg07KlGkVzfYvdQ+LvAK7F
	 MsrX/zSNIYHFXMSmVybmLDXr/fU52cmcs/Eu8GIF+tLQ9pHhZCD2ZAfnhLsWufCg1j
	 wxRl4iIOrcE40giOte14xhHDH6MUE/GclnQ2j0JZb/ByuTIltDYGH6r/0m3DQTBJp+
	 NWnFt9vV2fiHg==
From: Sasha Levin <sashal@kernel.org>
To: Wenshan Lan <jetlan9@163.com>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
Date: Tue,  2 Jun 2026 14:21:31 -0400
Message-ID: <20260602180900.cpsw-new-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601073708.73350-1-jetlan9@163.com>
References: <20260601073708.73350-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-259878-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jetlan9@163.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:haokexin@gmail.com,m:alexander.sverdlin@gmail.com,m:kuba@kernel.org,m:alexandersverdlin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,linuxfoundation.org,vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B97936310D5

On Mon, Jun 01, 2026 at 03:37:08PM +0800, Wenshan Lan wrote:
> [PATCH 6.12.y] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

Thanks. All four per-branch submissions (backports of upstream
9d724b34fbe1) are now applied:

  6.12.y  5452443ce7e16b
  6.6.y   59cbd3e205f322
  6.1.y   051d4a307d558c
  5.15.y  f9ae7c1e69f317

Thanks,
Sasha

