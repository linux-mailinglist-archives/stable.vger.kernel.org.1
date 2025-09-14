Return-Path: <stable+bounces-179561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A28B567DD
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 13:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399D9189DF3D
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AB22068F;
	Sun, 14 Sep 2025 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X24noeC8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B057C9F
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757848698; cv=none; b=Hwa4LSDRzy+m4FKLAyEOKxSuA6X+dhyRN6Ydbp+wm+/ftfXn4PQICcL+xKMiCB/5LaqV6D2SS14ubPIqe5ngdkQkB8FaEyfGfYhLX7QhNHYGB+0n78w3a+8/BuBLK0zX8V7Waxte3tvhH/KeuR9ZfRfcajaKo5VVdj3mPvFllaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757848698; c=relaxed/simple;
	bh=pg1pa9Uy9v9AKwdlo0E0UQEwWth+esMuLEydiYarm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ASCo2pbXe6GHivzPgiBIlOhi+RJ9mmnrelSXEWmuJQANLXaaR3kg2rl2c1ZpA+N2TfpbrEjCcK3jiOMdp/mxXyjgIe8HqN3MBVMkJSb8FilXvGGH44RQBlKhiqQikpm2UvBs9RclWwdn/d7B5DRP3BX9rCDpc2PCrC/Hz/cWTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X24noeC8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f0bf564e4so1291455a12.3
        for <stable@vger.kernel.org>; Sun, 14 Sep 2025 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757848694; x=1758453494; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RjK8j3XcAygkTFOC98PeAYyOVsDUZI6XrF0koWdfFHM=;
        b=X24noeC8In9fEi+hNi4vSXvMUwPX3Ps+EZslp4pXpdWdtKFkNiaUjU+0KOqx//Aoad
         1j/YfuWz1Be4TzRKOO1rY3l1GDaAa65Eze+wGGl6lJpcbVTXfmhi8l6HbFBQ7NGv4G0n
         a09M7iWvBYn3LHcMVlhAidWikF+CZhLbg8VbzJF28ErPTxQrFe0qQVIMp9vXKNZhUL92
         ymUADKwOH4rGgoYfPrdGgIZpoKOUXU0NtWIl25RqKTOiJrATGbYI+f+wKRBCPwwJh/O6
         RyHjpNFLss6H8m0hGfFALpQOyn7rcPqP2fLUUvdaukofx2NQ01DNRxR5NsOg64uLjy29
         gZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757848694; x=1758453494;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjK8j3XcAygkTFOC98PeAYyOVsDUZI6XrF0koWdfFHM=;
        b=gOgU/yLg3my/ZSMVg/Besn7WbJmARMqEkamOEMP6xUEMDxI+H9DbUWsnjcVMTRJuYy
         Av4HIa4pkGBmBiSYodD8lyYmKspU0geuQoDGK3h1iNehfTSKCv9NYSgh0w06Aiwf5Nm6
         4tGYIHG3MZMLX7N1b37uYGaF6n8OKt+sLjwgZWrz/QEZT97h/ZkX9a6OpB9/qufOnUOa
         jre9pjuJNKnoVGkfA3eM9YBIXbWns7ZKITxjLgBmkjP2McDza22CoA2gWQ2tfGd0N+fq
         N2vM7Kfpr6ZskP7cErmraOiN+LCkSmuKMsQg41Te38R+cIFBXmc8UF/Wbt8NW629ur3X
         ZxXQ==
X-Gm-Message-State: AOJu0YwHlFLqm4mN8itT4hu+7gvLWqQjFDvMHBM0nlvvSqlzILj/9SqG
	u4HUzcpYuJrYYrCoBjS3Q26TwSEzELWbpXDgsRfU7H3L3UA7luGdakGr
X-Gm-Gg: ASbGnctTbSj5DfbqSmS61sS0hpdVj2RqZdRbEV7cjRkqAfEJdeG/Us2tiExHBqSm2xX
	A8A3s+hAWUhz/DrXNjVQndNuo4ocmKbj2RLQ9UELE0+S+VSmJTUec1M/yLZ0UoH3VhHJqoPUWKZ
	5cHfnUncpv5Mk2v8Hxae9U1ER6bTKQhSYbrwb7wH7TPB5rCEvLOLDQv86okJDB+k38G0YPzX1I3
	gqGX0A1ECM/yA/OHLUbJzcR9KOB01lg+2HeZwYdLTFRmtTzalMZYN8HWBsxIcorvpufXv5XCaOM
	X5nAWDtkCtkKGBcnbvUEaUw0xWug3WFwQh8RfL56eXiEyOLF5L1CUiRWqOx40w8p2SKbFL1QgzQ
	CQjXQo/AccevM70g+R6XWcCKkmkKzVEqhKZ7eShDyhqPBlWdSos0Li1st
