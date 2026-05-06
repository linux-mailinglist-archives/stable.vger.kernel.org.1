Return-Path: <stable+bounces-244422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDsEA8Rh+2kuaQMAu9opvQ
	(envelope-from <stable+bounces-244422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:44:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C01C4DD7F0
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1798B300F5FF
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9BB49250C;
	Wed,  6 May 2026 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sW2XE3mP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E547DD50
	for <stable@vger.kernel.org>; Wed,  6 May 2026 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082215; cv=none; b=SIyFXQH8mmmO0fPzLeWqNYSZ8+PoED1TfXTQc47jPlS6qK8Ngd4LEyX2u9AyH4RNL3WPEjx6yvfj+Zwiisfgv8oMk2DyC9iCIvVxKmuoWt2/tqDgPTpEtdiDocEu+iqY+ksMMpgD5fx1B25w3CkSBsHfxvTHWuwa5y+8E3aDf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082215; c=relaxed/simple;
	bh=fc0UCfWAi93QxZVKMurRg9gBAkKxhWc0Wvdno1Zk6bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfE2rd2LFogCarO8ECZ/8kM9pUBSo8fKG47zDD5yWnpdG3VPKOs0qHBVhNcGuOiDqysLJEPsH3vKhjVed0wQQTa5XrLhfsnmenL9Uxrq+XhSzJIcj21wgbH95riVBamHur3x9M1Jn6GsP9GLNE7gR6D5CmnUWUccH/uka4N+3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sW2XE3mP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso6752616e87.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778082210; x=1778687010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc0UCfWAi93QxZVKMurRg9gBAkKxhWc0Wvdno1Zk6bQ=;
        b=sW2XE3mPb4vHOvQGvESQ8wPufOM30UeFxVC/egDBG/ZNJLoKB9oQYGT+RXpoGOS8dr
         CS99HoEx6fWFZa48GHtUF/MTmhAEglIxTsBC2EglfdvIKQQQ0HKGJbgYkZ4cDh3KCgNk
         LJGcsSK0nWZf00FH+1to+MvsI09/RCUZJQWIIe5ZC7XMJjzYPaW8d1J5fW6+kW+qwkCj
         YzmYyN+pygGKSDYOAIKsGupLPpzdVpoG3jk9n3FCBxZ1f42WwCPLUBuxpG8+xQMCzvBM
         wx4xhE6vjNUL2QeaBu+Wa4m/JAKUukKyjYVmeAGgGJ1tDtbHQpIgc0SrHgozcgvKGYfv
         IRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082210; x=1778687010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fc0UCfWAi93QxZVKMurRg9gBAkKxhWc0Wvdno1Zk6bQ=;
        b=cYhYwWP4yuX+ef/U2RVpoHBODu+jI4Iw5NEv2xHEJFMv4DBnK3kbB39jLJhwYmqMrR
         +USLnlXmf7INrRDWnRuvB7BrbKowfmQOPFJTTINz/ta9ycwLaEwXzYLI68yj1Qqra8ya
         +0YUvNbLTI1MrDGJ82sO24sijl9bd/eRDhKyuFynzFg6abzMlshQbjSSDQV/tsJM4kBd
         qcIn3Utur09Iy2f6qP6LuZHOK/WGQ98jm8+Ucm+cowrktjpg6UYdoFLwSe3Y1nDz4rxU
         GaCXcqRtBkqR3IP9Qaz1iMjQ5Q2zl3XTpKKv24/AcTMqJ972C/YVTEz1tsHA1BpyElfu
         lS8g==
X-Forwarded-Encrypted: i=1; AFNElJ9VJobY7yon89pLca/K2ow2WBhrcWbVAiiG1H5fNxtSjEIfm1gnLHXyxjID8PnGYWoXTiixfM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwFh7V2WKrythRb/Jh8mC0BUdfDjKEtCkSFkmMf9hqP6JyLtD
	b5/gt81ZlYo7Sfym2ET4MwjbSHRceTb4MTs11UZZUt8nwGl7IFcjXCun
X-Gm-Gg: AeBDiesQlELSo4KSalzOTlJOz2GUUytjk7mVr3g5rPxuW00v3N8vkYLGpylW8+1AvzA
	dgPd8w8pD1VUOWOOC6kc5X9r4nml3RJzHZnVWmdy8oF8imYdztSW1DeQq0cq+lsrQZYjNUe8/Ch
	wHe0CljahJZj23i50ipJFNXx1tuQTryIvrrPle2dT0Ujy9npzV+h6bIu6PICzXKjw1AiAXAOQH9
	nkLnL9E+ThEXdiJfwLpHOginSzaz0iJBJZTCxrc4dGoqfkBN02INyfmP87J+KNmqVQ2e8vnXm+2
	9OYsQHawpeeKfC9ei/7QyiEZn+XeWRKvPuGA7dDMUhpAcxyMZM3tVVIlyl0gsBk04tF8SE3FCIl
	wEaut5gHu2JIHs4WVzRL4Ec5hAyRGHYEdS0WklqGHudQWgsvSQS7zivD24fiPki1MsligDyssoO
	m3DHyPzO8lgyHnLpMFNVbS6B7wD59AHPLK0BmCDJmbOcK4q2WBOwvZJ9k98XQB4w2U/kGygmA=
X-Received: by 2002:a05:6512:685:b0:5a8:5b19:fd03 with SMTP id 2adb3069b0e04-5a887a9b5ccmr1445551e87.0.1778082209637;
        Wed, 06 May 2026 08:43:29 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393919f663dsm34884431fa.33.2026.05.06.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:43:29 -0700 (PDT)
From: Valery Borovsky <vebohr@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Valery Borovsky <vebohr@gmail.com>
Subject: Re: [PATCH 3/5] mtd: maps: physmap-core: fix reference leak on failed device registration
Date: Wed,  6 May 2026 18:43:27 +0300
Message-ID: <20260506154327.673283-1-vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C01C4DD7F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nod.at,ti.com,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244422-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Miquel,

Thanks for the review. I need to withdraw this patch as well, for the same
reason as the rest of the series.

`physmap_flash` is a static `platform_device` without a `.dev.release`
callback. Using `platform_device_put()` triggers a `WARN` in
`device_release()` when the kref hits zero, which is a dealbreaker for
systems with `panic_on_warn=1`.

The kernel-doc NOTE refers to dynamically allocated devices; for static
ones, the original code is actually correct.

I've already sent a withdrawal notice for the whole series (1/5-4/5) to
the cover letter thread. Sorry for the noise.

Best,
Valery Borovsky

