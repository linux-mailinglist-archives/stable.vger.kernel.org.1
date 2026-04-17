Return-Path: <stable+bounces-238388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EpYA0Cf4WkJvwAAu9opvQ
	(envelope-from <stable+bounces-238388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:47:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25362416549
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01A4E3023D54
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36347257849;
	Fri, 17 Apr 2026 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aftP48cw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A21F09A5
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393975; cv=none; b=e6zZpWyDZeAXkRV5/Cn8AZGh91RbX/68RG9w4kaEKs2VKJWR48cG49fuPyEUpFdanNrDnET3eeiLhZo4RMO0kFKJ4L2sL7vZ5SQ4rJJjuvLnB2caf/PYWkSlq0Dk71x/tUGuApF+0R+dYk5NRVEcZlRnDfeaIv3Hdx32NIhgspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393975; c=relaxed/simple;
	bh=ztUHmGBkpfCt9Lr7QW2t78qEL/2AN23F0vtmnSnFqPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tuxZsuHdir1QisrA0fRIPoBO+9dF4jXire7SpjwX4oUZeJQ6EttwtUWme7BSyX1e1J+ZbcGdaL7m/VRzssqzo4pz/GBMZ6HdqFrLuGdqQflesGAvurEp/TUC7GQt15hdBDmnqv8G4GbEw9bDa7qUUa41Rji/dfIU+pGomXo7388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aftP48cw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506362ac5f7so1989741cf.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 19:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776393973; x=1776998773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLLBdTaOOBVw7/ZqmgTccVTprn4QzoYOkyggn3HnUxg=;
        b=aftP48cwx6b/zjVeIFcDZUissSOeev1vPXjgCt3Un6FNa99C/F+Sg0zeNVNhUybVvz
         fnuqU+ZQWiTSKIonqeBFGBXR0XgYWGFlYOAU+4FpFH+r3v55VX+MyiTQKqWnZZ0L7kyg
         UlJozk67+cZSTvCTHOhG4+dtJ+d/e/38mbDVuGRHWB8FXZKNmsgl1jgLBZNCmd1VAJJj
         fAFlg4gjb7OS3U/RmJmpwWa4K4LPQi6gEHN9X5bq2ywBgmfpOc7FV9S1R4QeiHgSTFux
         +wZJWJy/j1UKuIZG5Mw9b0o86iyG9W3S34JkHGHE6yC0WfqQ33WtFyjA8318gJpckg0l
         iL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776393973; x=1776998773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLLBdTaOOBVw7/ZqmgTccVTprn4QzoYOkyggn3HnUxg=;
        b=h1yF8u5tBXZEfwql9Fm/59beJlE9nZhVya/jFe7KZd5DEI8i187mZqfkb8sbPJOe2i
         l8+3VybDFmFbHQ6qfgew1vAKjqH0LBWSN3unGOhKMi00J6D9ae1grKd8WN0eKnNn5/0e
         WS+saJfRykTUruldl1jNmjcd+knhEh29tRDk9FDVt2bhsMT9JrExE2QivCUnaXtBPZgK
         oIVAKj+mAJHSLFa98++ckfuN04lzGe77GMhIlV+yGmlnvrzyLey6EL3uWwBZkoVr0sa6
         iVHQsuRpysS1x2UTuZzWAXLwyebZtVn32I4f5VsbmaXPsLP04LMBr/t2KUXkHZmESnDL
         QNUg==
X-Forwarded-Encrypted: i=1; AFNElJ+Emfxtb/8YQKWbNl/p8gzIYQym75tGaMeJ08tifSUskSyRZ6WbFadtH0mXPsPiFizmwGtvZhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQa/cWFN6MpxBzZRW/SzAwyiQFJc+4uO6RuOfvdHbamb2yQuA
	Eei8kRi98vryVj8ar1y5sehA6CYNztlSxVP4VGnFs4x642lT/8ed3csZ
X-Gm-Gg: AeBDievXAb+6u9OorHfeq/D+MXzdvdTipRn+JFMKFNaF+W63odQgS3LBXSkAZVGzUQv
	+vQHGNgfgnarKY2bQ923s/IuNT7WlyPDCDNlc9JIOUygs6TFL19/chgwres89Fbdp6U4fK4xClB
	0msYTVoS4Tyiu5L2nhjx/+3rFn+aIJFbgYrYgO9JpPXq0MqaaMrV1ncwSQZ7UvdFH3Gi2iEJQNK
	gITL2eqYqwZwsZfYQ97HrcK1kp45n4gbJqmAhOxMIjyTOku14pwLcMfV0Gl9kN0BsDja5R8InvI
	JdaeahWRu0KchqjP2lgZzgi019q6CKVDvMA72XYBKzul6ACdwuQJjig/winS0ajWkLCLBXyFgLJ
	IYzXbykM4CeRbFrdCQyreK+StrzC281H4WrrFMNIZy9sou6rAHohqzypi6Gqdgn31W1pwzwn8gl
	6AyCP5I+mDG1gcKCpNF/kjtBb8DGt6jDleS+cbSoKcOFQDleUABZm831xK0VyJO74F8bBa06AjM
	d8J+CxOuqmAXFdaHkRCc0+sQYqp2pbnCdPq/w4=
X-Received: by 2002:a05:622a:110c:b0:50d:8b23:4948 with SMTP id d75a77b69052e-50e36c7d209mr13490761cf.46.1776393972651;
        Thu, 16 Apr 2026 19:46:12 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c44esm780676d6.27.2026.04.16.19.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 19:46:12 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: lpieralisi@kernel.org,
	nico@fluxnic.net
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] bus: arm-cci: fix of_node_put() leak in __cci_ace_get_port()
Date: Fri, 17 Apr 2026 02:45:45 +0000
Message-Id: <20260417024545.141289-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238388-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25362416549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

of_parse_phandle() hands back a node with its refcount bumped.
__cci_ace_get_port() uses it only for a pointer comparison against
ports[], then both return paths walk away without ever calling
of_node_put(), leaking the reference each time.

Add the missing of_node_put() on both return paths.

Fixes: ed69bdd8fd9b ("drivers: bus: add ARM CCI support")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/bus/arm-cci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7f2baf057128..223b1fe19ba0 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -167,9 +167,12 @@ static int __cci_ace_get_port(struct device_node *dn, int type)
 	cci_portn = of_parse_phandle(dn, "cci-control-port", 0);
 	for (i = 0; i < nb_cci_ports; i++) {
 		ace_match = ports[i].type == type;
-		if (ace_match && cci_portn == ports[i].dn)
+		if (ace_match && cci_portn == ports[i].dn) {
+			of_node_put(cci_portn);
 			return i;
+		}
 	}
+	of_node_put(cci_portn);
 	return -ENODEV;
 }
 
-- 
2.34.1


