Return-Path: <stable+bounces-20275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F49856492
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 14:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8720928CF8A
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1DD13172A;
	Thu, 15 Feb 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CtrbjDzx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CtrbjDzx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5807130E55
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004238; cv=none; b=IVz9A0J60MHaxSimGqyvqz9PzYsQPXNcfwPI36ZNku6j7/re3EW248I71VCne/R8ViCQ8ulDsAsb/fYDM7UhVVEf0wQegWOvaDj6yPmOHXhWELod++6vPMp6LnBSV3OrYLVb3YqMABL1jUC4iq9gdAH+Ds3AuvDcaz/WN790rhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004238; c=relaxed/simple;
	bh=nJv2WFEvo1VFxleuP6Okf58JpLdbPMiqKeiKuc7ySeI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Tz/GsrIN2WXGd18YGKGjbVyHtl8NKhsMVDXDKQI+AaKpnt/VV8VNKgLDK0g/xsR+oozspOZUvzu96YTlgd5YGlu5Tuj1wNc8sac/FrJcLi5RxOJj7CwZ4efrC38VK9uLfvMqrtmGfyPaw30L7zSbPMXqmkVrk6h6iOg5EUcOM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CtrbjDzx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CtrbjDzx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0562721D98
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708004235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nJv2WFEvo1VFxleuP6Okf58JpLdbPMiqKeiKuc7ySeI=;
	b=CtrbjDzxt4B6zhvv4cEIqTo86XcRvXtyPZ602naSKCNXMo+SECKAwm4C/5TcXvmcL6J2vw
	ymwMY3pijtKSyfRAsUPh2zlAJEbunCmt5yNw/v9qw9AIF8qE4OJ+PrSN7dyeM7kRdVM/DB
	AMi9Vg+azj8tQnpRoZkNOpHgNjp5cnQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708004235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nJv2WFEvo1VFxleuP6Okf58JpLdbPMiqKeiKuc7ySeI=;
	b=CtrbjDzxt4B6zhvv4cEIqTo86XcRvXtyPZ602naSKCNXMo+SECKAwm4C/5TcXvmcL6J2vw
	ymwMY3pijtKSyfRAsUPh2zlAJEbunCmt5yNw/v9qw9AIF8qE4OJ+PrSN7dyeM7kRdVM/DB
	AMi9Vg+azj8tQnpRoZkNOpHgNjp5cnQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F26FF139D0
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 13:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9AUsO4oTzmVjHAAAn2gu4w
	(envelope-from <dsterba@suse.com>)
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 13:37:14 +0000
From: David Sterba <dsterba@suse.com>
To: stable@vger.kernel.org
Subject: Btrfs fixes for 6.7.x
Date: Thu, 15 Feb 2024 14:36:31 +0100
Message-ID: <20240215133633.25420-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CtrbjDzx
X-Spamd-Result: default: False [3.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[stable@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.51)[91.73%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.18
X-Rspamd-Queue-Id: 0562721D98
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

Hi,

there's been a bug in btrfs space reservation since 6.7 that is now affecting
quite some users. I'd like to ask to add the fix right after it got merged to
Linus' tree so it can possibly be released in 6.7.5.

All apply cleanly on top of current 6.7.x tree. Thanks.

1693d5442c458ae8d5b0d58463b873cd879569ed
f4a9f219411f318ae60d6ff7f129082a75686c6c
12c5128f101bfa47a08e4c0e1a75cfa2d0872bcd
2f6397e448e689adf57e6788c90f913abd7e1af8

Short ids with subjects:

1693d5442c45 btrfs: add and use helper to check if block group is used
f4a9f219411f btrfs: do not delete unused block group if it may be used soon
12c5128f101b btrfs: add new unused block groups to the list of unused block groups
2f6397e448e6 btrfs: don't refill whole delayed refs block reserve when starting transaction

