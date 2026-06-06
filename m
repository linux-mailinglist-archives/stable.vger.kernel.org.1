Return-Path: <stable+bounces-260891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qE6uHsohJGoH3gEAu9opvQ
	(envelope-from <stable+bounces-260891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:34:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F406064DA52
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZTOgLMkB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260891-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260891-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B59730277C9
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9C346ADA;
	Sat,  6 Jun 2026 13:31:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC2155757
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752689; cv=none; b=smmXmBlzHDBSvwfnUbjHzrWN/FLilyA2HBu6AuhhDp77ATusdAQvLBLXjtL7A/5ZaamXHT4+B+q7gJzODQr8Ywq9mvXYiSNtc1CTx2RwkWFGSAvksDz5+5d9EGTShZoMxaHIVFZFoEdZyrB4+OTPGjkkhiFKlWmAjwZoiAG2Du4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752689; c=relaxed/simple;
	bh=S0Y4vTzhu1uVbgQSJv23zUAtEwJgda+GHw5VKxaOXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlgoW9XoHL6+A8mVz1kOHQzokilYLqNEF3+21tKGYvLxxSbXyTLSW2LvmgJ/DU7umRgirImqe+tzB0obQxzDk408ApoCCg5XyYZjbIP4XNr6Um78RHXmTGnKwNhkWgELFweXmRolmW1uWbkFsBMp7+fw2LRthcTVsBGJnkmSNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTOgLMkB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C211F00893;
	Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752687;
	bh=iYlUnCtiF3nT5sjh1FybYoMPA5WXEzUG7/rae560OPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZTOgLMkBJmlGSpeCljhEUbHovvl/aaTC13iieZn5zL/xQd6k8BOUNGbh5os3PbDND
	 iprOXJC0YGSY4nt9ICo11iVUC1eQDwxqNDzwq34liN8MpXLyp7rSiMENUI0tIN11yM
	 nIueukPnrn0MXbi05Ni25RxuvbGVBurenj5ttvE1F2DXiJBT/1oCTLGnFiCsfiSYnt
	 r3ARosqs+hcrqs9CGiMaLIgm0sqJN6DLZ14Qi4jin5TNFt1f6hryYZVv9oR6KEreNc
	 Ic01wMrzBjv6o7mN3pA3VRqqiMgO/KTblBWUKcL660xjBDBdfr9RtLmT9RvCBICbb7
	 kcT/R7v26o4Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dongchenchen2@huawei.com,
	kuba@kernel.org,
	toke@redhat.com,
	almasrymina@google.com,
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 5.10.y] page_pool: Fix use-after-free in page_pool_recycle_in_ring
Date: Sat,  6 Jun 2026 09:31:15 -0400
Message-ID: <20260606-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604204110.2083434-1-doebel@amazon.de>
References: <20260604204110.2083434-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260891-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:dongchenchen2@huawei.com,m:kuba@kernel.org,m:toke@redhat.com,m:almasrymina@google.com,m:syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com,m:doebel@amazon.de,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable,204a4382fcb3311f3858];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F406064DA52

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

