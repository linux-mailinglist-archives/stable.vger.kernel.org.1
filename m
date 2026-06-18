Return-Path: <stable+bounces-266951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9CC4GYM8M2pe+gUAu9opvQ
	(envelope-from <stable+bounces-266951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:32:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B069CE63
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:32:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nexthop.ai header.s=google header.b=WsBk7iyu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266951-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266951-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nexthop.ai;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5396B301E85D
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B71DF980;
	Thu, 18 Jun 2026 00:31:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3240D56F
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 00:31:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742718; cv=none; b=jpDf+JlffSGVHFGXrhSN67qCr+yUkesiSTxJp8RiQWN/7urRV8boRTuPMJv0QRMP8sIfZFYrxr3yoL4xfiPZAO4H9GpvHl2t+Fxc+PZUxSuCMjKAq40hJ5VQQnsBc1ZwCLYVmQzXSILUuUIHRgF9J/9LIUGVS+1gkVtjK6OlU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742718; c=relaxed/simple;
	bh=ZIG75i7x1ZgmifFTcb9cx0KDK6wjmw4pBXpL+pOY+Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCEV6alurdXVnfrmBxHRQOjlScpDCDkNVaJcXBbRfcPECTohqHLa60VmcAk40niVIvqp4I9GQ4v5wjBoWzcZltECnsS2ubFZZS7VjuQJJE7lC2XcNeYeqSBORMKSPlloaEbz7L4TFib3Msxe7WhOAkwHilVUlaKViylC6JGg2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=WsBk7iyu; arc=none smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3078e0dcd67so401075eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1781742717; x=1782347517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4pgwzoFb0zVAhpm4acqPJzAQGPCDmYkfnYJUCe00dY=;
        b=WsBk7iyu/+2cLRBtnlCYnbnoL/gSN+JQPJhTSa/n/CTcO/V8t2nNHS2yupwqbbSQaY
         kjRSMPPgghadRmqQW6L9QdcNF05Ps8x/u/ksdVv6P6fc+pws22CzEeiMcaTuy4eB+f4k
         1sVwb01AwFdUuu/JypyCGrKvEaCesRtc/Exp02OthUfelxC+Ouj69gm/atuKSTrEYydA
         eJn4GS4zzeqbs9nw6FBglD0CkZYtHmzR9ynDmygd7dnMmK75/gek/4y2KeP4qQJbq2Lv
         Ln+sdpvK1EmwdX9ekL7ufhsQd5AX/jOr9MoIv30Vxc6XsWdXqY2AwFHNFXwE7MIVQZ4/
         8uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781742717; x=1782347517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E4pgwzoFb0zVAhpm4acqPJzAQGPCDmYkfnYJUCe00dY=;
        b=RFrryHxq2alFFf+GwulcKgoZbDxNF/wOdbHxsu3N+KGbVut2bjWtdrpuLi0gN1zu9Q
         ajHptOuJaibQGE4ndKaZtm7BJShNrLKECJJfyVt35ytD4pf+kKMd8z8E4y5yks83iaqG
         lBkSavbPxYGEblsOlQqI2lo3w/tZjWjRgg/YF9riJfusB/9yVsaCuk6Lea9nbOP4ftqv
         BQG21+bbE46MW/wuxOo2DX08R2BSQa99M9jfvqDjpxiJW5AWmgjFduHOhX65KciXba2e
         QtuLCCHT3DDoXYBSwA4JSkVgPYTA4XIJ1bJQmeFj06pM9hQgUag/NUB3sunWWiHVFtHb
         VHMw==
X-Gm-Message-State: AOJu0YxXJnt+WJua9cK/TWNB3sv0cdMbR7UQSMl0ioa6jeAGCx7iDhTR
	6PKre6Nj4mLiO1+tZnWbpQrY1M5bVEbdF3WNFj658oxW7JbCUIENeSBfv1LZL8mwdpA=
X-Gm-Gg: AfdE7cl0zTJJ6+Ieh41eKyMNpTG+WqgM9RxvlhiMv4c35Z34Mvm+3ZysreV+AzoLH2q
	CrgdbV8FaC3Y/mNfnCQDH+L4WMtdh2kxgJbR7/JyNKfN9t8cBbsT2WcqFDJlNeOPy2cq9V4ffSK
	lwQaWz7Q2JdWoi893MlLXzHfr7FVXi8/oBI/g7vzQo3F39gc0BVJtvpqw4alZhV53eu4iY+QjMU
	qwmMYygqiLTmuSdObRUGNOSYqlPgJPqTTm5MeLn6l8379lSjSpvNQflr02nOumFzo9raNek5LJT
	qgtMXLqJO0XfkJQoun4F0TCctC4T3fx1MWC3VzerPRLFTkZm9vG1MDTgugMEPiSp3xNG/Dcohv0
	Z/9uXGgTl83OiA/kdQt3+7xx4cGWoAv4Yo7wAmiHTmsapzyj9z6Ypq+4KWH/plfyvdOerAuydHh
	CeOuipm5wRqdXPUlvLE74Io4Gx6nWqjUZyqw==
X-Received: by 2002:a05:7301:4e04:b0:30b:8862:db15 with SMTP id 5a478bee46e88-30bf097b9f8mr625290eec.28.1781742716569;
        Wed, 17 Jun 2026 17:31:56 -0700 (PDT)
Received: from cave.us-west-1.nexthop.ai ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm27482611eec.7.2026.06.17.17.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 17:31:56 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
To: abdurrahman@nexthop.ai
Cc: stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 24/38] hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer
Date: Wed, 17 Jun 2026 17:31:14 -0700
Message-ID: <20260618003128.3112824-24-abdurrahman@nexthop.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
References: <20260618003128.3112824-1-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266951-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:abdurrahman@nexthop.ai,m:stable@vger.kernel.org,m:linux@roeck-us.net,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 570B069CE63

