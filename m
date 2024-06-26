Return-Path: <stable+bounces-55868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29A9918E68
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7DF1C22099
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05619049E;
	Wed, 26 Jun 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSeYGX/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AE6E613;
	Wed, 26 Jun 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426476; cv=none; b=oZhkYM0Q5eY6C4DJanxz3+2Nz2FpRZ1+8ATkSxZAT/jA7u5jjAn/bUyB2uOe9I+mtIEkdKy1AS0Y1KeZK5G9GyAeAhHExp6wuQPc8dOmTDzLTXmEZL3ew1D4Qb1QtCuZ+Rgq9deBqD/8iPB5ykMtLNSMI91jYShkAJ3LauNJUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426476; c=relaxed/simple;
	bh=G+ZtIjhf8cOWG76YSlWa0IMYIwTaKc2Nr1+gh6cDYSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+S64HguOiwmpmcaaWuch30S+fK8VGSRd7ppA13vLugmQk/jfgCxKD5vUDkCFB+tP7wYthyCJj/qPJRKakeVJMsx/+XF+d6gQuW2u6S/q+96lDk1h3PVSAooWTpcFHopFkw7xcz+1kUbuSTFF8Q8GU9b2N6jaDo0db+RYC2sR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSeYGX/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD856C116B1;
	Wed, 26 Jun 2024 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426476;
	bh=G+ZtIjhf8cOWG76YSlWa0IMYIwTaKc2Nr1+gh6cDYSw=;
	h=From:To:Cc:Subject:Date:From;
	b=NSeYGX/aZGCEqRpqaf4tdmhZuqklSEw38+FzhGi9jbnRr6mUYaftyVTYQV7bfEpt5
	 vMUyuN7dAlQk/FmrIDFjvxMnbQxszSAIWrg62YmsZC8pIGqKrqXlRfY5GJd78IjHA6
	 xG8fOSqbG7Jo02n2e1yi9A5pBWEaPM5Ehd3WCFmzQKlcrtOfjgTJ8ackSKXlrt5lnC
	 YkAyY3m/rKQkcZ+if2KxRU8/5u9aMb4VzZ4iMeAzAv4pty3myVtaEBzJMzlLvKNcIv
	 0wenqQP6sCDgNroXNtpmCwO3lZUsLH/Bq+k42wlzH5eIFCqGLnLfZGaHMQJNqDQkQd
	 VGy/8jcnRJugQ==
From: cel@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<stable@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10 0/5] Five missing NFSD fixes for v5.10.y
Date: Wed, 26 Jun 2024 14:27:40 -0400
Message-ID: <20240626182745.288665-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Hi-

It was pointed out that the NFSD fixes that went into 5.10.220 were
missing a few forward fixes from upstream. These five are the ones
I identified. I've run them through the usual NFSD CI tests and
found no new issues.

Chuck Lever (3):
  SUNRPC: Fix a NULL pointer deref in trace_svc_stats_latency()
  SUNRPC: Fix svcxdr_init_decode's end-of-buffer calculation
  SUNRPC: Fix svcxdr_init_encode's buflen calculation

Jeff Layton (1):
  nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Yunjian Wang (1):
  SUNRPC: Fix null pointer dereference in svc_rqst_free()

 fs/nfsd/nfs4state.c           |  7 ++-----
 include/linux/sunrpc/svc.h    | 20 ++++++++++++++++----
 include/trace/events/sunrpc.h |  8 ++++----
 net/sunrpc/svc.c              | 18 +++++++++++++++++-
 4 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.45.1


