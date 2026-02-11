Return-Path: <stable+bounces-215771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OINjIuVEjGl+kQAAu9opvQ
	(envelope-from <stable+bounces-215771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:59:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4F12279A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 994BD300D9E6
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2F9350D78;
	Wed, 11 Feb 2026 08:59:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325534F46F
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800354; cv=none; b=VtnSI14Mv59j9JhIOFwLQ+brFZye4frQcPWbtHpmkDJSQ/l+5Hg+bkqhRti+l5zVEfcqvjPPi8Qm6BVeQld7wfy5yF1aDuHYOjVKbGtWqvG1qLU0FJBwz53XA1D3OpwHO9GQ2AlHafQI8+oPd5qskFARCH4P8tLCe1jBzkC3VqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800354; c=relaxed/simple;
	bh=untbHeSgClt1NbxyXv+2H3wxS2fkUX4eMkF88xDOoIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDBixnr0Dy1T9GxHTRH/GC5iBI5ujaw/yE2s1PtE/53pMO9HXXK22iq70d6us9RHtHVXh8+FYBxChegbKp3sg5jX4Z6SsSF9uHNFwFmqKv0AwQ1pAb/lvd26Oei/spYP59IHZQWZfG7OW2h7LArJtv/FfjoB1TUTNOsNSRXNo3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a95de4b5cbso43911445ad.1
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 00:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770800352; x=1771405152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yK55GKsRQUKRb2pbzYX2sV3DuP8HMn2n/G9bxyEv3MY=;
        b=sonJqcbYHZsAstQGyPuWMzU1dJKlxSieI1KGWo8WVzE8L7tBwfJUj3fvOUsSjN2qD/
         09yOA2xxE+BRnU3KpiPYG9wLqzUaIC8VlXU+Dz2EyXdyFr5JWxiMgAtrFiLYeCJaV8Ow
         UKkgsYcIIf2A651kw2H0PmLoPQ91D8SerZ5+9jjfymDxKU12PGApHiMNF6XLduwfMPQ4
         jCXHzOMdpyhimWMzjKesI7YMnDEttn0c07Z8P3S1Jqz6KF6YUOI/iW9aWTEjpzVmADik
         G/jR0sFOoDUGGU/0v1djUIW+Dtv23Qem5kcJ34+4y8xePj/XK+t6VHE62EgnNowWOMjB
         BMsw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ScfgJZwd2o68CoTdFxqq6am3L5CpWuoicgfE58tg+cm6fbLljwY9YMSbMHCV5fOcbXSQqyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VpVSCbSchDG+/XqwT/cazSS01Hqni3AvVmvhFAvMhzqYpQMU
	rQpKyWE5mOfNxmylSpS7vaCHu9f6FrnwRpmtj5lmOVQ12BxRvGIz5TQq
X-Gm-Gg: AZuq6aKacsbQmf/BTLAtIXP1IGxToDmA+RrmSqmjqcvukM5OKx8MFdCJc1qpuzkshSg
	OmocbjwFecOY2JGlxwBU/OGc6ABhUEcVzJz5Dl0vdl+2zFL1ebfM4lNnsvsyXl/NjFarkDLxACO
	SuodBMwckIV/PR8q1cwrK9UPff3PiiyQOAKx7+1PWE6XPWmP5y3fGYsqXtbrwUjz1ucKva8AEof
	3KP++jftVBCcgqtv9NuYvdwHDx9w3eRc3Xx7ZVGcPPtyuYRsdIMja85h4o9GVezL2Kji0SKNFiL
	kzWiAQLfmHzXiZ3gtFRyQt37erEZuFztrvhDxaSXnrhL/XNXNLk1aM7/3HSxVqKHOrsiuv1iT4d
	VGq83IRXJno/rg9NY2TrXP/+8yL+6FwDhsePuV6YBncjKHZlHZ3jzx4yNkuEp8mA1SSeAWrfR0d
	lZ+NAXpT4F1i/G2LNkUZ+6SwVhtUsSmDmD1KRSYbn8jHd6LQ==
X-Received: by 2002:a17:902:ce82:b0:2a7:95d1:3c0 with SMTP id d9443c01a7336-2ab2ac070e5mr13475785ad.23.1770800351677;
        Wed, 11 Feb 2026 00:59:11 -0800 (PST)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2c522a60sm10860205ad.63.2026.02.11.00.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:59:11 -0800 (PST)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org
Cc: christian.loehle@arm.com,
	daniel.lezcano@linaro.org,
	dsmythies@telus.net,
	gregkh@linuxfoundation.org,
	harshvardhan.j.jha@oracle.com,
	linux-pm@vger.kernel.org,
	luoxueqin@kylinos.cn,
	sashal@kernel.org,
	senozhatsky@chromium.org,
	stable@vger.kernel.org
Subject: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Wed, 11 Feb 2026 16:58:55 +0800
Message-ID: <20260211085855.96448-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
References: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215771-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_NEQ_ENVFROM(0.00)[luoxueqin@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFF4F12279A
X-Rspamd-Action: no action

On this platform (ZHAOXIN KaiXian KX-7000), we evaluated the impact
of commit 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
under a screen-on idle scenario. During testing, the cpufreq driver
was acpi-cpufreq and the scaling governor was set to ondemand.

With this commit applied, measured system idle power increases by
approximately 2W compared to the revert case. In addition, battery life
testing on the same system shows a reduction of roughly 80 minutes when
this commit is present.

These results were consistently reproduced across multiple test runs
under identical conditions.

-- 
2.43.0


