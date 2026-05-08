Return-Path: <stable+bounces-244738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MJJABPA/WkpigAAu9opvQ
	(envelope-from <stable+bounces-244738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:50:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5971A4F548F
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD41D301E759
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4F931E84F;
	Fri,  8 May 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jsuMjLQq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432F317171;
	Fri,  8 May 2026 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237446; cv=none; b=AXkGRwHmC2syCV/FgV6Uh6bFsbANRwljgfacySWwow/89UbQP+Q/rxgnQh8LBk5sdNSPPDFPE5QnGslaNaVRtxh0Ib1NReo/sgpKexuTSkeEPhVS08ycTeo7rkrpJo23E4IuuzTSNBpBGIYal1mNYWutqbZmyBsS87US/7rMRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237446; c=relaxed/simple;
	bh=U3C2nMOlgJHmRiEd95E5Gf12Adtc+N5QL0A9oV5Ve90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miQPvidKZOdtHRox5VHk3mH78+FO5vh1OzM1btF4XWk9blGT/jLQtKGVmVV0GnQQjh5ZesMWgGX6ZrUW2s3RY/7H7zvuZ4godBGEneqJI5mTx+ee4KSz9tlW51c0dU8vcGpYjliJAs3R+EzK9Qk3qe0N27beAxFHhTQ8vHejDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jsuMjLQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FC8C2BCB8;
	Fri,  8 May 2026 10:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778237446;
	bh=U3C2nMOlgJHmRiEd95E5Gf12Adtc+N5QL0A9oV5Ve90=;
	h=From:To:Cc:Subject:Date:From;
	b=jsuMjLQqC8uMGQ75MN6/7BJWtqjHdmSHnZjBWpkP98HWACWqKtBaK+Is8DNhyQJW5
	 b3It/qI8MJE2mI/g0Dg0pf4z0VhQynSeqjvTdHYC3zSshsC/MrS2LAHxcVRSnYcyDy
	 XTMzAZ5eZTThegRjWvM9h5k9CwAH1dRXNYW1xOM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.171
Date: Fri,  8 May 2026 12:50:40 +0200
Message-ID: <2026050840-dart-sampling-7fb7@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5971A4F548F
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
	TAGGED_FROM(0.00)[bounces-244738-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 6.1.171 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile             |    2 +-
 net/ipv4/esp4.c      |    3 ++-
 net/ipv4/ip_output.c |    2 ++
 net/ipv6/esp6.c      |    3 ++-
 4 files changed, 7 insertions(+), 3 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.1.171

Kuan-Ting Chen (1):
      xfrm: esp: avoid in-place decrypt on shared skb frags


