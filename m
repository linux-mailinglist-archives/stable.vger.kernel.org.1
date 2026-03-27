Return-Path: <stable+bounces-230619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAdpDVJaxmlgJAUAu9opvQ
	(envelope-from <stable+bounces-230619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:22:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DF43426A6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30FA8316A858
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC043A9DAB;
	Fri, 27 Mar 2026 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cn7VUUnc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6523A6B6C;
	Fri, 27 Mar 2026 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606339; cv=none; b=LwxWiXbJzy5sc9LjhQt4Ze4hAFrfses34c4u/fh9FhpYT6Fthoyy4z+oDF9zLJaNddBdNZ/iDA/Vg2wzl825RiBNY0rsISIg7HWhUn/6D5cSrE9a0iJMPFRVDfp05JAGHA67B0QCLu0SOezGN5ZALbHmoADuq45ua7ipk58o2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606339; c=relaxed/simple;
	bh=/sBlDAuD+k0xiaI00BMG8cbz3yQl8lhd2eBMiuzWDEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3GOTQeVYd14C3jaY4fkAscCUuAjwwUo5+U7Dxe5OO4MnNJlofXCvLQvvHA71u7nskc8urVgwOjDEF5AGqo78WFgHJDrddabw4vIiygRc9UBird51OpHo6I5iE2aegbqhLEDFV3L1d5xdoqKiY+iIkRPxqWBgSCPjxyLyhoJuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cn7VUUnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F08C19423;
	Fri, 27 Mar 2026 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774606339;
	bh=/sBlDAuD+k0xiaI00BMG8cbz3yQl8lhd2eBMiuzWDEw=;
	h=From:To:Cc:Subject:Date:From;
	b=cn7VUUnc1i/pW1bYvRLIUVJ0/hLspYWhIoGI2Y4f1f7Es67jmpczos39BTGcXDveR
	 yKzvONjRUuA3mp3WU2ksJhrNuJuNJ4WGAxC05iFTL92Qhg+n03Vp4LjlU0JyFf/MJv
	 DXkjdhOhrTvpDEfeBmCutgkx2giLp6SQqcrhDLeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.79
Date: Fri, 27 Mar 2026 11:11:54 +0100
Message-ID: <2026032708-voting-grafted-04f0@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230619-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: D9DF43426A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.79 kernel.

Only users that could not build the 6.12.78 release on the LoongArch platform
need to upgrade, this fixes a regression that was introduced in the last
release accidentally.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 +-
 arch/loongarch/kernel/machine_kexec.c |   22 ----------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.79

Huacai Chen (1):
      Revert "LoongArch: Add machine_kexec_mask_interrupts() implementation"


