Return-Path: <stable+bounces-20808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B2285BC4A
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 13:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918372843F0
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF85B5AF;
	Tue, 20 Feb 2024 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="C+Cjk3pM"
X-Original-To: stable@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B969969
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432467; cv=none; b=EuOarZmgOHVZHn3fiw5Ml6Y4V5w5ppGTjN2nzszIW2PL18ezsU2YK4HTsdCvAmNp9C5WaE0OCF+/dTp5s1vNMT/lvOjot8f//inSmeoS9VpDoIUBDzu03HdB3a2DmnxwFmSBNU6fF8/IaP381NZNczxdFldm2bVekGNlOexT2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432467; c=relaxed/simple;
	bh=D5hQ/aihNQQOA5Vj9kpY0O1juCdDslD0NOMrNTA/omo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RwYNOmH8kCTeE4BnMGbYZWynncbhYkTpcDsz9nPoKx7mvyXlODqQlS7BvinV1+HOSzJqffnVEKwbmioL8bu89ZR1vsZJgMg05d+C1GsEg1uaweZt0YJnPF5dcInI9NA/15IJL5JRVlaZxA7viKgla+vbCToQgZN4A8SXFNIabGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=C+Cjk3pM; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240220123412a2b6d20e3ef1e7dc07
        for <stable@vger.kernel.org>;
        Tue, 20 Feb 2024 13:34:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=un9mNzMZMR1p5o5WIMpNzNnYHB41NbA7g7XrypTunak=;
 b=C+Cjk3pMIddylmX3EY9qiOvI7c72G9F9wnptWH6O1FyABPZsijNyu+BMhEw5/S4h4YLjQY
 AYBoLLKcfDBSQPyaS5MNRm7AITaKqhEThk/p9Y7Ly9CYLcK8scfVY8U6l3lzROs9zgc17jRt
 cy3cChOaNKQshUuRGGAs6jNtR2pmA=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: dave@stgolabs.net,
	tglx@linutronix.de,
	bigeasy@linutronix.de,
	petr.ivanov@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v2][5.10, 5.15, 6.1][0/1] hrtimer: Ignore slack time for RT tasks
Date: Tue, 20 Feb 2024 13:34:02 +0100
Message-Id: <20240220123403.85403-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

Changes since v1:

- added upstream commit id to the commit message

This suggests a fix from 6.3 for stable that fixes a nasty bug in the
timing behavior of periodic RT tasks w.r.t timerslack_ns. While the
documentation clearly states that the slack time is ignored for RT tasks,
this is not the case for the hrtimer code. This patch fixes the issue and
applies to all stable kernels.

Best regards,
Felix Moessbauer
Siemens AG

Davidlohr Bueso (1):
  hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

 kernel/time/hrtimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.39.2


