Return-Path: <stable+bounces-112435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EAA28CB1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1D168C24
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B80E1494DF;
	Wed,  5 Feb 2025 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ql+s6COq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2E142E86;
	Wed,  5 Feb 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763566; cv=none; b=pfUO9nrFe/EMz/nA1Ls6++xEkvLe4CYuRZQm1uQX8thQxJ3VEf8vMJcwkKStu7FYsEJFyoPcWjG1CymECnJCzFua/P4J+EzLcfDeRWTzTGCiiyh2UuVz9Xlu3YoLGMNzmEyta7JYOJiHS+lGQJvAs+oHsjSMSno4CuXh083psbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763566; c=relaxed/simple;
	bh=9+24MuwPWpjwLp/7wot8EOpIrNvcnu1UTX1tyNNgv58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DukJ8LrgD+IQRwSUVygxHobMYYuKXIUnXV2pIJ5Juwx2eIQ18h7YElDRaho7bfBgznzZziH2xUP89jkB5ZjJGcKhTrqL9JbzmiSO3iXqwlb1zJHqJQkD6qM1GPVnW+dn5JnT8nUazBsEMghjL52UfAD0gbKigDeYSW0YQkNQH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ql+s6COq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738763564; x=1770299564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9+24MuwPWpjwLp/7wot8EOpIrNvcnu1UTX1tyNNgv58=;
  b=Ql+s6COqk6+VKUQMvzbnRNp76QBbDhn8dAGJFg//B+E7kPUeyhp6nR6q
   LZkjDOnIw5TV5L7xmcqdvCHloCjIIyefky9Dl9CW8BB+M5zfAGAlOtP3/
   giU+VhfyYZMwmdqQ61gfXwylHN3A+hC/AjUQgk6D7qb3NpIrBN526TV6H
   dQY5u37NeZT/CzHdIiVdtb86bGPq/y93Yd65BqFOGKKT9gQGggevB+hWs
   cGHMbJ37ciTcJUP56mcTsn5jCzBqr9rPkGgKqMqsGIiV8pCncaqXRWgX1
   XIY+WRg2LpwQu/99zYW+eLINMUxfZcshuprxCVjT5u22Kb1WcD1IJgcTu
   g==;
X-CSE-ConnectionGUID: OeDm3JgOTzSMYEiP1NP7lA==
X-CSE-MsgGUID: QUW4fXQ+T2y7Vclig6ikeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26931843"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="26931843"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:51:59 -0800
X-CSE-ConnectionGUID: TrGPsQBnQf+A2moruUmBDA==
X-CSE-MsgGUID: 3E52m7wZTSe3+gd5NQDE+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="141768359"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:51:54 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	cujomalainey@chromium.org,
	daniel.baluta@nxp.com
Subject: [PATCH v2 0/2] ASoC: SOF: Correct sps->stream and cstream nullity management
Date: Wed,  5 Feb 2025 15:52:30 +0200
Message-ID: <20250205135232.19762-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- fix the SHA of the Fixes tag

The Nullity of sps->cstream needs to be checked in sof_ipc_msg_data() and not
assume that it is not NULL.
The sps->stream must be cleared to NULL on close since this is used as a check
to see if we have active PCM stream.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
  ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close

 sound/soc/sof/pcm.c        | 2 ++
 sound/soc/sof/stream-ipc.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.48.1


