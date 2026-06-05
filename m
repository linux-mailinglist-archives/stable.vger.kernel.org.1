Return-Path: <stable+bounces-260787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I8BbBRwmI2rWjQEAu9opvQ
	(envelope-from <stable+bounces-260787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:40:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D301F64B012
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lOvpdXx5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260787-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260787-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D84793036400
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530E441030;
	Fri,  5 Jun 2026 19:37:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5F1FCF41;
	Fri,  5 Jun 2026 19:37:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688262; cv=none; b=l8REW9LbYIQHLQ1LM5h32cUW+Ugl8Obg+2oD1ZN4jCnyQNO7SR5XLTR2gb/a7g3KtlNkj2LIMinVKdOEXvdsNfw5C26FhyRpWAi++bhN1M59C5RMHiw/6LPV1rE6/fkaSChKZe6ebiUhPUg+ShnKk73V3q4Ui1gVmxCPwYDT6K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688262; c=relaxed/simple;
	bh=OFBzAyJ9wotpV9aYT/7987s36edPBn4agRYERsnu6F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVl570xIDQaYVaP10UUgAj0mHZ2AsdbT8q9voW7arN5GeFuQgqerrBKuAOyIJjrFitfI0Cc9p3p7QXT79tlUZ81H2B6FZddyYf+hjIRBcehmWcoYEMcs1vJ3pBSiFTg8g/suGDD091Im8cHzHGOsfr4M5+Phm63DfeJBFJnZryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOvpdXx5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205F01F0089A;
	Fri,  5 Jun 2026 19:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688259;
	bh=BuE3DvXv5e4Mu8i/UKdg/3B+Dcqvk1E4K+aUYJGSP/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOvpdXx5SUWsjtJrMur/fYQ5kOgYveNhqQnvcczwu/4OMCDAcU9v9fvVPaqHiOvH9
	 ry6wUK8+KT4PVJsY3Y49vbj6C+EtQ175UUKwz0kWCzEdXMb3AcZ1qO5iKE0hIzR/D5
	 i/O1mRheco6pEO87ihKbWhAPlWJyij7tdbkStBrC/jhaBnB6lVGeZ+CvvXv0jl8fIr
	 FPBdMnqtydLxBigZrLU8mY9nLz5VE1a0OeKUPyIEW6PdRVhY4rAoM9uL55X4rGfRRf
	 ZQrfU7wyyqwMOaYzWHsxct93q8vghxWby63/4EoKtZwVpUB0esH9FwTuKvMmMNlcuT
	 69wxZuCqvhk2g==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [linux-5.15.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Fri,  5 Jun 2026 15:37:12 -0400
Message-ID: <20260605-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604092659.3953067-1-lee@kernel.org>
References: <20260604092659.3953067-1-lee@kernel.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:jikos@kernel.org,m:benjamin.tissoires@redhat.com,m:vireshk@kernel.org,m:johan@kernel.org,m:elder@kernel.org,m:gregkh@linuxfoundation.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:greybus-dev@lists.linaro.org,m:linux-staging@lists.linux.dev,m:sashal@kernel.org,m:stable@vger.kernel.org,m:vi@endrift.com,m:jkosina@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D301F64B012

> [linux-5.15.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc

Whole series queued for 5.15.y, thanks.

-- 
Thanks,
Sasha

