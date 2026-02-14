Return-Path: <stable+bounces-216466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id L6s8DwT+j2mxUwEAu9opvQ
	(envelope-from <stable+bounces-216466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 05:45:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9D313B132
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 05:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2B7F30074D6
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC92F6193;
	Sat, 14 Feb 2026 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkjg9ed8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA32F1FE3
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771044350; cv=none; b=lTnZXDig3FH6aNL6DJ2RynHzhzXHV1NlIwkPZtKFmv9+/aeu/keFRiUHsfdFCtr2ywkG/KVMCaYWGbELV3f0X0rY1BF8I7tFueQra6J8VX1UdAlBH8ll1ysHyP5FnAYdv6LgT5GrTMD90odXEcH8xLupSKsiHnikvd3J+Au7zNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771044350; c=relaxed/simple;
	bh=o/GV5jieQ1nfLMF3Kw74P6li2KB/ycvzwnF/hdIeyP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe09YTG6YJFaahP+iCT+S06IxTQrgqUWDQUbjJd+5ta/+/DVNWMvrN8gMP0CHINSwdESbwqSiC7bVU0nNY9UM8Ocm/vlvZlTLgwzlLOqcNjdQZJuqDjEYSe7wEJ59vLLykbZGnJPH55Amfe60raubxLw+hAV61txWYb3+X335lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vkjg9ed8; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ae222d978so1542548d50.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 20:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771044349; x=1771649149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R43m5m1ez1GonWOxLG/dVD5h7A9CUwXvLk5pXGze70s=;
        b=Vkjg9ed8CNNTXxgQ+ueU8tL2WddHUZ3dIR86GTMuuYRXSNMrQoENP1TomfwD+AKqmR
         eAmdyf5ZqtCmfWHWKTtUmztOKeL4lX4qAFNcEhBP5Pnpg5j9hHRBnuvQcgweG7I8z3a4
         TKDSUbI0gzvBTsczVQdrMIxfxVAUBDtoY08qTGGEPruNU2rnIgJnOTfRdP7ICdc5JtLY
         JSI76AX3sm6W280/tDnaTLecOLhKBebfG6be3UwanAYyDE+TWXH0BHF8tCidEt0SYsC8
         eFcqJSAcbRqJo3m/bH0m1jJmICGA/jP1+n2eRIZChigu9USecD0lPXjDnAKnuXpF5eq7
         i+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771044349; x=1771649149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R43m5m1ez1GonWOxLG/dVD5h7A9CUwXvLk5pXGze70s=;
        b=Gr/lJrA0XHIZOwlDL2bbNaA8zkb+8FgXAwaY2Pc9uJKmdRcGAZ3YPfMz6G9Ob3lfwM
         KaMwC5shkbbwTJLqixW3wOLK2ZgYJDcrYUBlAe8CdBYqm7uUkTeJo872Ck4ShBHWBoMX
         RQ0WBsB71gROuXVnPsNWMKqCcoNv47Ntrdq1ohMwxcqHCnJbu9RQknS3S6HiGXIiIGUO
         ngae/D7Iqg2kXvevndwhr+tSGnYSs2PXIlcKQvVzgG8doOJOQj1Ytn0e5rqDyYyOJnf2
         AJRQVkNcxiMBxcr4mSsyAN0ZaPrP8ET+U+rHYwq4dp4S3cDFxK0yZtsLTU1g8XPwvOQA
         bFrA==
X-Forwarded-Encrypted: i=1; AJvYcCUzVPzLEt5Lbsy22FQhgdC7ecfXnp2sckzMO9a46FuaCTBlNECLfDv17C5LJSAviKmxQFdV7TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQ7oweH8fhOQDHG1YacFjDv1OfgK8poi33/Ss/hPVzZI7+Kfl
	btxFnJcRn6ZWCUaX9UCgwre0s5B00Kp4ZIuPgtLLErVg/pPiSUVqpgoEEigyZRQp1iA=
X-Gm-Gg: AZuq6aJVkJ+EzpJu1Bw4EmMFGw9d8YOH0ppgp59xtep8vH109t4G6s8CEZl9WStMOF1
	1zgQB92gv3DsQXFdshg1p/+RR5vvhl3c7nAzVwMzVKeXDYxYbdHsa7HdS59JKqGBwQfnACBMcpe
	7x04JKHgYhjjQGmfaaJWX0VzuQXroJsPsLkWvbpkv9Bm5I809vjUepmohowGTRl0O0sGNCMGeiH
	E/lvrKdKKd3V3qMQxhCSe/Qb8i4UxII7IAcIJBfdX/925c7WC4KOYyrkNCW6z3VHC0zea7qiMya
	+lg4bqTTebgdQ098XPcfqVn5yzK0EkZ0Qwq4LGBXx0KF/NKNNQkCJLd14SPoHMYA+jxdwv00uz3
	/QjZpy25Js+owyQLyM3Tob3nsnhWwAAiFGgSDlFU+K35MzDCPgwDu126QMqR9K50ypqhRPJbiA8
	/L33vP6Oc3pDWAYpLZ5NtpVkYH6/Qw8e5K+UDI6O8niWiafJjN2P4I8JMKtML2IFWpQpAQlyUnx
	0WONJ28Z85mQNsDrwmx82CxC0OSvbaEuPXOwDxg9CV4bsCLfSy3iQ==
X-Received: by 2002:a05:690e:14c9:b0:64c:2114:17a2 with SMTP id 956f58d0204a3-64c211418c1mr1742970d50.62.1771044348735;
        Fri, 13 Feb 2026 20:45:48 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22eb2059sm570067d50.10.2026.02.13.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:45:48 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: nomadik: Add missing IS_ERR() check
Date: Fri, 13 Feb 2026 22:45:31 -0600
Message-ID: <20260214044531.43539-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-216466-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D9D313B132
X-Rspamd-Action: no action

The function gpio_device_get_desc() can return an error pointer and is
not checked for one. Add check for error pointer.

Fixes: ddeb66d2cb10f ("gpio: nomadik: don't print out global GPIO numbers in debugfs callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/gpio/gpio-nomadik.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 97c5cd33279d..e22b713166d7 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -430,6 +430,9 @@ void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
 #ifdef CONFIG_PINCTRL_NOMADIK
 	if (mode == NMK_GPIO_ALT_C && pctldev) {
 		desc = gpio_device_get_desc(chip->gpiodev, offset);
+		if (IS_ERR(desc))
+			return;
+
 		mode = nmk_prcm_gpiocr_get_mode(pctldev, desc_to_gpio(desc));
 	}
 #endif
-- 
2.53.0


