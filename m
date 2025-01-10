Return-Path: <stable+bounces-108246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A41A09EDA
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 00:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640A17A4443
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0883122258D;
	Fri, 10 Jan 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="rHu4dOQU";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="H/eLuPyS"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1A222565
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553044; cv=none; b=BZLsAr8RMQTTgsFQ9Yi3LNVAK8SncYNpC/lZ0nB73DB7jher0Y87+lHC1eh8vbYzL3Ay9vK6YngDXmG470Wswr09u5ERLF+kkwzpUiZaSi9hR5dXLKXbddoOfz/+/i4WXRu7Zrf75CWcI2M6pAra/c8eVxGoye09FHPtfcFm2P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553044; c=relaxed/simple;
	bh=E24l2NEdocIuS+niS7tR9PZ+NuhoVhrhGfsNSIlWXmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YsFTe4ZyvNdLwSyl4XK+ZdGSkx95ObvzzHRHPFDbQFkY3c5w3iTiIk+XdQAl1CqJN28g/7/es5fvRpbX2Bm0OgWnqkYrNlSQzB5ONRNB4eteqH2rpOO6Zj+OnaivuA945mz4o2AIm8JqZdsjXDWr7umLwXM1fENx+gisCmz/0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=rHu4dOQU; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=H/eLuPyS; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1736553040;
	bh=E24l2NEdocIuS+niS7tR9PZ+NuhoVhrhGfsNSIlWXmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHu4dOQUHgn7CZwQ8eO1llvwC3DWhMQLulfVU+NW0nZsnoAMwXj5woUYt/gMwHHni
	 QpjYhupC3UZoLk+7wqPcM7Wj35Y1qUDvojSUFh91GGFqIi0nH1d+PmQDEIlCzvVvHi
	 psQvCHMw1h1YyHBgV9KY6JJ+PJU6+Pi/ufz9cZFaPNEeALp6FHnGaLQXzSYCPPB14t
	 4lwOKYr2ykw7Ko6Tfoyxc2NspvLyqJw3tHDTCym2HVZh1oZjykWgV1+w3GHfIOygli
	 o7Ktgm0GjIgLeN+4/0thA8Dd9f5zQWSsXv0su9DnpqFml+FCak4POwUA+KSXujiIDO
	 I9RfepR/ZtA6g==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id C929EA0
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 08:50:40 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=H/eLuPyS;
	dkim-atps=neutral
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id ACDF5A0
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 08:50:40 +0900 (JST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5f360b7013aso1918487eaf.2
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1736553039; x=1737157839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzXaow4OKVTn2usXw2dSsQUncbcTPm1ESbRX/Ahbebg=;
        b=H/eLuPySgCw2aQRTlcTJP7oSZeScq3C2COO9r6xJs3mVm1IGffU+n25Bzeb399wZ7T
         ElJejys50SAeTmabgr2O/oDIHkMZpUy28LFQWC4tsnDRc00dK3L2vm2E+V+UC4d35dn1
         31gfLeRFb/HD8LJzezTkflQ5o5lE5zIpAba3w4zd4+7+UFpyQ0mt28GHFyWHnuDhbyQ9
         qgED4gNfCiM4QqABRChLIjL1CFPs8qJYh4nsEW3QGCzB0Uj4h1cZzZ1ju36pg1plsjHo
         3MSdutOK/dOMCKtyUzNp/Bk7z5373pdVfJoktrAom8HVa65tqO/WMeB+00IBUL/D/t0W
         4HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736553039; x=1737157839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzXaow4OKVTn2usXw2dSsQUncbcTPm1ESbRX/Ahbebg=;
        b=lXbfewFhRwJPM478avPrFi3rD5lkNgxaRU+u6iG414gblCnQnv9QsQLLO5UDxYE0yS
         eWcFMWeXLpiizeYK75xMfQpZC1BgVmzABTn+jrKemPm2LtJU20D0WTlCrSknOQE7Ux5f
         IsItMrxFFOzcVkfyIJF9agtqOxp4pzpSjT6ONC81JuUb/mY6uhr1I7D63NTaKvFOrU8z
         OnmL3vOmDWww0Qf7tb6De2HwPsVlV0A4mKhnXbbCvNPtaZsYp3gRUQOf7PAPFLcqNrl8
         JHbO8wkyx7H8qdmGXGs3JqS7BsyhmvxFhZyOxEk3j48bNnmtheRSn2AD3FECw4hpYm6A
         iPNA==
X-Gm-Message-State: AOJu0Yyfsu3uftgKxNZQoQWOJBVjItHP5B2L+8tiQWj3Z1xqJEiQdE6Y
	k0C61hXKwjABSzJnovybi0aM95Pi/KGd9TfPJk2IF1HN1zUxQb3/F7q7URxLun7WUGq/LimES0I
	HxwI932+gpJMYBtF2x4EuWrnlMwWlvtuqx/IWA5imYldDBVdoHyLNOo8=
X-Gm-Gg: ASbGncuivFlllDW9XYrGuGFFwAw+t3Tjwi1WbSjQpzAR1+njqVp4TG22kJkIL4FambE
	LmaHi0+MVOzxCagEPqyPhF0ydcE4sRgkOACiNG8MKDIj0rD3vFLMdECtRjVuI9wpUNj5djMIQo3
	D0hIEczrJ+Z13DErSGSjQCqyTQSrYPwyNAi9ikkStuKW8u3NujAyb9Ux0kOo54dMA7SNnGktzwj
	lJ0uxu40d9MQweknmEmkzWpViQr6bhwO1yxUPSCF98uBLqN1UA5eTVCsVoimMNEV3kpwE2Uoa7E
	7WY51oFegy9Mrd275BglRXl2q9ISg3tMjqa2zJND
X-Received: by 2002:a05:6a20:9185:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1e88d0a2ad4mr17590496637.8.1736495936579;
        Thu, 09 Jan 2025 23:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7KMUqmK/amvBFF39uo8qX8lRwdic3kWHeFWOWkvP5T4KzKcVFjU22go/UgnH1YyVP9QgkEw==
X-Received: by 2002:a05:6a20:9185:b0:1e0:dcc5:164d with SMTP id adf61e73a8af0-1e88d0a2ad4mr17590471637.8.1736495936217;
        Thu, 09 Jan 2025 23:58:56 -0800 (PST)
Received: from localhost (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5a32sm1044357b3a.173.2025.01.09.23.58.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2025 23:58:55 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.15 2/3] zram: check comp is non-NULL before calling comp_destroy
Date: Fri, 10 Jan 2025 16:58:43 +0900
Message-Id: <20250110075844.1173719-3-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
References: <20250110075844.1173719-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ v6.1 stable tree commit 677294e4da96547b9ea2955661a4bbf1d13552a3 ]

This is a pre-requisite for the backport of commit 74363ec674cb ("zram:
fix uninitialized ZRAM not releasing backing device"), which has been
implemented differently in commit 7ac07a26dea7 ("zram: preparation for
multi-zcomp support") upstream.

We only need to ensure that zcomp_destroy is not called with a NULL
comp, so add this check as the other commit cannot be backported easily.

Stable-dep-of: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
Link: https://lore.kernel.org/Z3ytcILx4S1v_ueJ@codewreck.org
Suggested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9eed579d02f0..e5626303c8ff 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1712,7 +1712,8 @@ static void zram_reset_device(struct zram *zram)
 	zram_meta_free(zram, zram->disksize);
 	zram->disksize = 0;
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	zcomp_destroy(zram->comp);
+	if (zram->comp)
+		zcomp_destroy(zram->comp);
 	zram->comp = NULL;
 	reset_bdev(zram);
 }
-- 
2.39.5



