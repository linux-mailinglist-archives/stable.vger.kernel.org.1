Return-Path: <stable+bounces-254025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHt1JPzrEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:15:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 332805C255A
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE0223043FC5
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B983803D2;
	Sun, 24 May 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdLBabTo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C433C1B7
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624621; cv=none; b=Pr4tZPkXtt2T248Pn0ZKAYy3EIHm3j1m+UUOYcycZO/oz1yF0YmlltJywz0rlIpvKbGsMTP+bQfuZcxuFR5XTgsO7QgrWR68xtBwlfX7c/e7kcKFCCOwagw8dYkAOManwpyV1P4E0JHAkNl5UD/URFajtinGK0D+pDFuWZ+CqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624621; c=relaxed/simple;
	bh=S0Y4vTzhu1uVbgQSJv23zUAtEwJgda+GHw5VKxaOXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLk97JKEr2vZswKzz2pG2Zt+kyU+VVrK6055DRb64c0aFYDW293i7z95po7lUo6RjT728PLJOfcSse0M5TzJ54YQGp7uNH1P/Fmn40YZTtHtSRQxxE+4T9JCTfm25Wy8XeUKuaTLSnTfhbr6LS5II7eg2qfZ2gc/xqxATojPNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdLBabTo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344201F000E9;
	Sun, 24 May 2026 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624619;
	bh=iYlUnCtiF3nT5sjh1FybYoMPA5WXEzUG7/rae560OPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NdLBabTo9WnqGDv2hRFGkDCChin0iUTOF9P0hL7M87Q88cfuqQjtFMul4Ut0W3BMa
	 zI93siJHHIphAyas6XjinLQZJooUPGBuZd1r3PwfLWHD89tWvgtKDs3EZN9UKJd6rI
	 NfOanK/bwz+k/IJqCp0darpUXhpmMdWiYAOq1P8qdb8yYrl9H3rpUKTqrviVwTk7jn
	 jg6IhhYow/TO7xagR4NRDxrARoitMPtPc/tNFKMqXcBrjqqqCaZH2rZmBTJKMRzWiL
	 qyK6NOV33ccZH7DraTtKCwqMEEM3fAUYtTGVGy4B1zRMlni8YUsFwtd3PlU1JbRs/j
	 svFNU4jRB1k5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Benjamin Block <bblock@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 5.10.y] s390/debug: Reject zero-length input before trimming a newline
Date: Sun, 24 May 2026 08:10:17 -0400
Message-ID: <20260524-stable-item013e-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521022849.38876-1-pengpeng@iscas.ac.cn>
References: <20260521022849.38876-1-pengpeng@iscas.ac.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254025-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 332805C255A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

