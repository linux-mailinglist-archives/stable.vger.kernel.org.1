Return-Path: <stable+bounces-242437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAgQD9mz9Gk4DwIAu9opvQ
	(envelope-from <stable+bounces-242437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:08:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A74AD17E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62EE30078EB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC86382F03;
	Fri,  1 May 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="GXoFykAL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD2175A6A
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644431; cv=none; b=CTqp1blF6ThJlYbchcZnkPnRYhnsh/VFevVfK/z5iAY/IjZEiBG6puiCIdxRNpGmML0jIfGjTM8ddYeREnYZALZJ9G3uyihjbY72XnXhsZpxAlmXPr8G8OWFK+HV1UjEGdmBzRoU8cGH5Yqkmr7sFW6vRurpnbZU+FMTPi7prv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644431; c=relaxed/simple;
	bh=8GfNlrp5nfwjyPljIMP4Km8CiPW8iEuo6oaYCpjkJgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI1jQAHpvo9SQ6SyhbrjO2AByoe8fugk0wjlO34eOFe5olARt9jsuLTo6Z60SY4eHfeZOprkOnprb/mV0KzyXGeuntO4o2i3MoZJMbH0iV8hYFfNgOXVbZMOkDEXrgf0SqJOjZ4eWKXsP1/MC9IhlMEh4x2K39UHaPoWSWsAbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=GXoFykAL; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-42fdab683b7so1104933fac.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1777644428; x=1778249228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFZCli+XuCbIUBPxFJ+RqmReAoYe9NQSXzms8hsL1xQ=;
        b=GXoFykALqOMtbTXf5/jKgZ4Kgj1tadLmjZmXunzw+euh2gcM98LorAdhnTlDUt6jO2
         fj//WNpUpH5UsKVvXHqPDDfOUQhryK2H+BLKlpxGsPOcRhFoHBNZFHX19SsTJdL7vXxk
         Ker/bu/dD8GqFOJIRwyWeiORl1CKqLG/zVqd7gGgcNRttgd9Vg1GhM4k+xjjv/Jr5QOo
         8OIFWr/PoKDE0md+3ScWF/IXD9WIJH73qpaYbltYkEeHvp2uSzoiIfGZBD6fT/WYkI06
         JApdK14f/A2orDxjZybKaenaUXC01BVzMy7hqZ/f8PvIDkC9zuMYtsNiLHIRRDui/y/J
         PRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644428; x=1778249228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nFZCli+XuCbIUBPxFJ+RqmReAoYe9NQSXzms8hsL1xQ=;
        b=cGmGsI9Tlwzjnp+8QXgaFQlrxvDSlaoTPWgCcA2WiAmZmpQwW0zWnW5Jc7hvq/GxbG
         4QI56lvPg8cBJcZe0P4x7cmwhRJsqQ76+GSFO5M2F5tn0QZ8lNnCCTQtOEwvZF1Z14uQ
         fITu76EmXjCMXKKq//oNV2WcoBA4yevzVxb4z4yYFlxJrnH1+AcEKoQl8Pu6Fp1dhfrx
         lF1wlfncUsG+uZQKGOxbdqL2tFoQkxlsBWEBeMCmWQKz0a0CL7d1Q2B9WjDlRZ1Nabv6
         SMuLe+gjx33sgu/iLlwqCrh55jXVNmKdH49gnbJMzdJHfU5bHqtvl8Hedvz+HGAwFPuE
         zDxw==
X-Gm-Message-State: AOJu0YxwaIM8Pa5n6AsPD1VGn8Jyr707SNkpgRFzG8uOzDIQpz9aXNOT
	b/wDrOE0odJ55CNn/YqHNABcpgFPCz334YSv7oCy+zL1H24ue2jGJlanWwagKcs0BbGmwkU/kMw
	KaNaX
X-Gm-Gg: AeBDiesg9VHdEW9DqevJac13V+V0d61oiCplYxsqqgrrlh7/eSwy648n0KgbIy54h2R
	jJ0R5fS0Om16LNuNCWUEOHDG5P2OPPBCIkR7Wi72KI9+7hsce6ouV/FnfsBAuYVoLeVz0IZw+bj
	jYnRyApNS+iX7QdoLug0IWnP0eA1Dfhe16UonyYKVB0n6uzGeNkwg8eQrSyDAdCXyX/v/zQKnOp
	TnZlEhKzkEFWRB8FzOlImQx7qteXrTnpCL4fFl9MngQO/0Xs8fBIq+y0QA7EKyw4zE2SjHhM4qW
	9nGl+PE0F0O7be+RJ16NP9nnkUHlIi/vdKf/ZXBbt4yg0yUnrPAVpy01UM/GKi1+yBYPFnEE2KK
	EED74QvWzjuSxzVYbV1rOqTrEdXQmeBkQ9re7as2ojAKhUPvsbr81BNjyjX6k6kxXeM2wzSefHW
	XVVbhCon2KE2NfBOJDariKW+Wl+1YI+jgRfxr7rbr3QgYUK3LfFjAF0aLTpjxdsoban8imTeAp2
	mKbvNTYWW6LuNtG
X-Received: by 2002:a05:6870:bace:b0:430:3591:26c4 with SMTP id 586e51a60fabf-4345c0255d2mr2049224fac.7.1777644428436;
        Fri, 01 May 2026 07:07:08 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:4129:1360:1c90:7857])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-434549540b2sm2828444fac.6.2026.05.01.07.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:07:07 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>,
	Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 6.6.y 1/2] ipmi:ssif: Fix a shutdown race
Date: Fri,  1 May 2026 09:06:57 -0500
Message-ID: <20260501140658.707484-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026050147-kinfolk-perennial-0e04@gregkh>
References: <2026050147-kinfolk-perennial-0e04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 937A74AD17E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242437-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:dkim,minyard.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mvista.com:email]

It was possible for the SSIF thread to stop and quit before the
kthread_stop() call because ssif->stopping was set before the
stop.  So only exit the SSIF thread is kthread_should_stop()
returns true.

There is no need to wake the thread, as the wait will be interrupted
by kthread_stop().

Signed-off-by: Corey Minyard <cminyard@mvista.com>
(cherry picked from commit 6bd0eb6d759b9a22c5509ea04e19c2e8407ba418)
---
 drivers/char/ipmi/ipmi_ssif.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index df8dd50b4cbe..3c4aa87d6bd4 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -481,8 +481,6 @@ static int ipmi_ssif_thread(void *data)
 		/* Wait for something to do */
 		result = wait_for_completion_interruptible(
 						&ssif_info->wake_thread);
-		if (ssif_info->stopping)
-			break;
 		if (result == -ERESTARTSYS)
 			continue;
 		init_completion(&ssif_info->wake_thread);
@@ -1270,10 +1268,8 @@ static void shutdown_ssif(void *send_info)
 	ssif_info->stopping = true;
 	del_timer_sync(&ssif_info->watch_timer);
 	del_timer_sync(&ssif_info->retry_timer);
-	if (ssif_info->thread) {
-		complete(&ssif_info->wake_thread);
+	if (ssif_info->thread)
 		kthread_stop(ssif_info->thread);
-	}
 }
 
 static void ssif_remove(struct i2c_client *client)
-- 
2.43.0


