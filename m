Return-Path: <stable+bounces-245210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG/9N+DYAWpMlQEAu9opvQ
	(envelope-from <stable+bounces-245210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:25:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3213F50ED7E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38E6307BA89
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900153E5EC9;
	Mon, 11 May 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="hnhqMI8C"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8DD1B87C0
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505620; cv=none; b=QCXYNfUCUzuapNvxwhsctC7G1t7tNJmrzjdTVVu3gDvPC4O86VhK7I5pAnyihMKiGrESdbwdJ91zdD/G7MWl0THOkC4vxPTi+MznuhHsCSdt4ZCACIqYyueUxbSZTj7r6JUeheHh9H6ut8UjeP59y9tyGRo5RTvNENbGzUrVVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505620; c=relaxed/simple;
	bh=GJDw0Vr/GXAJ9CXhMxW/CsDAlu40dEkdLD89v1rzEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0RfgAEHYpGY7inST+ZpQ/he43fuwEmqqcr9IW5x7WrPf7i94vNHcB9DLDop1Kqv20lkKNEpO0gBEMfwm7eE4MthZ3x74vU4FuEBTd3mIRhDrNWxyQZkJvVeAPCZ3nVcMw6drUUpfiQojHY32Rf8N67h+QJwUJfnbEuWsnUNmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=hnhqMI8C; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6949831a7bcso2236003eaf.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505618; x=1779110418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krd1iEfXknLd7NaueCbxakH3PI/lvcnloEK4wgXwWPU=;
        b=hnhqMI8Ct4kKvbjKxJ7zDUkxj7vX5ZfEJicYkGLlWXQbRz+541vL2gElIozNCOJDEp
         aIiLRmjpK3FVxXpjQyTX6g1DtJok0a057n0azboCKFIe6GD+q0/Le7RbZNPyLRg8GDvM
         EWPbkUOuKpsVe/o8NkqiVpPxhXEkL5ordWp9ory0jXjQR1/8vXgSht9YARSPut9FqiFt
         y16lqzLln/w9fYj2CRvoTOxOhquqXaGB1E4KpUDMZXMrF5YHLyWiDb5W/LYXje4vALFb
         8zD1XbafuwF7M1Q+mvhXIXBMyDRReI29xjIRkexUVoducN5FAsUzRVXJPCwgz3CsCMha
         F0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505618; x=1779110418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krd1iEfXknLd7NaueCbxakH3PI/lvcnloEK4wgXwWPU=;
        b=K/Mo8pTfLsAcf2DuxS2X0nENyOXeV0uWdJXK0YRpOIpTxx1NMyn2TzC6Gb+fgjLj+n
         1UJGsyKd5cEiKZ3I1X9VyIOGXaxYJrGIqBOUN4tg16P5ZEZfNs7ZZ3uXaGnKDZ/hgmbd
         uiOdBlXtM7Ts1QMstnnQUbtek7CM+fyS7RFGIprrFVLW1UjC3NmbHIedAHbexlJnCJaX
         09OnUeYc34LMFHdD6zPkH6f9/xlw1XpYTnbG77HE9z4aTVcaL3xs5/eTJlRlYdE33OqO
         yVUpIeXoitg3SD8fJvdge0XgdJ3oc5MB1CCJUyh6HCJ50sGGVPz0rNG40wZoG1yoRzih
         OqQw==
X-Forwarded-Encrypted: i=1; AFNElJ8RvxhFOnHJOfMAHqQMHX4hUAlCHlB+ziVMJRsQjmx6lz++/Lqd+s1qIz7kgYt5wiFZH2iOud8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2enPrMFkR2C88/u9ew1bVTj47yKJmojmCY0SXCD9exUKaYdL
	g5Ft7Z8/EHIc0Qt9D40yfuPuuiy2XxPx9HPNiSqwDKzaasCiNzAB0CUmyvCJnjwrZ8Y=
X-Gm-Gg: Acq92OHSmaq0f+vvzDIQq+6p+DQyxnj/adroZvR86mSvt7VDVOcNNsvs8oTvq2TL/ea
	LQKQeRGT17Qc17bc4qutsjKYD84ePfzc0zRpWXfTtxHgZNj3X5eQjEX1OoeJsVoCBWctiA3aav2
	R2qU8/+K8tSRE1ypIoCxbgOo0raH31bfQ1WT9CKSvOiRZwKvacQwFmTBEL3mkJs+D6qtJFFNwsX
	fjESu1UWlY+uROL+0Ny3ooazcemfxNvFo7g5fcbGkKImsgAPDJEpelNc5SfGBN5T4SfpcFCckAm
	Cp+GChw/wox768Mh3A02te3vAImZK/QXMi83c2yAM7c+iVITwI5A+jMYnVzVbI6ocazfBfzkW+U
	uVHKgpAzblgPswpIbMC/u4oKeZn5H2xYcf2D5wDegnWg5Wfz1NLiikmoj3lRVg1SWhuTeXsQgs1
	ibzkK0DhWWrofZkZJFIZJ8jQ/P3E75Bu70JwmHBfF8OMjD9A6J2wGmBpR5WvlusupTVCNBtcfE9
	yxyKdVNFjtQMw==
X-Received: by 2002:a05:6820:2228:b0:688:c97d:bfc3 with SMTP id 006d021491bc7-69b25c88ea4mr7712070eaf.38.1778505617932;
        Mon, 11 May 2026 06:20:17 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-69b25e3917csm5755322eaf.15.2026.05.11.06.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:20:16 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 5.10.y v3 1/4] ipmi:ssif: Fix a shutdown race
Date: Mon, 11 May 2026 08:19:39 -0500
Message-ID: <20260511132012.1831026-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132012.1831026-1-corey@minyard.net>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
 <20260511132012.1831026-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3213F50ED7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245210-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,minyard.net:mid,minyard.net:dkim]
X-Rspamd-Action: no action

It was possible for the SSIF thread to stop and quit before the
kthread_stop() call because ssif->stopping was set before the
stop.  So only exit the SSIF thread is kthread_should_stop()
returns true.

In the mainstream kernel this was fixed in 6bd0eb6d759b ("ipmi:ssif:
Fix a shutdown race").  However, that requires a fix in kernel
version 6.1 has a fix to kthread stop to cause interruptible waits
to return -ERESTARTSYS on a stop.  This has not been backported to
older kernels, and that would probably be a bad idea.  But it means
that the mainstrem kernel fix for this will not work.

Instead, wait for kthread_should_stop() to return true before exiting
the thread.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 30f757249c5c..430302d2da6e 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -513,6 +513,16 @@ static int ipmi_ssif_thread(void *data)
 		}
 	}
 
+	/*
+	 * The thread can break out of the loop if stopping is set,
+	 * and this can be before kthread_stop() gets called and thus
+	 * kthread_should_stop() will not be set.  This can cause
+	 * spinning calling this function and other bad things.  So
+	 * wait for kthread_should_stop() to be set.
+	 */
+	while (!kthread_should_stop())
+		msleep_interruptible(1);
+
 	return 0;
 }
 
-- 
2.43.0


