Return-Path: <stable+bounces-273333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id erSfJTZeUWo4DQMAu9opvQ
	(envelope-from <stable+bounces-273333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204B73E97E
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fCwBkRum;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273333-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273333-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 715453022CEC
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560613B14CA;
	Fri, 10 Jul 2026 21:03:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E33AA1A6
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717422; cv=none; b=GuzZmsiAy/2whqB2tSnU3kUZ0XjaAxhlPGmTMV0w7lTJSnCAVpAm4p4urGjJLfUl3Hv8gxHcJSnAMvH0b0NlIkW1+fpSCUjNwob0oa8vJsbbkBz5ZJn/f/ENMoi0Cz1OxL4RaeZh4Qki+QtTMA4V1xXEmGN8GNFstq82QCyCsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717422; c=relaxed/simple;
	bh=gfJpRQ0oLnLfcg1Ceafuh3VK290e/PCZL6OphDIXO2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnG5KKzN/7VLVWcqr2v9nXpbeNgs02Chc3QfsanoXGqx471QJ1Khs/TK/rVrdNZjZMYlmC2GPmAMMsezhpF8vUhBaLro7FI2KrwykGJp0WpMqaRB9yOHKfaahtIy0UyNJqJSEz0tD6XdEvuMyS8qz1ULR3dTMuoyDIvWAj280GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCwBkRum; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F3C1F000E9;
	Fri, 10 Jul 2026 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717420;
	bh=P+ZKPLQkXxrKw23dewsSVwudgZ2sfwp5T+Gd2CMSNMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fCwBkRum5JyiwOkpA6z2C6QxR2SWGzYcAki/eNIdLSGcMYvCl+VBaW92dFeN5Tj+5
	 fOqGzaRLLcgGKDP7gzqDZTIgjcCIU7USwoF1m/LyOOjTwzA/UcJGoe1zCUP15SQyx0
	 AbaBBSO3Yd0zSfcke7MswZphqZcCeeZ14o8ImXyvOYVso4jyl2yN0f1NL7GclS7JGo
	 mLDQQBWGGSx5kJgjhligd2wYYmezgHA5PLTDu4/+y26U2R7BipM2PuB3XCxTyup34J
	 Ex593uQqQV6VsXVYNf8msX/tStxbUCQRpqZwg0pPKjzdVhVdWXYWJQMrglLv5Ql2V3
	 bhDmZ8a4xx63w==
From: Sasha Levin <sashal@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Song Liu <song@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios when collapsing
Date: Fri, 10 Jul 2026 17:03:10 -0400
Message-ID: <20260710163023.agent5-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ak9hKFnS8uQj1Yqb@pedro-suse.lan>
References: <20260708151357.353173-1-pfalcato@suse.de> <20260708194323.agent5-0003@kernel.org> <ak9hKFnS8uQj1Yqb@pedro-suse.lan>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:sashal@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:willy@infradead.org,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,m:gleventhal@janestreet.com,m:lance.yang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273333-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7204B73E97E

On Thu, Jul 09, 2026 at 10:00:34AM +0100, Pedro Falcato wrote:
> Thanks Sasha! FTR this also needs to be queued to the rest of the LTS
> branches (5.10, 5.15, 6.1 and 6.6).
>
> (for 5.10 it looks like it might need some good massaging...)

Thanks, but unfortunately v2 doesn't apply as-is to any of those trees.

-- 
Thanks,
Sasha

