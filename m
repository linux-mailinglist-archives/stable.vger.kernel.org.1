Return-Path: <stable+bounces-245205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNLQA1rWAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:15:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637750EABC
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E2423084899
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E888637B027;
	Mon, 11 May 2026 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="Kw5hIigb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187E3A452D
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505076; cv=none; b=e/ATXoz6VNMAeRyymE9RrE1iJDnncJcFoYze4icbAz3ROV0uhKPjeb5XRnNnvdtZ+6tfHXRn242SDf6wWTNJqYvqBhIRkc8FVDfnz1PYPzAdepEKEPM95AUW0PeDFAV4K5jbk44SBodwoeJqpVf+101fvui29WakXs9uprMDdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505076; c=relaxed/simple;
	bh=TmlF73mBAE8nFK7SrXa/lCumDBYZ/TfJZ+mvM60yTxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY6l4X1lMhCgc8oZQ4prhZL9OHU0FbOD5oYjALrS9At4z4MzUg79Y942T0US2gZ/G2eJLdUemQSJFqJsbaBsGKGS2mhmOxnnHbyUVWfsY5aBlVm/su5xPcRpMI7MrGjiKaTu5pEpGfbifQn8L0Jss7wltRazwiN0DrfrcRWIgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=Kw5hIigb; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7de431da8fbso3505847a34.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505073; x=1779109873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZiY94xRt+IuZ0M/273x48bBifax+x2ozD/E/r9Um4w=;
        b=Kw5hIigbNYNQFhcpFPzq0GCFrjVEPC03kpYMDSX+xSWc0+tv4F8F6k95qiMzkta//Q
         sZ7F+HcHfWiim655OTjkfhJ3Vh4xkGdMeBJ4XrxZAiW9tllJ5XNZV4c9j+cWeqKTf219
         teNp8nUA/OSgsTavVWHVZpHicCuOPa5eUgQjLgifg4+LsABtn1VHq5RQ10MfLYLd23AY
         0wSmdqw/3nd+70ZdUkS7/GEfoKdeiO89kS/21qGjURM+lc4VscGfpKDgVv8kRx61JsuO
         GEBUt26MP14uLazUPQbqPUq/3PpTDhCsSM93dSnmmG/vK5gtsJShQAwyOYa2nQIM+vIh
         uPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505073; x=1779109873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ZiY94xRt+IuZ0M/273x48bBifax+x2ozD/E/r9Um4w=;
        b=GPc+uqypzqF4CPNHvt03LZRSnvDeb5i239MB5jBZneHlj0fpkgnsxjCJqZj+o6/Dhb
         C6y9szLD6epUnuli6sYhatU73eVsdfC6fwJoYbmb1OAAVyxEfzvE4GAYo/Uc8+qDekvV
         +4lAixAoyw19vJgfgDuBb+GU4y5ziJHpsh/KTbe6RL/zDS3+eX8l/jo7oplfoT+ZDHmp
         REQhpg4a3FwWeNNVZyEsrubjlYgF3eUgIyVwDDirD++yB0o3sOkaMhoKG9WNim25Gf/q
         pbxFrLh0ozCnD7I38F3wZRvuM6B+xzOcaQGihfEdTOhDycR9D9Ozcr9rtA9QngBd4IUT
         x1Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+5s7zBtLBOy26MZaOWAzhYlnarmqUfO6Zr6W1nVVTPOnzn5/oB/fu7sSOkRMgIJrxajXtpU14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVoNjahMjyB343Ye4LkIOwc3J8DOPIWh3TuuBo3Is+3kK0tw5
	TLXFQ2kzL7LYrCzEMa10elO/Xj3oLDgHDTBB1/0U5R9B8benEm2XmNeMIt9yZHqHLDg=
X-Gm-Gg: Acq92OFiGKwAOibhD48t+ZI4AIkR315meVPSCAVTZnEz9RYQNQKk4l7vKF1AAf9fQNf
	HMJGZDF70UmwxNuHGTE3hxND+lNssa4d2M8O4ij/PM+bMKfcKSsgzxBNP4diXdPzNUwF/uqM3Px
	7LGC5oJaZszDZaDLhh0Apjo92pva5IKNKJ6QkRhokxDvJvRXzYX8zdzgMLp6bRKfPajRueWGycd
	Ev/DOpWBQ6RdJ2EQVOJuk1G/3l2WMuDFZ0ptFFP1tykkEzDsfIM31LVxh8dP5ltahGNgiUoUwrN
	/+NZjVKZ31Y4rUExh/1x1af5MjJAzHDHedeQYw1YfVYWoY2inlkot7RYhk/2Fng+6p62qNw6824
	s1dLu0zLWcONXs9BkL91i5CJngnEfrowCE6+eU2ZgKDsgFtpna24DmUzMXYRtyfTW/RPeQDyWU0
	EhhfJO4FPi9Tnui+FxweH8OROHfYu64/UTTQ0h/dx5XpR+3Gw5+w4BQNL6OVyyTRonPGohlUxv2
	Aqwb8H3KmoY/MkTt4JzSjGY
X-Received: by 2002:a05:6820:807:b0:696:248f:809e with SMTP id 006d021491bc7-69b36cfd78dmr4878358eaf.47.1778505072764;
        Mon, 11 May 2026 06:11:12 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43557371c56sm9211519fac.9.2026.05.11.06.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:11:12 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 5.15.y v3 4/4] ipmi:ssif: NULL thread on error
Date: Mon, 11 May 2026 08:09:26 -0500
Message-ID: <20260511131100.1772190-5-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511131100.1772190-1-corey@minyard.net>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
 <20260511131100.1772190-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7637750EABC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245205-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,minyard.net:mid,minyard.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Cleanup code was checking the thread for NULL, but it was possibly
a PTR_ERR() in one spot.

Spotted with static analysis.

Link: https://sourceforge.net/p/openipmi/mailman/message/59324676/
Fixes: 75c486cb1bca ("ipmi:ssif: Clean up kthread on errors")
Cc: <stable@vger.kernel.org> # 91eb7ec72612: ipmi:ssif: Remove unnecessary indention
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_ssif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index c973c0d92319..43c4863e7b03 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1891,6 +1891,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 					"kssif%4.4x", thread_num);
 	if (IS_ERR(ssif_info->thread)) {
 		rv = PTR_ERR(ssif_info->thread);
+		ssif_info->thread = NULL;
 		dev_notice(&ssif_info->client->dev,
 			   "Could not start kernel thread: error %d\n",
 			   rv);
-- 
2.43.0


