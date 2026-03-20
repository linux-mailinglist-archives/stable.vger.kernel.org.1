Return-Path: <stable+bounces-227408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CkQ0E22gvGmc1gIAu9opvQ
	(envelope-from <stable+bounces-227408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 02:18:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE9C2D49BA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 02:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1179E309A9A9
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FDE21256C;
	Fri, 20 Mar 2026 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="aTXykOmx"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065D3C465
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969510; cv=none; b=DGRPd32tYQhAyI8Ou4+RbreKWIab85JhWBMd2XfGP8ZMLmgxknI4fkDQ7uDgmfwESRuRx3OwE5D+ZOSyh1Y4LljXA6kdk42QDOFt/ssocp8toG9SS8NVMyxfHWxgM5+slQRE+80Ew6qyF6k4JGPgL3DMtHRAijIL1UukPJbI7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969510; c=relaxed/simple;
	bh=Jvothlz+wfPxedCpCKUTvZl8/DOXcxdI1a5GR5EJ458=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl8ODhbJI/Vt8FOar5sX2Etx3YbhIjtcjXiA4XmLU1ktEuKgSLujL8yqxY3b0UXPiyROH+sRf84zgfM+r6UwbCnBi55goRWL36YpMj7gX65sh+WsrR9iBCJL679n+WBw2z8+3hYUyrUxy2x7ISyH3qGW4etLwdw7kWhQag/aOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=aTXykOmx; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773969506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvothlz+wfPxedCpCKUTvZl8/DOXcxdI1a5GR5EJ458=;
	b=aTXykOmx6NOdxm3/0DbOt3iSc3DBlfrZdawMf96zUTLWbWiTaUArNTC4nMFDmw2TNm8QTj
	G8YVHuLQs3fU6nthGqCDFMOT2LgAKNnseVg/P2sr++agvvJuN9WszxQr1nn4g4rmcToKC/
	NcFIyUhTpvhS9CHaYXxldkiCge5EJb9Hrc0D18oN8DvDySCJgXnQeEV01bdzgpOycgDkIB
	jq12MqtyCaY8D43vBNfVwIZQplY2iH1MbWkJBw2sfAooHiQBvwwmJ6FE+TL/+ihiEyHhXh
	YApmEStehnU70c3I9+9nU8sz6g8EY+pTsaDB9Rv2WD/msdBmYjLT3oiZmDS6Tw==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: sean.wang@kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] wifi: mt76: mt7921: fix txpower reporting from rate power configuration
Date: Thu, 19 Mar 2026 18:17:27 -0700
Message-ID: <20260320011727.77939-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260319203854.30479-1-lucid_duck@justthetip.ca>
References: <20260319203854.30479-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-227408-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0DE9C2D49BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Note for stable backport: this patch uses mt76_tx_power_path_delta()
which was introduced in commit 56e38675c5bd ("mt76: support power delta
calculation for 5 TX paths"). That commit renamed the older
mt76_tx_power_nss_delta() and is needed as a prerequisite for the
backport to compile.

For stable kernels that don't have 56e3867, a trivial substitution of
mt76_tx_power_nss_delta for mt76_tx_power_path_delta produces identical
results for 1-4 chain devices (the lookup tables match exactly).

Reported-by: sam8641 (compile failure on 6.12.74)

