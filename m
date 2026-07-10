Return-Path: <stable+bounces-273321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0N27ASJeUWonDQMAu9opvQ
	(envelope-from <stable+bounces-273321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C273E95B
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ARKJwzRF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273321-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273321-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7042A300B059
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E033264D9;
	Fri, 10 Jul 2026 21:03:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C92225A38
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717405; cv=none; b=PpRdyozdiATE4w7GjzvhrO8g1zpdBpg+j0P4KmODwxHN/4yB8PdfaiFjYXX83OIZmsrY4nzrs7hOu7/1vXifRZrIFX8QP5+MOtRLo0YG6bRqWmmEdp12ghhcYfz2z4PzDEdJ3i1BB6ppEzo3irAkHSqIPtebpB69pGqnXx1kFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717405; c=relaxed/simple;
	bh=ZhhNa0t/7wxhfaXMOZH0053tyQZ7otJJGKLCILUg/DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLLgz1d/sltQCZ4TD9f0SesQ6Eeigh2HgoFxpAatUMG8kXPbaBC8CioziNnFd1rrnN92KkBNvaJCTpJqa4O8DKzJBxSfRGWCAFSmG0ycfQ2qsXd4nFwG5VnR3luDiTXY//0CveNftuWWPt2MeyumFTRsRX404raGhjy36KbShSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARKJwzRF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E141F00A3D;
	Fri, 10 Jul 2026 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717404;
	bh=TRbIXopC9vYVCcxu0eGR6GlAGJwY9ROYRhRW9oGYgpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARKJwzRFeGfs+8vC6W/rQEAL0/H+mWGiKoCI3I0QlOOjY46KynYNW6MtcB40CI1SW
	 H/4jErQzc7HfRZ9QUPgSrqf66CsQyw2Zqlk/9+tseYd6iny6zOQHgNW0r7gIfj+u3y
	 CBiGVit5kZA9aUk5QswPv175quQlcakTKtivuPZGW1CFUDJr6oCxjIu2f7v/AgDEr7
	 /BNdymS8lWoogBSYLylt3CBED9q/JThoY/siHeJ4U0ixYNttXwWx013uyfV+dwvfYK
	 HkbCngv9C4doIXfZmHBEnVx6SGSGS5OycKxeJb8HL0M4GHhpV0tu/CPRKcTCdhgBPM
	 eWjaSzMuh+ynw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Keenan Dong <keenanat2000@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Thomas Gleixner <tglx@kernel.org>,
	Sid Kumar <sidkumar1@gmail.com>
Subject: Re: [PATCH 5.15.y v2 1/2] rtmutex: Use waiter::task instead of current in remove_waiter()
Date: Fri, 10 Jul 2026 17:02:58 -0400
Message-ID: <20260710163023.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709145949.3640783-1-sidkumar1@gmail.com>
References: <20260709145949.3640783-1-sidkumar1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-273321-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,stgolabs.net,gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:dave@stgolabs.net,m:keenanat2000@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:tglx@kernel.org,m:sidkumar1@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C38C273E95B

On Thu, Jul 09, 2026 at 10:59:48AM -0400, Sid Kumar wrote:
> remove_waiter() is used by the slowlock paths, but it is also used for
> proxy-lock rollback in rt_mutex_start_proxy_lock() when invoked from
> futex_requeue().
>
> In the latter case waiter::task is not current, but remove_waiter()
> operates on current for the dequeue operation. That results in several
> problems:

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha

