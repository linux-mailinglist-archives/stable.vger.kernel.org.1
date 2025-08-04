Return-Path: <stable+bounces-166429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F5B199E2
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 03:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48383A689B
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 01:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314BA1E9B3F;
	Mon,  4 Aug 2025 01:36:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD157173;
	Mon,  4 Aug 2025 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271382; cv=none; b=WLXNro0DjTp7c3Sb1rgP+Qqp0hOxA8ys2dWB/2etap77jWwJpp4sdwuq1DSCWev3rjY5ee2nbWYzjIagwoZ0oyjkYL16EkKEIChm3f62fXMjlferSJov6hkzQjloqNkVBerSIkEQiwI9dUsaTzAub3DL34Klab6rAJDxmhd6ZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271382; c=relaxed/simple;
	bh=/Keh7XwihFhkH7/p1VNnfhrg98Ok167PyVFtl/lP6qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Snqu5mQBbbPCxaBOY8IjLETj111uG7g8iaROybEYvIbUPM1D499f0zsmy7pMuEpF8IU2XYeBuOZKuvdC9Jr+xpQ6U1Z1M5yGvEvnP+wGBT7IMvcZa33C+bFJIKw1GSGk10avdLakvOmJYgm7HWh1lRE8DnBV6yl1heBSzwrxGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 67ddb0b070d311f0b29709d653e92f7d-20250804
X-CID-CACHE: Type:Local,Time:202508040930+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:19f2735c-2a6f-4e51-8ffe-2ea9f6d9a637,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:a23135678690de963462a8cb6c5c13f3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 67ddb0b070d311f0b29709d653e92f7d-20250804
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 258496427; Mon, 04 Aug 2025 09:36:13 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id E304416001A03;
	Mon,  4 Aug 2025 09:36:12 +0800 (CST)
X-ns-mid: postfix-68900E8C-734670263
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 172B616001A01;
	Mon,  4 Aug 2025 01:36:10 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: maximlevitsky@gmail.com
Cc: gregkh@linuxfoundation.org,
	kai.heng.feng@canonical.com,
	oakad@yahoo.com,
	ulf.hansson@linaro.org,
	luoqiu@kylinsec.com.cn,
	viro@zeniv.linux.org.uk,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiayi_dec@163.com,
	Jiayi Li <lijiayi@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] memstick: Fix deadlock by moving removing flag earlier
Date: Mon,  4 Aug 2025 09:36:04 +0800
Message-ID: <20250804013604.1311218-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The existing memstick core patch: commit 62c59a8786e6 ("memstick: Skip
allocating card when removing host") sets host->removing in
memstick_remove_host(),but still exists a critical time window where
memstick_check can run after host->eject is set but before removing is se=
t.

In the rtsx_usb_ms driver, the problematic sequence is:

rtsx_usb_ms_drv_remove:          memstick_check:
  host->eject =3D true
  cancel_work_sync(handle_req)     if(!host->removing)
  ...                              memstick_alloc_card()
                                     memstick_set_rw_addr()
                                       memstick_new_req()
                                         rtsx_usb_ms_request()
                                           if(!host->eject)
                                           skip schedule_work
                                       wait_for_completion()
  memstick_remove_host:                [blocks indefinitely]
    host->removing =3D true
    flush_workqueue()
    [block]

1. rtsx_usb_ms_drv_remove sets host->eject =3D true
2. cancel_work_sync(&host->handle_req) runs
3. memstick_check work may be executed here <-- danger window
4. memstick_remove_host sets removing =3D 1

During this window (step 3), memstick_check calls memstick_alloc_card,
which may indefinitely waiting for mrq_complete completion that will
never occur because rtsx_usb_ms_request sees eject=3Dtrue and skips
scheduling work, memstick_set_rw_addr waits forever for completion.

This causes a deadlock when memstick_remove_host tries to flush_workqueue=
,
waiting for memstick_check to complete, while memstick_check is blocked
waiting for mrq_complete completion.

Fix this by setting removing=3Dtrue at the start of rtsx_usb_ms_drv_remov=
e,
before any work cancellation. This ensures memstick_check will see the
removing flag immediately and exit early, avoiding the deadlock.

Fixes: 62c59a8786e6 ("memstick: Skip allocating card when removing host")
Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
Cc: stable@vger.kernel.org

---
v1 -> v2:
Added Cc: stable@vger.kernel.org
---
 drivers/memstick/core/memstick.c    | 1 -
 drivers/memstick/host/rtsx_usb_ms.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/mem=
stick.c
index 043b9ec756ff..95e65f4958f2 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -555,7 +555,6 @@ EXPORT_SYMBOL(memstick_add_host);
  */
 void memstick_remove_host(struct memstick_host *host)
 {
-	host->removing =3D 1;
 	flush_workqueue(workqueue);
 	mutex_lock(&host->lock);
 	if (host->card)
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/=
rtsx_usb_ms.c
index 3878136227e4..5b5e9354fb2e 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -812,6 +812,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_de=
vice *pdev)
 	int err;
=20
 	host->eject =3D true;
+	msh->removing =3D true;
 	cancel_work_sync(&host->handle_req);
 	cancel_delayed_work_sync(&host->poll_card);
=20
--=20
2.47.1


