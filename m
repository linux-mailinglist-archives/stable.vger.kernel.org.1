Return-Path: <stable+bounces-172587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07904B328B1
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBA7AA3EC7
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCD1514E4;
	Sat, 23 Aug 2025 13:05:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6CC3FF1
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755954353; cv=none; b=T/qaxJPnt7tReC1CXjIM/xq/xNnHC0zR23b42nOxCOkxhaUZXgnBt7Ho1C0pJuph4BMoB+trlcSEMadgExsFvyKjD6jtD8LITKIMa276f2Ik3DiQ+/2jy/nuALCkFY3gAaYCjFDcawc4GoEAh8ZHNAJu5Gek7vA/gm0RduBVHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755954353; c=relaxed/simple;
	bh=EOXfjekqBcGf+1Aocd4X9vOErj4iFDyvJgIWBukYBa4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c0doWewoyT/Oo6xh3339TSt48PZ6adIHKN5WMKs1G/8mgEVPQ0S24qic7c4gvvGi9OG7lDQ2qECZE/jCzU9dayotOowv54l93AZkJiCOcMqO1iuIyPAR1tBYpjRLboPG6F7yEF2Zmri7MdxPNI+Wvp0Rza2vuFHihSFDZLWeQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Sat, 23 Aug 2025 15:05:46 +0200
From: Brett Sheffield <brett@librecast.net>
To: stable@vger.kernel.org
Subject: Backporting Selftests to Stable Kernels?
Message-ID: <aKm8qmts_2Cp4j2p@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Stable Maintainers,

When a bugfix is backported to stable kernels, should we be backporting the
associated selftest(s)?

eg.

9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
was backported to stable, but the selftest was not:
5777d1871bf6 ("selftests: net: add test for variable PMTU in broadcast routes")

Does stable policy say whether it should be?

It does not fix a bug, per se, but it does enable those of us running stable
kernel tests to more thoroughly test stable RCs.

Should mainline authors be encouraged to mark related tests for backporting?

Cheers,


Brett

