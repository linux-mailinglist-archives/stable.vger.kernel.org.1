Return-Path: <stable+bounces-216726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OnROD9Dk2kP3AEAu9opvQ
	(envelope-from <stable+bounces-216726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:18:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BC7146029
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1018130089B1
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED82FA0C4;
	Mon, 16 Feb 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8sdV15t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3121C173;
	Mon, 16 Feb 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258685; cv=none; b=ABMpn7fwhfeuZAsqR1OE0jhjvIqWgww1wqlakKnZVkBYjTXWg7ntlrk/FeE1hw1qDifWQdyynIUheETDUvOtZj68JAUxE7b9u/h7vP6VnZ12/tXU2+KYdcHOR3uBt7n1X4b1FtO3yWoAE1El7ycStSem6+4xBmt9WLHdQvIoMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258685; c=relaxed/simple;
	bh=bYATJG/bK2VnzzDt25VHIBQfiMo/nb8scE6RhcLaOpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSHUqsv0OpGsmaj+0xl9Id5JV/17YrPHh64/T6DXA8bzR3iPIJH0gr4U3cWBbCjTr5WeuE8AQtDnDqg+g9GnHnt9jKrWb34xQpmBW7eaNhdQ9wDrPHdnJoazggaZNWrI2P97epyCjzIS/VlMELpDEYmr6TcxhcyneYyU9MWwwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8sdV15t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DEEC116C6;
	Mon, 16 Feb 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771258685;
	bh=bYATJG/bK2VnzzDt25VHIBQfiMo/nb8scE6RhcLaOpE=;
	h=From:To:Cc:Subject:Date:From;
	b=A8sdV15trGilMhuZeCNzYtBfNIghqtrFsYhjQ2t/YkMTnXXg9hNzZShJ0AQPed8zc
	 z252noCW9kM4BG3qd1nFRX22YlNeLTpw+Fwf1pUx2M92cXPztR3KqYrWwS6a4JojIU
	 yfMj/rE+TYWUe04aw9sER/9yKaF716NDhleaKym0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.12
Date: Mon, 16 Feb 2026 17:18:00 +0100
Message-ID: <2026021637-amused-crimson-13af@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-216726-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 84BC7146029
X-Rspamd-Action: no action

I'm announcing the release of the 6.18.12 kernel.

If your system did not boot in 6.18.11, then you should upgrade, this
reverts one problematic commit.  If the last stable release worked just
fine, no need to upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile            |    2 +-
 drivers/base/base.h |    9 ---------
 drivers/base/bus.c  |    2 +-
 drivers/base/dd.c   |    2 +-
 4 files changed, 3 insertions(+), 12 deletions(-)

Greg Kroah-Hartman (2):
      Revert "driver core: enforce device_lock for driver_match_device()"
      Linux 6.18.12


