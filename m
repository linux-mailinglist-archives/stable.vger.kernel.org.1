Return-Path: <stable+bounces-240160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF49GFN752nC9QEAu9opvQ
	(envelope-from <stable+bounces-240160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:27:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C143B544
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54211303EE82
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3313D6CC2;
	Tue, 21 Apr 2026 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="XDC0u0EP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B82046BA
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777954; cv=none; b=hJ9BudSjMDyrIh/djVNa0nMupH0ZbRllQUZGy1yBDYGrz/17ovnib7a8vfNcc+n/jgxZDG8aeyQVPQK7IK1DL7JpZCNcLyCFAzRBdynbztCr1gZP3mVDdxC+H06LBp9w0yph49cQo/clwiIzStJ4Cd4Mr5HBim4n2e9p3UN6ZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777954; c=relaxed/simple;
	bh=79Lh6Hza3vFj/wwIyqRM4tXF0uZ0ixWXF5FGZekCV/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r66PkeRzkwXi94+kM4DVAOa3AgZJ0zVX2FAzvRj2TGdA5zoF6L0UP3LfDAJpeGxs/9vjxntgDbLbexi0DzkhQTzXZjizKTjTd1dBbmIl0JbPo0jmqkL7vm5B0xcrDvD/0qlDDVKp2vrfEG/azAmla6iTh1rmXUJeSGW2OEjU/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=XDC0u0EP; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3311163fac.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1776777952; x=1777382752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn8v2QAFkXlBjIgtscUI2wvGE8UVKuLcXTXCNPkIjzQ=;
        b=XDC0u0EPIV5W0vVerdLRRYIjQqCkyqGbzZlXNjQ1vh/TJ/K+5TjFH7xoc0RI5CNFaX
         nVGBuLzMnVzICsNesSq2GZarYHcfVp4F7WbpSljZkkKBWbQr0iBDwr9YuLp5Mgj4X+e2
         RTsqAYctnrza1V+yQ8SSJXu6CpKinMY6xGoPaM0s8vzxLS4JVpSnSAHjugU77Rvo7/4B
         08kuVqf01Kra95/KV6jEj3ffEPWaXAIWx2MgEX7VzLTjNqHGnNT3v/9LUBuLwtHz1Nue
         xxK+bIazR8REsStg4FlTjpFZkRJIX/Qe2lUQt7gI9kkMjkDpaCtPB4qxAH5fp4CjLRvZ
         G63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776777952; x=1777382752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dn8v2QAFkXlBjIgtscUI2wvGE8UVKuLcXTXCNPkIjzQ=;
        b=lcRfFUI9JizWDEeMOZvXAWbT/8Ftz5/+4ewqIdpIqXeH6QwfRtuTwUwKcrQj5ub3nv
         csUQ1/T6EisZCXbIGnutDpyu9gRyGZ+dKpQ0N4ZYuFbuWsSLiRlmDNGjoHOF8ZD7wcEB
         1GByYdHnKqFm6qG/0fKPDMFewhWbJF/fA2jm7qrdtreycQce49TtLH/doh2zwR59KS1m
         K+i0XrfjKxPC5C5pMsEa/EtgO1Q7xrvn9phSO/yyoPmOaq8G4f6xqUPpYZNnJqwbvRz5
         Wrg5JDM/SSVzuQg8iZiyYGQ/GjkGFfdKKSyf+jC39lqOHYTth7JGtr6+4V3AJ/PAHtw7
         hRHw==
X-Forwarded-Encrypted: i=1; AFNElJ+VGIn477rKaKi1FviHgEyzeSgrZ2DO5ek+qN+/E4kiXvEZTyO2qO1YYw8WXjgYniuhgPRbn8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9YGeM+GZ25q4twr/23vNZf7oXz+kXfe4wE2+6BqKqrdzfGqo
	HvTjkc1ZIsibe8nPjYNJ9ydd+Z/ThB+434PxQnnSu6H5+0BTKu1mKAy0EB0ow78OqFs=
X-Gm-Gg: AeBDievJ10FlJfBukqeYv8l1pusXkrGdZgoHx7ry3wquExff0eR7G8uIcQ2Qybrl5WH
	Do65x9IA4YQ4bvdlUNe1bHK7Da1g9J2u2jwJd5qR7xp+jAHbpMRKzSthuJVk9UtW5r7OrkZeOs1
	FaZeAx0zGRZTf8dN8C6rgtrvZoOI1bCK8GyTBqF5a7CGBOK36eT0E2Bp98Upv2GfigFPVAJUagx
	kPX54dhnMObDcWa8TjtqXkXAzUpoYNBd9v05s8vqyvRgGcYoXVV4D9TgeLmORGMRYguQh7ZASUj
	uVlYQa1sq37qJfBgRA5CYaJ5FhIRQKTUob4K8KXLdD0jIxQOinf3ewhRiOHmO5qdTDUOBrFBlhk
	IM/tkC5jx4hEFJg/Hxz7lViiMPQjzV7TCZzQS65/Qw/P31sZT0nmFmLLLfpI/Ycv93UeVSSrOGF
	SXZWrKCnDhfClsizbMY+6xw+VJCESlktemUzKobtxNhim6E9FZuo2mBjk94qaRkchFWYgWj+W91
	P9TmecVQON435Sh
X-Received: by 2002:a05:6870:2c91:b0:409:9a0b:b733 with SMTP id 586e51a60fabf-42abf29cc2fmr10719696fac.10.1776777951714;
        Tue, 21 Apr 2026 06:25:51 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:376f:c507:59cb:4749])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-42fae7ee3a5sm952278fac.7.2026.04.21.06.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 06:25:51 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	Tony Camuso <tcamuso@redhat.com>,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Corey Minyard <corey@minyard.net>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ipmi: Check event message buffer response for bad data
Date: Tue, 21 Apr 2026 07:42:43 -0500
Message-ID: <20260421132544.2666174-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421132544.2666174-1-corey@minyard.net>
References: <20260421132544.2666174-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240160-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[minyard.net:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,minyard.net:email,minyard.net:dkim,minyard.net:mid]
X-Rspamd-Queue-Id: D44C143B544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The event message buffer response data size got checked later when
processing, but check it right after the response comes back.  It
appears some BMCs may return an empty message instead of an error
when fetching events.

There are apparently some new BMCs that make this error, so we need to
compensate.

Reported-by: Matt Fleming <mfleming@cloudflare.com>
Closes: https://lore.kernel.org/lkml/20260415115930.3428942-1-matt@readmodwrite.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_si_intf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 4a9e9de4d684..08c208cc64c5 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -630,7 +630,13 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		 */
 		msg = smi_info->curr_msg;
 		smi_info->curr_msg = NULL;
-		if (msg->rsp[2] != 0) {
+		/*
+		 * It appears some BMCs, with no event data, return no
+		 * data in the message and not a 0x80 error as the
+		 * spec says they should.  Shut down processing if
+		 * the data is not the right length.
+		 */
+		if (msg->rsp[2] != 0 || msg->rsp_size != 19) {
 			/* Error getting event, probably done. */
 			msg->done(msg);
 
-- 
2.43.0


