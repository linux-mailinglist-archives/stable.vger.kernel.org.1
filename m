Return-Path: <stable+bounces-56085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7334D91C56C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 20:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5821B24E13
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CDF46441;
	Fri, 28 Jun 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtc1yFUg"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829F21B94F
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598075; cv=none; b=uApdistDaVsQ/9TpUFmuq3EuRsabnVI3PePL/QbZQUGp4Wozeg/D1f4Y5xGLRCFLR1Vc27Gj66l6gx28nHySw8TYq1Ok8cmQhOPrxJSW5FDkPlCZdVVd1KN5QYe+BfT4gzonINYYHEzJy9AbzOsEFV/X70NQY8Wlg35kTwiY0Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598075; c=relaxed/simple;
	bh=KyfcMeNeqKElnODem4wkulYLOb2bJUgjz0mqiXMtMBI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=L0sBehSn23cfOk5nijSXExNqSKjGtKfw7sXtSQp7IOdXcOm2YeOi2OYi0yMbVdAcUm7ajUpHH9KE9eaO5Wgjz82HKewjHhYi5Muw6K5UyZ0NNGA+10V2PbUDu1VAQg+W6Mcq3Gm9YQbPBOLTpYSsQdGyyx9IvR0q9lgGCp8YHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtc1yFUg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-376012bcc33so3998685ab.2
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598073; x=1720202873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULZ1Tsj9d03NTFx3zSTqx/lnRuDyqw7SgKAhFNR/Yp0=;
        b=Qtc1yFUgzGbisu1mrCQQPsG4wRizSiKbE0tmr5cm85UQMizBFO9i3OBZcpzpi5XThO
         VcwDDkrXy2jFTSSqzGMYeejW77bl8KrPtNlSkAomkNOiSdG40bpP7djmuFI2x630qdeQ
         iw2WyL0+vl06CEIXKygs98RZzDaFB9GSMPupD6EQuNPILzcmEjow/pjSo4CAVoTycXnc
         O/ygjprpx/xb4UaieP2KnCVrSJeVSFLoYhggePdVQc3nxBoUg+uNOcuYCb4V6Lm3q7gg
         08jh2nnzD1OWAzkj81MZJ6fqfOGMUyEOy5cPDMjZDYHuFgQgACjwtBqD+Lp5G2Fw+Zfd
         jolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598073; x=1720202873;
        h=content-transfer-encoding:cc:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULZ1Tsj9d03NTFx3zSTqx/lnRuDyqw7SgKAhFNR/Yp0=;
        b=Uo9fooHMLX0OSA4tVj/S1jFtZHa2Fpd9rf8pt6EkrLqNQ8eAU3SfyVgIsVeHnjjbmm
         0ph8qgN3D1Z04gEb/9veRsVF9W3kUZh4Z0uouC+lm39vzqN0/Nedf07t2BwWjzOCtnAI
         k4yW4mBM4fqebxPR4krDuet6kbwO95S7liUO6TWb+F2lbyYza+eKifEqOBIh+QfRE/6U
         Cp3Lpy07WGb2khmWv1PtkGJLM/BZ1NO4FGOItKnZZwJtlQ7hABhBgf22pBBJhap2Nyuk
         ucSNc4VyiMsexzXVDQ+DWacxHjkyjyCBxZ1bGZ1Dr1xWqaIYkew2WGHQ7qycBf2if3nq
         Wrkw==
X-Forwarded-Encrypted: i=1; AJvYcCX8aLsESGhMLMuY0LPWa21qItfZUUZTFuJpxVc9GH8Xsy3jqOxm4yhET9I8OLEoKYV2P3W1QSz71HUae/Tb69R6g0J62YW1
X-Gm-Message-State: AOJu0YzbrZBIkPjDJxP+8PuFEItOD8mqljyGhjBSuGaO5TB2GGrE8nBQ
	kss+OSiD3HYdfhFsGMLy91OchwbBqVgs4DigxNM5Arg3V/0/LT5I+U3E2tkc
X-Google-Smtp-Source: AGHT+IGFcPS9puQ9ja7KDI0Yt6cju0TLyfpQNBIJMcTpRTRK9xAtmExiqfGX+nVSzEVhpjkslBEtGQ==
X-Received: by 2002:a92:c241:0:b0:375:9d6d:12fc with SMTP id e9e14a558f8ab-3763f641476mr203100865ab.19.1719598073592;
        Fri, 28 Jun 2024 11:07:53 -0700 (PDT)
Received: from [172.26.252.3] (c-75-71-174-102.hsd1.co.comcast.net. [75.71.174.102])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad29827d6sm5307495ab.32.2024.06.28.11.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 11:07:53 -0700 (PDT)
Message-ID: <54398cb8-92e0-4ed2-8691-38f6d48efc9a@gmail.com>
Date: Fri, 28 Jun 2024 12:07:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH 6.1.96] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
To: rpeterso@redhat.com, agruenba@redhat.com
Content-Language: en-US
Cc: cluster-devel@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ Upstream commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 ]

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

The origin of a cherry-pick conflict is the (relevant) code block added in
commit f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")

There are no references to gfs2_withdrawn() nor gfs2_destroy_threads() in
gfs2_put_super(), so we can simply call gfs2_quota_cleanup() in a new else
block as bdcb8aa434c6 achieves.

Else braces were used for consistency with the if block.

Sponsor: 21SoftWare LLC
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 302d1e43d701..6107cd680176 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -591,6 +591,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));

