Return-Path: <stable+bounces-33875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9670A8938B8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CCB212A5
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CCBA2E;
	Mon,  1 Apr 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bqwPiJtO"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC1BA2D
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957854; cv=none; b=FtCqM1EvJx7hOjHhQb1xRCEjfrAiIJ+0DjyhRsuusHYhr7OGamnT6AJCwrFWDzhFlHNMYnepwKZiCo2uLpKeJ2R27hIESvi4S++OjJfZnv3hU09p9qgTsrhjoDVfACwHXcw1CmoHFpHWOLzBiswjKzaBXIcap5pOErO10f9mkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957854; c=relaxed/simple;
	bh=zQXqvKAfEgCE3Mq6D1h4MKuxn9XerNGad6v+FhB8TVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yf6D9CE57ZRlAeYnhE3yUd3bLq/hoRpWQTTKmYtovJOoCuv75X2DOA+wS6An/6jr0mr71rnMsjHYLVNgPUCJcbeDYoSctGU6WnjAfFDumGL1MRDjdsXBbdDUoKFxtRIOD7Ca+KgNoRoHPSRjVVEGuP7TmDNPeQ1zJ9D+QvkYy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bqwPiJtO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711957848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j6UpVJsETb7eg/0YIuixFYdagQ8WORenGC7yeyo3WTo=;
	b=bqwPiJtOhgEngQRTgBoWYeIHoG2/jm4WdQRirg758lsMnubEKBYy7HJdPPvWxOMfB7AJ2A
	JZ77UfxwGrvPBaV/5eksY3G/dwbG1g4gdh0Uxew/4DiPJ3FmOS1iMSpbucME319hsVkI5n
	9P7JACewTLr8ezGR1p64SAUuQW1/qiM=
From: George Guo <dongtai.guo@linux.dev>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4.19 v2 0/2]  Fix stable-4.19 use-after-free bug 
Date: Mon,  1 Apr 2024 15:50:47 +0800
Message-Id: <20240401075049.2655077-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v2:
 - add branch info the patch belongs to.
 - add upstream commit id (these patches are equivalent fix ones).

George Guo (2):
  tracing: Remove unnecessary hist_data destroy in
    destroy_synth_var_refs()
  tracing: Remove unnecessary var destroy in onmax_destroy()

 kernel/trace/trace_events_hist.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

-- 
2.34.1


