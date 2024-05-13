Return-Path: <stable+bounces-43751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE668C49E2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 01:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCDF1F21A64
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8384E08;
	Mon, 13 May 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="XaPb7BS7";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="h4RFnTX1"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA2684DF5
	for <stable@vger.kernel.org>; Mon, 13 May 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641623; cv=none; b=d0mHo3QQsFfEVbKbHaiQINWD+IILN9zKtXNdG1kp7jJNJyEE66Ek7gX+KCSHrOF41GN5quKun7l86K88AWYdDIkAQ/jCnUd5zKk5t0iAaqRU55/32/RTa3ZFlpmFHRvBs2O70ajGz8olVL1ELPbbreI5fbwWxR+SV624NonprCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641623; c=relaxed/simple;
	bh=ZpolEqSGxY+2JN0Ut/ZVEL54uz7os1NYNz0jMOaTv0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSBNYqucRm7C7P0phBqlaRuEnjaew/mNjevjnqtgph1FJwbCtvfaKKJm/m//OZLKazx4HZy7HafLRn4eJ7acD9V47DGaWMv2/DlQBrASKOU5wFJuZv3xVze/+6uwodyu8M4NzXjoQORvZNtQ3yjQtqkBRCxmVkJEXHwZ7FrgyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=XaPb7BS7; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=h4RFnTX1; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1715641621;
	bh=ZpolEqSGxY+2JN0Ut/ZVEL54uz7os1NYNz0jMOaTv0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaPb7BS7GV57bE2+7vZz1C17hO0E3cZ8KU97fi6wj6qiPvHreF06GLzV9DGIFBYRU
	 3BAL+JE9csq5T7/07WmnM5fDJzwE4rwCLH00nZXO4qYoBKVmdnFFxKFpNnjgQhG8a5
	 wux9hIgbqWMxwFRbeFCt6GKmht/ksGqQuGLPdbocvhRLy3F1qsnXsNe36/OZEAq83I
	 j2+vL3nZhX57jIczKx5B0unSIZhSEg7GRq8sFaHGr/VIJ8cPjJQplXjw5YaXwaQIUo
	 pthTnATvXDhMsTE3KCRO71dbet0Ybtz3WJR+Z9gst2HSutQaJCUK9dGOyphiukR6vv
	 PlTnbRFOZvlew==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 1B0C92B0
	for <stable@vger.kernel.org>; Tue, 14 May 2024 08:07:01 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=h4RFnTX1;
	dkim-atps=neutral
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 884BD2B0
	for <stable@vger.kernel.org>; Tue, 14 May 2024 08:07:00 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-61a119df58fso3441206a12.1
        for <stable@vger.kernel.org>; Mon, 13 May 2024 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1715641619; x=1716246419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDRbI+79Qk1eFfcbABhNC/u9TwmtDpW4rtPNAcpRwGI=;
        b=h4RFnTX1tVHm5NNK+R9sGzMdiJFqx+QFjPmnD3iB6FPvrQ2Ye6zO47J2JThithYtSK
         kKbzsU7zfzdny8/qgC9kDRdcsN1BYj4PBhF45gxFKMTp/7T8h70tRJI/eJl0iFMa6khp
         X5ArjoOCXdeGUkLk2wKJQYLYsjFkGfFtLF1sv+84TWA/SUV/lEi1MsfOKTnlrJJagVSQ
         RLJywgiYBAs6ImCA3rekwlR63R0JJ5BQLVymtIKWBFK2VwHerBgw/KlAyVhnz8JEoNoQ
         1Ka8vpn/s79zb3y6b+4vhpoaE9nZ8P6fRBK/DHTdoPir27VuT/nKI0qMx+qRwq7dStVW
         7Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641619; x=1716246419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDRbI+79Qk1eFfcbABhNC/u9TwmtDpW4rtPNAcpRwGI=;
        b=hOgJIePiPZFjuyUyS9Em8+Xe82QSCLjz7U2nvN+RlmL+C59I3e8QnynlWCKcoZf6MY
         K0emaYDw9rzzBvcWBTGwwVmygxfv3b6f1P8u/vr8ntT+XWpu47RMPaDqE/ZFrk0/ILGy
         sMYL7qkN2SZUqT+UzrYAMj93hJlM7jBZkw9XOd8v2gqBV43B1PCjGiNnYHKsETNQTneJ
         4hlHXrKo90cdBTCyRXg79d38kAL/lvgcr8cG4kC4C2792BUzvK0cFMQGrwPEgvxIXQFB
         wMEXA00Dkrt+QeMB1yvEavthpUpTmBCyGRDiTN8y7P2Tyohiy1bVZYcBzP+OIAQD8Fxl
         guOg==
X-Gm-Message-State: AOJu0YydWH14aZ6kzSKSKq9AzeMeWcr73cHRYn6czeOVLtrqPD0cxWsG
	7EFRf6EUmUUJIFPyAeVdc0Iw2YtlKC9iLLHTipzPU7YELm2DUES98BJPhLGt1O3cXcwJ3VsqKMD
	oQ5DHC2r0ko888WHGRyk3Bwy4sUrAnfZHPusV321XIYBa33NWRVhoXDM=
X-Received: by 2002:a05:6a20:1592:b0:1af:db2d:d36b with SMTP id adf61e73a8af0-1afde0dc165mr12088436637.15.1715641619543;
        Mon, 13 May 2024 16:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBMvSOwYtPGxD09dPTqWepvT4UHT6xrfuOvDwwRk2iT8x5jlYMtRepIskszWRCh9ArtmyEpQ==
X-Received: by 2002:a05:6a20:1592:b0:1af:db2d:d36b with SMTP id adf61e73a8af0-1afde0dc165mr12088413637.15.1715641619025;
        Mon, 13 May 2024 16:06:59 -0700 (PDT)
Received: from pc-0182.atmarktech (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade27fsm7877216b3a.108.2024.05.13.16.06.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 16:06:58 -0700 (PDT)
Received: from [::1] (helo=pc-0182.atmark.tech)
	by pc-0182.atmarktech with esmtp (Exim 4.96)
	(envelope-from <dominique.martinet@atmark-techno.com>)
	id 1s6ekz-004Rnm-1Z;
	Tue, 14 May 2024 08:06:57 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	dsterba@suse.com,
	pavel@denx.de,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.10 / 5.4 / 4.19] btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()
Date: Tue, 14 May 2024 08:06:49 +0900
Message-Id: <20240513230649.1060173-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2024051346-unvocal-magnetism-4ae1@gregkh>
References: <2024051346-unvocal-magnetism-4ae1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 9af503d91298c3f2945e73703f0e00995be08c30 ]

The previous patch that replaced BUG_ON by error handling forgot to
unlock the mutex in the error path.

Link: https://lore.kernel.org/all/Zh%2fHpAGFqa7YAFuM@duo.ucw.cz
Reported-by: Pavel Machek <pavel@denx.de>
Fixes: 7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()")
Cc: stable@vger.kernel.org
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
The conflict is in 7411055db5ce ("btrfs: handle chunk tree lookup error
in btrfs_relocate_sys_chunks()") but that no longer cleanly applies
after the backport of 7411055db5ce ("btrfs: handle chunk tree lookup
error in btrfs_relocate_sys_chunks()"); it's probably simpler to just
use the old mutex name directly.

This commit applies and builds on 4.19.313, 5.4.275 and 5.10.216

 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 09c23626feba..2d3aeef01c9e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3187,6 +3187,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 			goto error;
 		}
 
-- 
2.39.2



