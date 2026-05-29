Return-Path: <stable+bounces-256514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPyELQcrGWrCrggAu9opvQ
	(envelope-from <stable+bounces-256514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:58:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454E5FDAC1
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 975923043531
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE79D346E75;
	Fri, 29 May 2026 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6mmK03J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E8285CB6
	for <stable@vger.kernel.org>; Fri, 29 May 2026 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034101; cv=none; b=k7iy8iMTAeDJQeJT7d4mRtxXNG+V/rBKKqoBz1aN5OXPBSsJGWed8cN2VKtQ6EJ2xRMEo7uFCFComcLWS72VqWJqO/d8TZE399u4FZYlLvOsi7NkDlE0qVbrJOixZTb3YzAM4H4n941A+QiiB2MNAGGDshSOYFDkRyF6nb77Bwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034101; c=relaxed/simple;
	bh=6KZFpkWM7POjRcuxHbUUAl/+IGx9GORWkO5/9yx7ZLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4NpSpYOdlVsF95Hl49MKNd4ih9OqIWJYvrmso7mCbQPabOWdYauTE7bgzm3IbYxko8n+B/ZMRwpdpuNW/tZpHC385PBF2ISo/sDHco60DQeqWhg3iQ3zDEUrV6KdMlBz9O9rvPEOS9ud0TEkDSGlUXTdHz/Zywxdb9wA1iFG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6mmK03J; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so591655a91.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780034100; x=1780638900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrgT5+AKDUjY0IjOuj4IV2fg45b2KCmoTYhcKGwBdR0=;
        b=V6mmK03JcymYX83vDSkOSthbvSeWsxS73687s3YZfOmRZcUvO1odW0gktIXffMU/LN
         Ne5/P3p+pIxOVNPMzFS+npSqIrNU2m8RwwyiXW7K2RAsyPDQtJq5bu4UckMCnMuiBHqj
         tY+BHm8ZDfYFfsPb4EPTyjGi/IxIaF7GmHzuyqxQotOXUdvnUWcaA4/4C6aVDsdP0Zbn
         LbFEq4ZtlKIQ7mt2LDxo3VR/tG2AjIv0jTMebIL9ubk2BWwuBYk/mE20iPdedP9By9bz
         xbGcOBRJA+gbHnoGnULy3SZWAB2NYJFpME5SN/LgYhRFQJ4P2vPHTYFTbt5C3qK1HkH3
         YYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780034100; x=1780638900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrgT5+AKDUjY0IjOuj4IV2fg45b2KCmoTYhcKGwBdR0=;
        b=dpWon6neyjaF+gcaJr08CRhnVAgeepvNqlE7W4koWh5TH7wZ7kLFG0tSNhtUZWLOV/
         K78yE612EAu1DjnhkVRe5b73AmttJJJ13ptd/9033idiFusFSIqJg5/BmIqgiPWRnXOw
         MzNTQOvyQggIisD7ofUevNJ1IEm6dBYqkYPFsVWOg/pDSdqq5PubaiSgbteAAY0omgaz
         m1rUVfPmxK5/XWA4J3qHNJSj81jR7Mtx9+ngtaqOwPEMrUCb1TyGi9/NkMhNMCqCkv/u
         jqXJkWUWxOJJ4gp3y2vipG2MhvmhU9RrsSiL0Kwz4jGIvduqTZENm35AHgGd6WDiW14Y
         Jjuw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ok0EvkbhyLkJC3l3jAR1hNoTs5ddY1dImgDCTcLc+2ytgv+aWXBZFvzqDZBo4HOPFyBpHkkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UIVNwFS4MuGARSTMK39EOSSxvARQf03bB/kCvwQAjUleJu/n
	vrfJMED9mI/otR4MtRDkQdS7gVLcvt8QntXPddVp56XS0lEvHtbkLK5mPGuyJth+FA2KGw==
X-Gm-Gg: Acq92OGL0jTCrYCjDeAVU8DgVkyLqCtv/3WK1CaClY7aESY4IQUF2zG7l46dL0bebcs
	P5kzaxQhBEczqWcPZq2XGfntdj+PfnHfIhcITlxeSMy7rZ5456DH9XPV3HrvvEAEK6u751e4nHV
	y8vTq87emAEWLL8c7kkqE4yzbkaAG724ipgPbSkSKCrg2soE/UtsYglRnc3QAr6oGrihQEC3XYO
	H3ygO6FgfLp7B9WP/P1FkRFc4lhVvjCEtnyPqaCoLAKjUvLcUykejeiiqpawt7vhXf1N6C7U9d5
	fnIKBgo/poE45R0TdGbpPv/R7qK7WzS5t8GEwHnvHSt60hVGCA5b+UFLejgEeU0XFcB6BdcNwnD
	netFy6wy4b1WkasKDe6gDZEKIR4LYk/StdVknPW1ecdwVhPobbbeZLN1WDrQn424PDsdAoB7eE9
	Hccx/JoEwMSWZ98WCnjZC1PhthJI+heiVwhSYTvnOoiTtcP0FPk3yQ+3aIDw+N+5m/LJrdqQNl7
	yvWxUfmLQ==
X-Received: by 2002:a17:90b:2686:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36bbcad64d8mr1869227a91.3.1780034100032;
        Thu, 28 May 2026 22:55:00 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([240e:3bb:2e83:5c90:7639:89ff:fe18:ac64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdcda52dsm413399a91.4.2026.05.28.22.54.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 May 2026 22:54:59 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] wifi: mac80211: capture fast-RX rate before mesh reuses" failed to apply to 6.18-stable tree
Date: Fri, 29 May 2026 13:54:50 +0800
Message-ID: <20260529055449.85775-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026052854-skimmer-nutlike-eb6e@gregkh>
References: <2026052854-skimmer-nutlike-eb6e@gregkh>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256514-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1454E5FDAC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Please drop this for 6.18.y; no backport is needed there.

The failing cherry-pick is expected because the code fixed by
d71c841be5d9 ("wifi: mac80211: capture fast-RX rate before mesh reuses
skb->cb") is not present in 6.18.y.

In 6.18.y, the fast-RX mesh RX_QUEUED arm is:

	res = ieee80211_rx_mesh_data(rx->sdata, rx->sta, rx->skb);
	switch (res) {
	case RX_QUEUED:
		return true;

The later vulnerable post-mesh stats update:

	stats->last_rx = jiffies;
	stats->last_rate = sta_stats_encode_rate(status);

was introduced by:

	cc18fffa3a517 ("wifi: mac80211: fix missing RX bitrate update for mesh forwarding path")

That code is not in 6.18.y, so d71c841be5d9 is not applicable to 6.18.y.

Thanks,
Zhao

