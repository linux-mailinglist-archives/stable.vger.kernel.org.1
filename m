Return-Path: <stable+bounces-194761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E546C5B25E
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 04:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7E9A348403
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 03:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD92197A7D;
	Fri, 14 Nov 2025 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="qfsrUe1W"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9C85C4A
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091091; cv=none; b=YM8H1xM1C/R2A3FdUSJ4LEPIpdR2Dtx4H5jvLuxudehSIcTg4/7JbMSFSM0Th9iRTUTNKuRexMybfdr+xWHUB+iAqwi/tD8k3+E/K9D3AcRnbaHLxzcnMdNCt00q3z7pL6k3K/1HxAtouj8m1ZZUtKUObiIvLs9yK62eXmUFOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091091; c=relaxed/simple;
	bh=iwz9Ow6p6FaGJpXgBcCnpVP8ZCfKi0I/dUIa8mjGE58=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=aHLYifNHaqGg1CSuGus7Bga6QS1je9n8Axfx/2WLIZSUGJk0dnu7d320eW6nTvt0Nv0ceQlf3xr+DhUATnBASNO4pYBxUqMM823OKhLP4lBGbxLCD30WXki5TUPRQcS7l0oz062RorUz0/NOb36XNknPsVgDGWEEI0kBlRmjV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=qfsrUe1W; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=qfsrUe1WFv+fhWb/cIfKPpdHDJCAUnJ6zmcctCjKv90BsL+mODDdh1aXuxGhTQOOHIwNkAElGtaPH
	 kkKnr+YoCUP8I1BfnGZHSxom2IB3ynT03tn4RcxaKgLV0SSbyEOzB/yKy5FtJVYZ7qHvLWE6tr3b6L
	 RyDxRWNtO1Du0Pw4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-17-12016 (RichMail) with SMTP id 2ef06916a1ce627-4397a;
	Fri, 14 Nov 2025 11:28:16 +0800 (CST)
X-RM-TRANSID:2ef06916a1ce627-4397a
From: Rajani Kantha <681739313@139.com>
To: arefev@swemel.ru,
	tiwai@suse.de,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 1/1] ALSA: hda: Fix missing pointer check in hda_component_manager_init function
Date: Fri, 14 Nov 2025 11:28:09 +0800
Message-Id: <20251114032809.30655-2-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251114032809.30655-1-681739313@139.com>
References: <20251114032809.30655-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Denis Arefev <arefev@swemel.ru>

[ Upstream commit 1cf11d80db5df805b538c942269e05a65bcaf5bc ]

The __component_match_add function may assign the 'matchptr' pointer
the value ERR_PTR(-ENOMEM), which will subsequently be dereferenced.

The call stack leading to the error looks like this:

hda_component_manager_init
|-> component_match_add
    |-> component_match_add_release
        |-> __component_match_add ( ... ,**matchptr, ... )
            |-> *matchptr = ERR_PTR(-ENOMEM);       // assign
|-> component_master_add_with_match( ...  match)
    |-> component_match_realloc(match, match->num); // dereference

Add IS_ERR() check to prevent the crash.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ae7abe36e352 ("ALSA: hda/realtek: Add CS35L41 support for Thinkpad laptops")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ Modified the source code path due to 6.12 doesn't have
commit:6014e9021b28 ("ALSA: hda: Move codec drivers into sound/hda/codecs directory
") ]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 sound/pci/hda/hda_component.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_component.c b/sound/pci/hda/hda_component.c
index 2d6b7b0b355d..04eed6d0be3e 100644
--- a/sound/pci/hda/hda_component.c
+++ b/sound/pci/hda/hda_component.c
@@ -181,6 +181,10 @@ int hda_component_manager_init(struct hda_codec *cdc,
 		sm->match_str = match_str;
 		sm->index = i;
 		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
+		if (IS_ERR(match)) {
+			codec_err(cdc, "Fail to add component %ld\n", PTR_ERR(match));
+			return PTR_ERR(match);
+		}
 	}
 
 	ret = component_master_add_with_match(dev, ops, match);
-- 
2.17.1



