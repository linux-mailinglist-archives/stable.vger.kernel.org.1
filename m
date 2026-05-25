Return-Path: <stable+bounces-254202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ATyMxuwFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A4C5CE535
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D754302DA17
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182E63955D1;
	Mon, 25 May 2026 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXbc0nC/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0A38D40F
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740662; cv=none; b=ZU9SklLZwM0m1MUCukmpOXImO8VF52sDncW12d9+3qf8tq8UBysZRVGjzEgMyfS94AnDV3LaerKz+diEtB5+8fDtL6BHrl89Hha1vpOGngWQ7HRGBdi6zBX/POQygsEfjWVXgcw+Y3Sib34gKoI1hGub4FHNeMLlUqkCC4E9rBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740662; c=relaxed/simple;
	bh=2z3nyKEVA3fX4RWIlRXG+J+3x5NijVYYAa2uEK6YBRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkH9UKU6qGLBFRMCLJw3pyxdzKQ4fLIufxT5MO3nnXGljtyn+/dPaXMGD6R4pUqoCngRA1NepbQdkTM3VRC7RzpJwlQIfwJ9Hybg5theunmsVZBL/YoTw2ev3c/jqyjG+b+FJt6CNrAfBjn7KUK1jwz5nNfTfZZfBdcjIzQzV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXbc0nC/; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-48544493bd1so2293960b6e.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740660; x=1780345460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r8RhsQYE6qApYlJu+dL8K8TLlcMeAFqJPIZDrl2xNw=;
        b=EXbc0nC/UkukedZ/qZ8jdJThyMllC5lvnl43YdYcDaVv508JlXP1F43V0eO9bYcRlW
         k2U8AS1n6/Jo7rJAHkSBpIkeS6xTLL+PB5HooyFNJHeKNc7AwFhO9uCcfECQGDEi7qYg
         qIl5xImT0c3geBeuN0LJ/7z/7yeo74pk4gbUeIek7SjdJJSp3PxMJxdVV7MZsTz4E7AV
         OhuDu9qREKoxX/jvHrmFxB1NvEIOKtKPG5sP6oJacNtdECHi2PVf1zFbXvnMXVpW37aN
         +wB3oTjPova0svwrA1LAjFQlgCGnpFdtWUATveSbhVtGxyO4TzNFkryKd07WQ7k2wzI8
         +gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740660; x=1780345460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7r8RhsQYE6qApYlJu+dL8K8TLlcMeAFqJPIZDrl2xNw=;
        b=tRuqdpgiOYTfA6tgleJzr2ACzMoTeJ+M+c7y7b1wmWHL50BaKW5sk3L2G27GltpcyD
         WV2wyBpKXsgK5XOJpgy/Xfoll1DurBZCKBg9fqFgjtvD7jtm8WNrC+DQHsw/eOUSSWw7
         9gpwSCo+0kmERaNQS7/UBasiJYLwsLOazK/MS7mnIyTffEEmyDee/9QIHnAwYYyFSEkg
         gcarAoLI0CtxqOtrkuaf+H709yXmAtf4rOEx/by9R3QT4+6py/MhoMm5Eam3Z1OPlped
         mb3SGXt1or1AZ83RXSm9ks29RopQJzkKCHZYg4DQZhS2LFJclTY1bQ/QNVP3IZ7MXpeU
         L9fg==
X-Forwarded-Encrypted: i=1; AFNElJ9g98cr/p9WxOY4rqlWjh+tU/Vga/6O0ZUIpb11RfmGBIFYswx2DBtPJqwty15bCYXWz0qwQOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxscZP18W98BMfUL5agWSDMQ2X21jTy1AUKrsKeK+VizHicteNv
	vc4IDNr2ajNZB+ajpTLdVdLdVsvon4b+POEalvgQJs9JE4420VRxl5U8
X-Gm-Gg: Acq92OFZSXbj5ti0DRoz755H0LqhPp6VCc7MSZfwji6lflYcQ1167ZJul+PdnriixIE
	hJtJJwtuJxvroW19xCTyuKLslyDbB191GLIkDbrKKbrglPveDIX8YA2CoiKKGaOBzVeEcMNiT8q
	3Z8nk8CJ+bBCSPaLYR5tjQAOLAR9oQmaXhvkivEjdW9H3MNWGSlPxuL+FdeDE0GnSpnbXIu8zbI
	wRMiitTEbAFHeRRDOLB6s/z8bBAdSOuUW1qx4Ifpjw+DVzQXbaeXpzba4HMhjbu+A+PmNKm3bTr
	iZ/5Q+3WJ/kSXnQnqWXF1VPtrms7GX/2CEIo8w69s0W6CRem6b6/CzQjOrVBPQrTwo3Wu2rOYVJ
	1BIvTWCXmzHswACzUsf2geztcncLZO+JT+AZ1/3SewC0Jfl3mVU/jqFre0pQobTsvqQNaIkv/2l
	wBc/NU4zBmBDrp7Phk3C1jcQ+CNbZlgZ4bZB9gatJq+02JwPY0V0h8Rezb+STxo6mrkx4W9PC+B
	uF1R1Xmj2KeNnD2dumQ1wlWattG3jqyeZDwqX6+91q0E6rUGyygElKV8w==
X-Received: by 2002:a05:6808:191a:b0:47b:d914:48c3 with SMTP id 5614622812f47-48549cfca30mr8480499b6e.10.1779740660388;
        Mon, 25 May 2026 13:24:20 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5204305b6e.15.2026.05.25.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:24:20 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 3/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
Date: Mon, 25 May 2026 15:24:11 -0500
Message-ID: <20260525202414.602-5-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525202414.602-1-adriank20047@gmail.com>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202414.602-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254202-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 72A4C5CE535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

f_audio_disable() was an empty stub that simply returned without
cancelling the pending playback work item. The work function
f_audio_playback_work() accesses audio->lock, audio->play_queue and
audio->card which reside in the audio struct that is freed by
f_audio_free() after disable returns.

Fix by adding cancel_work_sync() to ensure the playback work item is
not in flight when the audio struct is freed.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 6ad4b16769b7..798fbb8550bc 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -697,7 +697,9 @@ static int f_audio_get_alt(struct usb_function *f, unsigned intf)
 
 static void f_audio_disable(struct usb_function *f)
 {
-	return;
+	struct f_audio *audio = func_to_audio(f);
+
+	cancel_work_sync(&audio->playback_work);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.43.0


