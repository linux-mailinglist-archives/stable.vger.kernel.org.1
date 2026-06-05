Return-Path: <stable+bounces-260797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F8e+MYkmI2rtjQEAu9opvQ
	(envelope-from <stable+bounces-260797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:42:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD0664B039
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:42:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ng06dZP2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260797-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260797-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FB79305BF9F
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA143C05A;
	Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C4416CF3
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688270; cv=none; b=sQZWYKim0GMn7YJ5HtrJE6q9xwPWSNmY7hRv4a8HvU9zhE3j+sbDTfkh27YR5muzEGLkSloBwozlBFY21l05DFdFopsiiosmtJaN/sstKbe7FW4q6Bo3d+G4GjcdC8NdaFlNWUr1pirTL4UuEvJM2D6RWotFgekoeyjtMwybbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688270; c=relaxed/simple;
	bh=IoDXSL066FRtEy7ArijmH0nqvEhjtksZvFXy6TyEyT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF7fUshUEVCDksE4UmMA0eTZ9FHHkcpxyiXrbq5nJ9JlN//KslAcqHQfHhhVikW4xemgjzVK/yG+1AX5gB4gP7vWGnBtxrPvZFCNwdCFrnICZ36tqzhNH99TlTfnUy1bvQZAuHal5fV7ZvjuASEMl8OygNDiiTh08oKMZdG+FyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng06dZP2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5BA1F00893;
	Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688269;
	bh=VNAJWE8Y2MkeM9gkoJtSJUoxPRcdNYQ5Jx1OSEmu3NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ng06dZP2jBKpOHSPjpBjdA5uocrpYK1oUGlqQooVn4JDZuHMTSjErlsrMPMyGFhH5
	 t/vgPIHsZLdCsSAcvf1h9G2LsJZQ5TaOx4DZxwtDYbeZ3ruvzdFN4PvMQddu5MGsNk
	 wXwaPQ6YmpCm1bZ14rLjVeRcOZD3c9173IbezCfz/MAMylSuvxkJ/k7kJ1iSolm030
	 lJfV9DRzIkqpe0aazB5LywD+qhrqR6YQUEDv7TmxUvKqvD+LIK3UZx06beH9XNAmtj
	 wiMpTBGYGMs3eKBO0D9h0ZAvUrPgYmfU3zsUGimm4vInlIpvfbGEKSxvKJHxRuVLz4
	 iPX1rfZrpGWzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 5.15.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:23 -0400
Message-ID: <20260605-stable-reply-0016@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121916.150415-1-weichengc@nvidia.com>
References: <2026060435-suitor-humiliate-81e2@gregkh> <20260604121916.150415-1-weichengc@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-260797-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 6FD0664B039

> [PATCH 5.15.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha

