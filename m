Return-Path: <stable+bounces-33754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7D68923E3
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013F12859E4
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10579130E5D;
	Fri, 29 Mar 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cysaH0ZA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB748563D
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739548; cv=none; b=oDJYnjdTjCB63aIqMqrpVA+2racJthes+HdDIN7RyvsUJKUxqTj2Ufzjea9oCdp+TPWnzd8egmjnCW5XzUmE2cPPrR1VWTnYU6Oxidvk60O7Tl3K5UCx5ADOGyohYrpc0om1MZ7x7xcyn4w0jtsoYbuKRkPZk69bRj5O/vbo/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739548; c=relaxed/simple;
	bh=AKvtFqmJH4ZOM6+yzO+8vG0/T8jZKT9K8FySji2Vvss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kuiP+qFBhTWs+SYZm0adUDJkUXipX2mFkUmDEixLIz8cjY7Woq46matPiT0hnm6Znl5YgmMFGGbUKM8yPMw5YYo0/5MEtfsFYtEM0iW+4845EClGJwkuUcbSLTPhck11VHHaVCvXMhfxL4ufUUWdjX5l6gBLkxG0lT1xIUZ10aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cysaH0ZA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so1848695b3a.2
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711739545; x=1712344345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scdxeJwXUHBDaV04a23nwEkYWMwKWnbfowekmqNHaec=;
        b=cysaH0ZARUctsKax8vvExBJt9dL7FAd26PNloL/5i6HhjLV+ORuRYAmUDfK7XhkkLF
         E5FTN7MnpGfMYBXvemz8lLnag3NIWniKzTotShfiSRB6OLXvrDrJNDu8HT/78cTg2UI4
         pDlOLnegmedYvwIDJzSxC6D9YrthXn9UbnBzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739545; x=1712344345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scdxeJwXUHBDaV04a23nwEkYWMwKWnbfowekmqNHaec=;
        b=uiFAoLLVf1PIybnBPByHl/DZKB/smkvr82ecT/MkB5gNZEs/8jF8iFICTxlZ7rOega
         wK16/ySajMykToxLVS1HXARd645b+NV8JY5mU+0+Sc5TJg1pJnQfNCz1x203NFiABbMD
         sOq+1c2FR2ZrYOHAbD+kdSn1iYCF3Z301klJ9FtgWqrUzYvgi3anzAO1tFtY/PmjJ4CL
         Vx4qEk/VIr2rEBGnnl68SX/D4x87m9BSlIkuQHoyRIdcAdcgizylATINNYvEfAVu8ASu
         tniglkMoDNwMEmytZxuOGtLGtjzMFRAaXTVkFwWmF1Eb51ViRIGhd6ZF0DvJrkXWIKg5
         xXCg==
X-Gm-Message-State: AOJu0YylpJWZa1quADh9Lk2ly4h+tkK2N7P1xO53E1WdEAEuNJT5Zzof
	QQ2ayIzBgJh3ZnDmS8lShC4IrmxoqXle4OXIEB7RDtLbeEDEDexnQJI0PNzqtD4ZhUHxJeDyxU3
	W2ffFwRxOjsit0RqLA1hAJ+CzM4iiTCzx2Gg3T4e4guRLOJ0lhNeQ+OIMZAfmCeRR5ULbO7b0ss
	9m7xSuHKTfLXedV06ubOgg73OKEYvnCbQNm27N3OSvRzE=
X-Google-Smtp-Source: AGHT+IEwjpEQv+LpV3KuKQ0fkXK/nEXbm5c2Qxf1IlRblY8ca0unVY5+k2YpXHSooflCb+JQub2eIA==
X-Received: by 2002:a05:6a21:318b:b0:1a6:ff14:a6a3 with SMTP id za11-20020a056a21318b00b001a6ff14a6a3mr1547146pzb.25.1711739545219;
        Fri, 29 Mar 2024 12:12:25 -0700 (PDT)
Received: from ubuntu-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b006e6c3753786sm1317471pfi.41.2024.03.29.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 12:12:24 -0700 (PDT)
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jslaby@suse.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Yangxi Xiang <xyangxi5@gmail.com>,
	stable <stable@kernel.org>,
	Kuntal Nayak <kuntal.nayak@broadcom.com>
Subject: [PATCH v4.19-v5.4] vt: fix memory overlapping when deleting chars in the buffer
Date: Fri, 29 Mar 2024 12:12:08 -0700
Message-Id: <20240329191208.88821-1-kuntal.nayak@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangxi Xiang <xyangxi5@gmail.com>

[ upstream commit 39cdb68c64d8 ]

A memory overlapping copy occurs when deleting a long line. This memory
overlapping copy can cause data corruption when scr_memcpyw is optimized
to memcpy because memcpy does not ensure its behavior if the destination
buffer overlaps with the source buffer. The line buffer is not always
broken, because the memcpy utilizes the hardware acceleration, whose
result is not deterministic.

Fix this problem by using replacing the scr_memcpyw with scr_memmovew.

Fixes: 81732c3b2fed ("tty vt: Fix line garbage in virtual console on command line edition")
Cc: stable <stable@kernel.org>
Signed-off-by: Yangxi Xiang <xyangxi5@gmail.com>
Link: https://lore.kernel.org/r/20220628093322.5688-1-xyangxi5@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ KN: vc_state is not a separate structure in LTS v4.19, v5.4. Adjusted the patch
  accordingly by using vc_x instead of state.x for backport. ]
Signed-off-by: Kuntal Nayak <kuntal.nayak@broadcom.com>
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c9083d853..a351e264d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -855,7 +855,7 @@ static void delete_char(struct vc_data *vc, unsigned int nr)
 	unsigned short *p = (unsigned short *) vc->vc_pos;
 
 	vc_uniscr_delete(vc, nr);
-	scr_memcpyw(p, p + nr, (vc->vc_cols - vc->vc_x - nr) * 2);
+	scr_memmovew(p, p + nr, (vc->vc_cols - vc->vc_x - nr) * 2);
 	scr_memsetw(p + vc->vc_cols - vc->vc_x - nr, vc->vc_video_erase_char,
 			nr * 2);
 	vc->vc_need_wrap = 0;
-- 
2.39.0


