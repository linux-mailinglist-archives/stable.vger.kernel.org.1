Return-Path: <stable+bounces-254205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SML7CG2wFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:26:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8119D5CE57E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D78330226A7
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103083793C3;
	Mon, 25 May 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbRKE9F6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF763955D1
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740674; cv=none; b=cggIsTZenPuvrhHKuzgIQpH+gg5qnbPultziLEZpkXaOisQKGFoPRiHiqzQZ2gLSnYp7P2haMJHYVu2jJdKx+tEzvFhoiGVHaSitc6OKJzwQyV3BQEKVnzq1J7uFLyxZMm0eJZ4r0J3QGiWxrztA9/+JT0WIv+JcBFPd2taXUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740674; c=relaxed/simple;
	bh=BDjNlnf6kqOTmpfdKzt077i1YFIj/VXRK26I2fNu3o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmHJ7s3p8G+4LVrcssUcTIbvP1UuSwR1yqdJmQWr1yGHsFCIk7EjQPkn6QDyH25YoAk0yqq2j822AzOp6nVqEl/DWmkvRAGa27h9hFvp+gI+WU3SjXQhEC1l5k0dMz4UfSTqzw/pv4JVX/ZEg1VEcbbqe6uZ12AAvd8dER3ygT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbRKE9F6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479ef2b78f3so9092521b6e.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740663; x=1780345463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4eLS8y1SewZPIf8sa07E1Jfs/Pz7SGQnlUffTbCSc8=;
        b=UbRKE9F6FkRD6933ctB9MMW6mWiRHLQLuwZHKndQIziA12X67d8wqMgNDi78Ee17vE
         /91aDIuRkB79y6URGu0i5pBNFhUEvl3QMJzVPtcsB0Z80MwxEsMx1uHGClypzpLy73WL
         jPTEBVKnQMRxJ4rR47K7m2JLZbLOABOByiyID6AWPgg3oM5Q7c1sXq+3yZOKRJfsKmYb
         cfqhEQAW3Fworlrcf4D0/kF9aRh8kejZZ9s/kaxvKSpsHVD2lw8yvHpbasBxkL3GEcv+
         Vlfy8F4kQjdWuD1ggiDTt4ps3FI+9Hp6fCFTGc62PbdkLL2ZjQe42nobgtSVRS7Lnz4K
         Qqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740663; x=1780345463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4eLS8y1SewZPIf8sa07E1Jfs/Pz7SGQnlUffTbCSc8=;
        b=DtVerLrfuxtCy/aZCkDHHKKhw0mPKA2p41BeUTzglL6SS/PXmCMSb4d9sSUvGiYc6e
         OJIHjLwuBeg+F8mgiIr+G68xesgQjPlmQX30AlxaTOkK7HTQ+oY+0AArjQ7dS9pjvhxt
         RlcicJLwbgNgItO2D8jQjtDHRBp34w+G/twkzBVupuzz/2V4osvlcvK7UvVN7heJbqX5
         sMIIWomTc9OirtOZsckmM5YwqgLq5OHEzfvcneNgssNqMiQD+7m0t+kHJXrMFOg43ghu
         RGMy+GPdITYZeIUiRF/N1oZ8Q+6xHcB0ltTe5JkigaBfa1Zkxbu97n3sf2a9NJNtbDjA
         S0rg==
X-Forwarded-Encrypted: i=1; AFNElJ+PANQQZ4CTXlQ16AfYd7DlfzIAUx51Nzc1eufPPa/ow8/8PzgLFWF8sjNJ0xb4WCcSqiJsJ6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx//ffi4DkHAh5yHoeklE/6Ry3fJ5R8ZDmRlGhxf5iIOD1o2uS2
	l58LGATos3yVp/+6VEQXqJQPCY0w+DQ37W9lbAuawM7ykhcs+fh0gR+uHnR4AMLBxjc=
X-Gm-Gg: Acq92OG4jqiJIUgCpm7fqzbourYdfHQbX4JconjtYdqtBOLhpkt3HkEcUK2fRS5lGWG
	jws2UCGgX16edOCZVw7cGFheYcFEzCWGD27QnJVGUnP8EtHQZvyHwIACQkw3c438JHfsdKR8rbX
	mpWAL0Z8lxfjWCdhig2PYj18gPzenGPzul24M5ykCVSurgD8YKPU6PB+kDJvIuIztTreb4yBb6Z
	c//QwhRsRe+g5LnCwucG/xzq/08SpsJKfYAUZ63CKvXcCfaK8FOUuj2t4YoNxdf3PmldO7aeeuq
	Z8HM3gS80cDnd0xIH5M4jw3KE/H6K4sc59qfrJ2oAx0ALH5JdwAI3eBvqAMOnT6nbtA1Nz/B/D8
	t0Zulmr9IjdsatE1VvdkQEufglVICwoVqNbVFASYNggVhvLlNbhDOsOWNIRonhAPXBpZyzx37VB
	TIBkzmGivh64Hpqphwk8GXmcMjxHgAaA6IZ/tBk5P6uXtbPx/WuXXf8/hDmjNMDA7HPr/WViVKv
	8DNd4SezrJHIZcD5RpjmQYxznwHWGBPgDte2mGi0WI7MCw=
X-Received: by 2002:a05:6808:640f:b0:485:42f0:7eb9 with SMTP id 5614622812f47-48549d6bb9dmr9450283b6e.5.1779740662729;
        Mon, 25 May 2026 13:24:22 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5204305b6e.15.2026.05.25.13.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:24:22 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 4/4] usb: typec: thunderbolt: cancel work before altmode is removed
Date: Mon, 25 May 2026 15:24:14 -0500
Message-ID: <20260525202414.602-8-adriank20047@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254205-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8119D5CE57E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tbt_altmode_remove() frees resources associated with the Thunderbolt
altmode but does not cancel the pending work item before returning.
Since tbt is allocated with devm_kzalloc(), it is freed automatically
when the device is released after remove() returns.

The work item tbt_altmode_work() can be scheduled via schedule_work()
from tbt_altmode_vdm(), tbt_altmode_activate(), and the probe path,
and may still be pending or running when tbt_altmode_remove() returns.
The work function accesses tbt->lock, tbt->state, tbt->alt, and
tbt->plug[] — all of which reside in the freed struct, resulting in
a use-after-free.

Fix by calling cancel_work_sync() in tbt_altmode_remove() before
releasing any resources, ensuring no work item referencing tbt can
run after teardown begins.

Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/typec/altmodes/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
index 32250b94262a..57c8dff0c51f 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -303,6 +303,8 @@ static void tbt_altmode_remove(struct typec_altmode *alt)
 {
 	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
 
+	cancel_work_sync(&tbt->work);
+
 	for (int i = TYPEC_PLUG_SOP_PP; i >= 0; --i) {
 		if (tbt->plug[i])
 			typec_altmode_put_plug(tbt->plug[i]);
-- 
2.43.0


