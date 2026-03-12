Return-Path: <stable+bounces-224882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANq8J5bfsmncQQAAu9opvQ
	(envelope-from <stable+bounces-224882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:45:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A46274CDA
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95A530B4F84
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4AD3B775E;
	Thu, 12 Mar 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nMiNRzpq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53926373C07
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330150; cv=none; b=iQXbUg552rSCBRNfnuJeODvSLpeBQxtsbVQ5JxFD5FS7zTbJlixubkQegitHwAzC9IuHBhBvt5817K4vyuhuVr0HW1qk8WIlTHu/kzVhabmkXf5ccbs6zAeCRZ9zzy5L5wsZkpEKGx5L5j+vfs7V75NxazdUktE+PHy6tVDD3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330150; c=relaxed/simple;
	bh=4PzX/2BcEMYN6bus1PXJ1eWTdsO2FXz36Sheli+4r/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RDLhOVAfKPtrsit51KSxbppG6hblCsQo0Jwz2DfaXPrRwQVJJE34SOmXhA+OqUw+AKnvITDa6su1pG3uHOK/pPGyXbfCbx3Y5jrtw0FqrgJuQ1tcdVXrvfyl+v9Pn4drqmOaXqfK+m5kmszatPwGVJtOxn2NAYHytK4PsargrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nMiNRzpq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439bcec8613so964835f8f.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773330148; x=1773934948; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIFxCq7ikd000RdSw5JxwXtTNKqwm1bQP1nyQMPePDA=;
        b=nMiNRzpq2p+rrHQqIp0JMOM+lsSzwPzmD9bh1X/ZP/A6xCy3DyTtlJlm6AXp2nF35h
         KsHbg8J6ronKlwpjSEtKTgch46wv7yVVsxokS7XP5Q8gLPR0IV6YC39Uf4wgzlZrzMtb
         wLfo1yy6g3I3uhPCIuvEJWIB/ErvSinvDjpptSFGT9jSgB/9XM5O5D6OJ6SZtHmRDKxI
         Y9ceRHJsZtPSNI29XfP49Ous2ZXtrjiRwvSEswcAdGYybL8Z8GKxN5il/aegNYKi1/c+
         ds9N9XWEpv9XNA0j3dvl6Dikgl8tE2e8iu//t4DjVfesdJuRKqR484dGLxDbL0yw9rBi
         n2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330148; x=1773934948;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIFxCq7ikd000RdSw5JxwXtTNKqwm1bQP1nyQMPePDA=;
        b=hLl6Uv8ghV1b6B8vVadLnbjFoCiI9yZOauA8FmAflsmGtxrxJ8bfrj7f6rnbIMgO9f
         lkpciNl2YJu49RRwbA8moLAZDishX8EuBKMUWOpO7whQUs/TTOGa7OwqYimSyfCtYg7J
         gKvbva2yc+8iuez8q/EK02WaWbBZAb91QA+jJ9+e5WhD9kMYR+8TqyhFMQJhugfSn22S
         goT9Mvh0Xq/ic/4X3/ciVkfHZfCSIYyp+xu/wQZ2ANYYxsk85JfEdYqcQo3b29rHwGU2
         O6VOSRyLqGVlU4VB+FaUlNRIeEdFrmLaKmTz9MXK9vJDKNB1Ipwjze6yveNlh07DzabV
         nxrg==
X-Forwarded-Encrypted: i=1; AJvYcCU/6vmhEn27Hv18fDvxEcZ7SnmMh1WhcvIurwgMlO5Zv4fTp7LCLqdkR4EqAUmyI9xma8goHIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9W8Af0cWvGihHoFzcMTrxUZEQSRkTYMRODhsWCAsN9pGcXaP
	eEZqK7iucLtKTQA4rVe556gqLxco3hVPQvHgtbPwzniaVO4p+S6nNoK7
X-Gm-Gg: ATEYQzxiCCc6U2pSvLH+4bxcrWc17uoLAUyhYMDqFLisd9izEfvArm+Th1ZWC9G5qYP
	5jhlPczHDuos+Ul9bahQwJYTLsXMwE14Uh0QFPBBeA2Gdc1jU6llQ+pm2iQpP5YarzNx0GaLHrT
	RLP3L9his6bRAybV8hrjbM0IRU4IbIpfkOZ/ViVjDObRd4Qhw8z/F9SXfW2D8qJ7poQpyhPHCm3
	HOBgUC0xXxTri2NUZP7ZKErFj0IlDAmhHmnbZxFCXJcSE0paT7IeceiilbxoxMtahEez1PQ0UuG
	tUi6rLTQY7OZtrls1nHvr/n1wm5towJSYavdMdhBUpvo2H2qlYAn/ojMBTjBpjGznRIIDRrn+Na
	vceFwpSMY2K8BpU/QyLaJe/NYQoxu1uGaGHUc6hFxK4PxM/9/6nnn66pI0A0aMb8tVRUiAlFTh0
	toNX3tM+Wq+k8yD8y+Tk4cE4UExLJOet6nWRJF88y62D/gmQ==
X-Received: by 2002:a05:600c:4710:b0:485:34b3:858a with SMTP id 5b1f17b1804b1-4854b0bb3bbmr113297805e9.11.1773330147379;
        Thu, 12 Mar 2026 08:42:27 -0700 (PDT)
Received: from ccde1gl2920.devint.net.sap ([130.214.226.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm269359615e9.7.2026.03.12.08.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:42:26 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
Date: Thu, 12 Mar 2026 16:42:19 +0100
Subject: [PATCH] sysctl: fix uninitialized variable in proc_do_large_bitmap
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDMBAAvyJ77kISWw/9SilhTVa7kCayUSkV/
 97Q48Awc0BlFa5w7w5Q3qVKyQ3spYPwojwzSmwMzrjB9NbhJB/csmRZhZJ8OeJOKjSmZmZctAQ
 fi0+kM/tR1jct2Jsw8HSlYMMNWnhRbpX/9PE8zx+xyS/5hAAAAA==
X-Change-ID: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Elias Oezcan <elias.rw2@gmail.com>, 
 Marc Buerg <buermarc@googlemail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773330146; l=3076;
 i=buermarc@googlemail.com; s=20260312; h=from:subject:message-id;
 bh=4PzX/2BcEMYN6bus1PXJ1eWTdsO2FXz36Sheli+4r/8=;
 b=jREgJ67/0Ad7cnev4wVPe9MLshX0zf4fyPwS70dVonHWj6g5mIcCY8ZALOllSiTbgn0rr78kb
 pg+WIR0Gz3ADvkLbbdYNsGbJBy/7Ooaxa/zP/RBy1RjSlqvb0yznUrQ
X-Developer-Key: i=buermarc@googlemail.com; a=ed25519;
 pk=kBZIEGh9yNUzqCz87kygF7XqwPxTWvwm4+HUrOuckyM=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,googlemail.com];
	TAGGED_FROM(0.00)[bounces-224882-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[buermarc@googlemail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Queue-Id: 16A46274CDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

proc_do_large_bitmap() does not initialize variable c, which is expected
to be set to a trailing character by proc_get_long().

However, proc_get_long() only sets c when the input buffer contains a
trailing character after the parsed value.

If c is not initialized it may happen to contain a '-'. If this is the
case proc_do_large_bitmap() expects to be able to parse a second part of
the input buffer. If there is no second part an unjustified -EINVAL will
be returned.

Initialize c to 0 to prevent returning -EINVAL on valid input.

---
When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
possible to receive an -EINVAL for a valid value.

This happens due to an uninitialized variable in the
proc_do_large_bitmap() function, namely char c. To trigger this behavior
the variable has to contain the later explicitly checked '-' char by
chance.

In proc_do_large_bitmap() it is expected that the variable might be
filled by the proc_get_long() function with the trailing character of
the given input. But only if a trailing character exists within the
passed size of the buffer.

The proc_get_long() function can set c if the length of the parsed long
is smaller than the given size of the buffer containing the user input.
This is not the case if the buffer only contains the port value (e.g.
"123") and sets the size exactly to that (3). Meaning if there is no
trailing character, c will not be set.

If no trailing character is present we still do a c == '-' check. If the
uninitialized variable contains this char the function continues
parsing. It will now set err to -EINVAL in the next proc_get_long()
call, as there is nothing more to parse.

Initializing c to 0 will solve the problem.

The problem will only arise sporadically, as the variable must contain
'-' by chance. On the affected system CONFIG_INIT_STACK_NONE=y was
enabled. Further, when enabling eBPF tracing to dump contents of the
stack the issue disappears, which would fit the current explanation as a
root cause for the observed behavior.

Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
Signed-off-by: Marc Buerg <buermarc@googlemail.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9d3a666ffde1..c9efb17cc255 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1118,7 +1118,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 	unsigned long bitmap_len = table->maxlen;
 	unsigned long *bitmap = *(unsigned long **) table->data;
 	unsigned long *tmp_bitmap = NULL;
-	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;
+	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c = 0;
 
 	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;

---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5

Best regards,
-- 
Marc Buerg <buermarc@googlemail.com>


