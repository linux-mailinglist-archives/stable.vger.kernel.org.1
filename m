Return-Path: <stable+bounces-37829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C7189D042
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE1B213C5
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D5E4EB58;
	Tue,  9 Apr 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iwsn2eJz"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656734E1C8
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628657; cv=none; b=ZroJcCSZ9MyxhqlxEKredo71tqWjqboBiM8oYVA6thcTXcJ8JUME35g4eHtlMCQQgedCoMnUzRoIY6OGQxLKr756hFCtjwtkjIEM7ZuHYkCRo94I4EPwhld2o4rijPDJIbeL8JtGKPViyZ1qfMO+3bw/AqOT/RTUmjUN5frpsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628657; c=relaxed/simple;
	bh=PsbhHzJFN84brokAgx/99cnhixPQsTrmUi5erSMYXSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWuoC935vv8mXVQ7b+wALPKnaRS6hjAGQb8yLl6pwNolakxyJ5s7X/Oum49CB7jyZqzGVOtwM7LTgZJS7EDKot0ekOIL3D3mCAqJPekSa1exIYRt5wB65Im5QJhiYcCArcw2VnUZq+Re0R0lX9oJ/kBMSwzsiQ4LYvEyDYv7Ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iwsn2eJz; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712628652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XIGQIf1an2/+VcEy4bR5ZmucTJl3jZ+cZuKUwnrMTXg=;
	b=Iwsn2eJzM4QktT0q0MytoLEVEJBKi8gIl3dlkzlvZcyllm96uQACfREAul79BcidFKaKnY
	YCuRbEZqerGqU74hBNsiIwnYgSHMSCsQIg/ZP6M4YrJH47n5uWF7jKp+FTxZkqTPp1eGD6
	hIlbqrpA7VUCFg+DJPz8870svP8pHUA=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org,
	tom.zanussi@linux.intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH 4.19.y v3 0/2] Fix stable-4.19 use-after-free bug
Date: Tue,  9 Apr 2024 10:10:36 +0800
Message-Id: <20240409021038.1695963-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1. About v3-0001-tracing-Remove-unnecessary-hist_data-destroy-in-d.patch:

The reason I write the changelog by myself is that no one found the bug
at that time, then later the code was removed on upstream, but
4.19-stable has the bug.

2. About v3-0002-tracing-Remove-unnecessary-var-destroy-in-onmax_d.patch

I also write the changelog by myself is that the upstream api is changed.
refs commits:
466f4528fbc6 ("tracing: Generalize hist trigger onmax and save action")
ff9d31d0d466 ("tracing: Remove unnecessary var_ref destroy in track_data_destroy()")

George Guo (2):
  tracing: Remove unnecessary hist_data destroy in
    destroy_synth_var_refs()
  tracing: Remove unnecessary var destroy in onmax_destroy()

 kernel/trace/trace_events_hist.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

-- 
2.34.1


