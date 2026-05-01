Return-Path: <stable+bounces-242438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH/pJ9yz9Gk4DwIAu9opvQ
	(envelope-from <stable+bounces-242438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:08:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6794AD185
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73DB53017243
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9339E36308E;
	Fri,  1 May 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="H9JK23w2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA73382F03
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644434; cv=none; b=ASEtyEgI4eqUSpMYveyOTzXW0b1fVweV5SFm8XKqO5GMPgTh+nBunGcN8c+HCiJRtvXLvgUf4LS2pvUFYtkGmsLv1Ab7fijiQKTIuhBkhFqdesGyTlBSMBmbRrMY5QiAKOxsCCs2r1r1NBSDRwDwrF2SWq6nUHCUGmyoTm9yaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644434; c=relaxed/simple;
	bh=OIw7SHXgAUpM6Q3eBADiDY+aAWncPObokvY94Qwnw3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq2LCgVQEf78nTUwu8LVRaxIRMV7BB/WlirlCLSzoEU/gvPXyseIsmUIImVYRo9uDIcCePtHOrXnTbOxr/rMZboyIf0BwhqhlJBQ3jA67k8aC+nY6YecxTFHGLsE3nUv1jHPaWnPAZsaSFzqpQ+GuNWjNswM96ql/l5JEOUr+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=H9JK23w2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479d5ff103aso940045b6e.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777644432; x=1778249232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+SdhzrztXQ6QAaa8HoBD4WuuSZSbDaOAnRCYF4WYeo=;
        b=H9JK23w2FNc/ehLXMsvh7gacaV7JqNGr/epsQu514Qhq+LcSjUPOLTEgOLeOfmfQBj
         L2iHCgB/SfcVmJR3Hn2owhjMDgv7Jlivbz06oDa1D+uDWccrVrcZSXvMiL16rWik3jeQ
         n7zC1+sb2rTNOBbio5MmevYZ7bczA0+7c+o+BPr5O9N/xmTAaK7RA0IUJ3QGDJ502guN
         /+UCrF5sSQP+SSVVbxadyF+czYmbSdhFtJ7VwONSYvmYcxoJNDb5IT/IFH+OezmrIqMN
         v9oiIQQl6NgKlXKUtUKAST4Gdosc3yJzOILEAo+bvGv4ETYXaWu6+eg+D6BEHJY4+jIE
         TNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644432; x=1778249232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+SdhzrztXQ6QAaa8HoBD4WuuSZSbDaOAnRCYF4WYeo=;
        b=HdvFaXFcfdsIkKOA3ChpGBUa/FzoR60zjv9H2o63iwXSC3qWdIkuaFqU3jbeSidJWU
         7QRAzZuONenBh+1AylcL8pBnjGraoc2WfygV6ODvAamM7NJD9fjfxeZgdItJBxw+7cWu
         5vd/IP7MneeX8CWF6lIHHpaXEPc/nwAfNI2XGSpRzY563t/c2rxAc3Aq/SHJZirx181p
         3eFb69FPACczGW4F4Lg6Wj8gwV77r+EWj2jFc1+DhlN6NITr3KgesB1d63WjyvXH+ShK
         vP6YsUNvqyfzEdivqcOBzmJbpyGcEFERWL+f+jGscMnBpSWLKmSkEA3CiuXMQsDAemg3
         f3eA==
X-Gm-Message-State: AOJu0YzhUwusKdBqArJgF/RuBIJS8lBJ0K1+/s51zGoWS0m6ru70b0KL
	wBKyD+M12BFJng4jJK0gpubBKek0BCHMitMvVDWlkvDHbwCoybanYFuKLUfH2RmC9flS02VYz27
	lPs6z
X-Gm-Gg: AeBDiesjYmkto357O0CyU5UfXUVldIPskowdTWdx+rcfehf1rDZAavW0eFaKsiynJZF
	NNjgtU8Gk3YoKGwAmzduFN8p9vPa9yFO/lr0Un+VSR0VtiY0Bv6zAuM5Md5eCA/7ONTsuq/AqNp
	gN51g3DyFcx94WPn/urHBRprG4Vr4LvVxX4ELXGhpXPdAFDLVKz8pS+MNxJtfnNQOv4iyA01VJK
	rV+Gw0iKGyniq6Y/2mCHfjBAfTp4gFGot8a2+z5P/pyY3e6eIA99k3gy0EgdQ4zCX4cY2881cdQ
	AGwRUEMOZ9WAhsou0t9o/SUKrUKC8DYJnPwBHaoFJLYnBpu/udjbJlENYtxj3o/DI/IJKr0dv0t
	qglL7yA9kEIAyloK9ftg7Ls316A1NxDosjk0AGGGyQwCAEZGZrp13qq33y3YsN3QpWl5hnft89R
	pk03NXqxno7wAdz/Nb/dEFAi8uz/XjrBr4TfW4c4kd2lMHPzs8jt3jT9G5A35Mcj2YwTjUo8vAo
	Jr4jYZWQgBAilH9
X-Received: by 2002:a05:6808:3026:b0:46a:72dc:28cc with SMTP id 5614622812f47-47c60dfb987mr3693811b6e.1.1777644431719;
        Fri, 01 May 2026 07:07:11 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-47c76935904sm1342991b6e.11.2026.05.01.07.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:07:10 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 6.6.y 2/2] ipmi:ssif: Clean up kthread on errors
Date: Fri,  1 May 2026 09:06:58 -0500
Message-ID: <20260501140658.707484-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501140658.707484-1-corey@minyard.net>
References: <2026050147-kinfolk-perennial-0e04@gregkh>
 <20260501140658.707484-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B6794AD185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242438-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:dkim,minyard.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hdu.edu.cn:email]

If an error occurs after the ssif kthread is created, but before the
main IPMI code starts the ssif interface, the ssif kthread will not
be stopped.

So make sure the kthread is stopped on an error condition if it is
running.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
Reported-by: Li Xiao <<252270051@hdu.edu.cn>
Cc: stable@vger.kernel.org
Reviewed-by: Li Xiao <252270051@hdu.edu.cn>
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit 75c486cb1bcaa1a3ec3a6438498176a3a4998ae4)
---
 drivers/char/ipmi/ipmi_ssif.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 3c4aa87d6bd4..6665cf1891b8 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1268,8 +1268,10 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread)
+	if (ssif_info->thread) {
 		kthread_stop(ssif_info->thread);
+		ssif_info->thread = NULL;
+	}
 }
 
 static void ssif_remove(struct i2c_client *client)
@@ -1894,6 +1896,15 @@ static int ssif_probe(struct i2c_client *client)
 
  out:
 	if (rv) {
+		/*
+		 * If ipmi_register_smi() starts the interface, it will
+		 * call shutdown and that will free the thread and set
+		 * it to NULL.  Otherwise it must be freed here.
+		 */
+		if (ssif_info->thread) {
+			kthread_stop(ssif_info->thread);
+			ssif_info->thread = NULL;
+		}
 		if (addr_info)
 			addr_info->client = NULL;
 
-- 
2.43.0


