Return-Path: <stable+bounces-98935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5D9E677B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 07:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9011885851
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB01D63F0;
	Fri,  6 Dec 2024 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJYdRdpD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9228684;
	Fri,  6 Dec 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468019; cv=none; b=mue5rmjXr9D79IsedNVeiyYicSlftzQn0O0Mh3IYpKT2A7832epK5FpLTUQBpc2UFY3aFalSwvv2S355fN2Px5l8ma2Rhf4v8+h5zscEkEF02zrFyiensaFbVleBiCzui3wWgnIn3Xgdsb7/2SJWs16Hrzi6NuffffHv2rmyy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468019; c=relaxed/simple;
	bh=jWQpb/L55Sg4tno4AmrxW+cEAKgbqQHIdngptZ7vN4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3G86YLMPDEMY+zcIynxJiGjJ4EjTqpV1VMLDglOJg/bxYcMSvV8b3hr4VO+WD3uiQFO2fS7eQxupyzBtWb82SHKh6/PT15tnwS0hNNZWyRuQewYhAnmxwOdVWE1J/NCqSbcyTLUlzBf4GAZp6mF+xPdNH+DULSk1h7CGZzgP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJYdRdpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1262BC4CED1;
	Fri,  6 Dec 2024 06:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733468018;
	bh=jWQpb/L55Sg4tno4AmrxW+cEAKgbqQHIdngptZ7vN4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=RJYdRdpD8Vi7QUuC2ULZog/oX8XN2cC8CeDCRnMvoDlmXwYjMu/bLSdjFIYOGWnBC
	 p3VPV0wo3AAw3W3DKNPEETnddlzP8RIZd3Q2EZNHGv8Otprf2TPMzzyCAntVSdLXnD
	 y7Mt1BJUCDwV5XKYvR8dkW42LDW4zaDnR+52pVro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.3
Date: Fri,  6 Dec 2024 07:53:33 +0100
Message-ID: <2024120634-likely-groovy-d26a@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.3 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile            |    2 +-
 kernel/sched/core.c |   12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.3

Thomas Gleixner (1):
      sched: Initialize idle tasks only once


