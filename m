Return-Path: <stable+bounces-247773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHMjMiQcB2r+rwIAu9opvQ
	(envelope-from <stable+bounces-247773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:14:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4865504DB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E18F304A9A5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF25379EF9;
	Fri, 15 May 2026 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g7Vht7xj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DE8379C3A;
	Fri, 15 May 2026 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850374; cv=none; b=DY7h+ovcC4pvupVBCPErkIUTxyk+exJ1tUFpSgmlT2FDWG8tg9RQIHLKEvTtKGUU6QG/zXOd6WqYBGn6WzxFNK6knqXSENLLdqEJ7SF4kx8w+pOK9Dn/1Rkm8f5OR8GC4WC+qdSi5+zXq8WE2nuPlmYsP8ZXtuqvJbwQE40tb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850374; c=relaxed/simple;
	bh=J7upUiZCyinuO0nKK3XNs6NdKIpwgZ1ZDcOPOmjcgCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ohg/8GTpEg4U81w455NdU23HLb0g0ZXvSXcj6PO73zgwL3wv0PmctgTFvGvNQEl/c79O4A0oqQJUBkTBojYv/pYkJVsCMFQcRuIQd3wCB0VFIRRdupkv/S+srm0PHATxuvslNwkCrCFN0eKIDi2zP6HMzBQDDjFvJaQ3TfPFr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g7Vht7xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F72C2BCB0;
	Fri, 15 May 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850373;
	bh=J7upUiZCyinuO0nKK3XNs6NdKIpwgZ1ZDcOPOmjcgCI=;
	h=From:To:Cc:Subject:Date:From;
	b=g7Vht7xjN90Uh5sVf8X2PwKg9Rs29YgCLwRSwfI1fvc5rwluPpUZD3DMcVJQtPjCM
	 1aMIcGx5IEvl34AaQ0IdQV03LNspnJbW8hTjt0s+94+DjEvjSzVC2ucPIl4c5UAsqv
	 SyLca+Y5Q1s+r+PF089YhiSHL75eTobTbscfz+No=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.8
Date: Fri, 15 May 2026 15:06:07 +0200
Message-ID: <2026051508-corset-rundown-5e61@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C4865504DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247773-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.976];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

I'm announcing the release of the 7.0.8 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile              |    2 +-
 include/linux/sched.h |    3 +++
 kernel/exit.c         |    1 +
 kernel/ptrace.c       |   22 ++++++++++++++++------
 4 files changed, 21 insertions(+), 7 deletions(-)

Greg Kroah-Hartman (1):
      Linux 7.0.8

Linus Torvalds (1):
      ptrace: slightly saner 'get_dumpable()' logic


