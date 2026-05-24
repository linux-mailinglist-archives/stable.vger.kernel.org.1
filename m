Return-Path: <stable+bounces-254021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK33FOLrEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:15:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6805C254B
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192853040FAF
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C83955DF;
	Sun, 24 May 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7oBRkGc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112950276
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624608; cv=none; b=nk2uzLg35IfP0gEHpR8qv/2Hypd68Et1Md2lBIDWh1DTSzBGHtyweKvfrg5iabIoHKhonu11El6o1t0PmQ1NbGGqFHLqMh2OlN8eDccG3ND6VPaf5aHBK9YI1z9OKJOcRui4K2J4qWiipzjZv1mPTgZErZqwAaUdhQijYNkF2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624608; c=relaxed/simple;
	bh=iqdBp1SBe9s5B8xK7xryHGkN3EFOsiyJRhWFfYHWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7AEHR4phxmZiVKefQyLnzlBgqKtj8hi7U/Gihc0YWNjTMJMdHHXrjU5y4Sc3JFGnjA65d/pnys9MAwJDSnsDOGYGnOBf2Dr584kXTay9f6m8Lh06RV8VLMFRjUQ6jS9K3MWJwbGjfYrWrPxWE/s1VUsMNurSCqXJc5WlDKym0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7oBRkGc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8CB1F00A3A;
	Sun, 24 May 2026 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624606;
	bh=JzucgvGDuY3nnjHaY/HehPAaXtFO2Zl/ImV4s57IpW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B7oBRkGc+hiamKMPK18rjiZ+7/eXWOs6Av1zKS22BADkoFZw+JLP64XWTwKDL6PME
	 KLjDgnKXTuz7WYpSv8zu9gIGm5PlOwXYEJoDAQDIeqFPUVpaHVLIyqEnVSr/oz9DvG
	 kSji4uhZBkaXI1RO21rKtrsKqPYYOoRpGiYQAPqvSTEpgGmoSDqJYC6rQQXwFKZ9Vq
	 u3gst0dF0Bayalqfc7NOx7FVEKfpOSBboVVrM+P44ciGo3ZzMhDRUh08Z3x4P/oR7O
	 jINVQM6416hkyWzlOSH+ta/6uimC6Fgrhq+02tdc0iwVMhc79Eannn855qSoPTWWei
	 d3LDYpEfTFvKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Benjamin Block <bblock@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 6.12.y] s390/debug: Reject zero-length input before trimming a newline
Date: Sun, 24 May 2026 08:10:04 -0400
Message-ID: <20260524-stable-item013a-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521022829.38645-1-pengpeng@iscas.ac.cn>
References: <20260521022829.38645-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254021-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD6805C254B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

