Return-Path: <stable+bounces-23338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD8785FC05
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A08A1C23C76
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3479114A4E4;
	Thu, 22 Feb 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhx+iYzv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWcbZGme";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nhx+iYzv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWcbZGme"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D50149002
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614830; cv=none; b=U1b7DB5cGDFsOTgF5oL3Wjoprl++6Dt39WGWhioiS8ytMpYQKb5zx1M6qKHidQ8iSRNaHcrgk4tVTfWIqSiUCrdAbLsAVYRrkwHU7mAZmJ1Zdj2e1RRKBOxHLGBhg0bOTiYPiu2QvWeRtkDni+qY3WVf25xKuDikiiPPdGuTccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614830; c=relaxed/simple;
	bh=cPFhSSMvP6hDs+3gM2jkAe3flILgDvf9JIchBkSbrtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rF074Rvs6Yv89hPOJuCSfl0ohMGwHsjD2deEgsMrEy7+NZtyF+8IF8MCz7yWkVxCMc274HobtR5jEx8u6eerhogndhs9/1jWkoLWAEVq3b7yx8Fq7J+IiJaoneLYHVBdGBMdYzRLdXO2c8zBuWgKMDg5fIdG7pJ5H+8iM0TIwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhx+iYzv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWcbZGme; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nhx+iYzv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWcbZGme; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2449F1F76C;
	Thu, 22 Feb 2024 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TDLpuLSS+CuO+xbvkVOTlVWb1RA8upN5YGYCriWA4AE=;
	b=nhx+iYzvqAy7/fKhL2aviIvfBMaz1HHjpIaTvnEq3NePPPfbZoopzRNQi3le+wYLyfB2dY
	uqin29LJuwJ4I64ABT9Muj5ibtc/gFsL84vPjoXLYhSBE1rnvJ5MGeeoyDmljY4d8WNWs4
	+5j3Arfoh+NEXa0G6cgHc34/Odjy3qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TDLpuLSS+CuO+xbvkVOTlVWb1RA8upN5YGYCriWA4AE=;
	b=hWcbZGmewzzE2msYRA25v+iGHBaNe+k7uSDx4+jr0BfHHZrUurMyKIXPiZE4naKUfaVY+P
	ZwPrLLc6M1AUC/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TDLpuLSS+CuO+xbvkVOTlVWb1RA8upN5YGYCriWA4AE=;
	b=nhx+iYzvqAy7/fKhL2aviIvfBMaz1HHjpIaTvnEq3NePPPfbZoopzRNQi3le+wYLyfB2dY
	uqin29LJuwJ4I64ABT9Muj5ibtc/gFsL84vPjoXLYhSBE1rnvJ5MGeeoyDmljY4d8WNWs4
	+5j3Arfoh+NEXa0G6cgHc34/Odjy3qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TDLpuLSS+CuO+xbvkVOTlVWb1RA8upN5YGYCriWA4AE=;
	b=hWcbZGmewzzE2msYRA25v+iGHBaNe+k7uSDx4+jr0BfHHZrUurMyKIXPiZE4naKUfaVY+P
	ZwPrLLc6M1AUC/Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BA87113419;
	Thu, 22 Feb 2024 15:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 01BGK6lk12WlbgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:13:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] sched/rt fixes for 4.19
Date: Thu, 22 Feb 2024 16:13:21 +0100
Message-ID: <20240222151333.1364818-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
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
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nhx+iYzv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hWcbZGme
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
	 BAYES_HAM(-0.00)[14.10%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 2449F1F76C
X-Spam-Flag: NO

Hi,

maybe you will not like introducing 'static int int_max = INT_MAX;' for
this old kernel which EOL in 10 months.

Cyril Hrubis (3):
  sched/rt: Fix sysctl_sched_rr_timeslice intial value
  sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
  sched/rt: Disallow writing invalid values to sched_rt_period_us

 kernel/sched/rt.c | 10 +++++-----
 kernel/sysctl.c   |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.35.3


