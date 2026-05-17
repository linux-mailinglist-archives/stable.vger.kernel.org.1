Return-Path: <stable+bounces-249146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLNrFhcRCmpRwgQAu9opvQ
	(envelope-from <stable+bounces-249146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 21:03:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B85636F2
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E473009CEE
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213E2F746D;
	Sun, 17 May 2026 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2f9O7Hq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEE2989B5
	for <stable@vger.kernel.org>; Sun, 17 May 2026 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779044625; cv=none; b=cynhUocJ3iei5yhNDOxHrDDFk40MNQnTBelOYc9uisQfdkY03AMl+RVIv+Ly/OXocxygVKTRqmJAeWpKhVYpMjsbdfkI2MrS7EZgsdQtoDghhEFY6BLYGgtuizhhkMT1tUPwIVi3T4++CDVtGERk82daGVcnH6FwJRzBAu5FFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779044625; c=relaxed/simple;
	bh=doIwb3v5SqeGUL31YnrxB/ixVjxF8Ax83+teKGbkmAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWWPYFNZGmwH1mPn8vrRdl1oYCUwZVzyYArQdGgOt3Nn+hRIrzxXt+Ik4GFzxEN8Kw92FPTe+WBwc7BAm4EqHo0wKp/L7UvFpFBIgroVzClpb6itx2yyHIE64bLX30I7k1m8M3lZXulidXu1VZly7HdD3Y0P4upXDoqyhJ36Nmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2f9O7Hq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so7840195e9.3
        for <stable@vger.kernel.org>; Sun, 17 May 2026 12:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779044622; x=1779649422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAAWutEdnIfqLAID0zZG1UZooygo5KGwOl4Z8XVbioA=;
        b=p2f9O7HqlQPLFE2+KdKmNA+ejm0cr31FXd6+FnspgrtTZ/N+G6ccPX97SUWUTb3WyU
         1Su8QdLWVAXzn2+Tx5tEZcsC3wxu22TiwCdbN/xye/yiBv9cJB7JGystx7qN0Wa5bBPk
         GM6Yrkox8jHJlc7NKRL4oWcNgPRzHGmju7Zxx+QnE1Lddp0b7szC3SbfOXC0Jwg2wtYZ
         f3U3fl+X5XM+iUyyK5tEVnhUkmeTW+4L4AWGaXcQCVwblJy+vUE/B6LXzOytONMEznwH
         8C1xI8yXoQxOW7+iPFi9k3jor1u9f9m7V6QOM/huz7t6UPh7AJ8SW3e/7pBiDj9joq9f
         FCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779044622; x=1779649422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAAWutEdnIfqLAID0zZG1UZooygo5KGwOl4Z8XVbioA=;
        b=JhQjdHHl+gs6Rbs9qcRhQf9FbBqmeJpWkzyOo4MTQYbiA0vEjmqSsGeI5XwXdEbK/g
         dD43CpE3A2LI+VIKD9EOcw39Y40eHlyD7UwPsIuu8A65LcFwy8YNwMLIJiKh3r7Ys7YH
         2Ip0FKUgesF1mAQEN9xDYfF8zT0bI7j0fO2couDEq09S4FZxfyj7Qmu0nGmEl0uuxl/Y
         KTdeqkXbqCuhTBm/z4/llS5O+/ApenP4Zo1SuKU3HckvlzCLxZXHxReB0GALp7D6+ugy
         d3tB894dKybUG/3yY9cJFfYPzf8Kfta+jpOy2XxY2jZOCdHHHoj4noCqcL/c0BuRavpk
         ZiJw==
X-Forwarded-Encrypted: i=1; AFNElJ+puZrWyfymSxnmGspMhqXYiwavYedin4giYS2JhphmRcNTp+OMlRPuG0bvvIq8wfy5PHgGiWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOqoYeWJEkvuMQtYYWXGRtxSapRzmdcwnEUYHvIaifHNr7TrKM
	bgT77H1dUwU4lahoVcOyd06FJCV122q51JgE7Ruw07UY9jex3YDA6oVm
X-Gm-Gg: Acq92OER+MyWeQU1bmf5tzHmPwDGc2daHkx3/zvw6kk5/KE0D8Hj0+ySdeVCI5ZhzxJ
	Aft2nd5vjxz7LsuhQO3NWKavJ0ixwGca50kksxz94SO8HDzTFX1QL0W3Gtos44XZrZy5pXL0fUJ
	pObsGNna3AV40N7lgE3+XTcQL+RcH5yOnTqQJ/0OXeL4zrfkoK49uvkW0pgeGHudh/OhVctAz3f
	FHR45HqLASuXUVYiruNTOd42UAO9D0Jxw9XM0qdT7Cz4wk1S4QCAj61JvJLvO9y0SvQknkjq4tV
	+2rNRhvrswtG/vqeTO5jxYJzB37fiHmSK+nAIgLv4bIvlaMO+HVnYEnQlkvufQDi6gzkCS1pU48
	eE5W/sB+ukgK7pKyugJAvVCPttPsO5rTn8gk40LHV6NOhsgNX1b9bRz11QzzYNfy1Az005XDsqo
	EhnCqvj8sgni5b5ogk+IMGwnezUesNVlaR7fTERhN86I7bhWwjF3xIsMOnTkY4r3SUXPjpfpCQ2
	g==
X-Received: by 2002:a05:600c:8b6e:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-48fe60ecc24mr191700565e9.8.1779044622151;
        Sun, 17 May 2026 12:03:42 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm67660135e9.4.2026.05.17.12.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:03:41 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: pmenzel@molgen.mpg.de
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Sun, 17 May 2026 15:03:12 -0400
Message-ID: <20260517190312.56076-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <860987c6-5a8a-4409-8943-0cba9d3cc2e1@molgen.mpg.de>
References: <20260517145417.31910-1-meatuni001@gmail.com> <3a7eaf6e-6e4e-42b1-a136-3ed2befa90e2@molgen.mpg.de> <20260517180832.52329-1-meatuni001@gmail.com> <860987c6-5a8a-4409-8943-0cba9d3cc2e1@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF8B85636F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249146-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Paul,

There is no safe way to access kp->value in the truncated case, since
the payload is not guaranteed to be present when skb->len < sizeof(*kp).

If diagnostic information is still useful, only metadata can be logged:

	if (skb->len < sizeof(*kp)) {
		bt_dev_dbg(conn->hcon->hdev,
			   "truncated keypress notify, len=%u",
			   skb->len);
		return SMP_INVALID_PARAMS;
	}

This keeps visibility into malformed packets without touching unvalidated
memory. Happy to send a v2 if that looks good to you.

Regards,
Muhammad Bilal

