Return-Path: <stable+bounces-237727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DJ+J6/V3WkekAkAu9opvQ
	(envelope-from <stable+bounces-237727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:50:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DAC3F5CDC
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D66D3033A97
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B62F6911;
	Tue, 14 Apr 2026 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI8dW1Gg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB42264D9
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145831; cv=none; b=WmdiZ/TXCeIM6quKZrv5KGUwLt3ujBUCQ5eDef5GXL4sVLCQHMVkw4Kb1absGG0B861FFSvl1AePrP0BoL7OBiNAgVh6DXiPddW0LUVR7qxukXX61YhcsKnmgGGu2Y/H/NaGg0PaX2oI9F6NzPkMeujtYhug/rb6mot4hbUB5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145831; c=relaxed/simple;
	bh=EO6dYTjceUlFmPDZvwvnjlhudlIzL5CQnQmzqEBRskM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References; b=DSFWVyCixYtzZDhkav0wJYPkHbRK1GucMl/0L7/dLhhVx23z6/lQfkzJLM0cnMxCC7lvfkKVcMvImox5lQ81Z1Vb9xvgMnjr+HGFlpdEElW+jpm1K0X4jMmO6lUxyeUl2rwptv4DIshuzsbSNWsWmEOGZN40nRvXMpiht4G5u0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI8dW1Gg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d933da14f0so571489285a.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776145829; x=1776750629; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO6dYTjceUlFmPDZvwvnjlhudlIzL5CQnQmzqEBRskM=;
        b=VI8dW1GgeP3wucEEByK0yRF3BGcRZAPLs+Q88rYtOMm+nDvC+lhrKC2LUJENJOCmoF
         sG1kXEBirtMxEdnSn5qsNUJzElAs9RyQSqxqg8mTnz20VHhexI14EJVvgh9svf/dPCkG
         D9bhkoKzWbu3E+u4aBPYUiMoO+iKlG5ak/OgjtCyf3VILnPAMRwMrVevQhQek95NEf5J
         dlVeAXuXJ0ZGJXxcGYNuRSQLsiCygdT3KAl5GVo2As8m+ruO6ulCSiwwb/LC9a5B80Ml
         C+FuPECzlXUpsiaIDEKAhuWzpU0DQJkLibI3Jzour89kZIQ1O+07u6dKlwjbDXfra7KH
         kPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776145829; x=1776750629;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EO6dYTjceUlFmPDZvwvnjlhudlIzL5CQnQmzqEBRskM=;
        b=T7XSmRRiqFkbpL8GtI79RQKydroNNRxgTiQI/Je5zNAKw7UHzMYagv+qPlEG8Z9aUm
         Ki4HqvfY8GWLBE/ixUjOR4HC7X/GvotIrphiDAPpTtT8zFthnjs81JJvBkhwN1axQQ8a
         iqR+hLc0v2ZDSIoM4qUySyR519JXi88E7eP1HQBt8BWvhUZadsYybOznXbXyCd8MTeGF
         nlcXjFQp7NvqZU6UF763IUzF5v0B+ptQaMVR+ctMqwWOJD+cKrEQMHSb1GZQ6AwfGMbz
         Ry4QNPoXuyBSN5hDftLhdHi2VWMkXuCAxYf088ijNtdnC3cgYbB8nu0Rq9+1cbAh1V+O
         cuxw==
X-Forwarded-Encrypted: i=1; AFNElJ/qGHWKx0hZl3IDiLgd5KM0xdAEdgU9lncM8n/zt+Oph+sWG+y/uMLwUk03CAcyZyw0VExzzQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBai1C1r6IOV9oK9UK4DYEMxR6npECb6R1NJgMmKCVGr21g3tp
	RuM6ChLzZgYNDdFW6psJoVhdZuB3BbswGXGhIfoNWubT6T+xi7eYDwzUCrMWYbai
X-Gm-Gg: AeBDiesWXZkm2jVjBT4b7R48ytcDjJzGaiHg5hnf5wluTJym4zmVmj9x2+WUg0vv19g
	TzlTxYQnmI+ml6v6e3uDWK7BHegSDVBy+KtiTmVZI124jPZdDdQx5u+Cwuh+tNp0B19gGMWg7AV
	IWK/ZuwNmswfs70QWfYclqxyNEBmn5p3vKkYNeIOfoZUngxMgNO0aFDZgijv5RHP6NpueoJis0Y
	9umKllU+FuDsQV3BlsT1u1Zwb3oSlt+RpPdJWQQUGR/1EikxJkMh9DTBKcI/keNxo2FsgnOgRkX
	WMAeGPhgjj5onUmU7lhz+Sjbm4kg97W0L+4wjrhGCzj0XYXbPjLKaslIpbABgyjidGJ8ojBmez1
	7wBRuZ1bsTiZYJc9rJZSBXeF/BiF8oAQ27JI3mAXauYRkU6LjLEiGMZm9I7EvWlzFfn3yihdOvu
	usQGts/GXcGy0Bm5NyFvjtGUH0Uahm79AHixOQWs+BFt9otDvLjW73B1lj+3lHGjaGLNoC6YM=
X-Received: by 2002:a05:620a:2905:b0:8cd:9bf2:60e8 with SMTP id af79cd13be357-8ddd0591fa8mr2511603985a.59.1776145828730;
        Mon, 13 Apr 2026 22:50:28 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb934dcd3sm1067773285a.34.2026.04.13.22.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:50:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org, itoral@igalia.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/v3d: Limit ioctl extension chain depth to prevent infinite loop
Date: Tue, 14 Apr 2026 05:50:27 -0000
Message-ID: <177614582755.3604322.4429889371712210858@gmail.com>
In-Reply-To: <616c212a-067d-485c-802c-c1375094c53e@igalia.com>
References: <616c212a-067d-485c-802c-c1375094c53e@igalia.com>
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237727-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07DAC3F5CDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgTWHDrXJhLAoKT24gNC8xMy8yNiAxMzo1OCwgTWHDrXJhIENhbmFsIHdyb3RlOgo+IFRoZSBw
cm9ibGVtIEkgc2VlIGlzIG1haW50YWluYWJpbGl0eS4gV2Ugd2lsbCBuZWVkIHRvIGtlZXAgdXBk
YXRpbmcgdGhpcwo+IG1hY3JvIGFzIHRoZSBudW1iZXIgb2YgZXh0ZW5zaW9ucyBpbmNyZWFzZS4g
U28gZmFyLCBhbGwgdGhlIGV4dGVuc2lvbnMKPiB3ZSBoYXZlIGNhbiBvbmx5IGJlIGFkZGVkIG9u
Y2UsIHNvIHdlIGNhbiBndWFyYW50ZWUgdGhhdCBwZXItZXh0ZW5zaW9uLgo+Cj4gSSdkIHByZWZl
ciB0byBjaGVjayB0aGUgbXVsdGlzeW5jIGV4dGVuc2lvbiBhbmQgbWFrZSBzdXJlIHRoYXQgYSBz
aW5nbGUKPiBvbmUgbm9uLWVtcHR5IGlzIGFkZGVkLgoKVGhhdCBpcyBhIGdyZWF0IHBvaW50IC0g
SSBoYWQgbm90IGNvbnNpZGVyZWQgdGhlIG1haW50YWluYWJpbGl0eSBhbmdsZS4KQWdyZWVkLCB0
aGUgcGVyLWV4dGVuc2lvbiBndWFyYW50ZWUgaXMgdGhlIHJpZ2h0IHBsYWNlIHRvIGVuZm9yY2Ug
dGhpcy4KCkkgaGF2ZSBzZW50IHYzIHdpdGggdGhlIGVtcHR5LW11bHRpc3luYyBjaGVjayBpbgp2
M2RfZ2V0X211bHRpc3luY19zdWJtaXRfZGVwcygpIGFzIHlvdSBzdWdnZXN0ZWQuCgpUaGFua3Mg
Zm9yIHRoZSBndWlkYW5jZS4KCkJlc3QgcmVnYXJkcywKQXNodXRvc2g=

