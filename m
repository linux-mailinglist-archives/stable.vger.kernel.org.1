Return-Path: <stable+bounces-259875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q66xNfMfH2qwhAAAu9opvQ
	(envelope-from <stable+bounces-259875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2296310C9
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oSV1iIzB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259875-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259875-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1706730421CE
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8441C84DC;
	Tue,  2 Jun 2026 18:21:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5458392C47;
	Tue,  2 Jun 2026 18:21:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424514; cv=none; b=W0HewqoCu7bpjNJ6aKZwswXY1F/7CzA5OBHdUqDUSOLzGGnti7b+0CbGRlryhZ1krrtX2zh+/heuxFtk7jGWVC2Uj8bR1NzllE4LueFxiA62kA/K66slpwFDoKq17mmJSz5U7Ul8ZT+lEReThiGaySVQO7ZHurpzgh+om4WsosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424514; c=relaxed/simple;
	bh=LnjFp/8BEVHPTPjHpfI9+wUYjQg7IoAdMbzSaJlBS+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbI4onYDaFqBsVI8yHY/GByZXDK+krrt+crvhQbesZo7MsKRjoP8a6HZg+lFEpQxMvNp6Cu7OpBBNtCsFVzYCQcrQOUx4T8l+q4BHmPmqLIDQ0sX89ara2qHfmyMQVZXc00RmfjXEzTz7oaYxgEZNsuCe+rOSdJAOBaX46b8ClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSV1iIzB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D0B1F0089B;
	Tue,  2 Jun 2026 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424511;
	bh=LnjFp/8BEVHPTPjHpfI9+wUYjQg7IoAdMbzSaJlBS+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSV1iIzBiGm1P5Vn/do1Jjsv7PMR9pTXiTiNYk4dUKA9TectMP4IiM6CaBfvDp1Zm
	 3HcXNwjohFOYBYl0PGusLWq5ztX27QSLtu2OyRtdzRHfxpmMAKyZ4QtIKCo/5kGOk8
	 wxml5ArvL325o9eY5G5N7sK9ougNbPo+RaOTt+cHzuwLIIqeopyoTEznVbU1qeLlFH
	 QoprLngMs9o7Lmn0ecIx3xmRvdkUlWtQNtSSnxIcYWl5osoAXsCuOmb6OH63p6QlZy
	 e0ew+0CrDd+6CZDgmQXlDDVCODxFkwzAQTNXcutEqDVZVuohUyI6PuWrqj6ZEG5JLQ
	 2uGfSpkfaZnpg==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH 5.10 274/589] drm/gem: Fix inconsistent plane dimension calculation in drm_gem_fb_init_with_funcs()
Date: Tue,  2 Jun 2026 14:21:28 -0400
Message-ID: <20260602180900.drm-gem-prereq-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <edea6d36625f362c3fcaed6bd251a02827081a1d.camel@decadent.org.uk>
References: <20260530160224.570625122@linuxfoundation.org> <20260530160232.175451425@linuxfoundation.org> <edea6d36625f362c3fcaed6bd251a02827081a1d.camel@decadent.org.uk>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,suse.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-259875-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:patches@lists.linux.dev,m:tzimmermann@suse.de,m:ashutoshdesai993@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F2296310C9

On Mon, Jun 01, 2026 at 09:46:20PM +0200, Ben Hutchings wrote:
> Without the prerequisite f2f455981a34 "drm: Remove plane hsub/vsub
> alignment requirement for core helpers" the queued fix is a no-op.

Good catch. I've now queued the prerequisite from mainline (f2f455981a34)
to 6.6.y, 6.1.y and 5.15.y, so the queued fix is effective there.

Thanks,
Sasha

