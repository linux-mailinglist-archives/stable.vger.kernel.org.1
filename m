Return-Path: <stable+bounces-245209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC5QHR3ZAWqvlQEAu9opvQ
	(envelope-from <stable+bounces-245209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:26:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444D50EDB1
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B49D3006836
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A753E5EEB;
	Mon, 11 May 2026 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="oQ70BCXS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5833ADB3
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505617; cv=none; b=nX25Og2iP0gvKykPIcBLuxAI2dYqKvWjJXZQcwiVwcj9OSQ5TwuJTlHqkd4MakGPUho5m4ToZx7ZvgzUJT91nOYn4MLImBEmVtxjYpvSxPyrf43VVLKTCJX+973+FRjcoQOvWa4gPTMGkL8RiQuAMOl+EgJdaUdb2PbSsWKyxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505617; c=relaxed/simple;
	bh=+ZUpcpMYEUXEaJnO9qiIXkVppurwU/x4hpZl008T2nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp0hne0jW/IYKFsRphhYPORcoqGLNLE1SYHvZytHPlVkWCXqsrCg46mC+udusCaYlB+oXIWGmQhkvEp9/FMrth/9uGXJsiTJy3esKcytKxmeEOqP5KrcK7+1xA0i3X1xrKHnhpqore2PFiSAbhRyW6ZSuoFKzL5Xhc183gG/19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=oQ70BCXS; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7de7c57b52cso3485442a34.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1778505615; x=1779110415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XaDF4hZ0HHCSzW0/BTdof1uueZEID8xFU5dqFnIvUE=;
        b=oQ70BCXScXjPx9C75hHXsgVu3kmcLDfjQ2nHbSVSuXtxunabyL7vn+PZPXp81ovYp6
         KDmm8fxCeuh4EAlpCbC7r2uGEJrWwUMhiS/3mAwcY38oJj1VVT7pJjD/94Udk91AjXC8
         KeZw/a+qxMcfZcpF281pBKb+qmmoQwM9zVgQ7pbHVGc2AyxDqRgwo55+82C/JSLZWO/4
         8IrTdCVhxVOEvtVB5s7vTl+wqeDSwUlFA0IjqIsyA89TiJgJKXZFORiUn+LbQZUkhSkW
         5bTzNfv24D+CUGb5Rr6olrEzOLgMjsGvRj5/+LWyk/BSYQjLNl+wOXxANFhxj5lpiYmg
         2hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505615; x=1779110415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7XaDF4hZ0HHCSzW0/BTdof1uueZEID8xFU5dqFnIvUE=;
        b=BqzQxoUDVpNU6WAfKX/Ez99Ua9g5A5ebQv+S5CTdBoVrc6T4G3FOXR4GRpH2825RJg
         IrKsi/3jgcUtBZGcC0s5sS+cTuaVh0JAMi/MiDlCXKfoipHRefvuNXPd+LEfeXNjatda
         9Df+vEAdFJ7+ZsV09IWa4tXKyqzFCWWKuGyk5V9PzIPg6dO/ec3dmeNF8YIeuj5C7Ejn
         f5h+iASrMVnwFyNea94ityFaOj1ZDe4ofkCQ2iw8F0Q4MggX5/az7NBuhJqiZj09TUTs
         l11n3IzAUX+ur5kxvlk2JHyxu32iDuhK/yQ1Fc/TAEF+m4r4T6iYdMtECEnPiO+0St8G
         UkxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qgkQW95Hn2qH9/kzSvoHSmP5mnNVniq8CmnXELkugVO88XkiBfs80I43o3R7hLL8y5/GRVls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKJtlCAwxjdJZaANrVXopO/NbjaPy5XSvx072l2+/Ds6vUdvK
	WtFLZ+mWHMmMGFWuEcNR7xdFiCW8mS9ggQaag4IDSxI7ixE7ZXCqUGW6DdBozhyJeFw=
X-Gm-Gg: Acq92OGNgHxzIK/v3HNawRNuq3DKvxfeZwTvA5Qm3fbw/KZ90+NzhFFh29Ei74YFWgP
	aNmkJ+nBGksIhlEZnW/bXU+cgO9In98EnGDPLNouKm7p9J4YF42qCvZCqtktdYKBHfRxIhA7bEi
	4UvWt5TlzkbSfqtTowXu27JjFg5xYhOlTaP3z3LpCRg/ESIECHBO13386BcV7xGaR95uVeWdY2k
	luoxrLr1OOE/WyvdlAo0JdEJ95cqwp1GGKOIteK7OV7rXWvxugtdNWwisNRPZZauCxmkZK/2Qgd
	E02hLqR7hqlPiB9ON2stBhZaArAg5EnmHRl10OHCYq1mMeje/TN9dAUm++YkfJEMb1lRaLhOUaz
	oJY47BRUB/kh+vwotrGjatA6EHmp7kQPJJMzABEs//+n+r6D6wB6F1QNNrpYN+GncksgWLnXV+3
	BxpLgu95ATu2x627EdxTf9MAbro7DF1hu6rD9LmfmKHrHHpO63qCeODBJ1aQQugNXdS08EAjgqr
	bU=
X-Received: by 2002:a05:6830:6588:b0:7d7:e3b9:58d6 with SMTP id 46e09a7af769-7e1df1ba521mr13999117a34.22.1778505615606;
        Mon, 11 May 2026 06:20:15 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8478:44:4948:b0d3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7e367be21f6sm6830459a34.2.2026.05.11.06.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 06:20:15 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Li Xiao <252270051@hdu.edu.cn>
Subject: [PATCH 5.10.y v3 1/4] Fix error in IPMI SSIF shutdown
Date: Mon, 11 May 2026 08:19:38 -0500
Message-ID: <20260511132012.1831026-1-corey@minyard.net>
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
X-Rspamd-Queue-Id: 7444D50EDB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245209-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[minyard.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,minyard.net:mid,minyard.net:dkim]
X-Rspamd-Action: no action

This is a backport of 75c486cb1bca ("ipmi:ssif: Clean up kthread on
errors") and other necessary patches with it.

Version 2: Don't take the "ipmi:ssif: Fix a shutdown race" and then
remove it and fix it later.  Just do the fix.

Version 3: Include a8aebe93a493 ("ipmi:ssif: NULL thread on error")
in the patch set.


