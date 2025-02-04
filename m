Return-Path: <stable+bounces-112131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4F0A26F5A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E63A439F
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DD208974;
	Tue,  4 Feb 2025 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="kIwoBFqb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2B201267
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665159; cv=none; b=NFq7ZzdPJp7vy9bmPvR8Kt3/xCHi1+OZKXabqo5kDq2xuJJl1HL//PvabG/vmir0Y2Yzs+V1GfrRAFXexrEH5T1KdlDUrZKyJfY90tGafbFH3LWYxNKIzdbuUElqfoXrhHvKK1JHMPaC/k/NZUKppBfw3F03IgEneWQL6yRReAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665159; c=relaxed/simple;
	bh=h4bCdJLPPIOUa1CDbt7BqwjsN6eRnUYH+RIoS+X8j7I=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=aVc2igbObrnCxPUHkRxSKnvnsQ9eS5GVbKjv7GXi81qJ5GvhCz1JXOKSXcTefkba1pfgyyBpEAEmpjsbFeGOiPczwNj3iOEauSUV3yuEGVouIeNC+iISSP1wYSrF9ZYfoRUICP1vI7/AlcLCMT852Ynej5NoDfT9Z+gxYMzn5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=kIwoBFqb; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6ef60e500d7so35781777b3.0
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 02:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738665156; x=1739269956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lotn/Z+tZKYm39dIV5cgvmfbrqHW1TEx+L7IZyFCKqU=;
        b=kIwoBFqbNguWcEoyJN173donsc5taVRX1rqjVxQ7rhodyUEqkf8D5/JVkX2SwE0vdR
         FBVlKUqzQjwOiSE+EQn/B/avVCQgJlP2fwchO1nrrFwLklr7X6dvAbMUwiD9PBXyrS6E
         GYZkfKf/UKaL7WMe5MrWAYIFpnCMDFJmjjzmYt/77bmCX8xqZvOiMBLUBgyuu01yyExh
         q4HEGOubDuYSJ2v2LHMSysI1tMwNwnEuq4SLTtmHft7ERqpjeFtcntfgrFB/TK8qpLpP
         TQTMjal5PnVOfThr8nXUOmLIgdhh5Sa5DZOs/hB1UIYXUc/z0GI7hWkQgw7QNICjJ+cM
         6T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665156; x=1739269956;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lotn/Z+tZKYm39dIV5cgvmfbrqHW1TEx+L7IZyFCKqU=;
        b=nPyUdqDIsOSNK0pwJSBLpZcLBIAqkuutJjijG/wFHHJwJSZP3yo3c48igBIE45w9ZK
         Mg+DLMrH7ikUCu+/jxQq/3SYV/anrJd7iBceXjwMY6lxfWp9HGwgFpVbJ5exAL5VxAjX
         MGIHN7QY3vb8Z0as1vIKEFGJnteReDpQQkpeG6Hy7jBeArhJiTfziLdFXH8aO0NMgtdI
         jdD6zLwvLGJzCKCfZ+hhgi5fdA4/BVOjCCGtNQXngGH1i+FPQ+we4kwV+7snkjm0j+dS
         m+tCSlgGPUjNrL6MEB69/4uLFsvUh3srTv43OGeEOY1nxXRKIvBG3Sb+NZC6xseKVJnm
         5i6Q==
X-Forwarded-Encrypted: i=1; AJvYcCURLc6pS3Eyjp2ylb7nDDcVQbkK1VfpClNKMAIZQ2Ak1fkryVY6VKqaKMg3/phSfDjoqpN7Efw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzY6Jfv4vfr6UJH33DqugCMFeU+syTNPXeKziqYXcj8CKjZ4Nu
	nyX2sEVYBheXB53MFnNa/yH43LtxQwmfrJdk77SDDc3v91mceoXHOG4OohrJ1Sbv+Z6DcbKPmGy
	vL8KimtlCdH1KlKTNT1AvP9twBKt1yvo0VsF8JfPCdZAYdLtOlDRbXwHN
X-Gm-Gg: ASbGncvCn4m4q2xdtQkW0X969Imvno0zx1sj6F2Fu4LvaFLw76+3QbMwtXYpqJojxJd
	5hUaRdpZZQshxO6L7yO6YBNCqyXG0kdValzRidRkJntv8WnJa+aNxs9gRoPaFsaFSxff5y8ojez
	IVwyzyKzGRFdLv2zFmnqgC/minRdv52A==
X-Google-Smtp-Source: AGHT+IH4wsIgbawr5ZwaHJHRs5m855SEHURgrWDl3dj5SfI948bQWH+QMC5+NTRInBsTl+21FBqAAMefEfAtpvjEVhU=
X-Received: by 2002:a05:690c:60c9:b0:6f9:447d:d1a6 with SMTP id
 00721157ae682-6f9447dd41emr91209777b3.25.1738665154560; Tue, 04 Feb 2025
 02:32:34 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Feb 2025 02:32:33 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Feb 2025 02:32:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 4 Feb 2025 02:32:33 -0800