commit 43cae21424ff8e33894a0f86c6b80b840c049fd7 upstream.

adm1266_pmbus_block_xfer() copies the device-supplied block payload
into the caller-provided buffer using the device-supplied length:

	memcpy(data_r, &msgs[1].buf[1], msgs[1].buf[0]);

The helper does not know how large data_r is and trusts the device to
return at most one record's worth of bytes.  adm1266_nvmem_read_blackbox()
violates that contract: it advances read_buff inside data->dev_mem in
ADM1266_BLACKBOX_SIZE (64-byte) strides while the helper is willing to
write up to ADM1266_PMBUS_BLOCK_MAX (255) bytes.  A device that returns
more than 64 bytes on the trailing record (read_buff offset 1984 in
the 2048-byte dev_mem allocation) overflows dev_mem by up to 191 bytes
before the post-call

	if (ret != ADM1266_BLACKBOX_SIZE)
		return -EIO;

can reject the response.

Contain the fix in the caller without changing the helper signature:
read each record into a 255-byte local bounce buffer that matches the
helper's maximum output, validate the returned length, and only then
copy exactly ADM1266_BLACKBOX_SIZE bytes into the dev_mem slot.

Fixes: 407dc802a9c0 ("hwmon: (pmbus/adm1266) Add Block process call")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-5-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index a7a440c09b52..0fe711722415 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -348,6 +348,7 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
 
 static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 {
+	u8 record[ADM1266_PMBUS_BLOCK_MAX];
 	int record_count;
 	char index;
 	u8 buf[I2C_SMBUS_BLOCK_MAX];
@@ -365,13 +366,14 @@ static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
 		return -EIO;
 
 	for (index = 0; index < record_count; index++) {
-		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, read_buff);
+		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, record);
 		if (ret < 0)
 			return ret;
 
 		if (ret != ADM1266_BLACKBOX_SIZE)
 			return -EIO;
 
+		memcpy(read_buff, record, ADM1266_BLACKBOX_SIZE);
 		read_buff += ADM1266_BLACKBOX_SIZE;
 	}
 
-- 
2.54.0


