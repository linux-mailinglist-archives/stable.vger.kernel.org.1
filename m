Return-Path: <stable+bounces-60675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB39938D6D
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D571F212E9
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF01684A4;
	Mon, 22 Jul 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="frEjqQuf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF223DE;
	Mon, 22 Jul 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643973; cv=none; b=ePmxHy41wn8WyfMVANueLIdGdG1rhQCYcc84MGIcmlIVlemp9XsjepDF5G7MXJ/FCQrbFGT9d2+RS/ocUA0+2xpc2ctO7DhDn0SG8gBE2sBnkx+ptcK+nFz55bAePt///hnM6FMQ6cRCYVvV4kWx/Q7PRTMO6eWfdVZ5neBfBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643973; c=relaxed/simple;
	bh=Qt0pSfpOd9uBkWnkfYjYMjZywxeQf5V5kpxLyx3iwfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=frJhGNPCV9uvp7RK9AhQ7E2awv5aaj/apYOVNw9gScZhHhzUfjZdCeysc59F9GQpiuVKI5ih/Txl3OACfj2RXLGD3mnEDedX+gbN7zh8yFDVbid1cPLctcfhUBCzOzjx4RfAXimC9Wb53xZqCKVtNoAC3qdyqvpfR7OgrZodHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=frEjqQuf; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M5A0s1002661;
	Mon, 22 Jul 2024 05:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=NHn1bBqpfkzxeBeN
	JeFDRk0oJyJI0hodEFZvCSqHS6E=; b=frEjqQufTCfJuNryIQXIsq3e2oj+MCZ9
	L3QMz6NFmRCvYdpOiVPtmmhxtoIKmvm06EX3kBzldWrw2V1UF+w29ZTOBeE6DNJk
	o2Lei9T1WiDOUef61QJqmQ70tUbSg5Sm1Bdz+uQx4cURGOT8dZKC1DOiWydUmKLk
	FdXWafUjUIAVk/8gBm709CpeySkJ2RsTnlgPxd4HqbvPDlxlZztRKEU5am544iYO
	7LEoF+RQdlkwr3jLgqF8iHeAaMMPzCwuPIbQcFa9/OyC3qytFPY3YnrNLws91yFK
	Zf0puyYHTUTmzbx63IqWPKTEVKrRf5OcnyyqphTx1vyByEqVXe2L5w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40g9nj1n5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 05:26:02 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 11:26:00 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 22 Jul 2024 11:26:00 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 612FD820244;
	Mon, 22 Jul 2024 10:26:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <stable@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: [PATCH for-6.10 0/2] ASoC: cs35l56: Set correct upper volume limit
Date: Mon, 22 Jul 2024 11:25:58 +0100
Message-ID: <20240722102600.37931-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rue46z4JOrwXlG0dj2kdX8dkwPrQ1xQq
X-Proofpoint-ORIG-GUID: rue46z4JOrwXlG0dj2kdX8dkwPrQ1xQq
X-Proofpoint-Spam-Reason: safe

Patch series to limit the upper range of the CS35L56 volume control to
+12 dB.

These commits were not marked 'Fixes' because they were thought to be only
a cosmetic issue. The user could reduce the volume to a usable value.

But for some complex audio topologies with SOF Audio DSP + CS42L43 +
multiple CS35L56 it has turned out to be not obvious to the user what the
problem actually is and what to do to fix it. As support for these
topologies went into 6.10 we would like this series to be applied to 6.10.

Richard Fitzgerald (2):
  ASoC: cs35l56: Use header defines for Speaker Volume control
    definition
  ASoC: cs35l56: Limit Speaker Volume to +12dB maximum

 include/sound/cs35l56.h    | 2 +-
 sound/soc/codecs/cs35l56.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.2


