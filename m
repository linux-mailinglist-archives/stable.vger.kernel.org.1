Return-Path: <stable+bounces-5276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F399680C506
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EDD1F213B9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836EC219E4;
	Mon, 11 Dec 2023 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WB5fzWkR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3B125DC
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFCFC433CA;
	Mon, 11 Dec 2023 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702287893;
	bh=Zh+N54AyVbzKOvWwPV9/di4kTKjV/K1n2+07OBQhpBM=;
	h=From:To:Cc:Subject:Date:From;
	b=WB5fzWkRKoYZYYqm0wX8nlkZt5boUyV9mneQaq3qymat33DiUq5ZNvtq2Ur/xQ5kT
	 toKTAL/1KQxAojpvPoiMpal8O5OIRpoDmktzfNdtf0R8hb7PSiGCycCWXq6pSSpsC/
	 AbnsyvMSIUfUpfFoMASLJ4O5tJ8wkkd0ut9B006g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.67
Date: Mon, 11 Dec 2023 10:44:46 +0100
Message-ID: <2023121147-finally-museum-8aad@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.67 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
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
      Linux 6.1.67