X-Gm-Features: AWEUYZk-uRbc2gy8W64EHSdbDfPoTyVyRVduHzbcp2iyNRb1CUjPe7IymHmmx9o
Message-ID: <CACo-S-3_q62Hv_ViTdgB50JwTZr6Z_G=SdK0VoCuJuqszfWT7g@mail.gmail.com>
Subject: stable-rc/linux-6.6.y: new boot regression: WARNING at
 drivers/base/core.c:2515 device_release+0x80/...
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-mediatek@lists.infradead.org, 
	angelogioacchino.delregno@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New boot regression found on stable-rc/linux-6.6.y:

 WARNING at drivers/base/core.c:2515 device_release+0x80/0x90
[logspec:generic_linux_boot,linux.kernel.warning]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:18a6cd3bd705698b41106eef2a1d7f2e411c7aab
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=maestro:18a6cd3bd705698b41106eef2a1d7f2e411c7aab


Log excerpt:
[   10.292722] mtk-wdt 10007000.watchdog: Watchdog enabled (timeout=31
sec, nowayout=0)
[   10.300525] Device 'conn' does not have a release() function, it is
broken and must be fixed. See Documentation/core-api/kobject.rst.
[   10.300855] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.312539] WARNING: CPU: 4 PID: 76 at drivers/base/core.c:2515
device_release+0x80/0x90
[   10.320803] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.328862] Modules linked in: videodev(+)
[   10.337116] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.337122]  ecdh_generic
[   10.344606] videodev: Linux video capture interface: v2.00
[   10.344795] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.344808] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.344813] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.344820] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.344825] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.344829] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.344862] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.344867] OF: graph: no port node found in
/soc/spi@11012000/cros-ec@0/typec/connector@0
[   10.349449]  ecc mtk_mutex cfg80211(+) cros_ec_typec(+) pwm_bl
videobuf2_common mtk_rpmsg mtk_mmsys mc rfkill elan_i2c auxadc_thermal
sbs_battery mtk_pmic_keys mtk_wdt(+) pwm_mediatek mtk_scp_ipi
mt6577_auxadc backlight
[   10.443014] CPU: 4 PID: 76 Comm: kworker/u18:7 Tainted: G        W
        6.6.76-rc1 #1
[   10.451183] Hardware name: Google juniper sku16 board (DT)
[   10.456659] Workqueue: events_unbound deferred_probe_work_func
[   10.462491] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   10.469443] pc : device_release+0x80/0x90
[   10.473443] lr : device_release+0x80/0x90
[   10.477441] sp : ffff8000806a3a80
[   10.480744] x29: ffff8000806a3a80 x28: 0000000000000000 x27: 0000000000000000
[   10.487871] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb3a8b7360500
[   10.494998] x23: 0000000000000000 x22: 0000000000000000 x21: ffffb3a8b735db90
[   10.502124] x20: 0000000000000000 x19: ffff514146120880 x18: 0000000000000006
[   10.509250] x17: 61206e656b6f7262 x16: 207369207469202c x15: 6e6f6974636e7566
[   10.516376] x14: 202928657361656c x13: 2e7473722e746365 x12: 6a626f6b2f697061
[   10.523502] x11: 2d65726f632f6e6f x10: 697461746e656d75 x9 : 6572206120657661
[   10.530628] x8 : 6820746f6e207365 x7 : 205d353235303033 x6 : 332e30312020205b
[   10.537754] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
[   10.544880] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff514140e28f00
[   10.552007] Call trace:
[   10.554442]  device_release+0x80/0x90
[   10.558095]  kobject_put+0xa4/0x120
[   10.561577]  put_device+0x14/0x24
[   10.564881]  genpd_remove+0x118/0x1bc
[   10.568534]  pm_genpd_remove+0x2c/0x50
[   10.572274]  scpsys_probe+0x13c/0x218
[   10.575927]  platform_probe+0x68/0xc4
[   10.579579]  really_probe+0x148/0x2ac
[   10.583232]  __driver_probe_device+0x78/0x12c
[   10.587579]  driver_probe_device+0xd8/0x15c
[   10.591754]  __device_attach_driver+0xb8/0x134
[   10.596188]  bus_for_each_drv+0x84/0xe0
[   10.600015]  __device_attach+0x9c/0x188
[   10.603841]  device_initial_probe+0x14/0x20
[   10.608015]  bus_probe_device+0xac/0xb0
[   10.611841]  deferred_probe_work_func+0x88/0xc0
[   10.616361]  process_one_work+0x148/0x2a0
[   10.620364]  worker_thread+0x324/0x43c
[   10.624104]  kthread+0x114/0x118
[   10.627323]  ret_from_fork+0x10/0x20



# Hardware platforms affected:

## mt8183-kukui-jacuzzi-juniper-sku16
- Compatibles: google,juniper-sku16 | google,juniper | mediatek,mt8183
- Dashboard: https://staging.dashboard.kernelci.org:9000/test/maestro:67a173d8661a7bc8748b7e53


#kernelci issue maestro:18a6cd3bd705698b41106eef2a1d7f2e411c7aab

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

