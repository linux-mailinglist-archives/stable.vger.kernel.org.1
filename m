Return-Path: <stable+bounces-230140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KkQCWN1wmnqdAQAu9opvQ
	(envelope-from <stable+bounces-230140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:28:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D483074FE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650B530B84B0
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6AD3DCD88;
	Tue, 24 Mar 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sPDCT2WD"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187B3E5590
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351624; cv=none; b=qGtPHQhvP7fmugCi69XO0Z+kxWsJlpkcbPXAuPd858y+niMhjXVQiaMuumcilUGirO7vTgj0dBGyJfoEWe57vwoFlbI+OWLc7goxeWlza/tTKurnDewq/X2Zd9v0k/ZoBja3I1TLD3F5cjhyFaZaG97vCVWfJu6YJrJ2zLrfLhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351624; c=relaxed/simple;
	bh=mwfnq+p/VIA/hxKMEUOtoonFgYbt/9YqPrOyodGMcM8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyLaVVkFtt7SQlNxAoWostOgwuaASZVKpjo9Z8akrm3ZUo4HN68mrzHXKrf/Np8C691oaO7yFY7H3NDhWracGTIt5P0+/hc8+9aeCgOg8B7F4smTPfxAmVy+cazzRkY37AaMeD5DxDeTz4mFoh4XqDyg1iz2poqsqv8YWpW/3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sPDCT2WD; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Mar 2026 19:26:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774351620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwfnq+p/VIA/hxKMEUOtoonFgYbt/9YqPrOyodGMcM8=;
	b=sPDCT2WDPd/UgCRu5UsMbWEbgQ76oyNGcz4Hxyrc1ixepDFHl80J1eDa+YwGfOkCrZOpgc
	0m83qNef+RUNEFD/80KAMaQeh92zt12gI4OBK4heEZ6+s83s0kWJLWhx6x4twkXC1rPJ0R
	XWHDkzTFJ+VXIqukwUR84f0tQnsOHSY=
Message-ID: <f75eb907cfe0944a5cc3bd02d137fce8.junjie.cao@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Junjie Cao <junjie.cao@linux.dev>
To: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com, Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_ioctl_prepare_clean_segments
In-Reply-To: <65f731a33b7f0f5e26bf288505694c9a.junjie.cao@linux.dev>
References: <69b8c9a9.a00a0220.3b25d1.002a.GAE@google.com> <69c08e14.050a0220.3bf4de.008f.GAE@google.com> <65f731a33b7f0f5e26bf288505694c9a.junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230140-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com,dubeyko.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junjie.cao@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,466a45fcfb0562f5b9a0];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B5D483074FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please test this branch.

#syz test: https://github.com/Lukaaa525/linux-kernel.git nilfs2-mark-blocks-dirty-fix-syztest

