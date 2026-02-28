Return-Path: <stable+bounces-220654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEBTLtM9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560CE1C6ABA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69D9F30D09B7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862663F12C2;
	Sat, 28 Feb 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVUd7xH+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D448AE15;
	Sat, 28 Feb 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300535; cv=none; b=AaLOZuS6+hsVEbgs8bG2Vp4ClCMU4GZhZpd6Y5ty41+NS3X7/2Qro2alN0TdAe7qr32xocWKByHOnCIJv+vDU3sK2nw/jWw6rY7q81SLEtiupFoGt1kc7CMvRvw3JOL8iZr5tcuAZPGI9DM9T7IeHJDZiNmDC773mnlQac5vS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300535; c=relaxed/simple;
	bh=X1qt2O3SpR6BNG/h6kwNGVHFl+CAHWvhjIa/OrInxyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgLxJZW2dQvEJvNhB/omHrmlwNNwlcIZTu73u+Hy0OuhmkDqMQlGfAS/mjfw3pyCH0PSgv3yOUGilm+O6oeH2gqYTPo6WYEK68KNeVd9SfWg6cCarv5NxxXNQx6svCOVqyklyqKYNPsz4JShYkjke0zB+DIroI47+RSwHuCqqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVUd7xH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F83C116D0;
	Sat, 28 Feb 2026 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300535;
	bh=X1qt2O3SpR6BNG/h6kwNGVHFl+CAHWvhjIa/OrInxyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVUd7xH+Q1wjz6UCsaIIsARwST3J64lNBzfA4x9zA5n1NuorkmhAml06+EWIhYfKu
	 IIZrYjJ8GyEXSUR8WDl7vosQKfeAFo9xqBj0kT7f9lhl2bPSxTPeLn2wtOL8Zem6eU
	 0kTjKNSWMjOfe1uParNof4AzJKiUb935+zquPWcRlrW79A8rmCda6o5JVuopNd5yy2
	 xu8G+mslK2M0/thJ7GHeOjQkWk9bn1GOVz6qd8olSoxGG/FIFFZzKdlrSZMEPfqQxy
	 R1CnSj49ybYkgu6EIFVVnhKnMc4Z8qy/NDeCA3jM1eJuPbRmwK/nPviGT1uWVu+boa
	 ntFj2cOrT09Eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 575/844] media: i2c/tw9906: Fix potential memory leak in tw9906_probe()
Date: Sat, 28 Feb 2026 12:28:08 -0500
Message-ID: <20260228173244.1509663-576-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220654-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iitm.ac.in:email]
X-Rspamd-Queue-Id: 560CE1C6ABA
X-Rspamd-Action: no action

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

[ Upstream commit cad237b6c875fbee5d353a2b289e98d240d17ec8 ]

In one of the error paths in tw9906_probe(), the memory allocated in
v4l2_ctrl_handler_init() and v4l2_ctrl_new_std() is not freed. Fix that
by calling v4l2_ctrl_handler_free() on the handler in that error path.

Cc: stable@vger.kernel.org
Fixes: a000e9a02b58 ("[media] tw9906: add Techwell tw9906 video decoder")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tw9906.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/tw9906.c b/drivers/media/i2c/tw9906.c
index 6220f4fddbabc..0ab43fe42d7f4 100644
--- a/drivers/media/i2c/tw9906.c
+++ b/drivers/media/i2c/tw9906.c
@@ -196,6 +196,7 @@ static int tw9906_probe(struct i2c_client *client)
 
 	if (write_regs(sd, initial_registers) < 0) {
 		v4l2_err(client, "error initializing TW9906\n");
+		v4l2_ctrl_handler_free(hdl);
 		return -EINVAL;
 	}
 
-- 
2.51.0


