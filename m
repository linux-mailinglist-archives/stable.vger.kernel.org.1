Return-Path: <stable+bounces-221686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNljOSSbo2kwIAUAu9opvQ
	(envelope-from <stable+bounces-221686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:49:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5111CBE40
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B06A3238B6F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05F92F28FC;
	Sun,  1 Mar 2026 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+lg8y6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C72EA73D
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328889; cv=none; b=JT5wGBntAWpr/DG+GncjNZraym+lqM9XkKEGlRrsYE2SHoSeeTfOAAm4md/1i12oYEiOqe1N+JWcGmBHPV3pXBMx9F6IVjipawJP9QUPSf9yFht7S8Xkz2a5sxh01vfQRjhDm5qBBf98OmUWiSgGuysh2Kmg/Zxwn2JCaUKdsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328889; c=relaxed/simple;
	bh=jWkehmdHRdNML8Klfewn0GYwQY0usiVjsOmqTcmQnw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XysqVwcWLPShkGSz8KH8u2AcwKlZljIlpJl2uTJS7qwuS8uE1VoBm8qdg0gAwsoRwykEW81w9TX9n4vKurbw4pm6qFuLk7ePb7Lq07N0am5QYzcwIDUk/a53vPTngT9LFkwSZrLlpXdj6us502dR5PdsQ4Ac3JLQ6P/lwhmLsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+lg8y6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FBAC19421;
	Sun,  1 Mar 2026 01:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328889;
	bh=jWkehmdHRdNML8Klfewn0GYwQY0usiVjsOmqTcmQnw0=;
	h=From:To:Cc:Subject:Date:From;
	b=R+lg8y6IabBwY8bJhLniQXYvOFlKysIYnS7B+qp/P6nsMo8wQiVP/sSDkObgdf08Z
	 4Fv6ZBpFt4hpFFiU5KNG48JpkT/+N8cX3HrHtfc0uE83rnbMWxTUAWxFjNIqCcGVbj
	 cs+dRKVVyWd5E52Hdl6nQngPsb+dy/T6Nx5t5YJ8A68vFwrb9UW6V+GqpebIkYuRVw
	 U+6BlyJ37SZ6E3gWkQhA3ngwPIkoj/7jLNY5tY9K9CIx9VTJ0rEd7QRq0QdxjImPFn
	 1XPQTrNlCsWMUNlFoy11F4ggc/B6OEjjJpEUh6YYVyAL94MUZlbsOvoP2x3uhejEtg
	 ytKaEMc/YpkVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: FAILED: Patch "nvmem: Drop OF node reference on nvmem_add_one_cell() failure" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:34:47 -0500
Message-ID: <20260301013448.1694370-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221686-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 4B5111CBE40
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f397bc0781553d01b4cdba506c09334a31cb0ec5 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 17:08:43 +0000
Subject: [PATCH] nvmem: Drop OF node reference on nvmem_add_one_cell() failure

If nvmem_add_one_cell() failed, the ownership of "child" (or "info.np"),
thus its OF reference, is not passed further and function should clean
up by putting the reference it got via earlier of_node_get().  Note that
this is independent of references obtained via for_each_child_of_node()
loop.

Fixes: 50014d659617 ("nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260116170846.733558-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 387c88c552595..ff68fd5ad3d6f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -831,6 +831,7 @@ static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_nod
 		kfree(info.name);
 		if (ret) {
 			of_node_put(child);
+			of_node_put(info.np);
 			return ret;
 		}
 	}
-- 
2.51.0





