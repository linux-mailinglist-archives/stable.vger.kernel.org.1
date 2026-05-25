Return-Path: <stable+bounces-254201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMmoMBOwFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9045CE527
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94664302B762
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2DF393DC0;
	Mon, 25 May 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBy/+nXb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E43947AE
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740662; cv=none; b=pd4X8c2plIB5p08fWe6tr8Vqltvqvnm85AkYrucLLVUctYej6g2RiNTxsE0UeYeLtg+QljxJlVrkovfzJG0Sg073RkVCdxwnNAm8S+Y+mcUieE3qX1sOcBS/kC74xcuiXZmU87GyCqcE4FF4q4sTmQ5C+QN40gOe5lWqOhHxLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740662; c=relaxed/simple;
	bh=0fGTtdOlj0OaFFj/juQWY2eIIWPMURqhon21vBu56EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCD16qO7opP309WowgSCK3ZTHzbpkiWokIYAxsi4JSdPct2ymTzimmaTBKsZBPXiUp2a7v2W5TCyVWEe0+Q35Rmulb9rG1PtKkoXQZ1MejaTVF+/+3dT4JEcijwLOi0hjV3kppyfvAqLPM5yCYP4uqwF1Omf0GhwIKci9Q42S1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBy/+nXb; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-479eb8bcacbso6411566b6e.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740659; x=1780345459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rH2bOPxUTZ7jcp1ZJ8Ke8Qi27deWhvd2Eb9MPg+cVXs=;
        b=dBy/+nXbTu8AyYHszM8QEKbRZM1STqSMBGrEHUQvi9feIPlmjsYaVho3Q1l6wQV00U
         rKUWUBO59xYPolp+c5ujQm/bvmQdjOF0K/ruz1AK7fwQdrBBu3n3miJ8YNf6RyCTh6d6
         2skxUXFG8EINgH2q8rambSqBJoq4ESHWvwIFgFU/JULY1XiKpwIOmQBlKjG6b4B3etyX
         Mgo4AMUigLFk8q2S/Gr1kBLgf7FG4WlgUcqTxMcAJX3ukxmFGCPhgYyybz7gZ7M2gApM
         c5yezwic2nf4UyeEF7NOwVKuZMUDihEGl6Y4MNxDkQ6jKI0T+W8OTHg0GE466OkmRb3w
         HD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740659; x=1780345459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rH2bOPxUTZ7jcp1ZJ8Ke8Qi27deWhvd2Eb9MPg+cVXs=;
        b=bHSyWSALmEGi2zelvKD4pbKWQHMZRlcT+djtc+78t6hPx+tr2iNz0H8IvutM1h34C8
         zEUy58O4UEcB6DmB7JLDGDu4gVDqjrnuMNHj00PTosTMtaIExLSHy/rRuoD9eIBxYbVk
         0FFCa9D9lBUwynKJdn1hM+fz/ysQNx/oyVSi5/qxR19jkxY2+2k96M9oY/VYDhNXEvqq
         T+ZylKg20zZlK0Nj3QX+fY101OHvanLKChXTAMnkY0NT3zPEjtyk+cFzVJyAtkk2ldVP
         Nji94mq8qI7rTKBja/E6SvARoqUgIsQ8kjs/1rXgu5NP2sm0VzG8rLtAg5dAY1VYvg6y
         B2Ug==
X-Forwarded-Encrypted: i=1; AFNElJ9eNCf+ORggXwDcJC0iPwQxB0uaVQqQ7YLCX4Jj2jU4kWvuhtHKZRDHC0jGUA8J1TkpjjVD1LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy9V0zGa2fhmHtAsFVFGvoh5GKTfimEEjQRXfe5rDuA9mlgzMO
	ZmqDiTPa3dgciDUMfTxukBOizIBbBFfRbDeqpNkehY2JjjsSNCSOERHS
