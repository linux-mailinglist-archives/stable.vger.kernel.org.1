Return-Path: <stable+bounces-253931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFDUJEKUEWpLnwYAu9opvQ
	(envelope-from <stable+bounces-253931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:49:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F95BEC4C
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A22DC304816F
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80938AC83;
	Sat, 23 May 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sF/qzRBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98938910C;
	Sat, 23 May 2026 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536768; cv=none; b=QVmByT9EbS29Tanm9iC3lhnvvkEwR61gYkz0jfSLKt6UhauEVXhSSjz/w/aiXy3MMNZFyNA5rZr8FPOBhRdCzsU+zteG7m6MJr7vR//jaMnptrjUpyBF3+2jKqfdidRWhE00NvFe+4A0UIQ0ktTZeUWVHhFKP74xQ587B4BKI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536768; c=relaxed/simple;
	bh=NqDuLoyGagYi7vlva4/N46PyMv7zBjiiR7jmKGN9xHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwhGSAHIiS1/hMd8Qi7C8cAOVqLuNGewwTKAe52+c6FR22pRjEzEDwhSq6EdO0UKMdmYAjH9mW5eneOSYgbNHyY5vTqwk8HmPI1DEWK7io4ZbfW3ZKTsp5VHd3BPf1InMSCR624+cE2YVTHfSksbYJ64LwVTutyvp6z++HGvNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sF/qzRBi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB5C1F00A3A;
	Sat, 23 May 2026 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779536767;
	bh=sseKSO2r9qXSjIAPk7DzDyJQB4CUgfH57T/9+yQ5wNE=;
	h=From:To:Cc:Subject:Date;
	b=sF/qzRBiZgS/QjXifmCeyt3vM2yDqP22frMVIIPAbkb5zP9akhg3jm3Dv8rPkxoM3
	 stytUkE3aWxhdgAYsPS8cuaj/SN3U7Pkn4fkddc0lnD5Pf5E51h44UgO4KXmvG3u2P
	 QWWgyjmxmfEl7gliJcIe2axyISn/BE1iIYMKv1+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.174
Date: Sat, 23 May 2026 13:46:05 +0200
Message-ID: <2026052306-gallantly-record-0015@gregkh>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253931-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.979];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 573F95BEC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.1.174 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile               |    2 +-
 net/core/gro.c         |    2 ++
 net/core/skbuff.c      |   11 ++++++++++-
 net/ipv4/udp_offload.c |    2 ++
 4 files changed, 15 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.1.174

Hyunwoo Kim (1):
      net: skbuff: propagate shared-frag marker through frag-transfer helpers

William Bowling (1):
      net: skbuff: preserve shared-frag marker during coalescing


