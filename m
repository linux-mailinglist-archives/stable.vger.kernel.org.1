Return-Path: <stable+bounces-23349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D270985FC10
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1503AB264B3
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093614D43B;
	Thu, 22 Feb 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pACY2gtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfmP4F0T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pACY2gtN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gfmP4F0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6414A08F
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614837; cv=none; b=gDMR+xAaAGNSCofdYkX2HIoLe/VGYlvfgra9yx1o/2J0o6oEI4JO3P7MAu0+tumG5nfvRzXNSrxmI2B1cL6VmUObwlue8DVHfYf614CupvC8KsldoaXotBZS3SObCOwbF9NPsu9LRbOQK47w2xInx+Wx2TZ0jwbUnJYWSpGbFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614837; c=relaxed/simple;
	bh=65KcE8tHBn7scyNM2AKvP79wYwIhND6Or7r2VnDKHEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3jQeQ6Y1MT0BApoz9wZ7usr9YWpV97ApZbaRFmlAn8QrCCVUnclI3jHMB99VhXjnh8pgfZoIUavYIcsxxANXnGmkVVyq14Nkq3sP1yF2tNhArRFOyKehR7Lrhhx6cA/6Xqv/QAX5c2j3VCIiu6f6tffpV0O/K5pQv8bBfa2Bp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pACY2gtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfmP4F0T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pACY2gtN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gfmP4F0T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FFDC21FE9;
	Thu, 22 Feb 2024 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUHtP25/ANJozHqnwrw4gJ+b55SYXfk4h1jTMlMoQSY=;
	b=pACY2gtNQ9pa7SSV7nDP6iNrj1O4nK0RwHnVIruHaXHQKRUG4DN9LAmEmQXMrJ8DF5vK8I
	EPLbiEi/H+Gv46WoNSP1X6yS+qg2ZDrw+mR8XerqlXdwq/EFeF50DKm5iNptr6XMU5q2zv
	/gGYvdGqXy5YQjq7R6GLI5EQhCcQ/ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUHtP25/ANJozHqnwrw4gJ+b55SYXfk4h1jTMlMoQSY=;
	b=gfmP4F0TRXo1yGh+Wgn4CCmbJix3W5NIeNCqclwxBq1FNzLSfIt09JQ7OuAprqkILVeI5a
	8NAfEMTSeR1u8GBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708614834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUHtP25/ANJozHqnwrw4gJ+b55SYXfk4h1jTMlMoQSY=;
	b=pACY2gtNQ9pa7SSV7nDP6iNrj1O4nK0RwHnVIruHaXHQKRUG4DN9LAmEmQXMrJ8DF5vK8I
	EPLbiEi/H+Gv46WoNSP1X6yS+qg2ZDrw+mR8XerqlXdwq/EFeF50DKm5iNptr6XMU5q2zv
	/gGYvdGqXy5YQjq7R6GLI5EQhCcQ/ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708614834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUHtP25/ANJozHqnwrw4gJ+b55SYXfk4h1jTMlMoQSY=;
	b=gfmP4F0TRXo1yGh+Wgn4CCmbJix3W5NIeNCqclwxBq1FNzLSfIt09JQ7OuAprqkILVeI5a
	8NAfEMTSeR1u8GBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 99D6913A71;
	Thu, 22 Feb 2024 15:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AC3iIrFk12WlbgAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 15:13:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: stable@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/1] sched/rt fixes for 6.6
Date: Thu, 22 Feb 2024 16:13:32 +0100
Message-ID: <20240222151333.1364818-12-pvorel@suse.cz>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pACY2gtN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gfmP4F0T
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
	 R_RATELIMIT(0.00)[to_ip_from(RLdzj5certor34mwkzd58688e8)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.97%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 3FFDC21FE9
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

Cyril Hrubis (1):
  sched/rt: Disallow writing invalid values to sched_rt_period_us

 kernel/sched/rt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.35.3


