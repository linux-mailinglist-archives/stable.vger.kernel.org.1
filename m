Return-Path: <stable+bounces-242074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCsiKCMm82nIxQEAu9opvQ
	(envelope-from <stable+bounces-242074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:51:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D594A0340
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9239330834A1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D7E3FE675;
	Thu, 30 Apr 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iopk4kIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C93AEF27;
	Thu, 30 Apr 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542346; cv=none; b=c+z0M+Wn+pOz7LjM2MrsZQWL4WuIGbzeI0sOTGpsISHMhbWdbResdYjMlaORJQbvjytKYhSkN5Ur4NpYkc4oYeiOd1pAbiR1drKVqbnyxHPaMJSmqI4EyACfcQUqdTYC6ZuuEWK+OkT5WAXK0JZ1NQDlxl4jqvLps1Ly28Oqzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542346; c=relaxed/simple;
	bh=kIYx2jXUXdmSPeXzX3danftHDgYNJdeZqL0Ui+bW4C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYKwZWcZnC6f9JDNtkdrh4LNs+x1q9Nx2Q/zM01hNsziAjob7oNR/D75gGC9JrSe8JemtfynUCHITAgCwdTGYfXz0ZFq1Wc/KDbsGueNfQpiUu8gb2nJ5adXrPh8P9CdMTcvGWi3xqTr4VAKwPJiHPqTSCx6uI8utK4UAnX+T/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iopk4kIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA92C2BCB3;
	Thu, 30 Apr 2026 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777542346;
	bh=kIYx2jXUXdmSPeXzX3danftHDgYNJdeZqL0Ui+bW4C0=;
	h=From:To:Cc:Subject:Date:From;
	b=Iopk4kIaGVafRNdAeCcfuQzJEypYfBJn5+zYTxlXa1uWf6CC75orlWVxEIjGphi7E
	 LLEKeXPi7Xb++pgrPez/OSm5F11fk5THNkzaB4roC1zKEneK3P4Cp7+ZqaeSbhW9kX
	 AuKNqOl4dNotaKcIzqKRgWIU9pjlM+Jrk9FomqNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.3
Date: Thu, 30 Apr 2026 11:45:05 +0200
Message-ID: <2026043052-coasting-tinwork-27b5@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08D594A0340
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242074-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.981];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]

I'm announcing the release of the 7.0.3 kernel.

Only users of Xen in the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                     |    2 +-
 drivers/xen/privcmd.c        |    7 +++++++
 drivers/xen/sys-hypervisor.c |    8 ++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

Greg Kroah-Hartman (1):
      Linux 7.0.3

Juergen Gross (2):
      Buffer overflow in drivers/xen/sys-hypervisor.c
      xen/privcmd: fix double free via VMA splitting


