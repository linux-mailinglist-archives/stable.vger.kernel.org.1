Return-Path: <stable+bounces-43135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19CB8BD489
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB0FB226D7
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4115749B;
	Mon,  6 May 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="ZmkTZQBL"
X-Original-To: stable@vger.kernel.org
Received: from ci74p00im-qukt09081701.me.com (ci74p00im-qukt09081701.me.com [17.57.156.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C4197
	for <stable@vger.kernel.org>; Mon,  6 May 2024 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019819; cv=none; b=ijS6gv61OJd8P7aoFaeSjSOAmFfAWHqIFaux7dIc9UdNzkTPlTsTG1tB868Pid9bKBOh8g0W8YXluU2cx6wEuvxjKxR+kuXXqmDFOiGk3Chs7cRQEGUOc8h9XGwhOxZC9P+0hslG9p8A/Vu1X8aJ6S+6a0/ywi123Oy5qoBN8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019819; c=relaxed/simple;
	bh=FhitAQDx3ZlWU26pkQUFqxgMMoHh/jcn75p9IzmANAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIS0sCdVCz9GpfWk2mAT5CT8tqK5b/y5Ude7kem1ZQxzIwf0L5QAIMx88gaA3r2ta8yr+E3d4IMq3dSdNgi/BWj9LTH6Fc28hWmPfV3ploiK/hJcwlxq+qj2L5nI+9YfiibfigAyi3mw33NsHzMxldL2a8g6REfY9lwg2uPrBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=ZmkTZQBL; arc=none smtp.client-ip=17.57.156.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1715019816; bh=k+qzt2+1Ia9zMIU6NU5FMS2XCDvlIMA5wroIBSQ6VMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZmkTZQBLK7+7+ble07oCEGknBzkFqgnEPgM5kh2sb6pBDGjAi1YHaSIqXL/+E3lQU
	 /qHlWq+cm5NFlwM81t2noUDAbxcGcjdqK8RseIXIecxEcPOBOkNC7haqe0m4T2yvdO
	 ppMQ1URbR0FNo83htwM9pc8f9pZXzus/2EeNiz0rqL8dYsZMslpEr55uPyhc4JlEDG
	 wkEQxjjm/wiTq7gKnw8yHU3HCBFwnspjz420Z5znybc+7Bz22wNw5aNIP8RVpKyXpT
	 ral6ePCH86Sh4I64ZxtlkDFHmu/0P5sN9YcN/VyvNX1IzuS8ug+EuwnAVHPT6vR8s9
	 kZazWFBrS9F1Q==
Received: from hitch.danm.net (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09081701.me.com (Postfix) with ESMTPSA id 74F7A46C044E;
	Mon,  6 May 2024 18:23:34 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: nouveau@lists.freedesktop.org
Cc: kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	airlied@redhat.com,
	stable@vger.kernel.org,
	dan@danm.net
Subject: [REGRESSION] v6.9-rc7: nouveau: init failed, no display output from kernel; successfully bisected
Date: Mon,  6 May 2024 12:23:31 -0600
Message-ID: <20240506182331.8076-1-dan@danm.net>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wz54LpTPKS3QRQ1x9J7c7q5aezbmJrMd
X-Proofpoint-ORIG-GUID: Wz54LpTPKS3QRQ1x9J7c7q5aezbmJrMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_13,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1030
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=844 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405060132

After upgrading to rc7 from rc6 on a system with NVIDIA GP104 using
the nouveau driver, I get no display output from the kernel (only the
output from GRUB shows on the primary display). Nonetheless, I was
able to SSH to the system and get the kernel log from dmesg. I found
errors from nouveau in it. Grepping it for nouveau gives me this:

[    0.367379] nouveau 0000:01:00.0: NVIDIA GP104 (134000a1)
[    0.474499] nouveau 0000:01:00.0: bios: version 86.04.50.80.13
[    0.474620] nouveau 0000:01:00.0: pmu: firmware unavailable
[    0.474977] nouveau 0000:01:00.0: fb: 8192 MiB GDDR5
[    0.484371] nouveau 0000:01:00.0: sec2(acr): mbox 00000001 00000000
[    0.484377] nouveau 0000:01:00.0: sec2(acr):load: boot failed: -5
[    0.484379] nouveau 0000:01:00.0: acr: init failed, -5
[    0.484466] nouveau 0000:01:00.0: init failed with -5
[    0.484468] nouveau: DRM-master:00000000:00000080: init failed with -5
[    0.484470] nouveau 0000:01:00.0: DRM-master: Device allocation failed: -5
[    0.485078] nouveau 0000:01:00.0: probe with driver nouveau failed with error -50

I bisected between v6.9-rc6 and v6.9-rc7 and that identified commit
52a6947bf576 ("drm/nouveau/firmware: Fix SG_DEBUG error with
nvkm_firmware_ctor()") as the first bad commit. I then rebuilt
v6.9-rc7 with just that commit reverted and the problem does not
occur.

Please let me know if there are any additional details I can provide
that would be helpful, or if I should reproduce the failure with
additional debugging options enabled, etc.

Cheers,

-- Dan

