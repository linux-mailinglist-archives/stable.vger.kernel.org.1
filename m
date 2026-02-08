Return-Path: <stable+bounces-214853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBkFLYlGiGnhmwQAu9opvQ
	(envelope-from <stable+bounces-214853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 09:17:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366810815E
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 09:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29B71300D9E1
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5789346770;
	Sun,  8 Feb 2026 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr66b2QE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D683451DA
	for <stable@vger.kernel.org>; Sun,  8 Feb 2026 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770538627; cv=none; b=DDWdQerSYBrL3QR2yAKSXYwZS1LbW6ic+D2OMJJ1gRirQ9jY1xZyzj+VLhJdCdi29ChvKTXwkXoGc7OtgxCp3JN4LR1Qcof8LMBtKF2YEAaySSQS+lNBR8u0UO7mnLz9gdQIBWBjVADk1byd1vb9sa2bcW0vWXeXwvKbYlrlG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770538627; c=relaxed/simple;
	bh=F9bNjK+pzEpZsGayI6GYJIczHINzrgN7fQGyUMcEuz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qes8CrRbkgDU5CgvIgbfuYh26P3mUlV21ss4efqoW2G2+HqhFj8lhnpaJKB0DzuYEBqQPr3uVFX92fOdqsyLapr78ZoDbGWGao77kcEAPoi83Tt85b7iwKgtLHsZV6WL5ReDdYI35OHDcnGAExcq6m2OglgDyNkELTP55Ako4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr66b2QE; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649e97f1e99so3110020d50.2
        for <stable@vger.kernel.org>; Sun, 08 Feb 2026 00:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770538626; x=1771143426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=Jr66b2QE9Q+b0K1jgBEBa49a/gSvLj8y9Su/1JPEb3kSZlK9pKoaPqI+GbrLp4t5/t
         4Jkde4qghtlixpuxLkMgDuMJ0wUrVw8K+mtFlpOoj2fKcv/roYucsEqc7HJwsq9c6vUQ
         oztKNQ06OLL3n31CfleN5fiODbtVKVjm3oGIBEaYOEnFgNP4cFkEMgZNsRviEv03eFmf
         q4PRUtaxoJbjWCS1wzpjROKCDMq5U4WaL+3hc9qiDD255Xz39YaU4cAMJ3VacZ/9llJf
         G7LHHHDDgNUoC51d5fpmNHrb18ms+OQh2ccCoLQlk68CPQ13HTKapH21rq2rDfGmDboT
         cd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770538626; x=1771143426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oS/b5/sslw48AcYmgWpe60xwd/fLzbiXHPdcLj7bmSM=;
        b=feKKfHtFB786LG24XDcRUk4eFFoYZbtMHjFiB601PH2nV8QQ+AZnbRXDtqVDmkmaqS
         ZZjvZPVSxGZ5F9X5pURFVZ71C9RLYnvCUExEYjh+dO/1tjslx+0v6l08u7JcvEiCzCnc
         2JlRqiS9q/bfKf22fz6g+Yyh5H2sKlFvI2DzG83+kzw2BjO4cx8LBpYueQZyCkjYrQlk
         bknK3Zc2QwQC/0Wa7ha7m6QGriylDev4LrRi1Icb7/JX7IKgGNPpD9IIG3yB5jVP4kX9
         Fs+E7haaRATxT0iH0KYQ4TZD79JezT0La31VYa9hUcDvGaI7PZSL80a+IhZfGRsmWDrw
         DFWg==
X-Forwarded-Encrypted: i=1; AJvYcCUpG/+7UiC2VIougHvcuXRBS8KZ+1MoHtza7n4rWDy56hGoAUXYXRhduRvhY1yzm8nBvkzVJno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjN4JGUNhG59pqR/tAKyT9hPro6wvOKyaxfzSL3Wnz3k0/mOH5
	LCWufsP6dCavoW+W3hS4KhAPTmt+xvZZhB9liorbYaGpODRDsgWaLWXm
X-Gm-Gg: AZuq6aJ6Ul+2LJhVEO+agk67+FgY8OQoJffbUDZG58EBZE6hOdryITuM/Q+d+vrQkQZ
	EcsKsYtx9vDsA1MH8vobRnWfRNwR+9jA7jIVa/S6GaF1zP50XKM27gAlO7vyhQIIB8R9x6rEHY4
	L0T+ZJzQfparIW7ZT9EKmQiwatiMM7JVg3O1ZEYWhPL+jJMnWJnKVB63TsKX+0gjrgd/w6quyR4
	cSa5FIb4LBIcOyTBPWrzZBL+cWKQ4a7SzCuI5+BNwqsk1SoShXTf6yF8jc8N8ZZNvfeN/Y6IKS9
	R6jzvy/aJ2+ab6R5rZKPqrljHjWfIqs0EiHicwJRYGAuUjWZgmY0RMkY0ZjXsQPRSRucEKJOF2h
	JCTDDl5Ib9gYm1i0Mmu7TqToLwcF444HYbMU/wdmas6ENEx5GBk3Yv+coZ4vUiPyAD9aMEx0xCX
	WO/qweYyxvzVsMfrEdceSVWUVxPypK2G7qaEo+FfBQsekyZpxx26qK0KigopubpVC/OGqh
X-Received: by 2002:a05:690e:e8c:b0:64a:d8a7:10a3 with SMTP id 956f58d0204a3-64ad8a71280mr2445654d50.91.1770538626217;
        Sun, 08 Feb 2026 00:17:06 -0800 (PST)
Received: from binary.. ([177.39.58.68])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ad8a12432sm3521745d50.21.2026.02.08.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 00:17:05 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Sun,  8 Feb 2026 08:15:58 +0000
Message-ID: <20260208081559.44983-2-maiquelpaiva@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-214853-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 2366810815E
X-Rspamd-Action: no action

Add a check for the user-provided length in mgmt_mesh_add() against
the size of the param buffer. This prevents a heap buffer overflow
if the user provides a length larger than the destination buffer.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
---
 net/bluetooth/mgmt_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index aa7b5585cb26..bdce52363332 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -413,6 +413,9 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx;
 
+	if (len > sizeof(mesh_tx->param))
+			return NULL;
+
 	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
 	if (!mesh_tx)
 		return NULL;
-- 
2.43.0


