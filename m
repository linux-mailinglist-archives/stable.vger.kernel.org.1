Return-Path: <stable+bounces-183508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9BBC0C43
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 10:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DF03A3D5F
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC92D8DD9;
	Tue,  7 Oct 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="wI6zlxB2"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BE2D8799;
	Tue,  7 Oct 2025 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826421; cv=none; b=r7ScLYy6JopKaDow0/INH63MRaWA3lc7kD3M1caVEkiH8ZWZCNRfjRpoR67fJO6dpAzN94IIz86YwUrAvNHg0ZANaLEASgPsbc9bt/Py+oHxPY+qWJuv04AI596Spv4rDLG3zaCMstc/XmuR3HC3RaEa1sBFTWdUrK526zE4DfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826421; c=relaxed/simple;
	bh=6TH1n43iDQopQFaCiebITeOGjq8DcWhmFm1VZn9zXWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7ErswspK+bMgll9EWYUtXUpBj8IlBP6vt8CONfO57fBOrYzApeVDZ+JqFQ+WhLhD9sdQgbeRhzOWpsK71tp/9NxXpqHYTWUF8jj5JB5lOOXYP0rsNZCVWllhDN14yV891RN+BqgvBouZK4B4t/G/RiiWBx6GsPmubKLxhaHHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=wI6zlxB2; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1759826399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b03Yo9E6XSLHshaPXOaGwlItUsxYbo20GLf6bLgjuvc=;
	b=wI6zlxB2X706myP9Lvm2kNoxIwDQelgXblkQKvAuU5gr/c1XbXtbfjNJHD+aRjirEJKrAK
	q+c6TKWc/C7CfYBYNFdmymP1QDEXMZGki/GxkZTBapGJe18ARY4ETMHT2kpzWxFLkOq2zn
	yWByxM9mQnOmR26PxAxBAbWzpr85wQw=
To: David Rhodes <david.rhodes@cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda: Fix missing pointer check in hda_component_manager_init function
Date: Tue,  7 Oct 2025 11:39:57 +0300
Message-ID: <20251007083959.7893-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: fd895a74dc1d ("ALSA: hda: realtek: Move hda_component implementation to module")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 sound/hda/codecs/side-codecs/hda_component.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/hda_component.c b/sound/hda/codecs/side-codecs/hda_component.c
index 71860e2d6377..84ddbab660e3 100644
--- a/sound/hda/codecs/side-codecs/hda_component.c
+++ b/sound/hda/codecs/side-codecs/hda_component.c
@@ -181,6 +181,8 @@ int hda_component_manager_init(struct hda_codec *cdc,
 		sm->match_str = match_str;
 		sm->index = i;
 		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
+		if (IS_ERR(match))
+			return PTR_ERR(match);
 	}
 
 	ret = component_master_add_with_match(dev, ops, match);
-- 
2.43.0


