Return-Path: <stable+bounces-244470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TmzsAP3Y+2n5FQAAu9opvQ
	(envelope-from <stable+bounces-244470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:12:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C74E1A9E
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 02:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92FEB301456B
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 00:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396CF9D9;
	Thu,  7 May 2026 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imFzBn/z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38A40DFD6
	for <stable@vger.kernel.org>; Thu,  7 May 2026 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778112738; cv=none; b=BgKncR5iN9z+YQvXt6EJnmnonoloK9xQSVSTnOdx3ZT30aMZhzbjw9XoMxNswKeuvwlRL+h0ZytaHD4WlgnkWqbQpGzmAeaU/i+xFdOlkwpz2JdIW6v4+Bjb6/ifIC3yg610joR+BeLUP/Y0k+JbrJR2Xa1ANdXP7aiu/Vt7GO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778112738; c=relaxed/simple;
	bh=+E3p4h+AEI6FLIY2FtHBTWGC9BGVw7ApMIqCzhgSZQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGoc5tCoo16vySPt/WdqVA6CabYcVFLATyjP9BcgVMdN/JFHF4GHo50XURFBTTFJh2smugYm9ws/QbqnmbxLHFVd1MSWdsb6FfMFzV5Zm7BZVhtlcE0LP2N2hfSL8PUIpEtdMsbj1rFMmZPjcf2GIAoqizrI+ABSQsm14Q1U3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imFzBn/z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8f15e900586so13234785a.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778112736; x=1778717536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E3p4h+AEI6FLIY2FtHBTWGC9BGVw7ApMIqCzhgSZQ4=;
        b=imFzBn/z2F0M36VPrNcK4hT3qu/3A+3+ozhveJdAlXcTkp/Z84eBPyxdGPBQ5MuTLF
         DexdcupRk+cbFtvgOab3a61ZWXq923y6ffLNLk6sTveTEkSMn+6Abh6hLVEnNsZC0+4n
         MUnbPxfhh+hD4DV1CjaVj2RtVMxlykY95SZi6vmgMacprvP2CAIrQHXQ8bam8EVJkIdT
         b7Mtwn7BeGbbdIXNru3ZZQxL7ISi7lBVcjwmlPgEq6PM9g6cLFE8AIZIoQee4HRZr7A2
         rGsZPLDiTU9JHpueDrwz1/Uhe8onLRjfehAivdsYyk7zwKu/37xp7hqsVdQUwOPvf5kY
         V2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778112736; x=1778717536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+E3p4h+AEI6FLIY2FtHBTWGC9BGVw7ApMIqCzhgSZQ4=;
        b=UcP46FGXKAwmV8s/W0TOyqU6dOq35xacoS8EX1W9pJ6x+p2KUS+dqm/lnX0pavtyMX
         oRSuTNdF8v79p772C+V9Rlj9OGblLO77KwF8K6LSvrOA2dbdo41S8R60I/EzIcTS0DJe
         JPcYGs9zilISvKnppAJMRz/s4pgK7pDYvwsi4jqo00ao7awhL9q/M9zt/E4SXPvfT31I
         O8GTVKshtciEJ6KwWt98++zg3nTPLOtweM4KxbhmBOWKQv8SojDUcUECiyfqJDN6NlFy
         LSDlnNxSWaC0dBbAu29Ev4sECWo5x90H7qR6b5WOYIKbPzLGh1fZ/rwzsXC+jjnvZ0+a
         XpAw==
X-Forwarded-Encrypted: i=1; AFNElJ9NCO72dHqjst81BY5ZIQiCYwaDdQgz9Npdk+nIyu7cBV7AFuoJEaI8EYPznwMm7f2eQonGQKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPt/KbpiiqJ1vSNtMbZWn9qScfPkwplb/T8o8aup6W8dv9lKp
	CLnAjxojlmU7dYemYX6/XWEURJPp6RLQ43HAzuKmMJuzHGuyn+u/jx1KIFoO6+EyG14=
X-Gm-Gg: AeBDiet2T8kimSM/4ymeKT8lg/l5MYiuuqxl0svK+yXfVcWy2cVJxr1iCs7hZYIdzhd
	LAAljh3gqCRRZyJByPhDVO8G0EucMrYK78DFqhhfKVxRBDDBfdRFnSf30TL1hPEODVVtSZo2oyo
	weH3769WhOs4enUHeBb6Aiz19rGX5O11rWP+ggIZhBftfWTxSCcy9KPWFWC40GSvLAoN0jW/Obv
	V+E2p64iCV+lGiFdSMil3pYGHBIWr7x+aLyEdC7Cg865JPE/BcTJ4O1Rn8EjuaBtnBcoNvSIFqu
	HOzmHhpFggxXX9nrLj0jrA1vk8JW5buL9TFtH7GEnYHYu6RWe7QKDSGKkwIsaVCa4jzWxMx+u2R
	g+Z9JuFOujInXX7iZfKNEWjhIgac3cTm/biGfpJmX8n2Y6d2VLmkrltYrRE6H9Q2IX+sbYEchrG
	w1PAg9fiDDjl+lhlsASb87Xf1lRIEzL6kiy7YxkaM/xEAfRy35R4APy7BE2ykBVLVZHIMLE+Dal
	N/XO0d5BlEfNJd8bQNNu1quN/o7vHevOuHO/wdX4Yjv5eKoQQ==
X-Received: by 2002:a05:620a:bd3:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-904d3fa42e0mr840254685a.8.1778112735645;
        Wed, 06 May 2026 17:12:15 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c34a0d4sm1739923685a.25.2026.05.06.17.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 17:12:15 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: lpieralisi@kernel.org,
	nico@fluxnic.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: Re: [PATCH] bus: arm-cci: fix of_node_put() leak in __cci_ace_get_port()
Date: Thu,  7 May 2026 00:12:03 +0000
Message-Id: <20260507001203.982150-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417024545.141289-1-ashutoshdesai993@gmail.com>
References: <20260417024545.141289-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C5C74E1A9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244470-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Hi Lorenzo, Nicolas,

Just a gentle ping on this patch from a few weeks ago - no rush at all,
I know you're busy.

https://lore.kernel.org/linux-kernel/20260417024545.141289-1-ashutoshdesai993@gmail.com/

Happy to revise anything if needed. Thanks for your time!

Ashutosh

