Return-Path: <stable+bounces-240292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FbRLeZ+6GkILAIAu9opvQ
	(envelope-from <stable+bounces-240292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:55:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CF44432E7
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23FB33010B87
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345A373BFE;
	Wed, 22 Apr 2026 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE0e+G7k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ACB372B4B
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844110; cv=none; b=DD20eZTkQNoXX0viz8oUcyBZY5SSo/BSKGUTuqnEGBeYj3Sh4j2/ETVIcTkLQVsTdsphixFkLEK4PcWbycrAr61KVgsMkvGji2hqRSTxOqvzYXBQSJ04IO7gzEiT4BVxa2u9X8eEmC+eTiWMElspdrXirLB+NffWaq6RyQ6GY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844110; c=relaxed/simple;
	bh=9QmZJk6nNP7BmBhjWjz5dh029aLvyN18dDwM1N0VeeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZlZMDkzX9mLRAGCywPRo6UnGwnt5tkmnNCFp5+5fBbXeP7K50H0kMP7kt1z5RwtVFw75JMqMmfO4zPwskpoGW/Riaag2ejJrubuRDwiYj4BtpiYbbaqrMOZPU0q+WJ/+djHssVueAka4rg+3ntVDSfEqsFYftBK44m12JtUk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE0e+G7k; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2990866f8f.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776844107; x=1777448907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G30wgWfxQ2XefhTFiNX7NVklFXAUvDTePASFRoNn3hY=;
        b=JE0e+G7ksK1NunMu+sv8WFiEOZOuPBY7fKA5lM99Iu/WuE4OJA0gpJz42JyTZU0ZT/
         /HXNGxjEeeYAtKvpIxMcHPFlCTkGLJLiI7oUB9AzM00TU3T8BBlpIsAgIlSBPbdVgHBK
         BjDpbI5VS2SJGtwA4TqVTI1aENvCj2Ji5wg6GnsDtn9IxNsu07Fgt1Y/mhN4F7Zb0uhb
         N9MjwGxQ0fWt99J9eR1B4grZ6hWSx8GJclXESnTpSjZ8292DrdXxEU/ZifMyoCA1DCXN
         qAT2ESbjUHVGb9TAVgUDoXTji5jxma3q1cGuI6dBXh6E26cV9CTc6pjsk3/qSjM379Sj
         fiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776844107; x=1777448907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G30wgWfxQ2XefhTFiNX7NVklFXAUvDTePASFRoNn3hY=;
        b=eOrcKjFva6ElPZ1QMdZW4BBJWlwW1VIxEVyYPhcYNqI4Q2SQfUpaaUbHOGjGshfMpg
         12eKvsedbNO32DPHI1IHbI9HWhnUqCyHlnmMBuARPI4bHjuS+jCiaUCWCfkx3uZa94Q3
         r5c8mlcllUZ64DX0uEGUeNcVst/DPknC7RYpodYlH0mgc6FFVtFLODz7BlcOcGVCPFHK
         iToT1KJPGYOm0e0jrpnS5W00VwGLAYw4IHKD4/IQCe1uwyLKgxF3q8c2St1Lajlyt8Yo
         67YrlkrC2YAZ00S/T+r7xqXiFIRPg44VUkG8Nrf45EVhD+1oIPs3zxx7WpVHGPtuBEZ4
         6azA==
X-Gm-Message-State: AOJu0YxdE7mAi60zOqdmSQSbM3EPfDqxxECCx39tN0yy1cs53kNSDzTI
	kuhlQrct0i1slX1u58nx0Y4tP49ku3roQh3nDh234Hr5qfOnOVqnyESB
X-Gm-Gg: AeBDiesslyys2Oh/cEJoTXVjq1u1ZxlPS/fb/PAf8Ril3/mZZUzUmBQzbwPFNK5FT0C
	4ax+s2ZBsKV0dcs+vwihHid58usmO4i8PL3qrJb8SrnfCAyBtB8w1Vr7LMERA2j3/wsHFH+Cvjy
	ycZ+XMb214ZEJl20sY2zBaaZtwPy3EslHnvzCyAVU+h+Dt8kew5ZhIIlo4ZN4cRH9E17oxIcAkc
	CDjew+5UowRec5NMhDOI2Fa6JV9iFQjeeZR6OvFuILIL5e6udvtdrMIbZJlZi2c5E8eVMVUVRCr
	hQu4WzoZJ5A47/pHgnaNdM2VKRfAq1wSAryB0AyKZ3ea5yN73HgIv9Zy27td4I3RpUuhOUojWvl
	IMtenWLKOQJMUkkLqoBUsblZziUUrLw5ohwKG9MmcheDcMkEbPDnotfeyWvWNMHtXrRbqg/lpej
	kAdyPQDp312J6V2r0liIghjvav4SdOOSWnVRwIXxJJzJX4SLgbKw==
X-Received: by 2002:a05:6000:1a8d:b0:43b:8806:be32 with SMTP id ffacd0b85a97d-43fe3db3b49mr31960085f8f.7.1776844107067;
        Wed, 22 Apr 2026 00:48:27 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm45476509f8f.27.2026.04.22.00.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 00:48:26 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH] gpib: Suppress setting END on error from NI_USB dongle
Date: Wed, 22 Apr 2026 09:48:07 +0200
Message-ID: <20260422074807.3194-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240292-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20CF44432E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The NI USB adapter sets the END bit in the status word when an error
occurs such as a read being interrupted by the setting of ATN. This
happens for example when a device clear is received from the
controller in charge during a read.

The common driver changes the error return to 0 whenever the END bit
is set in order to avoid errors such as timeout or interrupt to be
reported after the full message has actually been read. The behaviour
of the NI USB adapter in setting the END bit on errors was causing
actual errors (-EINTR, -ETIMEDOUT) not to be reported.

We avoid setting the END bit in the ni_usb_gpib driver when an error
is reported in error_code of the status from the adaptor.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/ni_usb/ni_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpib/ni_usb/ni_usb_gpib.c b/drivers/gpib/ni_usb/ni_usb_gpib.c
index a24cd6521362..b1f63c81c259 100644
--- a/drivers/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/gpib/ni_usb/ni_usb_gpib.c
@@ -720,7 +720,7 @@ static int ni_usb_read(struct gpib_board *board, u8 *buffer, size_t length,
 		break;
 	}
 	ni_usb_soft_update_status(board, status.ibsta, 0);
-	if (status.ibsta & END)
+	if ((status.ibsta & END) && (status.error_code == NIUSB_NO_ERROR))
 		*end = 1;
 	else
 		*end = 0;
-- 
2.53.0


