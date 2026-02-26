Return-Path: <stable+bounces-219739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGSbNECdn2mucwQAu9opvQ
	(envelope-from <stable+bounces-219739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:09:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07A19FBC5
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8CA3308A539
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995934E770;
	Thu, 26 Feb 2026 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIHxo6ac"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FE2C15A0
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772068113; cv=none; b=EgD2Wrjuy2CWqdQnuvtMv9rVUmTALHkZu5ZB09w/gnNZw79fytPyu72AkeOJlmzy4l4asnHGGuahZb52FRz9amv6lTKEU00WjLOCsqNQUkgvVTGTL2x4gG/nCQaFERAZpyoFjonWCVSB4A9pTLWAJ1NzvR8xcjo3043vMTkye20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772068113; c=relaxed/simple;
	bh=MleScNebmr/QZFfWvQ29HJiOauZJpd6IuQ2pFpYsVGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6BYJ1CSujmebNbgH7WETClttERctNdn5LdlCnzZS7KjgtSmkMFld6fRISdlO0fF7rJouxhfttIFVAgpgGs0cuJji9f/3BPAQ/DRvU2qWVeq9zNfgwhqE2Rn1sh+8UsKCqp+BlLB1mHGS5l/2X1UwyRra+jktijXkLZahdBHnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIHxo6ac; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8230d228372so165666b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772068110; x=1772672910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxujHuUWM9SO1xRU6A6jFOae3alKTW9P6VcQ6W3nWNM=;
        b=nIHxo6acgv0WCazzt2jlAXIHVxH206IDO0ynTQJSthc0Y2uhoe9HxCB4OPFsvz52Xi
         Ivx5rBeSe/jbVITXQA30GS3GkJcxWd/DLPp6wPaInv9y8WrKPPJnmmPEkuCHCGCCmbCG
         KHRlwAnRTC3FUsZx2Md+0/F54PUI1VlL7OFaJJJ3f4pIaHe156z7MAWstQm63/yL/9bJ
         bOwBLOLejeXaBC1ZkbaJuufQvlcVIvJ/4NNq3DP4n7u4MMSR5wQb/oGMaEpmo4jwI1f3
         FKUTGGiod75qEDoMxxFK6CfRdq2nCdxtlGg2Tym57VAqZw5ybycO7Kq13LaFq2N+BH7j
         ZPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772068110; x=1772672910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxujHuUWM9SO1xRU6A6jFOae3alKTW9P6VcQ6W3nWNM=;
        b=MQf52biAFUrvTGQyxn9qMjhGuys3GZugL/nzgZ5315gXUKMdXhzBgxa3woeIqPUV71
         Y0eNOK7NoYpgxKTJGeM+viuUuql8LAI5mglhFZ+RKCpLTOrk99RQ4sYBcB+MZla52G2e
         YLa7EA90AwDCF/kienUYSY7pl8X0i636CAmYSst5oijd5VU/Lk6sjzOjzJDaWaHS0CMP
         TIYUlCu1EQPmdIfK8qPSysQtZfXzXmJH+UcOUjCPCgP8rUjj88KI2HgNAHiyUkWqOjsr
         wsHkqRcr/n0hDJZHpc54HeGG8+hBIx7Buh3vfsPKI3/Z91Pu4VUEMjcQdW4pk9IbRF8/
         VjdA==
X-Forwarded-Encrypted: i=1; AJvYcCXZu1x5fJUBm/WWJECkcCxa/1OxUMaZPDBUwR3dxSlic/6JRODFE8vEjun4mIadmTE10D3CLMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVsJlMN1LXhkXUUxu3JWf9dyFZhviYhOetSU5Edo1W5DNPMZq
	dOH9iHD7qVX3yluZiDRHXGopHqOkGvhbzBwsH0CRyWe0OThXxIJnRLl0
X-Gm-Gg: ATEYQzx05Jvl7ImqWeCBVoEsxwK+rziOqcT9XLVVWG8m5fGfxXzXHkjhuhRHoDF2jj4
	jBplWb/Agz42vfnTJI1mXWEHf67YF29OMpBDuIRmua9mEU0tsOx3SVHcooyiYPt9yaZGs2ftuKo
	cJKFa+Fq5q+EzMHODarVwlDmzgEO1SkvUY6Azp9heffZD7VGLvh7XQXOd0NcMrt4zy+lQTRhuGd
	a4FBWVBtilQHmairoYu0tQoLF8zNqOHVkM9IiQmF9YFHl8wnByYVqXUuMk+SGQY9jaJxZS1IY77
	k9UhRKRtnczboMfy3wX6jUsZhHHX2AJYVtM3XniC2fnVSEAkjnQ0x8alCe4eNafIrdENFnQITLo
	Y5ju3DsuClWAKjDk1A7lJ5ixJIusuCtN4r5jfRdsogENq5ZKuxEv8m0y6eiSUyskVIlfH6Fi0Rd
	iDUulidxYsiVy0M1zufeA3e3bC33KDN0I=
X-Received: by 2002:a05:6a00:2e14:b0:7ff:885f:9c2a with SMTP id d2e1a72fcca58-826da8da56bmr16240676b3a.12.1772068110181;
        Wed, 25 Feb 2026 17:08:30 -0800 (PST)
Received: from localhost ([14.52.27.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4d880sm507672b3a.7.2026.02.25.17.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 17:08:29 -0800 (PST)
From: Jun Seo <junwoo93s@gmail.com>
X-Google-Original-From: Jun Seo <jun.seo.93@proton.me>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jun Seo <jun.seo.93@proton.me>
Subject: [PATCH] ALSA: usb-audio: Use correct version for UAC3 header validation
Date: Thu, 26 Feb 2026 10:08:20 +0900
Message-ID: <20260226010820.36529-1-jun.seo.93@proton.me>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219739-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[junwoo93s@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:mid,proton.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D07A19FBC5
X-Rspamd-Action: no action

The entry of the validators table for UAC3 AC header descriptor is
defined with the wrong protocol version UAC_VERSION_2, while it should
have been UAC_VERSION_3.  This results in the validator never matching
for actual UAC3 devices (protocol == UAC_VERSION_3), causing their
header descriptors to bypass validation entirely.  A malicious USB
device presenting a truncated UAC3 header could exploit this to cause
out-of-bounds reads when the driver later accesses unvalidated
descriptor fields.

The bug was introduced in the same commit as the recently fixed UAC3
feature unit sub-type typo, and appears to be from the same copy-paste
error when the UAC3 section was created from the UAC2 section.

Fixes: 57f8770620e9 ("ALSA: usb-audio: More validations of descriptor units")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jun Seo <jun.seo.93@proton.me>
---
 sound/usb/validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index 4bb4893f6e74..f62b7cc041dc 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -281,7 +281,7 @@ static const struct usb_desc_validator audio_validators[] = {
 	/* UAC_VERSION_2, UAC2_SAMPLE_RATE_CONVERTER: not implemented yet */
 
 	/* UAC3 */
-	FIXED(UAC_VERSION_2, UAC_HEADER, struct uac3_ac_header_descriptor),
+	FIXED(UAC_VERSION_3, UAC_HEADER, struct uac3_ac_header_descriptor),
 	FIXED(UAC_VERSION_3, UAC_INPUT_TERMINAL,
 	      struct uac3_input_terminal_descriptor),
 	FIXED(UAC_VERSION_3, UAC_OUTPUT_TERMINAL,
-- 
2.53.0


