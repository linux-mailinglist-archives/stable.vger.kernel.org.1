Return-Path: <stable+bounces-274627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qQZ7OMDQVmoOBgEAu9opvQ
	(envelope-from <stable+bounces-274627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A37BE7599ED
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NJmoVYJP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274627-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274627-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A64311F801
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC69F249EB;
	Wed, 15 Jul 2026 00:12:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B02AF1D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074373; cv=none; b=nQzLg5dzW/sAQl0LnCzNXvQODn402UaTPtjqm1SctrO+KNZpgQnZk6O/b5eFjZpPLAZGnT5xiGGlAvMrMMTx4XIII8ou9oOE6yqgLiuIzdJ2RKHLIACRj7IWHh1p9eTjs/ndaUk1iYSy0u5EStTmlRAEUTyuu9gq/upEh6djNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074373; c=relaxed/simple;
	bh=X70KQHQzPPZauwAhMqugpAebI1rSkCGjqMFW4ek7AXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8AFjnfyPfGYuuxVwjp0igeAvoHnp9CxT/3EY08U1hleI8CAVxnYZ1IRcizEObzgh1ew4qpeRO+pMoSDKlLYYCW8mglYWOjYnNYa0liyBdcaWnz0e9saHC2AdCWvIUBIiGPlNLbzi9eu0Hn4DLnmKmIer2o9UGwAV15dPsOds/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJmoVYJP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B21F00A3D;
	Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074372;
	bh=zLS7wYIgYVljk6zgdvYRBml+YlMgxs3Dn5pw2gPoIAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJmoVYJPEOZ8RiAEKhhXFpC/ROMxAMc4w/WPzsnzzqfsMot/BVK97QBT1lBpRDCCp
	 sgP7pVKkhu9W45RIRbDR68mQ9mHUYYg7KKWVL0hBKwT/uQGVb4Epuc/KUAvdbnXZ90
	 Euzp1il3+heaO3Q6gPj1CBRpXTMpVJLajO/RfkvnZXKCpTlZqn3yBDZReUEGOZZiAK
	 jHh9nl09mMWFEkuONl4gi42xSWAmz1DRKETDynmLvzZsoE6yK2qIyTjukxvDGS45n+
	 kZ90PATk1eu+3s6B7b75Tu42oN9YUEEOUn+TvnSzSpTXVdwvBDuc6uEKXjRpitj519
	 HG3u7218/nx/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y 1/2] rust_binder: introduce TransactionInfo
Date: Tue, 14 Jul 2026 20:12:37 -0400
Message-ID: <20260714200600.stable0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714064554.2090610-1-aliceryhl@google.com>
References: <20260714064554.2090610-1-aliceryhl@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274627-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A37BE7599ED

> Rust Binder exposes information about transactions that are sent in
> various ways: printing to the kernel log, tracepoints, files in
> binderfs, and the upcoming netlink support.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha

