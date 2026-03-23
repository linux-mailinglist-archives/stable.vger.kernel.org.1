Return-Path: <stable+bounces-227980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCD0LgQ8wWkZRwQAu9opvQ
	(envelope-from <stable+bounces-227980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:11:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F852F2909
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1EA5301511C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578333AB269;
	Mon, 23 Mar 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLO94n08"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BE33A5E73
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271442; cv=none; b=KngNtmHX/vZH9eYFLYGhCsM4Cr3IJpoLG9AkvKTrb+RSNOz85rldhBlX6TvrxqKZDDJXnjse3XrkGxiduHX0msTStW9+aQBhTrPBscmtqZ5CqPNUya+DKQ0ATnef+TnOHKvPDE/74zGxfBD3Oyyj0E2itwEVgLvPXkm75SsCoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271442; c=relaxed/simple;
	bh=vY4TcenAOFgGP74tpglPTaL2A4UIW1qGNpu9kH26VSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNWPpz8yGS2gMhijbFPv1ESh8oyhzhgq15zq/A2dp0nWTJ8j6jPP/tnqyzeBb5yHIGnlYdFhb1ccqAk+LNifP4rJKBO5JvpJkYPD55fBDhqjm/tqzWgaLh2oiMkg6KEwHETtNKGEU/Uu+Qcg5bXJN3i50mBl22IDQwgGEHUi0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OLO94n08; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso2828267e87.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774271439; x=1774876239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzNp/JcL77myXdZwPsBD1eDno+MS1KWcO+UVbGYOu0k=;
        b=OLO94n08y70qU8jA9GyFN2o5tEp3oLLfqEKv/9xdr6ByaqSdZcgCw5YI+0Zb1IUYnX
         PmGY4V7uEZTqGtLV0kPZLDC/u9OLH7AW7UJSJ/Ve0wkqwKJDl09tVvGUualpnPFvl2MD
         ZfXXrao+0LoiAd+2eUlQv1AOYlm6HobwOQMYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271439; x=1774876239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzNp/JcL77myXdZwPsBD1eDno+MS1KWcO+UVbGYOu0k=;
        b=kZcVsoqSwJuhHkErI0f1bPpR+LbTWn+iCb036V7ICPyX2vC3ClFqgoNg/vBBeoVQ6S
         /4y1m40lEKaepZ1yB2eyT9EYRvflMPMcOqPyz9heP1ZFEpvS8eTAZzBPl/oDHsPb/iaf
         IvYj2SZwiZw5h6ZUrujxBmU0i5LxsJyNzJtxc5f8TGhbgcskSp8vTEO9ts5jjjcntax/
         aODkRs2s1GnqYobladieEUuZNSUV56evGW6GnCatUuktivp6W8uPq1ti0DtGo6ede2eU
         uv/1EHzoUPuNTxgz9a/lVjULXjzJk0hWyTaTZhOCkZoGFxlLLNs6zNhtLI9WsU3jgxaF
         UlZg==
X-Forwarded-Encrypted: i=1; AJvYcCXp8tWBL8KPDBANODHmARBEK+RE2u2qzph3fl0oyfonLkGVP20+ItkiF5pp4xUOdb+/LoQ6R1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrNvMvDhF7RRU+lkM6UYaCCupjyj8rjgl9IoWLJT9kA3WbXLy
	BRcpEITi2GFn7iiCuDyZLIXvdsLij1TI+573dFh5UP0vKx79bGdougFAZ55lyJDhGQ==
X-Gm-Gg: ATEYQzyXnPeKz3czFqIX8CzICnMTKAIvap5qkmfsuxQLBdxWanZwOzPKDBydh+lTrdt
	/aFXUHI+zIY1Uw8LAl8to9cVYgsYYo3Jro2F+6uVI5eVsgg7wChX4YpHji8mu1yXY3VvqB2dQyJ
	1J0VdQoEspmsn0jt4bSjxJEjg/iV6CTNdZYWZvcQggZTuxaOuIXEiRIxn5RTssZuIdm85Eswn9Q
	ER5g6iXUwvkuhoXE4bvvDgaBqUxaoGwSiAazopiGU7VcsfDsOIPjTJjZYdwIfQOftMzHOneqQJx
	COAkLdfPQFiHnw0JznO0YFGpDNdxcAoSmxgQgspeMmygSefTiCzWZ9CkCaVRTHhwyYS9fDRZkrX
	ajZrrZssDCzSZPKuTJOhrbi225y/F87J33BOvf3+J32O//9iYyglYXud6I86iaPyIPnWphMXjCJ
	LtBR0a4hoIXJQzGKwqWZXEv+mpYsUvL9292XXceYsxFZdY0cfxLiKYJawDx06fzcfIgWjbs5GPp
	BNs05w=
X-Received: by 2002:a05:6512:158a:b0:5a2:7eb8:2f90 with SMTP id 2adb3069b0e04-5a285b5d65fmr3764860e87.39.1774271439020;
        Mon, 23 Mar 2026 06:10:39 -0700 (PDT)
Received: from ribalda.c.googlers.com (252.116.88.34.bc.googleusercontent.com. [34.88.116.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285305e07sm2515904e87.66.2026.03.23.06.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:10:37 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Mar 2026 13:10:29 +0000
Subject: [PATCH 2/4] media: uvcvideo: Use hw timestaming if the clock
 buffer is full
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-uvc-hwtimestamp-v1-2-aa42e3865204@chromium.org>
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
In-Reply-To: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227980-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,chromium.org:mid]
X-Rspamd-Queue-Id: 68F852F2909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In some situations, even with a full clock buffer, it does not contain
250msec of data. This results in the driver jumping back from software
to hardware timestapsing creating a nasty artifact in the video.

If the clock buffer is full, use it to calculate the timestamp instead
of defaulting to software stamps, the reduced accuracy is less visible
than jumping from one timestamping mechanism to the other.

Fixes: 6243c83be6ee8 ("media: uvcvideo: Allow hw clock updates with buffers not full")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 6786ca38fe5e..c7ebedb3450f 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -842,7 +842,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	 * dev_sof runs at 1KHz, and we have a fixed point precision of
 	 * 16 bits.
 	 */
-	if ((y2 - y1) < ((1000 / 4) << 16))
+	if (clock->size != clock->count && (y2 - y1) < ((1000 / 4) << 16))
 		goto done;
 
 	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2

-- 
2.53.0.959.g497ff81fa9-goog


