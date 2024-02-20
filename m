Return-Path: <stable+bounces-20839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7385BF63
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E7C1F257E6
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1AF56757;
	Tue, 20 Feb 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="L+SYvLJu"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F471B3F
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441345; cv=none; b=ZILz4Gw96XdXh+cLcK9+X+B7bLvjx7VbXwn+BfpEW5glZX4vheX/mTRlwT+nUTR8AX0aXIcGb/khTMwwTlY/tQwdL/PAVf+Z/8fdBPjUL/AdnOegYBAH4uZQz8O0FUEvSijCHLjUxyFopgYiZmFGLkZKgYSZbX2KzOc1UJQcG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441345; c=relaxed/simple;
	bh=OaLyMCRh34j4xgylTbKkfij6sUDVS2HCvWLyUAyDuzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RS57pAbKxRoWDSGqknlfcFx4yJaZ92zLirKdCLB4Y2yy3yT3kxurgeBEQiAjJVZsxWfhzjqLgc6g7yl3DaqNL2/DIzPgwCHTzMh+PMBclj+N4qZzCh7j1LXrr5UiiXcNItLG7fPo+C2OH+PRIJ+IGWQtljCHdqLOyMXkFKYwm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=L+SYvLJu; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240220150210cffce3eec5b1e7f7f2
        for <stable@vger.kernel.org>;
        Tue, 20 Feb 2024 16:02:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=AKlJhqBodoKTOj5zHUFwgLJ1/77m6oF6yqVSSgP5r44=;
 b=L+SYvLJuVOFUsQUcH9yYeDNxgz23vV1BlqP1H+mI/svc/zvqgTAZfFH8Q2rbqhDHg9SnJE
 jumi2rC94hjRcbmZLsVSsB0CU1Jmc8mMLJq+T/Qujci8R74Z5v6HIjh23PX1bTu9ciB+Y07F
 6W5Q2QkWaQ9FctD1rFw7EW8ul9es8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: dave@stgolabs.net,
	tglx@linutronix.de,
	bigeasy@linutronix.de,
	petr.ivanov@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3][5.10, 5.15, 6.1][0/1] hrtimer: Ignore slack time for RT tasks
Date: Tue, 20 Feb 2024 16:01:59 +0100
Message-Id: <20240220150200.114173-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

Changes since v2:

- added signed-off

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


