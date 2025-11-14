Return-Path: <stable+bounces-194760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B4C5B25B
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 04:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28C3C353A53
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3A19F40B;
	Fri, 14 Nov 2025 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="KFmIGXPK"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE64B652
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091090; cv=none; b=EbsoA75JVrNRUoRUYtrkxwWDavs/Bst/Yfv540LjF6JZBi1OIEJAQLx7X+bKoLw45ML9XUKuoxzfGTeVmMLSg3La0INq6erjzWaq0GxAJuz2chJKC5XK8NqJINtp/3ndvZ33MDt/MU73APdzNc4iN9Er5Dj0wc7P2CB0D2Ajyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091090; c=relaxed/simple;
	bh=L33iB99tBiv36C6dNpYgfJBNRJXqKXcXiKJMXP9NCvU=;
	h=From:To:Subject:Date:Message-Id; b=teW9FbXXMxEJESJEY3RppzcudZgGHBCGU4eVlDUaGt9RvWGXuaGWPN/jXUvxPFE6CwNBpLNNc5JSHCIA/i+s78dUQjKdjDf4eIL/lcBAlFNK7hUG3HlYNXYWqpMHfybFHrt8w2B56FElbnbmPomZT7Wwg9f8Wv13JxvhFwYVTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=KFmIGXPK; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=KFmIGXPKvVB+0JYmQDzPcqdpcvwjeUrEsDI8rLQ/unnhMw9REkwWom21Ky5b/bRNyJi8oUjZVLLTS
	 z1qNk/7A4iR/w0zpn1FrMADyP8GER/6ecvjojtq0foetFb82wB68PFS+Iwox4/BOSDy+6CnP7QIh5I
	 rTN30w4Oyre8bLHk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-17-12016 (RichMail) with SMTP id 2ef06916a1ce627-43974;
	Fri, 14 Nov 2025 11:28:16 +0800 (CST)
X-RM-TRANSID:2ef06916a1ce627-43974
From: Rajani Kantha <681739313@139.com>
To: arefev@swemel.ru,
	tiwai@suse.de,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 0/1] Backport "ALSA: hda: Fix missing pointer check in hda_component_manager_init function" to 6.12
Date: Fri, 14 Nov 2025 11:28:08 +0800
Message-Id: <20251114032809.30655-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Propose backporting commit:1cf11d80db5df ("ALSA: hda: Fix missing pointer check in hda_component_manager_init
 function") to the 6.12.y stable branch.

The current 6.12 branch does not include commit:6014e9021b28 ("ALSA: hda: Move codec drivers into sound/hda/codecs directory"), so the patch has been updated to reflect the original source code path.


Denis Arefev (1):
  ALSA: hda: Fix missing pointer check in hda_component_manager_init
    function

 sound/pci/hda/hda_component.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.17.1



