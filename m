Return-Path: <stable+bounces-26791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485D872066
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360BE1C25B51
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205B537F8;
	Tue,  5 Mar 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQYD7b/y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC88593E
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645939; cv=none; b=aF22th8POYoYv4e9wOfSYcTyONGJuDeHluxwtE82gdarxILr4EeFmTwj5KLDMOzN18JGaTT//cc3Z6Tw3Jo62yINM5zsHdGsRfpAzIs0Gv95/RZIe0QjxmFOzoiRRnt29EbTjfcz8CIMPHrEkjHsc5hJ94A8I7bmJM/+WYl2TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645939; c=relaxed/simple;
	bh=czHC4aaMIIxMKEnyQHGaUV95AewxoxYJJ10LZ/UYu0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IX7JhbmX42QutMaTDdfp2FDL6vrqHfFJEGPwJ21V+vWZ2wp5IFv866eRY5jvl66Th3GbxWMvKo1R4AXc3to2VT34LHRgPKQl1TZ38iqlTBWZT+Jf0Z5Ii3/oISWDSW0Al3S1Imx8C7I/bePVydYFvmQj9OfM2pkl1D/Lg88jKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQYD7b/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709645937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZmDbi0/7NtmfurlLAzP54jPejCnlehzU2sr97TUoiA=;
	b=RQYD7b/ygQag5mMNyEmRcSKV5XwXfNa/H7j3S34dbim1y3WFp6kS9bu1EP2Wky+tiBb1gk
	tcX9Z479nSQD2AyKYdRm5x7/pnNq27sPgvHpi42hwcdNTw/mZh8KcrnW0nWcyobhZ+K5Wf
	MSDYo2m8SXE0/Q5l8W0OHBXFIl7Rc8o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Ok9XQDPqM7Gium6eEDGfgw-1; Tue, 05 Mar 2024 08:38:55 -0500
X-MC-Unique: Ok9XQDPqM7Gium6eEDGfgw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a442979dc04so52129366b.1
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 05:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645935; x=1710250735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZmDbi0/7NtmfurlLAzP54jPejCnlehzU2sr97TUoiA=;
        b=SUo9sUSxAa3P4WTrHz4eng30lI+A9VKC765L9u4bMNudQLur0JTmVi+tyXpMk/88rb
         VC7uUnB01cvyce03FU0hZ3iy72uRSuOYpROWKfzuN971gKfurEWLUdxCriYkucOFXlab
         t6lN2nsx3492mNLAw+jjvjw+iSvMQnVk+9k41R93HFVJnKQOMaNcze+1+ltTQYAQbc/l
         YlpkSGoByRNaq47Pe+QaUyML23ho/8MliuMMFSPr2+dkf08ZBgqgtIQQ6wSfh2dJkewi
         XsPn0jwYOWL32SVzFLYWmMIO7K49EBadtCXEI4kpJ3GzDAo75rl0NYadMxymqtf7N49i
         wrTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn0kxsVnluNKWQZNRbWgz/RVK9kKMWgfnTZ8ULDQTrRVleEi1rPX7MT58ZsQN8uaxny+GoKF+RW6LXoPPdpIvArzS2vpfk
X-Gm-Message-State: AOJu0YyeyCin10i+9+UFJipdpxLvIOEE3Mq55kX4Nfz/6fzE7oxwB8d1
	UyGDZecyaSXOjKC0W0nkBXUykyvdKjiFLxkJs9s0ZiXSqLnWDxo3QJx35XUEmpBindRvxmlCYGw
	pipzGFUaaEhgOyXFpY2/Jr8yLFo6zbq2Er+wdv3yima75XKNwIHlfaw==
X-Received: by 2002:a17:907:8e99:b0:a45:ac3d:c7b with SMTP id tx25-20020a1709078e9900b00a45ac3d0c7bmr392288ejc.0.1709645934810;
        Tue, 05 Mar 2024 05:38:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoA5EnVACQYWqtrKszYM26SCh3o7LzluQPz/dl1CKgBblrnDtnRwmrcAiwSzosvNxTTtA1Fg==
X-Received: by 2002:a17:907:8e99:b0:a45:ac3d:c7b with SMTP id tx25-20020a1709078e9900b00a45ac3d0c7bmr392262ejc.0.1709645934470;
        Tue, 05 Mar 2024 05:38:54 -0800 (PST)
Received: from kherbst.pingu ([77.20.15.65])
        by smtp.gmail.com with ESMTPSA id wk16-20020a170907055000b00a4532d289edsm2641326ejb.116.2024.03.05.05.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:38:54 -0800 (PST)
From: Karol Herbst <kherbst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Karol Herbst <kherbst@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pushbuf
Date: Tue,  5 Mar 2024 14:38:52 +0100
Message-ID: <20240305133853.2214268-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If VM_BIND is enabled on the client the legacy submission ioctl can't be
used, however if a client tries to do so regardless it will return an
error. In this case the clients mutex remained unlocked leading to a
deadlock inside nouveau_drm_postclose or any other nouveau ioctl call.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240304183157.1587152-1-kherbst@redhat.com
---
 drivers/gpu/drm/nouveau/nouveau_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 49c2bcbef1299..5a887d67dc0e8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -764,7 +764,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 		return -ENOMEM;
 
 	if (unlikely(nouveau_cli_uvmm(cli)))
-		return -ENOSYS;
+		return nouveau_abi16_put(abi16, -ENOSYS);
 
 	list_for_each_entry(temp, &abi16->channels, head) {
 		if (temp->chan->chid == req->channel) {
-- 
2.44.0


