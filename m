Return-Path: <stable+bounces-219210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEeVEk6dnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C300319296F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C22453087D05
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02B2C17A0;
	Wed, 25 Feb 2026 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VclHQXF/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128222C0F97;
	Wed, 25 Feb 2026 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002561; cv=none; b=tHFXdyCqKuo6yomVpyWH580/QRQuWb3ATRSbvtTfx9cEzcif9qrzArge9ExWtJRIwFAlCD4O0tYXq9AgtpFRppYRfmpW/mHvhS6TLmus8/StUl1dtjbii4HmoQmh2Uakt3UVVuKOng/vl0tehyv6IMYHzX/1wbvj9Hrm6NbXWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002561; c=relaxed/simple;
	bh=UOQqNHOOzi/S7975CQI43HRnTbXBTsQny+IyamDH9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3UY6EO/oKt1k8wH/Z9B7U0XRLNy/Q3wqWoyXXbC91qki9xlWXkrFMmdElxc63SUJMmqpOMRsN/Xnwp5e0KLPOu37xqZSGruq4er7eL3UmD0l0mjow0LsS1+I/EtHAjKJZvHcapRJkjzE6m+U99dZ3/iQxwExo6sycJajgVodPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VclHQXF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCCDC116D0;
	Wed, 25 Feb 2026 06:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002560;
	bh=UOQqNHOOzi/S7975CQI43HRnTbXBTsQny+IyamDH9aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VclHQXF/cXwh2c6zqpS08SOfSQwVZOO/ujLc4e+137mQte0iqF8X2BPuoO7DXdd8Q
	 p2Ps+WsnZVMEQwgu5sfWJxIxGtxlf5epIxKgSkrodZ0qmkqZu+ULiwaDvKylchO+5S
	 EN6vmMuOMbR4wm/vX95wrO1tVdf28R06aXSMKKhE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tuo Li <islituo@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 297/641] of: unittest: fix possible null-pointer dereferences in of_unittest_property_copy()
Date: Tue, 24 Feb 2026 17:20:23 -0800
Message-ID: <20260225012355.943871531@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219210-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C300319296F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tuo Li <islituo@gmail.com>

[ Upstream commit d289cb7fcefe41a54d8f9c6d0e0947f5f82b15c6 ]

This function first duplicates p1 and p2 into new, and then checks whether
the duplication succeeds. However, if the duplication fails (e.g.,
kzalloc() returns NULL in __of_prop_dup()), new will be NULL but is still
dereferenced in __of_prop_free(). To ensure that the unit test continues to
run even when duplication fails, add a NULL check before calling
__of_prop_free().

Fixes: 1c5e3d9bf33b ("of: Add a helper to free property struct")
Signed-off-by: Tuo Li <islituo@gmail.com>
Link: https://patch.msgid.link/20260105071438.156186-1-islituo@gmail.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/unittest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 3b773aaf9d050..9c184e93f50c6 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -804,11 +804,13 @@ static void __init of_unittest_property_copy(void)
 
 	new = __of_prop_dup(&p1, GFP_KERNEL);
 	unittest(new && propcmp(&p1, new), "empty property didn't copy correctly\n");
-	__of_prop_free(new);
+	if (new)
+		__of_prop_free(new);
 
 	new = __of_prop_dup(&p2, GFP_KERNEL);
 	unittest(new && propcmp(&p2, new), "non-empty property didn't copy correctly\n");
-	__of_prop_free(new);
+	if (new)
+		__of_prop_free(new);
 #endif
 }
 
-- 
2.51.0




