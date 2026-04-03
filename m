Return-Path: <stable+bounces-233164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tkXxLoCQz2lqxQYAu9opvQ
	(envelope-from <stable+bounces-233164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 023833931AF
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BEE3067594
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446783947A3;
	Fri,  3 Apr 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYLizsVG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701623A169E
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209835; cv=none; b=qE0TrooSbJoVqcpzB6Su8pNS+l0AMGWpfUg/kKGKOWZUVOYj6LaQIMTYX7sM7Dp8RBkrYWjf3coT0HoiCsZAfW5kl/2A2JmrDwvGfw3JNH8btiPEaUoLDyoC4DbBcTgmGQ+Tfme1bfuzWYnsM2kiD2gHFyr0cMsEUh4QsJuEX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209835; c=relaxed/simple;
	bh=4wAOxts4EStG6lpegLK0Ji5fza/gxnnRX+GBzYLxjCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxUeFx49LpWb3QNmz6YoWmpg8lRxbBqdwBoDCmbYv7gQeRh+QxFEhEvXUbd3yglEQYqDtjbdYZHkVWmZdEGLD8GSJM8ZfZ6Yvtd3UWLkrCw8hFMj8r/rzp8SdKXZn4CT+nBwmkoaNRkpzvG5rjwZPD2NoJFKnjXiM0yQzonR+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYLizsVG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so702106a12.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775209821; x=1775814621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KReXkppPG3uNOMveoUqnh+3H0YwKOe6D48GuF2fODs=;
        b=TYLizsVGH3d5oXqQzlhtBWQDF8SenJDWOIyl2JM6+j7/M5CIu8ohvSm5NJtH5jLTpo
         ZcdvwpZs99osHJMIhCNGKkWtjBo/wTwSJT6rWxFSrfGX1iS7tSXdDWPD726ac9WJ9PzQ
         7LUvs6L9A0yhKLXtgDdKbWPmXSqwfygbHo00Hy5/DT6xoWXftf/XEEb//M1gbcOOVugy
         lWAj4CDN8VoJOgRaSD5+qb4G7D66rxl2xlPxLl5U923r0nxl5g/IPSsmZMtMrML0n87R
         3eXXXRoZGe3YPx4bKJ79Y+mhgG3mRyrJB9mD2wQ3CX1Q8MA5EtJQTTjSo4CR8ivLq4DE
         gUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209821; x=1775814621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KReXkppPG3uNOMveoUqnh+3H0YwKOe6D48GuF2fODs=;
        b=LDVmJOuAKAR6tYTA50slsHCAjgpEGN5O8x3CBnP5PfMPvTk9MMRl9E8BfCAX+r9nIO
         xO2RwzzxVqZES3yo2P74UZIXendXi5HiMIRhyrD/UaB2BIBEGNDYybzk4glxHc117nB0
         IARsGMvwQxoYFmWcWPhg5UGIOw+cvKaWOBqtSyM5hug9pomcc9ZzFoQXMDDEankcE38s
         JLXJrNubGVbFxsie9XlmnT39GOmUDIOw/abP09BGfdtXB4UBE8wICo21QL+pT2l3pB8d
         9WwWQP45do4kiS94W3eRntamRy3BEMtwi5jMa40S02SINhdylPVe9eKO5hpvS4qfifK2
         9v/w==
X-Forwarded-Encrypted: i=1; AJvYcCXDvAHTvUjh0I2QkSyE3V9GDej3+o2/+uq7uVmCTN9P0HBHV4DvwSV94xzBPlau6xwHZvRFKBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QlNn2G3rxyI9V+C8TLtduGQrqRuBj/9u5Da+SKwxi7OzF4t8
	3TZkfnVe/xpmBY1+uT5Ko4FSKR8bB3TZZigjc2vO6TAoFu3W3VLXmTrr
X-Gm-Gg: ATEYQzzo4uvDzCISZosugYv+evER+ciyRYOSQfH4SRaHvG17sLy9GJ0ouqktBF6DgOR
	JhoGktDDut0CLzFmjjDRv/a2aIsTTmU8aU6xuoNUV3y0HfY190tvKT7SR/BlZZoptymtmLE7hZ8
	+Kf6fBFuqaiBjcuj3DsHxiDbaa+wjoyBGeCKxdgSBONcSs/kdNAc8QylgKqUvJB6bYaNDwWS2Sa
	YpRoW2+Aukx98yKofpUyIi4+voOK/kbnvrnR0LnGffUGas8lWR6q7+lwnqSfPWv/PlQKgfCScCy
	1nUvWetHWMeOak80gHKYw+IMv1yRrx6xw1O9H4rbPT5Gw3X9MqeNWDQJ4lM4IUC9+SctlaREe36
	+sbHuXu+wA15bmUyMsh/mOIcBIju+Q/P6v0rIsKI1pmU2HkViVYEAKeYnYc4XyHqxQuQbxByd7w
	LcW0xZbrqVgMOfmd8LA6laIDYZJk0rUh5GwtJrHGl3K73wVwUXYzc=
X-Received: by 2002:a05:6a20:7d8a:b0:39b:81bf:15ed with SMTP id adf61e73a8af0-39f2f3358c6mr2215246637.52.1775209821060;
        Fri, 03 Apr 2026 02:50:21 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6561fe9sm4612331a12.15.2026.04.03.02.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:50:20 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: yanquanmin1@huawei.com
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 17:50:19 +0800
Message-ID: <20260403095019.29222-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8a902208-675d-4564-bb31-fdefcaebb752@huawei.com>
References: <8a902208-675d-4564-bb31-fdefcaebb752@huawei.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233164-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,kvack.org,kernel.org,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[aethernet65535@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 023833931AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Quanmin,

On Fri, 3 Apr 2026 16:59:38 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> [...]
> 
> I'm a little confused, what does "causing kdamond to terminate
> unexpectedly" mean? The damon_lru_sort_apply_parameters function will
> eventually call damon_commit_ctx, and the power-of-2 check is always
> performed. Is the early check here to prevent some more broken case
> or am I missing something?

terminate unexpectedly means - termination not initiated by the user.
(e.g., not by echo N > enabled)

The issue is not about whether the check exists, but about when it
happens.

In damon_commit_ctx():

    dst->maybe_corrupted = true;
    if (!is_power_of_2(src->min_region_sz))
        return -EINVAL;

Even though -EINVAL is returned, the 'maybe_corrupted' flag has already
been set. When kdamond sees this flag, it terminates.

My patch prevents this by rejecting invalid 'min_region_sz' before
damon_commit_ctx() is called, so 'maybe_corrupted' never gets set for
invalid inputs.

Best regards,
Rui Yan

