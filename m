Return-Path: <stable+bounces-220143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PBQAloro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:52:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1AF1C5271
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F60B30DF6E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5325748B39D;
	Sat, 28 Feb 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBnhUSm2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6D48AE2F;
	Sat, 28 Feb 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300052; cv=none; b=NSdqVvWHx4F9U0bkn8yu9zHUP5Gaji+kNMHLVd26MxYzIXfElwlEniSqV0QJEhND8B/Hu9dKYtKrM3L4jitADr3vDhI23VbQyq8ogwLLlEVzpuDpxAlc76JxFY0gG0+IgB38unmkTMKJvS12o+kXKdwoNNtNUeSUKdphWmD2Ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300052; c=relaxed/simple;
	bh=3ehqF7E1bgU2yP6k2XkYnR7D370BRBMbkJnAp8RL7Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/jAIYLbzCVGdwlXxDpavZ279loCYBKmYdKlfGtzdIqHJUqXHfS2N/3XKkSwmvR/3DrYp9hyGsxg9KLSalh6MPG5kN/gg39pyw4T7/AnF8RBRq0LVVW0+KvCKJe+3c+DDx8CIsXecCecfg5OYUamt7z1YxqtgjHH1KAzQV596pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBnhUSm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA78C19423;
	Sat, 28 Feb 2026 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300052;
	bh=3ehqF7E1bgU2yP6k2XkYnR7D370BRBMbkJnAp8RL7Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBnhUSm2rW+ozOGA66GaGvzHGFFg0EM6Jn+OMEFCbpcArZ9Y6CSi8mO1ea9QeDLuu
	 s3rKCUmrs52y13MVRXoJy/dpb4aCSprEBwiDinzim3qH9CvVhjLC+hS4hAnbc04/j0
	 cUnuKBV2QZ868W8ZOo5HODMJb1nvFH16GVPJDyJ50wGt5hbTp4ssvFwuSQzlqjvbqs
	 DHgR5FlLlIGF8nakvzs5BsEoFR43zub8eUnZm9FoOkBnzmUsqn7BXQqj0SrpB9DT49
	 adoheg+Ps+B9CLQalTXoOXYd0/dMsrYIjHyuH6gMomj3euJCTNa+VZphHdIJccrveq
	 b9IEJm/1Lfjtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 065/844] EFI/CPER: don't dump the entire memory region
Date: Sat, 28 Feb 2026 12:19:38 -0500
Message-ID: <20260228173244.1509663-66-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220143-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,huawei];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3C1AF1C5271
X-Rspamd-Action: no action

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 55cc6fe5716f678f06bcb95140882dfa684464ec ]

The current logic at cper_print_fw_err() doesn't check if the
error record length is big enough to handle offset. On a bad firmware,
if the ofset is above the actual record, length -= offset will
underflow, making it dump the entire memory.

The end result can be:

 - the logic taking a lot of time dumping large regions of memory;
 - data disclosure due to the memory dumps;
 - an OOPS, if it tries to dump an unmapped memory region.

Fix it by checking if the section length is too small before doing
a hex dump.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
[ rjw: Subject tweaks ]
Link: https://patch.msgid.link/1752b5ba63a3e2f148ddee813b36c996cc617e86.1767871950.git.mchehab+huawei@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/cper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index bd99802cb0cad..09a4f0168df80 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -560,6 +560,11 @@ static void cper_print_fw_err(const char *pfx,
 	} else {
 		offset = sizeof(*fw_err);
 	}
+	if (offset > length) {
+		printk("%s""error section length is too small: offset=%d, length=%d\n",
+		       pfx, offset, length);
+		return;
+	}
 
 	buf += offset;
 	length -= offset;
-- 
2.51.0


