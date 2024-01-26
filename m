Return-Path: <stable+bounces-15897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C696283DE53
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 17:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57171B21A04
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACDC1D555;
	Fri, 26 Jan 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4qRwL4p"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF21D527
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285271; cv=none; b=j6uMsdAvHmy20HbyxdK4L2tKgHf82q9JVav7VHfFY88vyHZPH+XtcixQv3sh89t4fwc/yOlI0WFeuW4H2cmIGShaDm54UBwvM3ZkB6z42tlVNQlkix57t1rR4brpT9dLrs9h6oQdGfKm1z4NW0LvtpJi9VeLDxthOFQnxEYdics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285271; c=relaxed/simple;
	bh=msl+pRuD5P5zFRlWMH/aDgd0LBjVTJdc7AoKbctMcIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMys3k9ffPXv6++EYEYPkJVfzskLm532n4s2HxswcD4MBRA7bcQqR258BIIp7mOVDTgDrWn6yvuAixFA5Ggf7ZoVL+c1nqNSl92Uqog53+E1AfvlJn5bVtCXNnCgMmH0yUY19bL1vdjnyawbS40KVQcQFgqxGY7QkHm4JkPWyMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4qRwL4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706285269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XXP9w7kKPlYEgTmtrjAIjtvem/ro/F62xr2HXJTsCE=;
	b=J4qRwL4pKbjDlRWi9uo2XLxkqv1f+wLT1j4QTN2lCSiMEgedMbq+UN+qAuIIc3Zr2zjL2L
	RY+2HO36m031zCeBTJyLGcxPlMUmu4tJIW+ppauti7V4j7Z3eJIWJVrqtd5lrGDLhCSgVu
	sckhoKqtLhVXvWr53UlAzmE5rwRP9EM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-u-Ek7JKpOxCuqokkglN2uQ-1; Fri,
 26 Jan 2024 11:07:45 -0500
X-MC-Unique: u-Ek7JKpOxCuqokkglN2uQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AE7D383CD7A;
	Fri, 26 Jan 2024 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4BB6111D65B;
	Fri, 26 Jan 2024 16:07:43 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: [PATCH regression fix 2/2] Input: atkbd - Do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID
Date: Fri, 26 Jan 2024 17:07:24 +0100
Message-ID: <20240126160724.13278-3-hdegoede@redhat.com>
In-Reply-To: <20240126160724.13278-1-hdegoede@redhat.com>
References: <20240126160724.13278-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

After commit 936e4d49ecbc ("Input: atkbd - skip ATKBD_CMD_GETID in
translated mode") not only the getid command is skipped, but also
the de-activating of the keyboard at the end of atkbd_probe(), potentially
re-introducing the problem fixed by commit be2d7e4233a4 ("Input: atkbd -
fix multi-byte scancode handling on reconnect").

Make sure multi-byte scancode handling on reconnect is still handled
correctly by not skipping the atkbd_deactivate() call.

Fixes: 936e4d49ecbc ("Input: atkbd - skip ATKBD_CMD_GETID in translated mode")
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/keyboard/atkbd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c229bd6b3f7f..7f67f9f2946b 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -826,7 +826,7 @@ static int atkbd_probe(struct atkbd *atkbd)
 
 	if (atkbd_skip_getid(atkbd)) {
 		atkbd->id = 0xab83;
-		return 0;
+		goto deactivate_kbd;
 	}
 
 /*
@@ -863,6 +863,7 @@ static int atkbd_probe(struct atkbd *atkbd)
 		return -1;
 	}
 
+deactivate_kbd:
 /*
  * Make sure nothing is coming from the keyboard and disturbs our
  * internal state.
-- 
2.43.0


