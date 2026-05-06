Return-Path: <stable+bounces-244298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B8bMNul+mm7QwMAu9opvQ
	(envelope-from <stable+bounces-244298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:22:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D6F4D5A05
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 04:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF9130238CD
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385B279DCA;
	Wed,  6 May 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="h8Gj8uGB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A5248F72
	for <stable@vger.kernel.org>; Wed,  6 May 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034073; cv=none; b=dN+ifBj2x2eI0gh6lB2Kzx7+YUFRmyP0JWoB2qYbPtKqMnBSOvm/PbW0nB35szcAY+FiyJ/vfkJWslKTOyT1Q+jHbMTccoUy1tkm/XzfCg2UFzP8ZQgxSDK+NyAohQJUWOe/66wcvGQ/UMoQau8ZGDpGryABGT5Rt6sncsEDv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034073; c=relaxed/simple;
	bh=Qub8W5DOuGrPZBNbmzaxGwvAExMQ3iX7VoPqndSPXk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmtR4Cn0aylpJr2BrK0VTKTezQUvtnXDFRTnp24SLwxqyDjy2LH6Nv7s5OfnT6PLTr9T2uoVZn+z0oSyW+lyHS+j22os+T/6Yf0a/RR0PbjlHaiQBgp/9Mxwp3bEjrgHC2lUoufwLxMo2uaFDY5ln2izrgYFNcpR2Fn4mXhb2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=h8Gj8uGB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so5750544a34.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778034071; x=1778638871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJQM2X8ovb1SBk8hlI549WELVH79VMa9uCDGa279uNs=;
        b=h8Gj8uGB0WBDlXgXh04LPvDIEh10nybz0AS4Mi8my3DyJ0ppwG/lxIFZwmxoVfAT3h
         RE99sfehbg6QJ2PK/ImQ2Z+tpzzQ9BrNmhnopyNry/+0RNmdlE1n8X6zcZHpDM0kFlD3
         qq3+qtF+YZBHKjdvm7Cvq085fRAyjemjk+k/YNy5KTTgvhElOkbaNuVWtz29BJKBxFwG
         hzNOiUfXJgwpP/OTsJXWP1WUShKKYBmuk1fjpyVoXSa1EyOIg8RLOpGLCCeOoE1N28Ad
         NYWlannBCDo+Tfg1BvKisO3W1KjJeod2i3/FBYSgCkA0hxvCKxKrj04c9VkvVhagoxCD
         pQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778034071; x=1778638871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJQM2X8ovb1SBk8hlI549WELVH79VMa9uCDGa279uNs=;
        b=OrfjKpeD/CEqJxMaT8Et58UUhH3CuSrezZaUtRt07NpLnkfKFykDkNCXQ6BETZUSZW
         gVgwnesVHmJnylICE3fuDQJYil4hHb5dx4wZqAH/2IZtEQE7F4L+VDo50MNS7EN4L+FY
         /pTH9KTcb0SGhKonXrDBzEfvQ1HaIAsRDwhSOGW0nq1fkYf2nSkTLbnzVMG2QcgHGsXr
         SbtEzPW8X4JOjhp9sZ4z4HXC44ZaYhSUDsofPns9HizYL92Zml9CPQWaxISRFD944T9n
         RFlbYIbiFUQPH7ctLQcZIorTPvzWflqgUDUaYbQ5hA8dhWdAJ41mHYXt0RBPFKKASw7+
         utiQ==
X-Gm-Message-State: AOJu0Yy+ms3OhVrInnCkOU92imt7r0GlSkPlNdN7OkY936haJdwomipg
	jh5m1FdCP9Li1BKp2aQ9cR5Z2jRq1PCsgApKGMTlFe3uYvwrrbqixYRXhR6vVc4PyXBhPXwM0P3
	cin80
X-Gm-Gg: AeBDiesOGQE7Vj/Q6TP99KeV8YseB/dWhjsPlmpqK20B2Nv+2XFOe1eekkdD4tnu2Qi
	6gswyqUZIVHeK+PYRFfm6fKuAoBgVDwNhVujDtkK/dwe5ocUZ19bFeLbOsxsC3TpuOO0Rfp0i3m
	BHncP5XRyKX0u23eojr9qVe+Sa7Dk8ZN+43g6m8ralKzDW00AIiNioYI1wmShE63WIU0N9ANYWr
	5b6+JgFb6a+btgl68ZdrWKWBWaOp74Qxcisyd05bpi970LHC+KiwaNWdgxjieXqq9fc+myPDKjg
	H6niWP2Bqz+7GY6od4AboB57/iEzsZWvLugZt7M7PLK12NfK+w8Opa6/fLZ1cRAhYgh/cFsDu8r
	zBAMiTVyHjeoa94RRfYgLowenj2sXESEFwjqj6Zgc5wt8qcOVNmAr8wXa/kKEXe728uoKGBpdX8
	+DNG8GZ3ELxYIABNtOutbwskJodbV2szel4SenzeqkKmraj1VfSJkU1PgtBWEMduPiTJyIqdf8M
	QmNXz/0VyCN4w==
X-Received: by 2002:a05:6830:3696:b0:7d7:fbe5:e9b3 with SMTP id 46e09a7af769-7e1deec4f0emr877853a34.3.1778034071590;
        Tue, 05 May 2026 19:21:11 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4a29:1d2:a1fb:6ae])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7decac2633bsm11011112a34.16.2026.05.05.19.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 19:21:10 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 5.10.y] ipmi:ssif: Clean up kthread on errors
Date: Tue,  5 May 2026 21:20:48 -0500
Message-ID: <20260506022107.1469501-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050148-irregular-kite-7f24@gregkh>
References: <2026050148-irregular-kite-7f24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25D6F4D5A05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244298-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:dkim,minyard.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
[Adjusted for stopping flag and complete operation still being present.]
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4)
---
Version 2 of this patch, not taking a patch and then doing the fix
for it later, but just doing the patch.  The fix for setting the
thread to NULL on an ERR_PTR() error return is already in the main
kernel and should be coming to stable.

 drivers/char/ipmi/ipmi_ssif.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 430302d2da6e..b884bfae7fa6 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1292,6 +1292,7 @@ static void shutdown_ssif(void *send_info)
 	if (ssif_info->thread) {
 		complete(&ssif_info->wake_thread);
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
 	}
 }
 
@@ -1922,6 +1923,17 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
  out:
 	if (rv) {
+		/*
+		 * If ipmi_register_smi() starts the interface, it will
+		 * call shutdown and that will free the thread and set
+		 * it to NULL.  Otherwise it must be freed here.
+		 */
+		if (ssif_info->thread) {
+			ssif_info->stopping = true;
+			complete(&ssif_info->wake_thread);
+			kthread_stop(ssif_info->thread);
+			ssif_info->thread = NULL;
+		}
 		if (addr_info)
 			addr_info->client = NULL;
 
-- 
2.43.0


