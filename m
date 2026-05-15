Return-Path: <stable+bounces-248834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFrvCBhQB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0480F554357
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BB3430E6516
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97212949E0;
	Fri, 15 May 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="GL5iguDF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E13E00A3
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862747; cv=none; b=lS0fkRNQGstEzxMUOLQOXIVWsnwGDAEe+jc9ecE2uCJuU0RuKdF8Mq/uz6yFEml1KaJRJfeBHPLzpoo9W2U4/6W8USTi06E+PFiJn4auUrMCp2i4a+NtKdT6/72odXdFmvxwiVd8DLpsUXpH8ANBUxoWBh5FYsuccy59lBONZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862747; c=relaxed/simple;
	bh=dPAlCQ7CamKJWpH3yYFUpq/IoYtHj+j7eQfz/0JyHZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amHX1Ju9GWuhuPGeC2A7P+XkquyyGFqBlKn/UR0YtaWtB8u5tns1OCjHmL4k6V3f+R+xwW/vzvPA3jRwfvzD3VMOrBcSKxQzGW6xq8rqdgYYINV/adJiefD4wGaL8dHDdFn5t+Yr3QUu5ygm6QnQbItL7fcb1AuRxRlITpRjCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=GL5iguDF; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e4004a4a6fso2083416a34.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778862745; x=1779467545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXVodw1E6K24BZjEFIdMFaaX39L55IwMJxB4Jx+bt2c=;
        b=GL5iguDFKskg5EsQl2gpFDJw2bGViqOPxOxQVpzNud6ayuHHHpBX7VA7UhTY8N5n0v
         2hust1ptLR8HS2I0t1kuDRr8zBe34sy2PMMQ9rJ645opT5k35FOaSUjL3cR0i4VUX0su
         DPaGhR7mxkXF9QOll8wn8lBjP9KTlxuU21meKDi46G/Q+Q9bVv6gSN3xCW6d0IoGFb+f
         dbb3QhKsdBQIOWWV7g2j29/EJxmggYG0y197fc3SRkZaf70A/Ug9k4lRXNPZGk3AtUXg
         iirzglM6H9UwFHyHZkv4+R7MhAqYSBD2TbgdS96YSZK9ZNtd1XKClAmnPM2zNGFGPu3g
         Sl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862745; x=1779467545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXVodw1E6K24BZjEFIdMFaaX39L55IwMJxB4Jx+bt2c=;
        b=G82esvmiaZPBt9codBaH/GlZAX6rAba5EfP3aY6UwM4AEQoSWn5j6IkFqWXz7lKFzW
         4udyV0Cu75UKE12BDe8lfd61UGc3wYnIX6VEEM0k0a8xeM2I1f528xIh7y88VtS9yqXo
         qJzd/ZRi13IpCA+lUzhEJre7t0bu+59MlSqOP0JS6KEmjJSXHSF21r+EDGipCeVS8Ydc
         LjmFq4tqzf8FwjqpJ4DHomVJMwdmvu53Bp1X+C0Z6fK8iWWnctx87D8naqWX7u+BVRy+
         kjxMDRAxIM+IQbwSVfs8/0/qWbXYKjDdR/9Zw38C5gogEOS1oCtg9zvIv3wBnH9f7d+l
         nYZw==
X-Gm-Message-State: AOJu0YwMRFvquXxP7PECtXg0Bu9s7cH+qxA5mqG57bGsuFZFS/WaFNB2
	Q6GR1TjMIhiMxHHJcbrEhNkwkzTP+T779TDS9NJHsuD2S5DaUMRV7N4hRo6oHZ54StQ2XIV11RX
	CFwDw
X-Gm-Gg: Acq92OHKQrGjcFxAwQ74hFGI/aU1z+qu8YeTmUBa5q0Ahpr8Pnm3UUDlFKRjfQf70z/
	AyfEmLWO5UaeDKUokbcZGgwycVqbN576en3Gpr3G1OvCcmrh6eccNk3UPpRd/VNBAHTdtsUZxOo
	bvo6adErk3AraYQ3qt2utwnpILRJSMjijjBQf6ZOTHX97Wlco0gCapLBpUapmMS0UWIYbt4a/9j
	lXuqLrTuSgoilvyciWyBwHjFD9w8ErG3BSGrGixfT7zHqCh7Z6XtnAb4y9JYahAW2HFt2cf/dVm
	ybgeMfr1065PqKRgew0ZDG5TpRCDovOqoyuP7KFe/I5PNjsskaLfy81JPCjE+AOx7gN6B8m2Dsg
	y+lM1S+L7sUwjWRDxK4mhcAjsC2NBdC8UMuWYzf6ZO/RDPwKIBpGaLHuHkBjInn8XtiWnJ5t7Qc
	wBF2UMvMfxxMfgcG18w+aP22UK8DEHywwgCQJkTzfzdto4G+cTD6pw2eK6fKbBHJYR7om6H6G4i
	3qVZg==
X-Received: by 2002:a05:6830:6106:b0:7dc:e45a:adda with SMTP id 46e09a7af769-7e4f2b6e6ccmr2931921a34.19.1778862745103;
        Fri, 15 May 2026 09:32:25 -0700 (PDT)
Received: from localhost ([47.184.181.198])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e55b7cd6c0sm1785956a34.4.2026.05.15.09.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 09:32:24 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: stable@vger.kernel.org
Cc: Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.15.y 2/2] ipmi:ssif: NULL thread on error
Date: Fri, 15 May 2026 11:32:19 -0500
Message-ID: <20260515163219.2279960-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515163219.2279960-1-corey@minyard.net>
References: <2026051541-going-septic-6fe5@gregkh>
 <20260515163219.2279960-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0480F554357
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248834-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,minyard.net:email,minyard.net:mid,minyard.net:dkim]
X-Rspamd-Action: no action

Cleanup code was checking the thread for NULL, but it was possibly
a PTR_ERR() in one spot.

Spotted with static analysis.

Link: https://sourceforge.net/p/openipmi/mailman/message/59324676/
Fixes: 75c486cb1bca ("ipmi:ssif: Clean up kthread on errors")
Cc: <stable@vger.kernel.org> # 91eb7ec72612: ipmi:ssif: Remove unnecessary indention
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
(cherry picked from commit a8aebe93a4938c0ca1941eeaae821738f869be3d)
---
 drivers/char/ipmi/ipmi_ssif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 266a5f223739..71622a95517a 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1880,6 +1880,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 					"kssif%4.4x", thread_num);
 	if (IS_ERR(ssif_info->thread)) {
 		rv = PTR_ERR(ssif_info->thread);
+		ssif_info->thread = NULL;
 		dev_notice(&ssif_info->client->dev,
 			   "Could not start kernel thread: error %d\n",
 			   rv);
-- 
2.43.0


