Return-Path: <stable+bounces-23342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D90C85FC08
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C6B1F28508
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2862914C584;
	Thu, 22 Feb 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4F8TsKb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuQGvLMh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4F8TsKb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuQGvLMh"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3F14A4E5
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614831; cv=none; b=IM//3nCLrjsLvnqzH5oCW9qB56w2cH4Bpq/UfsJ76o3Z//kbudRQ6hcbLRAXjKPsp6kXVEvCAH4FnKpddAZ+m896ca7rgVvPOduB+WY6oeSVbpSafXKwUREGm6lsWEYqt4ZlknZCA7avN0tABmWFO6Q1e0Dx5rtHPIGNBdEZS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614831; c=relaxed/simple;
	bh=w3owt/D60zOI2UPQ+pnBVXUtkpdfXD64g/YRqWEpD30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO8KY8bqtf9Ruq+35ro0VF+cM6ADJo2fOzTfg2dyJi/e+LhvPeJb4SXk9ygjZ/U+HxjrTtHAx/FDiGGZrfZDqZXNFhJWVr3tRHYnFNGw4d5iCkE9LtjSoRmBTzbA+LOlaOoqPNEawz9rIPb/Pl9Ok0vkQ24DTac/JUcwoPmyFXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4F8TsKb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuQGvLMh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4F8TsKb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuQGvLMh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A959E1F76E;
	Thu, 22 Feb 2024 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dInRqQ54+2Mf+VhfCnQMu5bz3bR/t1MTdcO1LQ0+QBE=;
	b=N4F8TsKbYMIstF2MdQy4HzBIkln2QKiz2Q45PKrw1LOCS609hH5wDtI1H63MFsXcbiFd+v
	2Xix+kowL2ADuD72RQtkseUO7QUpsLATA7i3kUCik0HtVIHhrVTqplnjVM5b7BZWjZjL4Y
	9MeDncMHT/2gQ0lhnYMfeS7F9hucbAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dInRqQ54+2Mf+VhfCnQMu5bz3bR/t1MTdcO1LQ0+QBE=;
	b=wuQGvLMhodP940Hxy/WKwFhSfgWXfLrEWnqabRBJrz3k5KYSGbZyrNUphoBK9U/mE3Y191
	dVON8QAITYBd5DDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dInRqQ54+2Mf+VhfCnQMu5bz3bR/t1MTdcO1LQ0+QBE=;
	b=N4F8TsKbYMIstF2MdQy4HzBIkln2QKiz2Q45PKrw1LOCS609hH5wDtI1H63MFsXcbiFd+v
	2Xix+kowL2ADuD72RQtkseUO7QUpsLATA7i3kUCik0HtVIHhrVTqplnjVM5b7BZWjZjL4Y
	9MeDncMHT/2gQ0lhnYMfeS7F9hucbAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dInRqQ54+2Mf+VhfCnQMu5bz3bR/t1MTdcO1LQ0+QBE=;
	b=wuQGvLMhodP940Hxy/WKwFhSfgWXfLrEWnqabRBJrz3k5KYSGbZyrNUphoBK9U/mE3Y191
	dVON8QAITYBd5DDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F1E813419;
	Thu, 22 Feb 2024 15:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MM+LEKxk12WlbgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:13:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] sched/rt fixes for 5.15, 5.10, 5.4
Date: Thu, 22 Feb 2024 16:13:25 +0100
Message-ID: <20240222151333.1364818-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222151333.1364818-1-pvorel@suse.cz>
References: <20240222151333.1364818-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N4F8TsKb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wuQGvLMh
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.80%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: A959E1F76E
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Cyril Hrubis (3):
  sched/rt: Fix sysctl_sched_rr_timeslice intial value
  sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
  sched/rt: Disallow writing invalid values to sched_rt_period_us

 kernel/sched/rt.c | 10 +++++-----
 kernel/sysctl.c   |  4 ++++
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.35.3


