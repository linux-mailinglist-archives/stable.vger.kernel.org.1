Return-Path: <stable+bounces-267311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zFh0Af/ANGoEgQYAu9opvQ
	(envelope-from <stable+bounces-267311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:09:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE9C6A3BFD
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:09:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AvsIiAhl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267311-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267311-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2552C305046C
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F365532B106;
	Fri, 19 Jun 2026 04:07:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92B322B72
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842037; cv=none; b=vFv87JKQx/YsbzP4ns1vnrvTlL1DqT82hWCziN/g1uu5p5m8B7zKNlQU8XWYfmptb1o61B1laGF+ddhEwuEK5gzGyek1VzH8HgVwYFe07wyI4BwGBK4247pM6Ez/Q2GNSKTZnpOL2CDs637g/sABbDc4snleC7L9heQu0VWFh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842037; c=relaxed/simple;
	bh=pyBGYcpehEUjjtFgUFwfGgV7Kf+2dUd2PdmvjDVogIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmw3xfJxBr0QM8qLUotKYOmBnFa9oa5DUSYXOsNJlUX6fEB/LG6n6XMLIQzokvs993BQGV6p45TEpBk7N7PH64mzkXK4sdpmqdOO9kmDfelnkVZoeCp6zRomQyao5JQNUMhGqanulsXxDofvTLq8Nc3A12aOUMPNSPYbyroIZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvsIiAhl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF9D1F00A3A;
	Fri, 19 Jun 2026 04:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842036;
	bh=5Z/yb9Y8HER8Bh8Ma09v7AxnLAJeH2mHubtdwln6D38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvsIiAhl704PasGvFMTmYf7psWMWswytVyu5g1BIL/cvzh9fQVTy672dezQhSTCb1
	 coGizhOrPCN3S4UPIRW16dpss0QcDsRRzaYJWa344qZ41DFLKS4/ZpHp4IEfsbpdMw
	 Ew7ZYYTojE54GU8mdkMyrBm1Cpjyp2K0ThRx0RzlMM64PO2eoJfky7sBxOiDpOpc69
	 O1HvGkTdTypZySkZsK3v+vc4UghKOOYbQOTTgJDUEpSrhTeKZcg1BNm39OvPnKmm3h
	 O4mKSIMBeo3St6d7M/iO+0eEmmWs77kXlGHebocqK0tqSQShJv9jFui46zlGyVTXLE
	 /txM0fTYNLFYQ==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.1.y 0/3] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 19 Jun 2026 00:07:00 -0400
Message-ID: <20260618-reply-item015-pedit-61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618034034.1525175-1-guanwentao@uniontech.com>
References: <20260618034034.1525175-1-guanwentao@uniontech.com>
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
	TAGGED_FROM(0.00)[bounces-267311-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:guanwentao@uniontech.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AE9C6A3BFD

>  [PATCH 6.1.y 0/3] net/sched: fix pedit partial COW leading to page
>  cache corruption (CVE-2026-46331)

Queued the series for 6.1, thanks.

--
Thanks,
Sasha

