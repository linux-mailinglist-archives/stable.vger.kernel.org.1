Return-Path: <stable+bounces-260112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b9I9O15HIGr4zwAAu9opvQ
	(envelope-from <stable+bounces-260112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0D6639248
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Snen5FJ5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260112-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260112-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E24132F5417
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F33B8D76;
	Wed,  3 Jun 2026 15:14:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD053D410D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499678; cv=none; b=L6FJ1g8AD8TTXXZx/+RBAV5XfyBScetNUHWhpbnVPLqCEduYfFUcITZPWqYR0hcrLv1VoqFvwihHV9q58BuunGdlu8ZMpRSHwgVW8UHfdcXbk8anniN3F4B9zggLMwqWLKJVGf51MI1hfrkbpl0ygcuy2PsjRa2avBOTuUK/UmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499678; c=relaxed/simple;
	bh=sSg1Bp2Q7gxa9Rm/Bu/ydi2z7TgHKY4GL1qs4g3TuNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqnP0LotTCwlIERu598YXyLMXPsgPEJj+SAKAkAVKeyCbX1xg+jC2qYaMn+5zoixGlCTafR7HaPJm77LDpTVCukIPIiubuVs7Ex8RpiDXBBxTCyoyBkBXieNlWlDBGJ/pB0QaC/Xs/6/IQZV3XxXsegq77jqPAM2Atgos4h2v6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snen5FJ5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0781F00898;
	Wed,  3 Jun 2026 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499677;
	bh=pX7WEF6IeTgp1VCOrtgpExlDWue20UoEpxE6XPci39M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Snen5FJ5TNL8aH8mqDXjJAMZbqeygtD2pIWtHoPymy8fbNYpZFZG8hSqC7aI2efUd
	 JwjLJ7Cj9LJjN/nPQqjyvTVmxvvPb/Jc0L0CKcm9hverCCHG+cIaANHDZNwS9A3c6x
	 6Iv2QMBuhRIAW+Ok+m8FtWy66sY/g6A7wKDwEOP8Ch0C+3PdiIKwE+Lf0JMwn8QP6p
	 RzDFRPaXCWoCHsP1lh+TaUvd1WIeJrKJgHPVwtXv7XZGdpYbXtIMc6BOtAdk+rXJP6
	 CohRnmYFGiqRruuqL5LQE39Yp977NL2fJXSqMPKE7ohxY3s01uOP4o55WLcmqY33Zt
	 LN6Q4bMEH05kQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Aleksei Oladko <aleksey.oladko@virtuozzo.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 5.10] selftests: forwarding: lib: Add helpers for checksum handling
Date: Wed,  3 Jun 2026 11:14:02 -0400
Message-ID: <20260603111500.item006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahgnK2FarjRafL_J@decadent.org.uk>
References: <ahgnK2FarjRafL_J@decadent.org.uk>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260112-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:aleksey.oladko@virtuozzo.com,m:idosch@nvidia.com,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:benh@debian.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F0D6639248

Queued for 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

