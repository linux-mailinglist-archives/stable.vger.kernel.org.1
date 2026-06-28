Return-Path: <stable+bounces-269441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPD7GTWWQGrMgQkAu9opvQ
	(envelope-from <stable+bounces-269441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0036D306C
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lCW6nYEC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269441-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269441-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A44D3006032
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DD526E70E;
	Sun, 28 Jun 2026 03:33:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B21F872D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617626; cv=none; b=HbT/1KMOOrIARmxkXVQA+9AXGRlGl5Tovp32uugQqqywWmS1MU8kpk24o/337/UqkmY6BpHQB8o1rUnDSO+MdwxCe/TPhbwUJ0JZ03tp8ztkYfG4KbDqjsPLg7w2FzLmsCOZ4RN0YQOyabHeenJHJ8zfkCBE2AGqqCA1drz9Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617626; c=relaxed/simple;
	bh=PyLEN6oOOCis3XcykYO9fXOE5+8Pj+5s+pwz/LIS8Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejfsMx7sQJH8EHQHLKtRithWWiSik/29hRxC/PmaE9MgrSsokUNKIxatNwHCzUFrRqkXaplDY7u/cbdWtTgrgr1o6Q2lcTbjv4Kq+OW+PyPrwKVbLL13iZKQNK8Fn5DI2iqMESnHWXyr24Gg5raNDmQJtCsfjIG8if6jOh33pCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCW6nYEC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC2C1F00A3A;
	Sun, 28 Jun 2026 03:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617625;
	bh=PyLEN6oOOCis3XcykYO9fXOE5+8Pj+5s+pwz/LIS8Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lCW6nYECnZXkOhpNaLR4bZ7Q7adME0p4z8h5CH5LC62Q3/CeLopqGJBTZoJ/lC8Gn
	 WpUCRmCIgK6nnuG12qigOgyEkDVp25vtT0jBjJg6F7TA7QtdFCm009mS7VOsGZPoii
	 oIMDXtD7naAuDof8SOv0c4U78Q0HaFW7oQt7/IwG6oZqc4gf/S8PV9BSjS58qWpMgm
	 v/OeXQFAkTxLj3hGgEnl4ZZh1DT2qEmfx00BDLWOutRRzCa4NirkB80ff9Tndz9gZL
	 TxDqubqQAwDn1GVyY2lJ22EizNiM/5s4lCd2DPRBLQG0OwH0uE8WdotM49t2sDZsf2
	 WTME9P/r4WQEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.18 00/26] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:33 -0400
Message-ID: <20260628032401.0003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269441-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF0036D306C

On Fri, Jun 26, 2026 at 06:11:44PM +0200, Sven Eckelmann wrote:
> [PATCH 6.18 00/26] batman-adv: 7.2 merge window fixes backports

All 26 patches are queued for 6.18, thanks.

--
Thanks,
Sasha

