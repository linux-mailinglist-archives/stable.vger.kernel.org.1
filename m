Return-Path: <stable+bounces-176830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B31B3E000
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBEB17940A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D640309DD2;
	Mon,  1 Sep 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QmGkKTA6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uY7sJyC1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QmGkKTA6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uY7sJyC1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231930AD02
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722054; cv=none; b=IQb+oQKRG7v+aMk7lWf9mvNE27fVHjBa84Bbh6G0X7/ZYYXTI9M0HEmkRjkANp3W+5WyX7SP0OFZHfDDDVyRYAKqhn20wh8SC5bv0ZWi4jtMnjAJFsWPNSqZ1cJdOPcZV2DHUaDw9T1kcFOQHK27ad+Eu7an2Fse7jhJSPcF97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722054; c=relaxed/simple;
	bh=Kow1rbxlJKuwL2yuZHGeWRNSqLGuxqbSohKpgPBlHRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oejASruqbphVvDe2UahWhOAzDtYJ24lns1LbIA3ZRLYQ9sfRvt2oPZJf4gTZQSYBrqJKvNj0yWV9cVPrZm+DqEEHqv4B1r72KuAzCgLaeQS6MUpE/rc2NVZxMhFKvajI7rasSzuHqVzCuhB7OnrWvyJYGE3pNBAcdkCPDdAYufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QmGkKTA6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uY7sJyC1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QmGkKTA6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uY7sJyC1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8FE5D21168;
	Mon,  1 Sep 2025 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756722050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+yjcUMTcUdL0Qe6D6WQHRRMPA2tdvWuFWsnMtFpskOw=;
	b=QmGkKTA6JIMVwEsCP+VbwYtMp5Y7/pdWh0jX0Dx57Vtj3G4z/bwvUvNMiq844sASYzRUiZ
	Bj/QKBPriD0/cc/Ou4iGMPzVVKgjSgpiSi1TMqqRWfywiwps1thX0jMtYC3ZlwUMfxaswv
	Yq2QitXZeASL/qH7w+I97qW+O11RV0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756722050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+yjcUMTcUdL0Qe6D6WQHRRMPA2tdvWuFWsnMtFpskOw=;
	b=uY7sJyC1hHOpapmFTPWBu/DJdnpda+Ms+PfOTMa7tD+a2s7CoVdlpNiG9AsGidSn2znYuT
	KxSGQrIoQHK4f+Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QmGkKTA6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uY7sJyC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756722050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+yjcUMTcUdL0Qe6D6WQHRRMPA2tdvWuFWsnMtFpskOw=;
	b=QmGkKTA6JIMVwEsCP+VbwYtMp5Y7/pdWh0jX0Dx57Vtj3G4z/bwvUvNMiq844sASYzRUiZ
	Bj/QKBPriD0/cc/Ou4iGMPzVVKgjSgpiSi1TMqqRWfywiwps1thX0jMtYC3ZlwUMfxaswv
	Yq2QitXZeASL/qH7w+I97qW+O11RV0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756722050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+yjcUMTcUdL0Qe6D6WQHRRMPA2tdvWuFWsnMtFpskOw=;
	b=uY7sJyC1hHOpapmFTPWBu/DJdnpda+Ms+PfOTMa7tD+a2s7CoVdlpNiG9AsGidSn2znYuT
	KxSGQrIoQHK4f+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88156136ED;
	Mon,  1 Sep 2025 10:20:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3mkkIYJztWiLfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 10:20:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 43DDEA099B; Mon,  1 Sep 2025 12:20:50 +0200 (CEST)
Date: Mon, 1 Sep 2025 12:20:50 +0200
From: Jan Kara <jack@suse.cz>
To: stable@vger.kernel.org
Cc: hc105@poolhem.se
Subject: UDF failures in 5.15
Message-ID: <z7j65bmrb4apv63sudegcqaxxxrnja2i4fysjcpiects5gmue4@sapo53pogv25>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8FE5D21168
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

Hello,

Henrik notified me that UDF in 5.15 kernel is failing for him, likely
because commit 1ea1cd11c72d ("udf: Fix directory iteration for longer tail
extents") is missing 5.15 stable tree. Basically wherever d16076d9b684b got
backported, 1ea1cd11c72d needs to be backported as well (I'm sorry for
forgetting to add proper Fixes tag back then).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