X-Google-Smtp-Source: AGHT+IHNU1vcE//OuEp8qD1A0Z2CVeP+2kENyToA+BmMdZE4yxcymB9z5U8AYlqdkiU7g41SSsqETw==
X-Received: by 2002:a05:6402:4616:b0:629:8c4d:6a91 with SMTP id 4fb4d7f45d1cf-62ed822daecmr9057349a12.3.1757848693562;
        Sun, 14 Sep 2025 04:18:13 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f0c7a5546sm2959961a12.43.2025.09.14.04.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:18:12 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5A8BEBE2DE0; Sun, 14 Sep 2025 13:18:11 +0200 (CEST)
Date: Sun, 14 Sep 2025 13:18:11 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Marcel Jira <marcel.jira@gmail.com>,
	Niklas Cathor <niklas.cathor@gmx.de>, 1114806bugs@debian.org
Subject: Please backport commit 440cec4ca1c2 ("drm/amdgpu: Wait for
 bootloader after PSPv11 reset") to v6.16.y
Message-ID: <aMakc-rP93XNJaA6@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hE7nFNJ/IMAwc0q8"
Content-Disposition: inline


--hE7nFNJ/IMAwc0q8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

In Debian we got the report in https://bugs.debian.org/1114806 that
suspend to RAM fails (amdgpu driver hang) and Niklas Cathor was both
able to bisect the issue down to 8345a71fc54b ("drm/amdgpu: Add more
checks to PSP mailbox") (which was backported to 6.12.2 as well).

There is an upstream report as well at
https://gitlab.freedesktop.org/drm/amd/-/issues/4531 matching the
issue and fixed by 440cec4ca1c2 ("drm/amdgpu: Wait for bootloader
after PSPv11 reset").

Unfortunately the commit does not apply cleanly to 6.16.y as well as
there were the changes around 9888f73679b7 ("drm/amdgpu: Add a
noverbose flag to psp_wait_for").

Attached patch backports the commit due to this context changes,
assuming it is not desirable to pick as well 9888f73679b7.

Does that looks good? If yes, can you please consider picking it up or
the next 6.16.y stable series as well?

Regards,
Salvatore

--hE7nFNJ/IMAwc0q8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Wait-for-bootloader-after-PSPv11-reset.patch"

From 6e2bbc123bf09d2f98008722c61d3907f54a0611 Mon Sep 17 00:00:00 2001
From: Lijo Lazar <lijo.lazar@amd.com>
Date: Fri, 18 Jul 2025 18:50:58 +0530
Subject: [PATCH] drm/amdgpu: Wait for bootloader after PSPv11 reset

Commit 440cec4ca1c242d72e309a801995584a55af25c6 upstream.

Some PSPv11 SOCs take a longer time for PSP based mode-1 reset. Instead
of checking for C2PMSG_33 status, add the callback wait_for_bootloader.
Wait for bootloader to be back to steady state is already part of the
generic mode-1 reset flow. Increase the retry count for bootloader wait
and also fix the mask to prevent fake pass.

Fixes: 8345a71fc54b ("drm/amdgpu: Add more checks to PSP mailbox")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4531
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 32f73741d6ee41fd5db8791c1163931e313d0fdc)
[Salvatore Bonaccorso: Backport for v6.16: Context changes for code
before 9888f73679b7 ("drm/amdgpu: Add a noverbose flag to psp_wait_for")]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1a4a26e6ffd2..4cd37fe96c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -149,13 +149,13 @@ static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
 	int ret;
 	int retry_loop;
 
-	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
+	for (retry_loop = 0; retry_loop < 20; retry_loop++) {
 		/* Wait for bootloader to signify that is
 		    ready having bit 31 of C2PMSG_35 set to 1 */
 		ret = psp_wait_for(psp,
 				   SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_35),
 				   0x80000000,
-				   0x80000000,
+				   0x8000FFFF,
 				   false);
 
 		if (ret == 0)
@@ -399,18 +399,6 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 
 	msleep(500);
 
-	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
-
-	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
-			   false);
-
-	if (ret) {
-		DRM_INFO("psp mode 1 reset failed!\n");
-		return -EINVAL;
-	}
-
-	DRM_INFO("psp mode1 reset succeed \n");
-
 	return 0;
 }
 
@@ -666,7 +654,8 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_get_wptr = psp_v11_0_ring_get_wptr,
 	.ring_set_wptr = psp_v11_0_ring_set_wptr,
 	.load_usbc_pd_fw = psp_v11_0_load_usbc_pd_fw,
-	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw
+	.read_usbc_pd_fw = psp_v11_0_read_usbc_pd_fw,
+	.wait_for_bootloader = psp_v11_0_wait_for_bootloader
 };
 
 void psp_v11_0_set_psp_funcs(struct psp_context *psp)
-- 
2.51.0


--hE7nFNJ/IMAwc0q8--

