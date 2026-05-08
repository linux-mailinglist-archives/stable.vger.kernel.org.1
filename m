Return-Path: <stable+bounces-244688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8At9CTmR/WnWfgAAu9opvQ
	(envelope-from <stable+bounces-244688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:31:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A514F306C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3A503074519
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB137E316;
	Fri,  8 May 2026 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7MftL8D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1337880B;
	Fri,  8 May 2026 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225105; cv=none; b=XwcnKJnTHCQY7cFOO09jf4Fqat0uMIMn7yBcdKyW2BlMqQATKiY3DTPcnqO//O4KWseLYFVT9Yh8v8FpJC1RZimHLipryRowNXRiXvFCqi1dTUsf6VUz+Xyd4WhxEBKJvF3Xy7mqE4IdrkFbQTTffBT/tEMjH/U70/Zr6L5Wvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225105; c=relaxed/simple;
	bh=ZpmRdcF4Qg88t+qPEsKp+GMTHXioyNDoYwzjPOZB8bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qk5bk0wb/xY26VTJeLfQ51FZRtML4SoUrUkWTOxsSKyYhcdfsyoy4rKmC+nmywupNDu8cbqmJbeYNYWd9NUMKVZMywxeqrQO2ohjeeTE4HzVTuOORj5EHxHn9tcH4RO8RkVZ8d60NN6c6Wdh5OQM15gQnPSzMPfAwtyUfm8l5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7MftL8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3DCC2BCB0;
	Fri,  8 May 2026 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778225104;
	bh=ZpmRdcF4Qg88t+qPEsKp+GMTHXioyNDoYwzjPOZB8bA=;
	h=From:To:Cc:Subject:Date:From;
	b=M7MftL8D+oVbMa14LQlkpgLaHeK+yUknFFnzIdq6pEg90HxXx14Qt/D40MLgdclUB
	 zq/fageyFm0U9igt3f+aTLCFwPWL3L+ojVCIwsH2kNFEw5+aj2Lk+tGi3If/cbtfCz
	 3zUEMEPj4gdWsaH0DdufZzG6hu2+FgEk32Eo6wSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.5
Date: Fri,  8 May 2026 09:24:50 +0200
Message-ID: <2026050851-iron-hurdle-6421@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6A514F306C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244688-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 7.0.5 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile              |    2 +-
 net/ipv4/esp4.c       |    3 ++-
 net/ipv4/ip_output.c  |    2 ++
 net/ipv6/esp6.c       |    3 ++-
 net/ipv6/ip6_output.c |    2 ++
 5 files changed, 9 insertions(+), 3 deletions(-)

Greg Kroah-Hartman (1):
      Linux 7.0.5

Kuan-Ting Chen (1):
      xfrm: esp: avoid in-place decrypt on shared skb frags


