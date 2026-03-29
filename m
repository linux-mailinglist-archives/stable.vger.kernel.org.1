Return-Path: <stable+bounces-230848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFlMBgvSyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:17:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BFA35101F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C352302DF78
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EA2C11E1;
	Sun, 29 Mar 2026 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7yJKhNM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452B22D4DC
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768599; cv=none; b=txEKbF00SuNlpgOAjJ5gWlni0QjszecsNcRBgRZGngu06ZWJNVpLoJ2rMiv/3293wh+nSSlm9TUvbr9++PA9rjIgqZDtYv1ZjdoRADR6G7sJvUm7ZhyTQ9ouIoI+bOGXK4n6bLYCFJw/7HLqguHtRi2DGyIN2a9KAx4bbQvHFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768599; c=relaxed/simple;
	bh=libs/QDv9jb4avhsuouWTEl+BcQZS4aPoB0znhCSDhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g99NqsTuQ7351AieOWHnHUMDnpXkGPCuRAblxsK8kFU0qlqUjqtAdv/Tg4m82kWzkowY/rP7y4VRpdse64Pbey/8yBa3vfXnorcHzqXKjE+dRVa99aCZLidpIQLvnfUz660/Km6kzsdj0CaLTJq8m2+TyJM8FaPuEKWuLvo71Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7yJKhNM; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-60328744754so2202436137.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774768597; x=1775373397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veDKQhNg9NBvP46wNZP/JDlqedS7FBlQQuLF0X7HADw=;
        b=m7yJKhNM2zxkbUEX7yDg3o8SNS7XpBFLwrY5ujFnP8voFjeUD+In1RuIarG39HMzKu
         FxO/9kQ0yaIn7v9V+gIuas60xGX7PCkZAGLL1JA3ERroaIVKL3Ju0b2fjqKtnZ9v30JH
         6BNlTuaEfMBGmvqEtTHvP7bHSGm31JQKN/QnEBqZoEXAnGj2CqlkIRD4QhKstPPnoag8
         +5mYdsFJhk5J0MVe8ULBO+qzbl/hZogOh9HEJ3TXa2NN0fZneEv2flefzWaiWBFZLpVc
         Lkyxm0TmJOlO5/cxTlANdhYyzMJDu60Ftsu81YSUGalmgA19f1CBQxqeZHPejqEJ9cCU
         Wliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774768597; x=1775373397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=veDKQhNg9NBvP46wNZP/JDlqedS7FBlQQuLF0X7HADw=;
        b=LPu7cK+P/9bm9K7AwmG8U3Fk0wym/PA2HSDLDqCJDDOu6dJb4NsekoDQgd/q/d9eZD
         Lu1cffIa2srbFuSProUxxbfbyJv5qqnhf6NfrHz9YUiWxPjOUnyw/0G5og/8GHJdS//O
         EAnCQXW/jcyaUBpMHF8fEWba+k8Bpt/iqXke8nj9T5+q9sROErUCQeWfigoAT0DRnEWI
         mwGehseaZ6jwUYaKxMzhePY9VQlqcvLRjS/2enAYP/ku5BsRh00TjgfrMn5ARNze4OpY
         sCKEQorBslKsIjvXhrgxYTGeazv1+9694qFL6492Ir4gicKHsIEjjndYytpwLi8inouT
         HENw==
X-Forwarded-Encrypted: i=1; AJvYcCUUh1YiatLW5J07spN0No2/yFHpsiu4uamAzuPZkR6C1wFk8ZrJJdNjCsprFV1vZANuFxuuOiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxradV2/wmGIQOrIvvo5j5ePZPFEsMqqid9waDUbCGrI11hyytw
	Z6D6vwsK7P4i6ncfGTZO4hL52OKwUkggwRSLXQI8bkevEyyuZM0a3FIG
X-Gm-Gg: ATEYQzxSOdek1Q8511ncSIEQ3cjR+htw2zKneiKq8rnKy4kgrSxE9u0bQPR3TLOdc2N
	desnKBsSKBMyqVUCwHWRS4LZoo6DFswbLl8pQufTDIc24EWZ8Ct4bxwIH2t5rFKUdLDpZavECtV
	aKW5fCuQbS9+IOH9vU66ffIOYRQRx0bVTz6l0M3bRFVRJGir1jtlyrHVnFrza70+Kj7b3BAJO3/
	Z8/tJx+0gL6lEpY9Q5Frn/B/vrHxmSN2zwqovWhvALd5mToH53vfUa3RO4uxRuwuFfeIx+MVOfd
	aDZAwf7N7qbYqMIm1sAv9yxYaIpzG3BmTthzZLoQdtNd+vLknJ4pDMoB0jcnWcsmLEAvhM6vm2U
	u/OFsuL7oJZaYZY1Wwq7qRyUu+DshdbQIprDNX62vSwIctHF0V9xhi9wi7R9++kghochQWJN+16
	A97kOJrS4hzYan2sW7wOQpeppgT0SRR+ux4c8=
X-Received: by 2002:a05:6102:6cb:b0:602:9977:a4f5 with SMTP id ada2fe7eead31-604f926f2d3mr3395247137.27.1774768597337;
        Sun, 29 Mar 2026 00:16:37 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6df:aa::11:19a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60512a5afa9sm4390638137.6.2026.03.29.00.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 00:16:36 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] staging: vc04_services: vchiq-mmal: prevent stack overflow in port_parameter_set()
Date: Sun, 29 Mar 2026 01:15:41 -0600
Message-ID: <20260329071616.507876-4-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329071616.507876-1-sebasjosue84@gmail.com>
References: <20260329062229.493430-1-sebasjosue84@gmail.com>
 <20260329071616.507876-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,raspberrypi.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-230848-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79BFA35101F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

port_parameter_set() copies value_size bytes from the caller-supplied
value buffer into the stack-allocated struct mmal_msg's
port_parameter_set.value field, which is u32[96] (384 bytes). There is
no bounds check on value_size before the memcpy.

While current in-tree callers pass small fixed-size structures, the
function is exported via EXPORT_SYMBOL_GPL and accessible to any GPL
kernel module. A caller passing value_size > 384 would overflow the
stack-allocated mmal_msg structure.

Add a bounds check rejecting value_size larger than the value field.

Cc: stable@vger.kernel.org
Fixes: b18ee53ad297 ("staging: bcm2835: Break MMAL support out from camera")
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 44e5246f1..18e805b92 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1361,6 +1361,14 @@ static int port_parameter_set(struct vchiq_mmal_instance *instance,
 	struct mmal_msg *rmsg;
 	struct vchiq_header *rmsg_handle;
 
+	if (value_size >
+	    sizeof(m.u.port_parameter_set.value)) {
+		pr_err_ratelimited("port_parameter_set: value_size %u exceeds max %zu\n",
+				   value_size,
+				   sizeof(m.u.port_parameter_set.value));
+		return -EINVAL;
+	}
+
 	m.h.type = MMAL_MSG_TYPE_PORT_PARAMETER_SET;
 
 	m.u.port_parameter_set.component_handle = port->component->handle;
-- 
2.43.0


