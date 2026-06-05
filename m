Return-Path: <stable+bounces-260789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MrWsHUsmI2rejQEAu9opvQ
	(envelope-from <stable+bounces-260789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:40:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9464B01A
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:40:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mvxsJNji;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260789-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260789-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93CB330477FA
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E744D6AC;
	Fri,  5 Jun 2026 19:37:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE94418F2
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688264; cv=none; b=JFg2DVqBAyD/mNm17I+9jcs73t+qFQlmMF3U4YRelicH+uxTS68BLHWqKMPSntSb/Q0h8wZQz7wqHvBDb7OW6SFUqgLx+14f9Wr7mFr97RCGRC5hJUPza6Y5yGH9Bfmt3zr8ZAMjq4wuwSCvF5V/hgJn6of/Hyd1LzJn2eOUcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688264; c=relaxed/simple;
	bh=KZZhr1nAqTo679FRy/AexSo1d31BEqEDGMrHRtoZ1+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeITbpDGoPiflG65DhUvj3mig55gPPKq4d5/bVqopc3FlE8x7F4gVdave6ovcc3C6vxqo9bTYKLGEPlCKU9s83KsCv6YxA4YIiJjZMC09MWStW5JmQzjmxtpkkv46Ulwv63DB2ixAOdjIg+rw+x2jLnj2lm3MzEgxHYN2iAW06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvxsJNji; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12451F00898;
	Fri,  5 Jun 2026 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688263;
	bh=DFSkp3+phW8Ar707XKfjvJ1BoCJkI8wOJrygS2qo3c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvxsJNjiDtPUFFFfCPchY3P0RSIhMgYbm7RgBsutHnkMDk6b4rr8VP5lnMV57naYI
	 HvWVWUoSFJL1DYthtfw4DIsry3u3ePwc41ECPAZX9DJBr1RBqbICTjuMlvtIteT2DC
	 ClnE/Vbfyn724kKLBa5hTlStKtKr4Kaihse6Paf3W9sInKOpPDQ8qRt4HH8Dyf7bhJ
	 OLlzRAe08QT6veoZ0uZJIaxLpfBc/OPRpQkne0RIZWtr591YywEejwuuXRK8O2RV1w
	 6Xn0Ln7iGZndGDY+m24P1HauevOAxjrCC/EV37H7BSjWKbdREcWlpnGThGHzFfXZy9
	 mJiHj28tGgtlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shaomin Chen <eeesssooo020@gmail.com>
Subject: Re: [PATCH 6.18.y] xfrm: iptfs: reset runtime state when cloning SAs
Date: Fri,  5 Jun 2026 15:37:15 -0400
Message-ID: <20260605-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604152119.1694883-1-eeesssooo020@gmail.com>
References: <20260604152119.1694883-1-eeesssooo020@gmail.com>
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
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260789-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:eeesssooo020@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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
X-Rspamd-Queue-Id: 01F9464B01A

> [PATCH 6.18.y] xfrm: iptfs: reset runtime state when cloning SAs

Queued for 6.18.y, thanks.

-- 
Thanks,
Sasha

