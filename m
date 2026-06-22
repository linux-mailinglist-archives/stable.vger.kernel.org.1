Return-Path: <stable+bounces-267642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vy2fOW8GOWpblgcAu9opvQ
	(envelope-from <stable+bounces-267642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:54:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 926FC6AE743
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:54:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HXaDP3XC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267642-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267642-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32C22300C331
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E03A48F4;
	Mon, 22 Jun 2026 09:54:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A473A383C
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:54:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122078; cv=none; b=p9jCqudtz0u8UzNwQK1mFBaC8mg3v1CmQMyTVLIlXoI1Pp6kZU8bCGKVjtwHtwZ97gbdj9nqZJj2GVzWpSm6/9PUzRqZcs17v7Mt+RktMKsGTDgH0P2F3XxH5aXTfMbc8ZyZs3EO1sKnVk94LvpLRyluSG7ywE/JE5kKriOC4zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122078; c=relaxed/simple;
	bh=BJyGh0z3P30vO2qgFu4RutoNTFYPMu59XThdlfPpiyg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=W5EBc/EbWipXak58ProGSvK9J6QGxmeivvgVP5rKhI2qv8mqYteoeeip1d7icN1FVqScxXm0G6DjZXaoKRcGUEbGUsN4ZYc7Hu0LcfVoX4JrfxnykNlu4whWUvmxLGH5OBzBukrifRwl1JFUeznyg9fJmglnIekGfdwg4eh20NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXaDP3XC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B481B1F000E9;
	Mon, 22 Jun 2026 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122076;
	bh=xhmApsWlju3W9kGDHLVahbpDlPbsjxixGor1UQqvCqs=;
	h=Date:From:To:Cc:Subject;
	b=HXaDP3XCQ8RmUhyJ4FXtqIxrrznp871bUhV+69DHZox6FxFynN1w+0zZPxC4SZD28
	 9iJkJIhDU4n/j+NDtyNmmfULh/0Q6Vxr+sO5DnLnM9YlHvBbTkAiqPFWtkqWoh4h2p
	 w00UR5yWyjQe7yZHMt936e2DVZIF/vMnbvaaAo+KJbDsdEGtNnaeKfgBTYJw3SWy9U
	 RLmCt9yChkodw4Z/BZ1pJp1jk80kM0FFx2I9DnmrXb62iQI5hBimTGv5DCxK0Km/TT
	 fAWSXqrUWUZ8xOzJe3bCetFCbOMBnOnYGNtVo6NznmuFTdz6kyOpZFgiRzyOsBQJVb
	 gfu5fzvyBNikA==
Date: Mon, 22 Jun 2026 11:54:33 +0200
Message-ID: <20260622093040.582177124@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.18.y 0/4] debugobjects: Various backports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267642-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:longman@redhat.com,m:bigeasy@linutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 926FC6AE743

This series contains the necessary backports to apply the recent important
debugobject fixes to the linux-6.18.y series.

Thanks,

	tglx

