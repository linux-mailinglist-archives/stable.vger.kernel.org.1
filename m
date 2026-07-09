Return-Path: <stable+bounces-272777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SFTnI8j0Tmq1XgIAu9opvQ
	(envelope-from <stable+bounces-272777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:09:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39072B985
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:09:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IeC6Eg7q;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272777-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272777-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24FD83016ACD
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 01:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175039657D;
	Thu,  9 Jul 2026 01:04:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60257395ADA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:04:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559097; cv=none; b=fqIO8vCOG0L/SfcIqV19KMtP8sr5JKuQyk4KvRMdf4cu8udlerhwiaDOut1LBzw8hNoU3DYOAm+UFlJxWwpjRwWP+0yFUFl2tIT/BwoQPTgC/XnrzZbzrYbAPoH7s0APtMRzbh9m4LZ6pf+828pFt3z7WnbBwcyQoYHoKePf1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559097; c=relaxed/simple;
	bh=2biBtVaZJzKXatDYC3rlJQqfuxkG3+exhbxe8kSacAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpJcSO06yf5FCEjwvLjuyJH3QIVzdPwz9g7ETtq02DEr02CX6SFp54tJOEb1WY/E/mRyb4GBKRUDzjFhsReQqlN9ko0Y47YIdS76KcKNEm9YMByqBc2F0l+KD8GCTx2u9w+B50kwksCfCpPfcXoGrAmQEgKPILRGC9WHQ+b9fNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeC6Eg7q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC591F00A3E;
	Thu,  9 Jul 2026 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559096;
	bh=nNcE2gtya9jGC2DcKGhJAdZybci4wsyZY9OoXAOEefM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IeC6Eg7qOMaCycaotm+pp0ADFz1U/fYhT74nBwfyXDj4qhXLiwM2maryLcE9kOFz/
	 FhdCFBagg3nLvxPTHgtGNKQzY4N29RBmt0RNTWRWNSZpC9cQhiTXJ/MX1ua+lO/JcH
	 RtddHhEB1rS2dMjEhR7RcfeXi285A6ahBH+1MeeqrOoNDrSxgzYayxryHoNQHahlG0
	 BYfapUbEV8jLeT85B7NDpbC6YFEJnMDRlcvlvpOw3PMLhKQfS946K5i6k7ehtD4vAy
	 mZBktJ6cg2g68duFYDlL1eRea6mw7akKMbVg4pkhjWLWm13dS262JDv4WKgBpTA7vc
	 xxkDaAfyLtqNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Keenan Dong <keenanat2000@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sid Kumar <sidkumar1@gmail.com>
Subject: Re: [PATCH 5.15.y] rtmutex: Use waiter::task instead of current in remove_waiter()
Date: Wed,  8 Jul 2026 21:04:48 -0400
Message-ID: <20260708194323.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708150527.3212183-1-sidkumar1@gmail.com>
References: <20260708150527.3212183-1-sidkumar1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272777-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:keenanat2000@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:tglx@kernel.org,m:sidkumar1@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E39072B985

> Use waiter::task instead of current in all related operations in
> remove_waiter() to cure those problems.
>
> [ tglx: Fixup rt_mutex_adjust_prio_chain(), add a comment and amend the
> 	changelog ]
>
> [ sidk: Replace scoped_guard() macro with raw spinlock operations for
> 	5.15]

The backport itself looks correct, but I can't take it alone: upstream
this commit has a Cc: stable follow-up fix, 40a25d59e85b3c
("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued").

Could you resend this as a two-patch series: this patch plus a 5.15.y
adaptation of 40a25d59e85b3c? Also worth considering as a third patch is
74e144274af399 ("futex/requeue: Prevent NULL pointer dereference in
remove_waiter() on self-deadlock").

-- 
Thanks,
Sasha

