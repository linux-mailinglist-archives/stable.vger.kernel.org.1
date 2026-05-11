Return-Path: <stable+bounces-245201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I9MNV7XAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:19:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5050EBF9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADA9C30B1F63
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBC3B19AA;
	Mon, 11 May 2026 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="Lzfmni1y"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73D372EF0
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505067; cv=none; b=TzV26sF7vkuWbN4cIJ+hDW8n4hegJA2uJ115uJQC2mil4o39KG6urQhZkCn9trJnkt5HMy5yPN1v0kaM8WLLTkd5nmYZdZ5ERftYiLEYMXrELL6CgH+ew0qqsoDTBLDh1XqRHZwl2Rz6CcKgF4B2tV9DYsbkxDoMqoIdA01nGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505067; c=relaxed/simple;
	bh=+ZUpcpMYEUXEaJnO9qiIXkVppurwU/x4hpZl008T2nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq53pqjPB1U62IT+AY4dq+MvrbKoKoh8nTfdgGUm8WfsM47kdMV7ZL08Nw0CZZ4AktDISXQ//+8v4UqFVzxKwqC64RCAELknyHcEFng4JrDyO+bsnifjJFQXQGp+vgc3rNxMDgsB0ex7z+Rb7V7tHQkzlI+f8X38M/FHO7I9q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=Lzfmni1y; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40423dbe98bso2187153fac.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505065; x=1779109865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XaDF4hZ0HHCSzW0/BTdof1uueZEID8xFU5dqFnIvUE=;
        b=Lzfmni1ylG2HI4dBKU2deOkjPCrboPQpsVk+B+PrYsSfeznlNhGM+qLclFtGZ/bE/a
         pKc4vep4X4Qah4O6ugMlzwlOzOPhgte3izR2UjrgIYemgGtxtTD5Ncg4CyklnxSMoObf
         YHhmq6dc0jP96er/gf6Sb54LJnHwkFnfk9jYJAQuE1T1Zw0SsU7I4iyriKchY5rjXpUy
         h/3LA6Cg+IxgSLVHKQ577oMBzNygAzRj7FMvGQIhLV57ung7wZgOwXAshASHbMkt6ZUa
         0c8JC7w/cosBekDYytCM9NmU8FNUIcqHDq6CSTi6U2Uuh7JlwPQvpbNLxAp8K8Pd+/cN
         +mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505065; x=1779109865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7XaDF4hZ0HHCSzW0/BTdof1uueZEID8xFU5dqFnIvUE=;
        b=j9M+YZu0xTjT1FPPLhYsTx/x9AAhJ3G6DCJw6JwrSUCknQhvakiFOdZJoLs5Yjz3pR
         T529p4qEJcsS5yoXAgPfYipcVikz43fR/N0fLN28XQnsgN/d5Y7Eg9jMngnqM49iQ6W+
         KTd4WAYn7KHslXfn/0hI93UBC3Me+cTtDQ5eQBv4RhoElBbCf8iIk1fW9MNHy9Rd4qNn
         8QhJHJBtKrmmnBULxJ7EPhwRxnfXBg1tMXqJQ5wyiC/fH1TvKnCPAVaSsMmAQa+zvW3j
         pBjYQ/VY9vIhpTikgMm82rj0GhHD+8UkWHT1pHpW/cuy2WuR2nPXMvlX4dPSIDTVeZhy
         XkkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7/NtKPCJxIXsIJYIy/eEH9RulazMEFYapkeg00QzDFkhcYUIYsMEQXKNBOFPLMzl7mdTdeBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/YdfhNL/U0sYbb9VutywcpkQ4oD3PeIc+lQ3rZe/ox1sOx9M
	fX/+zSpU5k3mdJvA5zEOb0qJzrq1tDNK0NRuT+97GSpsQ0/J0QY6cRlhg7z3wb3bLcE=
X-Gm-Gg: Acq92OH4paHm0RT1fiwW53LWlAzG54bykye3143P9uEjP1f8Hc0N6bJdnbjespAnbaV
	4FqZfWDBD05b6BahgiMUw0vKUoKot9qr7vtiJHGg9/FtwULmiYPKtofWImvCNC7wQq3pF3bx8Ue
	V8MevJrPCq1O63KkhjIdE/JLoKZeXJ0+nMKDs2m9Un0RbuB3lgx+6u5qE6QCN9iyfg8wXGZ9I6K
	IF5ABGPFDxlf7ic97skzlCZ864Zjny2prypJAol3JZJPpMdMhyAs3QgLLuZWiZjnDZ/FIHB2Mlr
	XZpUXrUV2hBsIRdEeDMkyeEqAwq7P+5GsRgfmSvtshZ159RJH0Vjx0HfAPAsE+hE6pV42YqyefS
	oJEZxhUQM1cR5B109jrrMFaEVIQaayVoDt+h8A+T8V5XXKZ9a3lFa4qWYYTNHMX04WYCLP3BxsB
	fAborL3C3zomGh6/JkfoUeZWjfuqhN3X/8/WsEh/EwKzcvCIslOKGjvcDNs2t5g7sKfRwHEyNDw
	4g=
X-Received: by 2002:a05:6870:a446:b0:41c:5589:ec48 with SMTP id 586e51a60fabf-434f5869e3emr14142470fac.16.1778505065152;
        Mon, 11 May 2026 06:11:05 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-435570ad92dsm9947425fac.2.2026.05.11.06.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:11:04 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 5.15.y v3 0/4] Fix error in IPMI SSIF shutdown
Date: Mon, 11 May 2026 08:09:22 -0500
Message-ID: <20260511131100.1772190-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
References: <20260509122858.ae87f8133ecd.re-ipmi-ssif-cleanup-5.15@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36E5050EBF9
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
	TAGGED_FROM(0.00)[bounces-245201-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:mid,minyard.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is a backport of 75c486cb1bca ("ipmi:ssif: Clean up kthread on
errors") and other necessary patches with it.

Version 2: Don't take the "ipmi:ssif: Fix a shutdown race" and then
remove it and fix it later.  Just do the fix.

Version 3: Include a8aebe93a493 ("ipmi:ssif: NULL thread on error")
in the patch set.


