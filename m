Return-Path: <stable+bounces-217560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5scUEgpImGnYFAMAu9opvQ
	(envelope-from <stable+bounces-217560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 12:39:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAE16750B
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB3B4300B76F
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEE5331211;
	Fri, 20 Feb 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Mh8hHb79"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D7330B28
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587587; cv=none; b=eMW7gHWHql7Vqkpn+eTkVDxDyjTBTYKhyfU4TGbfA8uNrgs4UwD4lEwMzlhrqDNMKfUIZ9TIeTSRuJB/UVyTc/8rRQBzapKdAjvJ/rUyVkOODDOnp3PtMGlFx9zvDVXBc6VwId8Usp/ezxylUqhGFUMEbQdPvUAOIaoYHXKhDOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587587; c=relaxed/simple;
	bh=09UEbk9dCc1/v7GTUjrY4SUM9KDAOWfH15C+AzLS2AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2MdTBC5sbg75CCPb2+5kqMo1NTWx+uqFmsYFj3+LRyt6YehuHAO+fYnCFJFR9PO2xpQk0jIKTLjLmOLOhzma05sHo+6LjDZYL/kudEi3og7pUcke8om+x1tA3ql1RlEJk7CrEt54by1btA/DqDTph3QSGclhoFF8S40kcDKSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Mh8hHb79; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso13488125e9.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1771587584; x=1772192384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAZvmYa4+oLnoaGzT3J4OlkyuUdxp/o/vWFvPoP3fG0=;
        b=Mh8hHb794dTdhWTQo28a964za56bBpuZ9D4oliBPpVgnd1Yrs2rgIgfwZHn/yNRvQg
         EF7iJyFR3nf0tOVrBT7Gy89mRTAfnZgwUIxjWn1CXc6tVjwMzrU4hQ9W7JpZXZTRAOY4
         gu+nivpZ87n3oKx/u8rhnpLqXjOfUBgD25tMcp0FrnmYosm+N4rhzLDdrk6d3mzOFkfz
         UBbUWfb7Grs+oHCZuQy43E8JtOizYc3030pIbWR0dw2TyoTq+Om3XALDBTZW9zQBEZM7
         YlsheWQLhIdJZKU7Eq22Wb/2XJvXPTf9TNq5TPgWQxLSvNnEQus7YE9ByolRRLZt0ViU
         c5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771587584; x=1772192384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAZvmYa4+oLnoaGzT3J4OlkyuUdxp/o/vWFvPoP3fG0=;
        b=VjWjlbYEUT4eXHmuTadQrnP4DLYUwgDDDBF41D4DzBWSievR351eSxvlMS3rwMHcc2
         imTzzyq1dqjgZrTq/ndWrg6GUxWZ3WiIK0KNMxw5gvIwDzJqHjplz9JhYP2SA2IPlVbO
         suo6G9RjZ8VJm9iPtcXl45FOfmvYi97Z4rfW4Si509wyUPrI6M0JG8zI2wAjjZJNoDnC
         fuP45ghD3zFETVzmNDiMkHF4UQpy3iC8OmyNN8nSEGNBA1VzURKugfK0KlPverUUK2lV
         flzCCPoIB4w7XxBPWsnGZPsFFPthr5yIE7kofehHprCru6g6B9sGFut2aAGBt07So4O+
         8exQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0IdB6n3l0vo7hMvXmuXMz0ry72qKRg6+5Morgb86dIY6BV2mBDjtPFMyh/6MbI8aTFlrMDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ0zN7RANXKeq9Vhw2wOTdTMo1wpQnVZ/RVeJZSw99lFJch3LV
	gFY/GQVjvYNPUPAG4uKPulP8HKGhwi3e59yyP2KEbOzOiLkJuBQ5YI1rStLMx2KJd5o=
X-Gm-Gg: AZuq6aIKdaMurtQ7hKBYSKL5OoiGdNXhvLvUI5tr7RbJqvIt+k+Vdf0q1zcW36rin2c
	/sPhY8fQ4s8Kzo0xV3qR9Gfn+3oiDFWa8/YStDxK+tGGwPyYCgIz6NI0WXd8tgXGL2J+1k3fAFc
	aiZbSrzLaH5uamnSePRQgHZr6hVJap/ld4uCrs7zeirAtYI+ngtkdpJpq0IJLtybB9Q6VTSx1CF
	hKacmjFCqw0sFlm+0+pdMAM0qehUkqOHzTaD5NmlUNOsMFGguF5wmJyTM38hezrTSP1R7HrUoDj
	C3+XqCIkkQOy8yBJpsKMMHk4MLNl3gN0m1NtvzpzLyeW1DGEXCX/Oh3sbTZ/tKh0Jgo/jVwNxu2
	0bScGN5Y1IxUK/ZznxYN9mHuP5BQHfKu6EPRuyIvuijl4AETJP7mRBry6jAV1fJbatUVeutTR40
	r5yJ6EpSJKJwxcmxucOvClsp0Qt8Y29tkmS3cFHxz4EbWpi3kipKlZpuqYrBCtUOggt/Kxxjdoe
	9w+kjratGxB2mrRoFiG0Q==
X-Received: by 2002:a05:600c:c114:b0:47e:e97e:11aa with SMTP id 5b1f17b1804b1-4839fe8e843mr76621565e9.4.1771587583811;
        Fri, 20 Feb 2026 03:39:43 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm75529045e9.0.2026.02.20.03.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 03:39:43 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	stable@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] drbd: fix null-pointer dereference on local read error
Date: Fri, 20 Feb 2026 12:39:37 +0100
Message-ID: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linbit-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linbit.com,vger.kernel.org,linbit.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217560-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linbit-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit.com:mid,linbit.com:email]
X-Rspamd-Queue-Id: 8DCAE16750B
X-Rspamd-Action: no action

In drbd_request_endio(), READ_COMPLETED_WITH_ERROR is passed to
__req_mod() with a NULL peer_device:

  __req_mod(req, what, NULL, &m);

The READ_COMPLETED_WITH_ERROR handler then unconditionally passes this
NULL peer_device to drbd_set_out_of_sync(), which dereferences it,
causing a null-pointer dereference.

Fix this by obtaining the peer_device via first_peer_device(device),
matching how drbd_req_destroy() handles the same situation.

Cc: stable@vger.kernel.org
Reported-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/linux-block/20260104165355.151864-1-islituo@gmail.com
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d15826f6ee81..70f75ef07945 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -621,7 +621,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		break;
 
 	case READ_COMPLETED_WITH_ERROR:
-		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
+		drbd_set_out_of_sync(first_peer_device(device),
+				req->i.sector, req->i.size);
 		drbd_report_io_error(device, req);
 		__drbd_chk_io_error(device, DRBD_READ_ERROR);
 		fallthrough;

base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.53.0


