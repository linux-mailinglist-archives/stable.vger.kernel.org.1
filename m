Return-Path: <stable+bounces-241459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKa6JLcX8GmvOQEAu9opvQ
	(envelope-from <stable+bounces-241459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:13:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADE47CA40
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CC5F30488ED
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8C379EC4;
	Tue, 28 Apr 2026 02:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAvGJAkJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903230ACFB
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342352; cv=none; b=V6UlG7XuslOaCVJ5CICQGRsyiMcNO+TkT4EXWQIq164FWBfy4gwtddt7eiHoO0biAWr44Ui/6yvPMf7Nlk+0lxCryVgiB6CpKlEoRj6BhvUNogEsrGB9vjkdrWtANSb2kj/U65oh/E/EFfpo3Kc8vFdjDvwDUiOWF29j5wV9C1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342352; c=relaxed/simple;
	bh=Tdk2lJ4zWobo7srIX/NAQZAcJs3hYskyW6KHVsKjjfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovBH9brMXpfC0k1TLCS2opFFLYdmnUEX+sxubTyhHWZFdHfFqqHp2F6JDlnUcLi9ZJ3mDezyYaYsVSjFm27TicVD7I0AEEnsapjgg7cx7ee9uBD6KNVDOqDaBvDZGVCgeYfanitQICdzjX5OgPK2ABbBOxNPSfymJQQuAK+Gz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAvGJAkJ; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso8902861eec.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 19:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777342349; x=1777947149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHJNwzAXnwG2bTgqC2dIYJnrKIbhFFR0KSctlzcpGck=;
        b=kAvGJAkJT3y4BbOWJytnZ/OHkH6lBB4MSBFsFhEhX31/TjBsr5AtY23xaOAteGXKap
         uGKNz9F+MqNDMvmRWWTFRR9h9eeQJ3G5D77xiy3LqeURkQxklIlUtHvL42YZ+U1d8Vou
         jgDJV6PoLbzvUvH8lfWQvxhZi7PEp7M0UkM3vK+KBldcRIaiIduw7xBtb0C1iYERV/px
         1Y6+Iw484bEcHYuOgYGTOwPbJj7VzkpqSHNkrE0UOXBEm1q7W4C0XMDl5EJsA/bLEnJT
         3MgWUImyEBTVVqj9QcoEOGNij3uVK6pthW6c9U3TnjL/JJRoTG4JIhM3tHuoIFMtLLtK
         cHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777342349; x=1777947149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHJNwzAXnwG2bTgqC2dIYJnrKIbhFFR0KSctlzcpGck=;
        b=kx0DsMvN+att80T/Uz27Kxir+sAIg29pccFp4DQ5ZOxvAuPVYKnsSWyh5VzqPbD7QO
         nJEPWovk2aZw1NpAOTYJGbybmSQmJDeIWv/mALbxjCxYHx8rvnxGwQpRxmzxuEWGTc6B
         YFIadtDsgUzKD4/iBm5w/Z0fyZ5TFP0f3XTlakkpLrZ4wT5IC/cvCe2WlyJzJyzUXUAj
         6N5hGcFWcbibq+d+/x0CiOfvOR61fvE/VbY4+CGjAUuf7lEYKZL8wrebbbm10DjGYU/f
         aJuDqwSk83Z+gAdHCASlEFwSmM6cuyux6+U8/qpcsQoa4Kefl+TkEm0/aLiXMueb7EYp
         KKWA==
X-Forwarded-Encrypted: i=1; AFNElJ9vOt54efcQTldp1bi9R2wximIlPS4RGzkkwiVf5+jNITQ0MAAKnxuL/pqUYsDVjcgfS1OLHBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTB2vm0zNHcDBhsLaiWgH7Yqfnjkc+EVCIbkDZrpouddsx93dK
	LAQP7RwiKyZZl85U8yn1YPbIFY9Hmobz29cJ6iPahJvVUuC5gbHJYwpJ
X-Gm-Gg: AeBDietnpiZLV8SeSNxLUL9DPWj+yUYkoAsuM9hYEMyIEk0GqY7C/erPv11H8E9FiHu
	HygyWhUnttQmElCvT9G3p/tP8Ztc1V+tHicAEgQpHfABygjF3J1d1hJBEjEDymQ+SHmi/rkTU1P
	SDP3YdcXllMawiLlq713AMKoSubMxlVgEZzTuYFhCGB/vOfDUaZiTQhtXXW3PYZzqRlnlQtU0Bd
	+Lbm8iPwpNkN/6lFhsgErz0K5RHRfRERNDsEhX6CfWxlZkc2tzokC8Xlk5DPrl7NxGt/CGn1VO1
	IkL3wV2KzqHU62gsJJ0u9mZq2NJlu0kq+muDzRr7iWJI34CPDT7DsWjAEjIQV4Uvj/bijNV8rl5
	sel4AZuEgE8oIGB41HMa3DS96EfKC1Vlba9f7CgxjtyJcuRz9ss1132Vy9kcSU6EdbqndOkiGTN
	b42DGN/tNFn/QWyELeG+cfi66JSVdiqnoCDH6Deok80caIIvyl8YeUYBzhK7jACmgSwmsROOX5/
	9VbR5qT73bCLIu1/PALOQLxh6+VwNGtvtIJIgEcOPWj5g+1orLNf8FuI0LG/w3EyFPP5MTVWfbf
	md1NI1ENQ7Attst202WXGdVHwUV2
X-Received: by 2002:a05:7300:3b07:b0:2ea:ea7:480e with SMTP id 5a478bee46e88-2ed0e3773a9mr164856eec.10.1777342349061;
        Mon, 27 Apr 2026 19:12:29 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a0ce761sm1132554eec.15.2026.04.27.19.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:12:28 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] net: fealnx: make driver work on architectures without I/O ports
Date: Mon, 27 Apr 2026 19:11:36 -0700
Message-ID: <20260428021145.40930-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBADE47CA40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-241459-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Devices supported by the fealnx driver support both MMIO and PIO access
(they have a PCI BAR for each). However, the driver always tries to use
the PIO BAR on architectures other than Alpha. This makes the driver
not work on architectures without I/O port mapping support. The comment
explaining why this was done explains that some x86 systems have issues
with MMIO. To enable the driver on all architectures while preventing
potential regressions, change the driver to only use PIO on x86.

Issue discovered by manual inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/fealnx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 3c9961806f75..51dd09107242 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -91,7 +91,7 @@ static int full_duplex[MAX_UNITS] = { -1, -1, -1, -1, -1, -1, -1, -1 };
 
 /* This driver was written to use PCI memory space, however some x86 systems
    work only with I/O space accesses. */
-#ifndef __alpha__
+#ifdef CONFIG_X86
 #define USE_IO_OPS
 #endif
 
-- 
2.43.0


