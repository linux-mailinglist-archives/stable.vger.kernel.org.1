Return-Path: <stable+bounces-83340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29299847D
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1324285359
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9B1C2444;
	Thu, 10 Oct 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H5MQR+dS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DBF1C231C;
	Thu, 10 Oct 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558401; cv=none; b=kZK7vbPecQroYH0CCcZiSKb19bJmR1TmvKBw1VLVEJ2UojOLLxn5PI7KN6OFVCwqEWu0xHGMyDpLBOUC9DKrY2CSq6uj8lzejreGgvNd3mqNTyUgUr60bMEZDjx8/myhQCpACCRk9BK02fMMgccCbbbyH5fKmRotxMYiaZ1bEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558401; c=relaxed/simple;
	bh=TSsUmplMGOAcnYoM40yD1Pqwn+rWMN1btaFW9HcDeDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roNl6Gm8FX3cIuIyyF2nTrM0vCrnJS0t1JCwiHYpougSDutCMp0K1b+d9vyswGRu3JUgIcGLiqhvlImEei7TheaJ+0/6xGLOotYWS7nPtkMezplsC8dejtOHfyWmBhnmTvCRgIrhuDJKEH/Ff+XQ3BC86ahDdQEikxuQ8jX2EZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H5MQR+dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D2CC4CEC6;
	Thu, 10 Oct 2024 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728558401;
	bh=TSsUmplMGOAcnYoM40yD1Pqwn+rWMN1btaFW9HcDeDY=;
	h=From:To:Cc:Subject:Date:From;
	b=H5MQR+dS7zDshzzWsz8H8/1Hd65LMQ7tWrF+S8r2HgZ3vHk+Pjeii8i3PK0Vven4h
	 Sp7aR0oDF2uvZTUcUTxOTYUHvVSgOf77rKCWyvmtpwdusfe1iQCb6TaJf3VjoekWtY
	 E05g8KhMRla80Ywmyg9/7iQmyUTwTpmnF3rey7uI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.56
Date: Thu, 10 Oct 2024 13:06:36 +0200
Message-ID: <2024101038-overhung-discard-e873@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.56 kernel.

This fixes a build error in perf that I should have caught before 6.6.55
was released (my fault, it was correctly reported...).  If you do not
use the perf tool in the 6.6.y tree, there is no need to upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                  |    4 ++--
 tools/perf/util/machine.c |   17 ++---------------
 tools/perf/util/thread.c  |    4 ----
 tools/perf/util/thread.h  |    1 -
 4 files changed, 4 insertions(+), 22 deletions(-)

Greg Kroah-Hartman (2):
      Revert "perf callchain: Fix stitch LBR memory leaks"
      Linux 6.6.56


