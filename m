Return-Path: <stable+bounces-23348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B7D85FC0F
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D1C1F2855E
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0D14D43A;
	Thu, 22 Feb 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHc8v6RC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ptFjaoUn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHc8v6RC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ptFjaoUn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28014D42F
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614836; cv=none; b=pdXyMPk7BkpJ9b+m+XdB53IgUZy8dsb5Mk66ca2cV9x+SVa4TsFgtt/rPSmG/TiVGiAAo3Zn9vCxok3DI7wuXznnTZ5sKWOBVgSvYKh9GvHORUe5ZEjeA0XlO5Q08Hd4kEpo5y5TXb5qh1c66ppbxrCThEJB18gynK2dKaqJ8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614836; c=relaxed/simple;
	bh=OhpjA37BQ8EwCRD8YxRA1f1FVucRtcNxKxh9JOqJXoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgGZBkO6cr8p7kuC8nRe6/g2BN+Yfu1ipJZE8Y9U7HvGX0mrdxiiV1ILiLngP2aO+Fzqy7J77y5p1blCHD1W9oSu9K4wNcA++UgIofS6xr8yMqoa8EfecLAPaLJvbOTJgujCQs6GbBEtuLGpWnx5HlRz6poGHo6Gqx1q25sNiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHc8v6RC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ptFjaoUn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHc8v6RC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ptFjaoUn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8068C1F7B5;
	Thu, 22 Feb 2024 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm2FCZS393LV59FU1JGwky5ox3WKa1xh5+HrK4QP7Po=;
	b=uHc8v6RCtbPEK/eZWjasPvyDUtT2YlpFKgYW4YLc4ObbiCxaMoH121fbqwrC9JTb1x8ueM
	X9b8fh1Fq7cjWKwWc7PRLhziNLSVSx1uLc3xKVhgtrK9HQ8ERCTzKCmuHBp3VE4H3gCLc4
	ZjEPz9OA0TUz1R/BbSLuSLsBEt4ZBaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm2FCZS393LV59FU1JGwky5ox3WKa1xh5+HrK4QP7Po=;
	b=ptFjaoUniLH4E+WCo/yX2HTi6DMIoM/qQ1lp/n27PbNIVNvHm24G/s+xeSdbW7sgcgKXMl
	CuZzhyHG0esOi4DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm2FCZS393LV59FU1JGwky5ox3WKa1xh5+HrK4QP7Po=;
	b=uHc8v6RCtbPEK/eZWjasPvyDUtT2YlpFKgYW4YLc4ObbiCxaMoH121fbqwrC9JTb1x8ueM
	X9b8fh1Fq7cjWKwWc7PRLhziNLSVSx1uLc3xKVhgtrK9HQ8ERCTzKCmuHBp3VE4H3gCLc4
	ZjEPz9OA0TUz1R/BbSLuSLsBEt4ZBaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm2FCZS393LV59FU1JGwky5ox3WKa1xh5+HrK4QP7Po=;
	b=ptFjaoUniLH4E+WCo/yX2HTi6DMIoM/qQ1lp/n27PbNIVNvHm24G/s+xeSdbW7sgcgKXMl
	CuZzhyHG0esOi4DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 127BE13419;
	Thu, 22 Feb 2024 15:13:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KKsHArBk12WlbgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:13:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] sched/rt fixes for 6.1
Date: Thu, 22 Feb 2024 16:13:29 +0100
Message-ID: <20240222151333.1364818-9-pvorel@suse.cz>
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
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uHc8v6RC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ptFjaoUn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLdzj5certor34mwkzd58688e8)];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.58%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 8068C1F7B5
X-Spam-Flag: NO

Hi,

FYI c7fcb99877f9 has already been cherry-picked as
5fce29ab20cb05797239e4628fb683d2ee9aa140.

Cyril Hrubis (2):
  sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
  sched/rt: Disallow writing invalid values to sched_rt_period_us

 kernel/sched/rt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.35.3


