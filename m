Return-Path: <stable+bounces-143017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0DAB0DD1
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD33A6803
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D56272E48;
	Fri,  9 May 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqzQPQdV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A721FF23;
	Fri,  9 May 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780732; cv=none; b=UsTidk2uNCQjUzh13xAyBQDBRIoRNd1ZWvlsQeV9O7e52rWQyZEwiX3wIURiAbkH6MGiNsoqEWd+fCT4fA0gMZIFmoIgycgBbFyxyK4hWdXzLv6B+YivXg/WUYAjhfsxrPmuY7u07dEvI4VBjkP6yBJv1e83YnHQDXa02psNl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780732; c=relaxed/simple;
	bh=3NWLRY1fttsxR1X1w6G21knbvaA4o/ONT7PqaOvD1yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=crgDaMku6jlLSjXKG2odwbeJCWnozbvBfgPGbMR6XyRL8AcWUIBNtuI6U+A1UNC4l37nScErys7mSIl+Pcyhys7hKltJuR/+Cmkq0yE3RqkJYP3WJn/CCy/Cbp+sD6V5CAaqRgthAF03JObyUHDl0vd/LgOf9VPLk2/pjv3v//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqzQPQdV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746780731; x=1778316731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3NWLRY1fttsxR1X1w6G21knbvaA4o/ONT7PqaOvD1yQ=;
  b=UqzQPQdVgEgHeFp8TY3h+8/4nMGjBGK6KTkPipN/fmQihkF5VfIT0K68
   W3V2HhzwMgpsmhpC2MEdQK7fIyCJAOtglN17cygQT84wfGPJD3hE3c5Em
   KL+24WS7jZEQE3sodVdTizuQyGenZX+WcytbiU+QsA4OxPRC5yI+uXTKT
   cUA6Pf3fC0gOwyzF69G3Nt89cBtp28JOuvIXnNRz/e0QT7vWOGqPgVUcb
   ginyKFUlqXQgYhvfmaIgf+vsirEGt735WDE2XjH2sLf2vootsDAWXzxgQ
   xqjHVhKYLE6bj21tYnkSwmiaRlIx+iKZbChauWlfltbUjEr7IKBtxEFx3
   w==;
X-CSE-ConnectionGUID: vPWNAPqmRLG8x5Kr7E2dvw==
X-CSE-MsgGUID: +CW2Jrj7Ti2QDJibNYeGjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48300687"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48300687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:52:10 -0700
X-CSE-ConnectionGUID: ScD8pEPGTUakD30H5rERfw==
X-CSE-MsgGUID: u1qHCCtQSp6wjN4OXqQyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="173725327"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:52:08 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoc: SOF: topology: connect DAI to a single DAI link
Date: Fri,  9 May 2025 11:53:18 +0300
Message-ID: <20250509085318.13936-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

The partial matching of DAI widget to link names, can cause problems if
one of the widget names is a substring of another. E.g. with names
"Foo1" and Foo10", it's not possible to correctly link up "Foo1".

Modify the logic so that if multiple DAI links match the widget stream
name, prioritize a full match if one is found.

Fixes: fe88788779fc ("ASoC: SOF: topology: Use partial match for connecting DAI link and DAI widget")
Link: https://github.com/thesofproject/linux/issues/5308
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/topology.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 2d4e660b19d5..d612d693efc3 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1071,7 +1071,7 @@ static int sof_connect_dai_widget(struct snd_soc_component *scomp,
 				  struct snd_sof_dai *dai)
 {
 	struct snd_soc_card *card = scomp->card;
-	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_pcm_runtime *rtd, *full, *partial;
 	struct snd_soc_dai *cpu_dai;
 	int stream;
 	int i;
@@ -1088,12 +1088,22 @@ static int sof_connect_dai_widget(struct snd_soc_component *scomp,
 	else
 		goto end;
 
+	full = NULL;
+	partial = NULL;
 	list_for_each_entry(rtd, &card->rtd_list, list) {
 		/* does stream match DAI link ? */
-		if (!rtd->dai_link->stream_name ||
-		    !strstr(rtd->dai_link->stream_name, w->sname))
-			continue;
+		if (rtd->dai_link->stream_name) {
+			if (!strcmp(rtd->dai_link->stream_name, w->sname)) {
+				full = rtd;
+				break;
+			} else if (strstr(rtd->dai_link->stream_name, w->sname)) {
+				partial = rtd;
+			}
+		}
+	}
 
+	rtd = full ? full : partial;
+	if (rtd) {
 		for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
 			/*
 			 * Please create DAI widget in the right order
-- 
2.49.0


