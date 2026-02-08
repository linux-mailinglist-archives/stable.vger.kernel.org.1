Return-Path: <stable+bounces-214854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFRkDY9GiGnhmwQAu9opvQ
	(envelope-from <stable+bounces-214854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 09:17:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B410816C
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 09:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B434300D726
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D05833BBB8;
	Sun,  8 Feb 2026 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T57tyYaP"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8332836B1
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770538630; cv=none; b=XH2nK7HDLRuJYoaMEXdw2vsqfkN7eoA6GpaBFRu8oynwgVG3b3OuB94Es/nDFfzUcBZYKMC30YyngHGEgw81R6Vn1Zy/Dsxqx0QVsTC+n4ZMoO5CfRU+qAODz52o77BzpdIHTJSEYUHRVwGm/jVD2mDyf2r1GcZzqeTPtxn+VPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770538630; c=relaxed/simple;
	bh=96xld+DCWspLDg17ZejKbFvZZbmlOGwLmt7mdx2FSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeHlUatPH3CzI0JM/gy1Bvdf0rt+5/hU2IoEJifSCQFcfxEPPwgCvWtEpK1Uiy2v4kB2fRCGpgms9cl22GH4dmlISvgtA3fJAPS0HuzeXGcj0TmW6kwj/xTeh2gDZjMxtAu1tXXzEcyZevjO7eKzPDbs6SrzdZatqAUh0r8fnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T57tyYaP; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad9fabd08so647958d50.2
        for <stable@vger.kernel.org>; Sun, 08 Feb 2026 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770538629; x=1771143429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw03+oSynXoyvfX4mJDGrIXnO7wDDDQdFtNcgwK8ukE=;
        b=T57tyYaPOAiHwo+2d1WnorEQNTkDD3AzXm1kLFYt+MfJgz8QCHHzLqc/J5OBi+ANUh
         Qb7TJZlcSVXEMvNk0jb482EhkDZwABrljIDp/OCHZxNGnC//duLR9xOvbf472YrcEe0f
         Dg79Qv0zJVhhlPDCJduC9rnaJPx4vk7p4zHGCcQWd8DNb8yOLa8EprxdGIfLdehuFaq7
         uNVgJgzzhPPCPkx+NhP9VsBR0CKHwqbK3BERkhpRHuXiUC0MGAPOBauXPVm9fviBK41m
         k+8RaeUjdruW27IDMl1/jb6wfXury7C0OnoThbcoYzkNbZ0s0XOzQGLEH4R7cxgq4vvs
         46Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770538629; x=1771143429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cw03+oSynXoyvfX4mJDGrIXnO7wDDDQdFtNcgwK8ukE=;
        b=lROFn4gkMDdPoOuIH29fD6l/pT9kkK/9VUQT5Xz93dEW3aHh5mRUoLc//22LgefIQ1
         nNqDD8gLpfVrYigcHWhf+GarPaavjWL681rw4EK9+TWaOchZXUXjwmfEJ3kjyhVZlONv
         FAisCKe2CibJfPXWjzIG2p0/IdrdwfFV/Do8J1Vz5RcF4pYH1HUaUpRUgDXd5Vu79QQf
         TCXFwKu4eSzf+Zm5aeJ2fz/deTwEtpHqgznFRNVx9+Pe7bc5JM+6YJidsKqB/qaCQP1r
         kdUGNp2hbghDdOYjJMC6lmoPVNw5A6aS83kukH3ca5RgHlryMp8W1y1FM++oV8sYa3BR
         oFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe5aq6e+792fjSDUTv3HOYa968dQplaz7yBOqncb563nKNP7rsOdT8MpGJG9q91dMrnwpvt6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0iCZ1v8gaRdbfgF4PLvdzAs9J/lzQ7YvpX9zumRCYQqzbollH
	iSKxHobeA4NNkS6g8LIQbQg7x/q0WXh8LiM0W3CFPAx8AZZbY0oEVgcM
X-Gm-Gg: AZuq6aJ+6JXcLBhjOZ5Z+cldmZIUs4xMqZdANGR2qb+OOIcb4IrO0VCfpfM56LJcBYH
	VVEc0ZdDmQr/X3GOT0V6ft4lbkeUUmmPpWC2oK5howtW1hKOxOE2uyGvRJnVH9Nm9fyJ02HGAMz
	mHPpEYTiUE8Zlb9citgmgsl7v/oZv5Qu837piVZcXMRI+76e7jqf7ZgjiRGl0E5yRSJkdBiTY+X
	Udn6sFwfMQlnjuXZyRdfODdL1c1dDAvK5FME5SO3iPpphEmqXSqgTMgB2z/XH/JrZlmr+MXsH06
	Adi1CjPb/sehtpzOAnOLcwyxjxD+5aIRzrgSQyy70pLpN4WyqRsm4lEA9y1gJb0pe9Hm+PoDPBQ
	1w/3A4h9NCkg/La5u2Qy2dZemAJPlhm8Es3s38rCyXayx8rP5+HO7x+wgm4OukKd7KxKO91CZqw
	As+zbfWBOfhuVIrQ1bBP1ZoLScYgAB2wyOPZIZzemoeFrF1JD948By9fN2xJ2byrWgHG7D
X-Received: by 2002:a53:d013:0:b0:649:b2a9:92c9 with SMTP id 956f58d0204a3-649f21ec127mr5681322d50.93.1770538629103;
        Sun, 08 Feb 2026 00:17:09 -0800 (PST)
Received: from binary.. ([177.39.58.68])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ad8a12432sm3521745d50.21.2026.02.08.00.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 00:17:08 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: mgmt: Fix race conditions in mesh handling
Date: Sun,  8 Feb 2026 08:15:59 +0000
Message-ID: <20260208081559.44983-3-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260208081559.44983-1-maiquelpaiva@gmail.com>
References: <20260208081559.44983-1-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,holtmann.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214854-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maiquelpaiva@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DD6B410816C
X-Rspamd-Action: no action

The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
mesh_pending list without locking, leading to potential race conditions
and list corruption.

Use guard(spinlock) with hdev->lock to protect the critical sections.
This ensures atomic access to the list and reference counter, preventing
race conditions and avoiding sleeping in atomic context (which fixes CI
failures).

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index bdce52363332..af9194e44943 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
-	if (list_empty(&hdev->mesh_pending))
-		return NULL;
+	guard(spinlock)(&hdev->lock);
 
 	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
 		if (mesh_tx->handle == handle)
@@ -420,6 +419,8 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 	if (!mesh_tx)
 		return NULL;
 
+	guard(spinlock)(&hdev->lock);
+
 	hdev->mesh_send_ref++;
 	if (!hdev->mesh_send_ref)
 		hdev->mesh_send_ref++;
-- 
2.43.0


