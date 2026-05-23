Return-Path: <stable+bounces-253929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/kHvmTEWpLnwYAu9opvQ
	(envelope-from <stable+bounces-253929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:48:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057125BEC20
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80754303C61A
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46AC38AC83;
	Sat, 23 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ViYUN68L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6538A718;
	Sat, 23 May 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536762; cv=none; b=AgMDF2VN+aJD1c0Y/tfVEPWgSKCsSs7AtGLDuvZmXXw41wf2PAcabQrEhDSjRbzoOLBk+7Ug6gJObiTroaulU20uYnvp9BG3t74yj1+1zjdHjxn+tl/I0QbWQjl7rxkVuAhsbD5zFJIiorNWs3YL7M9L4v09p4E6PZZOUTk1zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536762; c=relaxed/simple;
	bh=AkSYbaytLyiXEAjFP2KTf/T5ff9oPqRyxmgGyjtWt9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAWB01XkdkcK96U/bD/fLesWqESmFZO8KtzTM0YhgQtjwJf95Mu9tRFQVQ/WcLVXD8T+8vvO6voovVQ3UxtFpri3A/bmPDmI9gLkOYPXFwfHq9Af/pA3yOMR6/vP60mkcDdElbbAtrtaAbEDg05QAe+XEhOp4/uc5cfI+03ix8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ViYUN68L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4861F000E9;
	Sat, 23 May 2026 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779536761;
	bh=oFw1QfSWMqbocdP/5oy1MMxOcO2QiIHkSiFgzHGAW+4=;
	h=From:To:Cc:Subject:Date;
	b=ViYUN68LJjTfnY2UafHNdsAHx44cP1YQkETbqjXz8vHkYQdUWjRdrEw8efWIE2uus
	 Zo4zNrD3JQExSf5pxK5txTGNKI6I53HCBpB80/xKbDSZIa6fiNE2YewHRPPS4Gt9b1
	 9AAL/hXtD2Zzc8u470vo8GfTNfVYVq+ZghRQDfJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.208
Date: Sat, 23 May 2026 13:45:59 +0200
Message-ID: <2026052300-comfort-aspire-57fb@gregkh>
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
	TAGGED_FROM(0.00)[bounces-253929-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 057125BEC20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 5.15.208 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile          |    2 +-
 net/core/skbuff.c |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

Greg Kroah-Hartman (1):
      Linux 5.15.208

Hyunwoo Kim (1):
      net: skbuff: propagate shared-frag marker through frag-transfer helpers

William Bowling (1):
      net: skbuff: preserve shared-frag marker during coalescing


