Return-Path: <stable+bounces-224667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MwOHMREsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:32:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B72E2623E7
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E872B3041C87
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E73E3CEBAA;
	Wed, 11 Mar 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnPMmio+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BD3CEB9F
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225094; cv=none; b=tqWu/vLzTV2e0hzNagg6rFI/6H637kafT2E6NWJQSZzkPYNXEDu33zP7mInOwznjNmvFdcC5xwBhYOhB2G89CB3LSYPYofCvk5sXsr45h2Mf0EuvfYEAqs5x8OK476qQLujKFoZ50fiNfU6Fk0D5RmTUiglQfZvu9zoNyDPj8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225094; c=relaxed/simple;
	bh=A7pliAaFlvjBgnccGAmiRGQibD/JUX9gqF8ur5uKKVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/Ng0ozURXtNn+poLd4M2R8/jOMGtk1s6M/dq8tLVOWcYCS9Wzga8nmXGDCp3IZvXUMVsI/9QoP1NNs8mwPDJF5sG9+Wy0fs8XMrkoihBuh2XRfaqIdMG3qTTCpeHisMliqKevl3KsM+GNZEO/T3RjKtlPs525Rr0fa6sBsz0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnPMmio+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829756f3ee9so6529803b3a.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773225092; x=1773829892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmNvd1PHGKe/+jOkhZ60vdpiKJgn6ANHvZ8AjwmtkSQ=;
        b=fnPMmio+MA1tlV1zjpaE7ExMsz8F9feTxxU/hCgu7Am4FqN4AH1agDKaqTp7/UPktu
         iGApLmaUtn988tfPGjHyUec6zjOs0nNyzl3FaxqCJTBhAMs0jfy4x/PEPOi4cr7mTvYQ
         rTqxXEvBieHeziOaB/PFxWINGo62BbG9puUCxasDBJwdBlhOkE1AJCWoCusaJoR0DRYw
         s2Z97QQUMYnm6hWLyaQ2+GAvoj9m6tw4M0DmDYkX8SU/eJDOjiU35XzdgCWqM+hBwEGf
         J7cAJB070oIqTMtkQC8RByGK+d/WlaWfqsT9E0aGAvRvcmiTtqaFRCqf8He+q5MuJyeO
         cFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225092; x=1773829892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CmNvd1PHGKe/+jOkhZ60vdpiKJgn6ANHvZ8AjwmtkSQ=;
        b=CJ3mkz8ZfKCn4r7Q7B7CPT94ZOqct65ExoU9QGKoW4lgqE8ezaQ0Lcqlyme4dZXlfI
         QLLVLCCVnwzYlV5dmXH1tPyK0flHkRKCmEt7Z3dt/HBps27bVf9RRaci1/cxFtsXw+kF
         z+0J4gnN9bokLZx0HI8bmUKUhKPFO6rWYDNaoh751PwulrWKNwboGp1BaAjvCsqGJooY
         jRNlxsgePpAFelunLXj9vSC5BJJZL7Ls7WZKkNcwSsX6A9nH43FEMl3IsjktgE22zAIY
         0es11c6sL0ZmCptGk3kI59qZR0udpHaNs/y95GHUhFmQR2AOiOTKOAbfWaADnmNMcEYT
         +apA==
X-Forwarded-Encrypted: i=1; AJvYcCVJWfzpp6j/GekiO2Oas9EOzDL/SStOScK98oTZZ8mQtzBqmzt1ZNZdyI9ex4h3pte80r2QDHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4f0PZIDtPK5rxy6q1DYonfEwVtFgD/ahn8MFEwwR6Zjff9kf
	jSfSOAQlv8jmJmY9W/YieRqmPecU8pZ+lvbPfOKbMDXJj6zyb7Hjouc/
X-Gm-Gg: ATEYQzxJLNGHkKUUBptwlRJQsECbfeCWnK466GuRlsMqhmhwcX+sRzNGi0H6w6z4UPI
	ZRCw+QUi8zqwwRk3V7jsLMOwW/6ew3SP+I3ybVP4J6rTneUXBl/1ynBDI+biQiUMyVI566yP1Fj
	vUK/v6vqL8Z9YggLnCKzICw6kRlli7hK5QPscnO14n74cv9fhz4huFAL4p3dWW1XjjMOxKeqsSa
	CrMB8nCHjBhQo5XFc1tGG38ekrgRMsLqDTnN+rxzaS8skWF8kq+aHpDJPw8ItNdw/jbnRL2Ah7S
	UfHEbG5+doCCmEyukM4+LVYgL1E4tZKJPvmORpYNVTUucTB10eSj5CSXAnVsv6Ye/k1AjyQcFU7
	1Nt96zza2Ms1InijW1pQeqVBikXliarQ93JXyXc7mFW9OI8z1oFzu0PqaszyJhhm9zCoOpw+QpD
	1sUkhLf8oALWvnk3upm6L0B8O2hjjpVg==
X-Received: by 2002:a05:6a00:ac0f:b0:827:2d0f:1ed3 with SMTP id d2e1a72fcca58-829f7199380mr2087752b3a.56.1773225092254;
        Wed, 11 Mar 2026 03:31:32 -0700 (PDT)
Received: from 1f3ae71dd79f ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebf57sm2052558b3a.38.2026.03.11.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:31:31 -0700 (PDT)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: [PATCH v4 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is not available
Date: Wed, 11 Mar 2026 10:30:57 +0000
Message-ID: <20260311103057.29-3-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311103057.29-1-sanjaikumarvs@gmail.com>
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B72E2623E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-224667-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,dicortech.com:email]
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

When the SPI controller lacks direct mapping support, the fallback path
in spi_nor_spimem_write_data() uses nor->write_proto based operation
template. However, this template uses the standard page program opcode
set during probe, not the AAI opcode required for SST flash.

Add check for nodirmap flag to ensure the code falls through to
spi_nor_spimem_exec_op() path which builds the operation at runtime
with the correct program_opcode set by sst_nor_write_data().

Fixes: df5c21002cf4 ("mtd: spi-nor: use spi-mem dirmap API")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8ffeb41c3e08..cb7f4d447156 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -281,7 +281,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
-	if (nor->dirmap.wdesc) {
+	if (nor->dirmap.wdesc && !nor->dirmap.wdesc->nodirmap) {
 		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 					      op.data.nbytes, op.data.buf.out);
 	} else {
-- 
2.43.0


