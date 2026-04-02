Return-Path: <stable+bounces-233003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFO6IDVczmmgnAYAu9opvQ
	(envelope-from <stable+bounces-233003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:08:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F38CB388D39
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94B66300A8CE
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A23CEBAD;
	Thu,  2 Apr 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nwotJB/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440C3B19CC;
	Thu,  2 Apr 2026 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131620; cv=none; b=S5pIaJq3MmWCeC5dH/aTX6ot1O/0d2xoUcTpiCh0IBf5gCg3137P3eqPtjRrKtlzzxPGMQeMXcJEG51Q4h6PziNCWacG7biOUPTy54TGmOUvPfTFYKxIRgNOGiYNWJ1awsMhk4O5fSaPS2bBfkK1Etl9CS4D1Q2SpYtJ5S+40jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131620; c=relaxed/simple;
	bh=LDz1I8NAtSlfBOJHdCpoImHT2OhotOFr5s15bm5RtKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2+wUjq6QskTR5H6BNYnQc1bNOQe/F9t9fCcimVWsg3FOoZ3IEjIM6auMi2HzXKLFUYWUfh6ZNIP4yeMgFOPfE2Nug5vpCF5nG6av4o+115uqS2ijfY8bLJFo30u10Mjr7XGQimIVo5WVaRQmS1koTbZLjIw4NLpAV3MH55xUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0nwotJB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145F5C116C6;
	Thu,  2 Apr 2026 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775131620;
	bh=LDz1I8NAtSlfBOJHdCpoImHT2OhotOFr5s15bm5RtKE=;
	h=From:To:Cc:Subject:Date:From;
	b=0nwotJB/g12Pp/R3u+tKuVvPL3C0E5VqRWmbdYAQlkt6me8KYycNTpuqGsu6g8Tm/
	 2Mhjx97V9JZOCNbUFIOi7aPa6G3qiJokb4xqSLtvMOzOasAxJEU2/Rc9ZgaeZj9Ldd
	 XUaEh4kIYm4FKiXoRqQOg/uY1dN06Bt+OuE8G/sQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.132
Date: Thu,  2 Apr 2026 14:06:55 +0200
Message-ID: <2026040211-smog-slander-0a1a@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233003-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F38CB388D39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.6.132 kernel.

Only users that built the rust core in 6.6.131 need upgrade, as it failed to
build there, sorry about that.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                   |    2 
 rust/kernel/init/macros.rs |  160 ++++++++-------------------------------------
 2 files changed, 32 insertions(+), 130 deletions(-)

Greg Kroah-Hartman (3):
      Revert "rust: pin-init: internal: init: document load-bearing fact of field accessors"
      Revert "rust: pin-init: add references to previously initialized fields"
      Linux 6.6.132


