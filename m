Return-Path: <stable+bounces-260225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HbJyGp7BIGpp7gAAu9opvQ
	(envelope-from <stable+bounces-260225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:06:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF60063BFD2
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:06:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TQWHrAK7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260225-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260225-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 702F53019955
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FCF70830;
	Thu,  4 Jun 2026 00:06:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2143C8EB;
	Thu,  4 Jun 2026 00:06:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531561; cv=none; b=WT4/0sEDrdtjVBA1lxwryHejGb6Dbbv73MdI/uxm32S1Ugau9n4DtxiLM/fXeqY4ryUgmZz2BuqiVFWM50j6HPHYzaiu68pQ1TCYXaOIZXTEgi/7UHNSerhJpBe3sHTvhZ7HbuauMWOfubnafduCo3Np8CKjecD5X2sEkbLQEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531561; c=relaxed/simple;
	bh=FOQ+g21fD38nz+kDpjuiZiHGQwoDcWHXvmJJb6q62WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYiy68lG0FmWSnVXgp88AzR9cMz6k67i4CoL4hR8kEQ50w2f+3UaVpEyrMeOhnyBDdV+C1Z5kyJZ508lWF1zi+URf84eIoDWCRaUWzolBeOnjHuI4iENzCLvxWe4BNln933/3MeVXh20AaN5A+Mu8S8YINTp8aGSqEuJdY1XUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQWHrAK7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B8C1F0089A;
	Thu,  4 Jun 2026 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531560;
	bh=GQXv4mn29c7uJ5o4xkASkf2rQcC8NTXHp5zWDTL4P8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQWHrAK7+a9lgawgYqgW8Syjq9PgJ1GHcnD2CLEqyJ6BP0vOUvkVYl4y1CWae2gLS
	 Q0BV68QGYP/Ln8L/yq9Z3Z1pjPk0lwtAP2rAGPFruVEFLOzapW4ekvj7LE44jENZZw
	 eWYMZ44GzF+UsPoTkwb5ACKNwoWN81cHyjVdOgOXPhZ7xeHGOdVVvhti6N2b0GfZIt
	 pHssbNEFlem32NE/bztxsQgiy9/Lj32imgf8yaKdWjpv1MvFdHWGiOHjSOMgSjFvbb
	 Hh5gbFuzJdO0F42A933iKnVsu5KP92OMEF6+unyxE60OfiNNkrjaCaNDHHxHbfkX7h
	 dciEgVB9YbAMQ==
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
Date: Wed,  3 Jun 2026 20:05:45 -0400
Message-ID: <20260603210831.item010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603080912.2022575-1-rob_garcia@163.com>
References: <20260603080912.2022575-1-rob_garcia@163.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260225-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:pshete@nvidia.com,m:sashal@kernel.org,m:treding@nvidia.com,m:petlozup@nvidia.com,m:jonathanh@nvidia.com,m:gregkh@linuxfoundation.org,m:Meng.Li@windriver.com,m:ulf.hansson@linaro.org,m:rob_garcia@163.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,linuxfoundation.org,windriver.com,linaro.org,163.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF60063BFD2

> [PATCH 6.6.y] soc/tegra: pmc: Fix unsafe generic_handle_irq() call
> (resend, regenerated against the actual 6.6 tree)

Queued for 6.6.y, thanks - the resend applies cleanly.

-- 
Thanks,
Sasha

