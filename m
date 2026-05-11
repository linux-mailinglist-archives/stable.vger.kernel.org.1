Return-Path: <stable+bounces-245111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D13MFp6AWqMagEAu9opvQ
	(envelope-from <stable+bounces-245111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:42:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CDC508A99
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75306300610E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF18342CB0;
	Mon, 11 May 2026 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="G23YYp66"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E037363097
	for <stable@vger.kernel.org>; Mon, 11 May 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481749; cv=none; b=WDOEhHGh/bX5OlJ7y1RXPAgWie+WKaIelYS2CFPbnDUAsdeLd5XUvWlrRC07nAjj9ZZDeRcvmDJJpWr08Oxqaw6UtddB/sHeDwrO8Q6xpg2Lv1fhe8Co5mz20nb4hAlfFfwJI18LoLFOOJC3uyLqDMQ8uO2xMcfSYWci1JwOtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481749; c=relaxed/simple;
	bh=aqOreI6fX/uZN/lEw3smALiG7YxaCe62+LvjMxRJqj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnA8xbPLt5KMzfJknrICXigst3xMGxVQJOWBAfdCuiFZO4+VI7XrDn6sVcCN9e3kqHqkNbbh1vk8sDpvQ+EnMZI49B5wjpQHQaVUxPbpcIhDgbAmwtKw1wKUGKRY2kpg4QnXLxj/dDKkUZleUtGf4xWGnK17ymIdcJBE/e6Zt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=G23YYp66; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8367df48711so1725102b3a.1
        for <stable@vger.kernel.org>; Sun, 10 May 2026 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778481746; x=1779086546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6WETen+kRNNiAQvSfnOnKOKODS+5kYfhp3vdgbGUFvE=;
        b=G23YYp66afKKdS1/yKrOpuu7iRiNGvR5H8hQRYpysbYLSad7TZOcUzcOvixDOZvlYD
         pMoexS4VlqDwwm0WegrMRaUydqdR8F3mmLPyOmsXEpUAnxPGBxBBnZkcmffYpGJyGNVt
         y1qdrmAKFvX/hKMGxQB+FAHloHYbIYNLeOzMK9edX5a3GxagB+CmDJ9YsgfAGs9Ss4AS
         XMwjLo/2YsGzzz+1NoDnc98cQoF59DEg3hjQkY6RQ3iqUj+xdOfq1ZLD1BYhxFZ2rUkj
         qZ0hAhBqzHH3m0/tdUd2MRy/zKYCaKd0E7sQJjKOghfCM6vhGXNUYoxZ8fFGAy+0e9+O
         kPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481746; x=1779086546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WETen+kRNNiAQvSfnOnKOKODS+5kYfhp3vdgbGUFvE=;
        b=tGKAdTvzu8iie+TZHg8qRZ2BWolKWmCuINAsrXUXXX3Fgbk44oJRWgoqhVt8X1K6uX
         wCigkdikTu/86qavyP4ja65tUuvYuWbz9oYi+D5SUd8jU4vug/nBcWLfJegTktyovPVa
         hX0GvVRnQQfoj+8C7parsjVC/3RphCr3c4Q2slFc0otp1bTCGL+XUVAC4s9cfDceePhM
         /fB3MHjmndHJmRfSQDZu31r3Dqrm7hXvDNaqGMRL6O1u6vwT11+eJvtA34r9Te+E/i5H
         6sD/O/SLuDvVQqKkq0ww3SUNmXwlicwKYR0hYuNVCQOlumTshYrKstg6qmNXxAorUQI4
         vjQA==
X-Forwarded-Encrypted: i=1; AFNElJ9AngdffKLh4BRVY9DsyGkLiau5KZS4gCqgdBlMRgS9AT4ROnzRbrVgF/m6BM+p8edXhCKWjY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEO6XkXpQSP9z7bHt8U3DUROOfsgsh1w550O97w9eJ2B5wyXt
	+YV0jZrAECOg3s72z67AFyjMg+j+JtnnVFHR0oyCMAIUvhloSqP8YcMroA+IPyTEpMk=
X-Gm-Gg: Acq92OHwteMC3LmQuK9Eb8a8EDBxU0KIhYhD9vXfsAebmhxLJ35gZsKxOTtZD8BT3EV
	WZIaVxwFAG8XU+ZYBbuOUTN4MhHZ+FZMq03GzSkkTyVEryJR+8Monifumsj6WDjikkRb1YldBsg
	Lm+SftBHKugW8LgEDcpub94Vx1NEY7XpR9z1En8EHp2oQS9A0xvfFOV8NgxZtHHie8ixFwjo425
	bObPJqon/DEvWvRaOPsoWbB1DJuCe7/u4Nfg6MyBydjaqAsneEj9bspufXIJkT9XgLEv8MmaKfN
	G+8slN1+NqHx6+IPONvo9NZRiZo98ScCtX2mHjxAGpcL/9fnczUMClYE9o25luH90fJEldYrelT
	Sqn9oXWGk5s4j/tfkPTnNs8QJdPJIfRkx9E0BaXvORYWq+lJtHM6enV5q7jphLoB3pqmHAhueTA
	pbOcq7pw5FBsrVHhr/dQwfN/jeEgZZgP0cNvxtqhuaM+VMc9eXBHd0wN9mrc8GCsy6TC4YdQfz0
	j0lSmzuYepnLQ6QoQMNFcU2lbWDETsN0tu3hKct1APbVOb6EwqQL/jIbQ==
X-Received: by 2002:a05:6a00:12d2:b0:837:e9cc:d470 with SMTP id d2e1a72fcca58-83a5bfbd016mr22454757b3a.20.1778481745668;
        Sun, 10 May 2026 23:42:25 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83967dbcf36sm23339343b3a.41.2026.05.10.23.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:42:25 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: vireshk@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	nm@ti.com,
	sboyd@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jcalligeros99@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] OPP: of: Fix potential memory leak in opp_parse_supplies()
Date: Mon, 11 May 2026 12:12:11 +0530
Message-ID: <20260511064213.33638-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4CDC508A99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,ti.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245111-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iitm.ac.in:email]
X-Rspamd-Action: no action

The memory allocated for microvolt, microamp and microwatt is not freed
in one of the paths in opp_parse_supplies() which returns directly.
Fix that by adding a goto to the error unwind ladder.

Fixes: 2eedf62e66c2 ("OPP: decouple dt properties in opp_parse_supplies()")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/opp/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index f96adfd5b219..c02e20632fa6 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -673,7 +673,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	 */
 	if (unlikely(opp_table->regulator_count == -1)) {
 		opp_table->regulator_count = 0;
-		return 0;
+		goto free_microwatt;
 	}
 
 	for (i = 0, j = 0; i < opp_table->regulator_count; i++) {
@@ -696,6 +696,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			opp->supplies[i].u_watt = microwatt[i];
 	}
 
+free_microwatt:
 	kfree(microwatt);
 free_microamp:
 	kfree(microamp);
-- 
2.43.0


