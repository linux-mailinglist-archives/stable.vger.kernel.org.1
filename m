Return-Path: <stable+bounces-5274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283CE80C503
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BC01C20A04
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8962137F;
	Mon, 11 Dec 2023 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yFxClikA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FE125DC
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F58DC433C9;
	Mon, 11 Dec 2023 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702287884;
	bh=q/C5ziaTIcAfCgYbJMUNuQjSdh9vU96sqQtAi7IwjtI=;
	h=From:To:Cc:Subject:Date:From;
	b=yFxClikAEdIbjLyEQyxpKqyb5kziO89VNFcddVFCMzIH3aoaW9OIlAB54vBEwl4ad
	 NlFQhz1Uw+FR85ph13RuD2s6EenRpTG+Tg/Lc8n5EN7ZMl5yCyZP52IP0duL2mOvf/
	 YfYcJg1yITu4DgWyBIp1sGAcaSJ+0gRj0cp5yykw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.6
Date: Mon, 11 Dec 2023 10:44:40 +0100
Message-ID: <2023121140-nervy-directed-5a9e@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.6 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile               |    2 -
 net/wireless/core.h    |    1 
 net/wireless/nl80211.c |   50 ++++++++++++++++++-------------------------------
 3 files changed, 20 insertions(+), 33 deletions(-)

Greg Kroah-Hartman (2):
      Revert "wifi: cfg80211: fix CQM for non-range use"
      Linux 6.6.6


