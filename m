Return-Path: <stable+bounces-273323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxXCIDNeUWo2DQMAu9opvQ
	(envelope-from <stable+bounces-273323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D658C73E977
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PJIxyA9T;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273323-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273323-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B00430137A7
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8EF318EC4;
	Fri, 10 Jul 2026 21:03:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F613DDAE;
	Fri, 10 Jul 2026 21:03:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717408; cv=none; b=PCWz6p3tQ01pzgHN864sooVBQPHdD9OykI5BOHa4KqabTKSjadA1bBWtd1a2qLIIrQdLFFKwIpjGi/hKd3s+hScQb0mlSYbvzzWlgvYFhkr2PR7NbZ0DgjJQdeZ4twob0KxsFpjSTwEh0dgw2/4nA4OfPvwIrd8CNVALUa/dv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717408; c=relaxed/simple;
	bh=gUFh2jEwowyf3tBPGLOuRxUu0ZrIQ6KUHu9kkmR9BTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aePTFKxhWb1f2W9gniltde32q4zyLP80WKS4ZTUhyvh/s/wgXKlbK81FhhzO0nHBkc0hsub8ysva8ooU82tNRhaj0jDXtjYFYPaw49ldfjIVwFda8YopxqpsgDEoDEhBhztGBo9Re34dzu4pxOfIM2gNbfDU57Vj7VPhwoBogWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJIxyA9T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863E11F00A3D;
	Fri, 10 Jul 2026 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717407;
	bh=IxDQXUffjDPiX8s75V9lUlztwYc8UXv2+mVoAik2+IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJIxyA9T9LcedZvZtKzFpv4Nv71M/63UFU1MMhcIJ/witPYFfZxgHfa0l5l3+46kt
	 S8jHOqiu9gYMsbCrNw8vyi2rh+mFTGaA5y/q1GxqAMAnyAY2FjVXpfiNIP5qD+lnOd
	 x+gHiqPkYwzJehN+CZ4ENbbhyy4g1NbaMx1nbQ6/l3nfpJC5uiIDnEmI/fdpb7/bxC
	 GS5jVf3EzR2VfcWfBU4XHLnmu429oiVjVzhjB6HOviZFMLcFnUW8YOTwmIaggNUGcB
	 /s/3BXiB253AW0lhVTgW8GBFyc8MrHQQ8oBNocaMftBoE9IqqOuX743M8LC6js1hC9
	 WpYSuyKI5vHig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	oliver.upton@linux.dev,
	gregkh@linuxfoundation.org,
	mizhang@google.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	mark.rutland@arm.com,
	ahmed.genidi@arm.com,
	leo.yan@arm.com,
	miguel.luis@oracle.com,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH 6.6 v3 0/6] arm64: KVM: Backport VHE-only boot fixes
Date: Fri, 10 Jul 2026 17:03:00 -0400
Message-ID: <20260710163023.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709223604.12934-1-coltonlewis@google.com>
References: <20260709223604.12934-1-coltonlewis@google.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:oliver.upton@linux.dev,m:gregkh@linuxfoundation.org,m:mizhang@google.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mark.rutland@arm.com,m:ahmed.genidi@arm.com,m:leo.yan@arm.com,m:miguel.luis@oracle.com,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:coltonlewis@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273323-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D658C73E977

On Thu, Jul 09, 2026 at 10:35:57PM +0000, Colton Lewis wrote:
> Architectural updates retroactively made FEAT_E2H0 optional, meaning
> hardware can implement FEAT_VHE without FEAT_E2H0. On such CPUs,
> HCR_EL2.E2H can reset to an unknown state and must be initialized early
> so later code can reliably detect whether E2H mode is active.
>
> Without these fixes, booting 6.6.y as a guest under KVM nested
> virtualization will hang at boot.

Queued the series for 6.6, thanks. I also picked up the follow-up
"arm64: sysreg: Correct sign definitions for EIESB and DoubleLock"
on top.

-- 
Thanks,
Sasha

