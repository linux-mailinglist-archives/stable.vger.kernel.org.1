Return-Path: <stable+bounces-269266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 39BmHBa+Pmo6LAkAu9opvQ
	(envelope-from <stable+bounces-269266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DE6CF8ED
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=how95+WC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269266-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269266-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE87304BE5B
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F83AD535;
	Fri, 26 Jun 2026 17:55:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04573A9851
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:55:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496505; cv=none; b=nTRIDhJRP4B7kwhzVBlKGWlxiZtS9r5swBiMjsHgsWIy8p/HFTMBwRmPlfLcnyhnlyCZiXbN8jBkKBl2xkpLRBOxcZiYDoQ8oBOsHf2L+DSA3YM85KVFJMY3oNkwFlmUfD4wncnIGaj4xE8g113q2Wp9lofdQfW712xnMRUpAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496505; c=relaxed/simple;
	bh=PvkNmZ8aXYyrA9y5a4yHNaQ34eLBVWHtv5sxJEmjNeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR1PrFilQlqyL2VXicV+w06aR29BroToyfUhJOHxM3W4DANyKV7TtyTKLrBrDXFbFk8h99rwMHfBkgC+MwUERgHNCzQLpM4sLSPMidQfF9nIvTu2wyyyqp/khYFwSsNkBAgMdA2l9zNNJdqXIzVKUO4PBrNfZ2jEEoPGus+a6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=how95+WC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4796F1F00ADB;
	Fri, 26 Jun 2026 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496503;
	bh=Pdn0E5Y5Nj/fQCduvqhoJH4aFkxsGQNt0zWn1FUQEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=how95+WCM80h3Igw2zPYuF9DZ8HIv6DQ7fZT7He4ckFBCPVeFgmhPmCqy1cQpshhd
	 sOpoD4eL9YjqTWwAcVLV9pp2PnmQKTgFnM9QK35D44DXG71ApvwhTjU7Vabvw/WrQz
	 M48wuO2KJq95CAWgYdJpHfE3jV6GIJ7T3sbrMpQT50Tv/PJcx0rgeAeZ8r+d8o+b7n
	 sDqmFhy1LLzohDpmPjYXclNY/1eEw6wFBuO3Lq44IOgyLWYAlALPDjm9XdVRu3e/Ir
	 aPmO/daj6P8uBjV9ht7ga1Exz+1e78LGk2RXdTFOuCBMWkRGEOoiNkeOoTMxx2bBxt
	 QUBeeq67HeH9w==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	stable@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.1.y] Revert "ptp: add testptp mask test"
Date: Fri, 26 Jun 2026 13:54:30 -0400
Message-ID: <stable-reply-item014-ptp-revert-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <07d9593140f9b608272e5f2ae312d94f9d9a743f.1782381059.git.petrm@nvidia.com>
References: <07d9593140f9b608272e5f2ae312d94f9d9a743f.1782381059.git.petrm@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269266-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:petrm@nvidia.com,m:stable@vger.kernel.org,m:wwasko@nvidia.com,m:maheshb@google.com,m:shuah@kernel.org,m:richardcochran@gmail.com,m:yongwang@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C5DE6CF8ED

> [PATCH 6.1.y] Revert "ptp: add testptp mask test"

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

