Return-Path: <stable+bounces-254209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENzuOKOwFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:27:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 694325CE5C9
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D966302A6DB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9033955D1;
	Mon, 25 May 2026 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axmROOAl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ADC395DB8
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740780; cv=none; b=M5lg6ywySGvuMhoeqbdjV6+0qifg52T5lhXbton4BKBZZ9LsLYBa2+BC+ZPWfyo6RDa75kOWweLZ8eox/iNN1xP38PAtw+FUnOkOxHZ8RzkWD+Bq9XkKayNd1VgukTQynsKEJJnYAsQQu+s+wrkS2f2ytovzZjl/taHTjAA1/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740780; c=relaxed/simple;
	bh=BDjNlnf6kqOTmpfdKzt077i1YFIj/VXRK26I2fNu3o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHDig3qfbCvkCy52aetTBMp4qvWZy1h20mLjDIHWwzmPE+GzRNmXJ9QG93WfmJjLoQlPj5MmbVi8zfIPsqBklqka9+8jkPESLLW4Y9U/cXxMZCTIpHjsAajTRcG5vBxmL1chVZoZ07VbBNMvXaHSeaYn2xwbnZgqXZ9haLLlHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axmROOAl; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dcdca9aa0bso10508522a34.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740778; x=1780345578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4eLS8y1SewZPIf8sa07E1Jfs/Pz7SGQnlUffTbCSc8=;
        b=axmROOAlOL/DaxOZUC8iK5woqnHP1IWO9HuDE/bWK6lKBPlcZt4WmU8/4DRD2hmOVs
         LhSHovXnafJu2WfSMGFfjmQUVssN838ieby7iBn77Mz0XIR6GTGQsRC4pJqbPW6UC0UD
         uUa/6uTkFQnQQIzmIFy+oZzaCKQ8CWztmOY0Neygf7hU/ARRbmt7e2dKj8xGYUA2hzHT
         Sgvj0nCz8Ur4pLZnKg95IchWfVL6azmVVYaWKZA+nS84QXzAs/cq+jDFi7lgmVexnsfo
         7kBDaxgSPDIzTyH+2BdYvNFDeQK+jD1biHfFcxWaPLNGSloh/2E/J0iVe2J8z45BVngi
         ppxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740778; x=1780345578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4eLS8y1SewZPIf8sa07E1Jfs/Pz7SGQnlUffTbCSc8=;
        b=cju8V9HY0cAbz2Kl0+dICrEB293Hubupvfy0ZgBZi3C3UXGUpSvCWOeC/nZ6wezuKK
         UvFV0rJvKiSwRdjLBtjSSzfCsWn/MQx8S3cFB5UXbZMSgCYx0SFYwLdsVIYt2bZRKKHA
         I+Beyx/ezDkYR/pzg+/f913RYTW2pKfWVfkS5Q2POh0JONZPT5XwdgC1MH393GzPRbIf
         fKtYvLmiivrI23kyoqwnBuakKNRESSwTEaLt4LlvHJhpHynzhfltjq3D8aW16q/N1SjQ
         5PSyz+ouWJV0BFoioVQ6F/TIBZTVsA7QTXnHg0tX5fBNyOUDc7hoFabRkh/CFAriB9GK
         XX6g==
X-Forwarded-Encrypted: i=1; AFNElJ8FOCW/kkGcIlhRtdU5FQtOP5uqptV+Gvj48aFG024pMYPJyfudV/O2rEbPhmDR+COZSLcwAtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRZ1aUJk49014U6sqMBFjAJfzMeRD1utFjevedsPTjkdaYtLX
	YUXdTUGGzL+zw9uOa0Qmf6i/T6WEGm9XZLnGLJaCe/sHlDkQGp6niiQ0
X-Gm-Gg: Acq92OE8/8SWqJ21kCmXua9CRlGWhf/OFK33Me5sHTmfImDYDQsQHnEW96r01vlZjEj
	30WKnqWO8BLtLLZVSQAxnR8aNJtQCgkL27tnjdkFNEMWBC7ia7Tfh3IXPt9txCSo3nflbuVqkc1
	DEdS095h0c8N8mE+x7MPBCncLwror+ekxZOdiyJ5BgvwPijOEWAFJizJk0A0/oWbspEc0id3n8P
	RlqoS6s51h4Hst0lcbhyMogI+Y52F516I/eJZReKgYP0Up6Q04p8TYbFptn5eXJIEZ76ox8OxpD
	Q0cSZ1/hhLH9VqC6r2XM8J7sb1xtAO4SXltwnCR1NZy0q3oIFjqHfwRpRKQya4zShUIlyX6Bcw/
	DTruTcxn8CGOWqJYIqVn6u8oi+YmVRjpqd/W/4Oxg7SDNkbmp3QtuPpC2yIQaL8semx65SxLRVq
	awgPaLHTi81tTfIs8k0WBBTw6c0N2PDGszOUB5Xl3K6sf3pXQ97f7RfBpgnlMn20inRf9xj955P
	N3HHHegp9Xei/KwzMvrrM/R+sgCwDvJl/Nwh75eaD7OmvM=
X-Received: by 2002:a05:6820:290f:b0:69d:9198:227f with SMTP id 006d021491bc7-69d91982730mr5285853eaf.25.1779740778004;
        Mon, 25 May 2026 13:26:18 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63512d63sm10898192fac.2.2026.05.25.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:26:17 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 4/4] usb: typec: thunderbolt: cancel work before altmode is removed
Date: Mon, 25 May 2026 15:26:12 -0500
Message-ID: <20260525202612.680-4-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525202612.680-1-adriank20047@gmail.com>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202612.680-1-adriank20047@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254209-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 694325CE5C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tbt_altmode_remove() frees resources associated with the Thunderbolt
altmode but does not cancel the pending work item before returning.
Since tbt is allocated with devm_kzalloc(), it is freed automatically
when the device is released after remove() returns.

The work item tbt_altmode_work() can be scheduled via schedule_work()
from tbt_altmode_vdm(), tbt_altmode_activate(), and the probe path,
and may still be pending or running when tbt_altmode_remove() returns.
The work function accesses tbt->lock, tbt->state, tbt->alt, and
tbt->plug[] — all of which reside in the freed struct, resulting in
a use-after-free.

Fix by calling cancel_work_sync() in tbt_altmode_remove() before
releasing any resources, ensuring no work item referencing tbt can
run after teardown begins.

Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/typec/altmodes/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
index 32250b94262a..57c8dff0c51f 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -303,6 +303,8 @@ static void tbt_altmode_remove(struct typec_altmode *alt)
 {
 	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
 
+	cancel_work_sync(&tbt->work);
+
 	for (int i = TYPEC_PLUG_SOP_PP; i >= 0; --i) {
 		if (tbt->plug[i])
 			typec_altmode_put_plug(tbt->plug[i]);
-- 
2.43.0


