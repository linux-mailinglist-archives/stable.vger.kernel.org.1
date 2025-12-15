Return-Path: <stable+bounces-201034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C17CBDBBA
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 13:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A06303C9AB
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F02C026E;
	Mon, 15 Dec 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxvqsDwc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68F223DFB;
	Mon, 15 Dec 2025 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800388; cv=none; b=EuVlNomd2aQ0xLky9TRG86VjF1UyjysVCqO2RoSb277ZWxXol2b/VWW71tEfYYMnX492IH3zjEy2enFvzetV86zN2/vdys435RNKLbdWk/w+vDBKyyISicq+n+jaqoDky7O/gdw1vouprj+LK6ZMJbowSTkP8ZkcQKji1Bcw3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800388; c=relaxed/simple;
	bh=Utb1PS3X4J+dGAhc/RJuBcsRQ+22xXmIkBR/oYXyeT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQGVYY1t0S10Vh0AbK8P5ma9OfbHrljDo0caF+5lhwazH16HTvqcZQ1rCVT0AICWyd5iYhbvJPkqpG3BhFDb8CVCh+IkifCCAaCFnJWm2ZdMJI4qIwaVqvymHAdAf6VrOleGtm339u+K3TR3S+9b5+xwOZW+Nm5KGn7T7Mh9l6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxvqsDwc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800387; x=1797336387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Utb1PS3X4J+dGAhc/RJuBcsRQ+22xXmIkBR/oYXyeT8=;
  b=hxvqsDwcoCoRHRgONGNck4aOja0v9CFTr2gSTXfEdzne+WVhTxs4f7qU
   Q74mbGEQttKWVrO6Od4QzUQBsSdfpjOfNzrTH/fPJYsUe1OtPl/K1Ezkm
   9EK9sI8JnDJN6dnDoNiNxPulExYZV5Uf2GoIdv5SbaLZl7s67x9JMYd4o
   BirkU19GADL0KnIHNWb1vb8zD1KtwW2nGwbVrD3ti4dVF7V3zuUyztB8z
   jsqPytfd7LnUdhEkHul4o6pSGWrtG8/VpnsXPN7XNCECrcR6hOGVbvcWZ
   0MrdaRwW1+HQ4+qMcwwQNi28e8X1aVkH3kdSijhKM9QyihrgZC06EUmQf
   A==;
X-CSE-ConnectionGUID: YnO30Dn2SVakotcRivP0Uw==
X-CSE-MsgGUID: BYiDtmYvTYmcxQOINHKRew==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90354167"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="90354167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:06:27 -0800
X-CSE-ConnectionGUID: Gq2QHNUzR8O7jSItqms1pA==
X-CSE-MsgGUID: GjAa4fv7S4aIKuIzeLWkQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="196788202"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:06:23 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 0/2] ASoC: SOF: ipc4-topology: fixes for 'exotic' format handling
Date: Mon, 15 Dec 2025 14:06:46 +0200
Message-ID: <20251215120648.4827-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The introduction of 8bit and FLOAT formats missed to cover the
new corner cases they cause when the NHLT blobs are looked up.

The two patch in this series fixes the 8bit and FLOAT format caused
cases to be able to find the correct blob from NHLT.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: SOF: ipc4-topology: Prefer 32-bit DMIC blobs for 8-bit formats
    as well
  ASoC: SOF: ipc4-topology: Convert FLOAT to S32 during blob selection

 sound/soc/sof/ipc4-topology.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

-- 
2.52.0


