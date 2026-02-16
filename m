Return-Path: <stable+bounces-216724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHezMRFDk2kP3AEAu9opvQ
	(envelope-from <stable+bounces-216724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:17:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79074146004
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7AF13008C1B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73321D3D6;
	Mon, 16 Feb 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwiT85uP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEBC1F17E8;
	Mon, 16 Feb 2026 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258639; cv=none; b=MwLgt071j6pwY58xOiimYbvy5M65INpXSKXCtJCEAN3SlAnwkjT0Y9xRlngn4wx1taf/7ZbKSY1cVl9yz9TvO0UrsN9mNHtCP3WeptxN9eMqqDvPoclQTY5a03ZZrlY8BxYADI8n13CEdPYEfDelHJPFtRje1TSzngMwqfisoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258639; c=relaxed/simple;
	bh=w+jnAeM195ia9/KQKy69svD499HUZcfDrAAzDwIocUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BefxlURqsejyZFwnu1roJFUpreXCbiYCifgZUg7Oy64h3UaOVQqqGgte9tWhHADTRjVcPJ7rxIYHFpWrTDtTffO7wwPq4MG/3rtqLZoVnN1bck6ExGDBULbc6IiMcUM4rSmYFrvl5fu14F192moWk85Onb3L3Wi13SJK3tcZVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwiT85uP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05891C2BC86;
	Mon, 16 Feb 2026 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771258638;
	bh=w+jnAeM195ia9/KQKy69svD499HUZcfDrAAzDwIocUk=;
	h=From:To:Cc:Subject:Date:From;
	b=KwiT85uPkarX8ziEFbQKYdz9hL7g8TEptqMBA71/UKTbv0XL+ya0RwJhk3+UCREGX
	 dRv4bui4nZf6wn1mbkd4o3kUCDCLAlwVVrjPfdf8G1g68ycQvsVKaqcTVCfOwIvMn4
	 byHMrYdi77Dyw37OFE49iYR/3jgwZjeaGBOUj2Bk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.19.2
Date: Mon, 16 Feb 2026 17:17:13 +0100
Message-ID: <2026021619-phrasing-booth-18a8@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216724-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 79074146004
X-Rspamd-Action: no action

I'm announcing the release of the 6.19.2 kernel.

If your system did not boot in 6.19.1, then you should upgrade, this
reverts one problematic commit.  If the last stable release worked just
fine, no need to upgrade.

The updated 6.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
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
      Linux 6.19.2


