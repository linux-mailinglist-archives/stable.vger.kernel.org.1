Return-Path: <stable+bounces-260795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eRjjEX4mI2rpjQEAu9opvQ
	(envelope-from <stable+bounces-260795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A1E64B030
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:41:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Dxp+4Vtm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260795-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260795-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286143059A7B
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0396E404BCE;
	Fri,  5 Jun 2026 19:37:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52D416CF3
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688268; cv=none; b=mJvOxwqFhvlYMHCFo1yyItTz9pRBGC0M66ydjH4H0uqQkpmxE7qY9HUejTa2NRD08zhvCjYvmzqVLt7hrowzyUucjCQSdb+l5GBmS3atHdGY/auQxN0vCd0RAifNljl6LCwGfmq6ZbdMgcv7jlF60cMdOhL258atoZycypYW+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688268; c=relaxed/simple;
	bh=xDtBujhxdu8fOOTw3Y8BhDwPUR4/8CxXJxGhf9ZGeF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPi6H1MBzCbuimw77DXeIPVbrjyfj/AP3wQtacbdYZ+s9w5dAn4QyIDNRqchlHOc364oFBa4ozHYIaJnDMgFwOWnS3qgkd0mvNzJMGYFFppjpgChrlkryev1s3DYXRNqXZ860mkxRQB/rAnocM6MP0LfnLaFr+0yXHSqqEwxsmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxp+4Vtm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688801F0089B;
	Fri,  5 Jun 2026 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688267;
	bh=kiZNHPgcfwiveKmS/0ZPzPkGy4RRm5m2oulHxn+KZJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dxp+4Vtm+IodSEDj99JqSUrnR7+g2kV7BHKCk82ezRJhi3EPmOr/6dhMpBn4JEsd4
	 bUq9TZ+xU9Yhow0MmOtZp3r4JBvi4k3UNqk/ST7MtH8jqhQGJawthLjeYX+0ejgF4W
	 32pAMr0yPJ899tMFqJZR/YjGFesDfMWn8zimpyaeqT2quTgaQPQTIla+LAL7JXtkQK
	 A7k1nt0FHKqF7yfBRc7JWUiKfRGflMcWEt4ENjF9qC5DMY/uiSVxNIAYnp4HTp+O5v
	 tV9uPdHoYesE1mp42l6DAgRCWquKZHfCxVibwv17Ue1BesgkMxRcXC04r6kLixtGWw
	 439poj6yq6VQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 6.6.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:21 -0400
Message-ID: <20260605-stable-reply-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121911.150179-1-weichengc@nvidia.com>
References: <2026060433-palace-registry-511c@gregkh> <20260604121911.150179-1-weichengc@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260795-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:weichengc@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9A1E64B030

> [PATCH 6.6.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha

