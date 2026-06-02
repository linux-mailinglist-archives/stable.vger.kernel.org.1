Return-Path: <stable+bounces-259865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vBpDODkfH2qcgwAAu9opvQ
	(envelope-from <stable+bounces-259865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:21:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F20CA631050
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:21:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TbJlZNZ+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259865-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259865-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89965302814B
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9B392C47;
	Tue,  2 Jun 2026 18:21:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01738839D;
	Tue,  2 Jun 2026 18:21:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424501; cv=none; b=N1R74AzYwG/FvB9dciNSxApQg50nEm+lEYqKqPTnCTgjyr/PI69MEgVJGJGXpQR3V4g5hX2CC573vEmNl1e0Zeeeu/xc9tu2DwvhvRe7EZFoMLmrKcfBGr+PorUDFIhdt8PcNriAr/Vz3o8cQGq1GeoYzaZW6/qpGysmVZL3o/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424501; c=relaxed/simple;
	bh=VX8/5J1UHVi6WOFIgYIpOxAZUnFMdQy0KtAPIzqi6VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSytDIV2n2wz60lA5/KOodNO+UEBDr89EYIY5TjXMXuU6VAtBpZJLws0/30E3nvH5h4BDEszpMyR2h+eEnSuey368ajg3kkY4pr0iOYqnYiJK2rex8bByQDvWSzvNTHqypdPs8xT5DWoRzaJUZ3t6kNJhvIfCH5YTTRBqcxtIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbJlZNZ+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB1D1F00893;
	Tue,  2 Jun 2026 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424498;
	bh=BRXmaFtHlGtmlACxC5RELFhg8zad2ITbAOk9CjyKfFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbJlZNZ+lDckIQHwqLqi7pwz3DgXXMoniCMFQMYrqutjoc8Um5Q9oG4p8QhWTL41a
	 /Z9PpXTzCEh2emlG8ENEFmtD5bInXIzumSvFwDHnx0m0ktbfM8jhSfCiCyxlt7rIuD
	 bq0Wdcvdk57ruf6L4AhaqAnvx9Y9a0KlwImQSbGhSE3AYL/hLP+qldzTnOz0asE8GO
	 U7d5J/rQMlBaaIBgowckw6nNSrtN+cZMa4x3BNxfKW3q9bOQXTbH9Fmin+rxN0IBff
	 APiCEXmGor1Z0PAEhAO6s9qgCkXOrLZi+MPlrh3+Jxrs+GmBxRaz/arPHwWU2s/1hj
	 kcJJvyoriEZvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Prathamesh Shete <pshete@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Petlozu Pravareshwar <petlozup@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Meng Li <Meng.Li@windriver.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Robert Garcia <rob_garcia@163.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call
Date: Tue,  2 Jun 2026 14:21:18 -0400
Message-ID: <20260602180500.tegra-pmc-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602025812.3535026-1-rob_garcia@163.com>
References: <20260602025812.3535026-1-rob_garcia@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-259865-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:pshete@nvidia.com,m:sashal@kernel.org,m:treding@nvidia.com,m:petlozup@nvidia.com,m:jonathanh@nvidia.com,m:gregkh@linuxfoundation.org,m:Meng.Li@windriver.com,m:ulf.hansson@linaro.org,m:rob_garcia@163.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,linuxfoundation.org,windriver.com,linaro.org,163.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F20CA631050

On Tue, Jun 02, 2026 at 10:58:12AM +0800, Robert Garcia wrote:
> [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call

Thanks, but this doesn't apply to 6.6.y.

-- 
Thanks,
Sasha