X-Gm-Gg: Acq92OE1lRyX3JyYGeaZOsrZpYORrqWZ+jMUlcRxhNJVx41yZ2K0uLURi/vSuPdXQAh
	Q3hH3M4RpR0E9VPO48kj+lJpgYg+edFQTbtQaF9aFnMFechzzI7kbTFb2ry1KQeat+Ad8wgfwqB
	Dq278osYc+ZG/4oDzApteFWWb08oQtaWw+c8/9b3AiADrYcCGpi/rx12P3aG5EMZ1Mc0nqfJyWK
	vAp7/Wp+FwK0cRkQFHhM/pZldrINBEKGRAVstT1eC3wUgxTeqQCor5AgtvdZSgUyC6rmv8Yfhvb
	hb5lXZsQwwr6pdlEoFQj9h96d1EkCPFMvqykJVFls0glaug734w2wv1XmycwXa1pXO9OGRXD8Hn
	Bi1rc3+6gpSd1pVulxzgCsp6Y0szJfQLWm04xJdO8IZi+0m7CWtVbvAFTb7AmywxtLhbFGro/lo
	U6Rb/Y4PvQW/RlmuZP3/jOeC/FBh/bqs9JtUZkAHRE6h8z85AC99pQUaOB8xkUWWQFLdk/+ozq1
	Z38RzQKN2ErqGTa5DqU5c/qTDWMSjV+zhIPhvnB288CTcY=
X-Received: by 2002:a05:6808:5387:b0:485:3dd3:7719 with SMTP id 5614622812f47-4854a3fa2abmr8790520b6e.22.1779740659634;
        Mon, 25 May 2026 13:24:19 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5204305b6e.15.2026.05.25.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:24:19 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 2/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
Date: Mon, 25 May 2026 15:24:10 -0500
Message-ID: <20260525202414.602-4-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525202414.602-1-adriank20047@gmail.com>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202414.602-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254201-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3B9045CE527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

f_audio_bind() guards gaudio_setup() with an 'audio_opts->bound' flag
to prevent re-initialization on repeated bind attempts. However the
fail: error path unconditionally calls gaudio_cleanup(). On repeated
bind attempts after failure, this closes file handles that were opened
in a previous bind invocation and already freed by RCU, causing a
use-after-free detected by KASAN:

  BUG: KASAN: slab-use-after-free in filp_flush+0x23/0x1b0
  Read of size 8 at addr ffff88810d5523a8 by task bash/306
  ...
  gaudio_cleanup+0x59/0x100
  f_audio_bind+0x4b0/0x590

Fix by removing the bound guard and calling gaudio_setup()
unconditionally in f_audio_bind(), making setup and cleanup a matched
pair within each bind invocation. Remove the now-unused 'bound' field
from struct f_uac1_legacy_opts.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 11 ++++-------
 drivers/usb/gadget/function/u_uac1_legacy.h |  1 -
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 5d201a2e30e7..6ad4b16769b7 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -735,13 +735,10 @@ f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 	audio_opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
 	audio->card.gadget = c->cdev->gadget;
-	/* set up ASLA audio devices */
-	if (!audio_opts->bound) {
-		status = gaudio_setup(&audio->card);
-		if (status < 0)
-			return status;
-		audio_opts->bound = true;
-	}
+	/* set up ALSA audio devices */
+	status = gaudio_setup(&audio->card);
+	if (status < 0)
+		return status;
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
 	if (IS_ERR(us))
 		return PTR_ERR(us);
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.h b/drivers/usb/gadget/function/u_uac1_legacy.h
index b5df9bcbbeba..fd22fd37fe53 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.h
+++ b/drivers/usb/gadget/function/u_uac1_legacy.h
@@ -61,7 +61,6 @@ struct f_uac1_legacy_opts {
 	char				*fn_play;
 	char				*fn_cap;
 	char				*fn_cntl;
-	unsigned			bound:1;
 	unsigned			fn_play_alloc:1;
 	unsigned			fn_cap_alloc:1;
 	unsigned			fn_cntl_alloc:1;
-- 
2.43.0


