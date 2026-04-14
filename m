Return-Path: <stable+bounces-237869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB9SAKA93mn6pgkAu9opvQ
	(envelope-from <stable+bounces-237869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:14:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD003FA5EC
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 728363016011
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA153E6DD5;
	Tue, 14 Apr 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMcfS7d9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434E3E63A7
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172444; cv=none; b=MU2hya9WDMDZ5x7faQ/ACDl3gOxBjSP2XN631SasCNh1hdsaxNzziteOdzvV5rwlbE7CYXWkTzM95srwi4En8OexOePrKPtIjZ2BfWWw51BXkrtByRHdQ4Bl6fZ7aQWyrtNmO3WyKoSuWxzP05Eb/lyHs0SYxmqJ8rRNxnL+Kww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172444; c=relaxed/simple;
	bh=NYEHalXB2jDAOMKQYaWv9VzsDsdm8AajciQKa3U53EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNjRrTEnPxqHRwtKJMpW2daa0zWM9/ztmhO6aDKbMwc5bv+O9m2LOjzA024D1h5NnBD1PPxj81hAB9WexVqJPy0fiME4/uwsT4wfcyqyS76BHaKTSnwHKxtYVtOlwnr+y2Hqq4P1r4LvZBIhf4GJtP/j8xC0/Rc46KiMExfartM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMcfS7d9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso3192981b3a.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776172443; x=1776777243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2yQNWWDsx/mIlUloKDUpE0HbqZx6yFU3riRkk2FowU=;
        b=kMcfS7d9ipWa7O7HIrN0p2LJ9LrOQWhStj2JUB4cqkSVcUz0iqRTdHQRCAcN5Z8h8+
         QIZv1nam6IqBUkXEBsXxKMDYZwyz/qTr8YfhYGTiQOhaHroFKcOlVBZMrXuoEOJ9smTl
         refYXXdsTs8CFhhtSn553e55NvDx3Fyk7VYIAlLUWdwBI42gF/B9Jz8ABtXVp4N2VraG
         TrkNma5zRt/JL71klTywW9jzM10jOCs4hNMmFWmUneITJ7DGsGIPamBH5uUVy1mpaSFx
         h+TEP0Ue8vg1pKA0iO7Mehzq/NQHrw6ZJ/48qBhf7fDWJbsYRnH6Mnpue93VahvjHhJd
         aF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172443; x=1776777243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2yQNWWDsx/mIlUloKDUpE0HbqZx6yFU3riRkk2FowU=;
        b=gH2b+BN5t3X0EbcaMuqCtRoGCfPtqy3GXZOIQ1n2GuchKds81+bbRV+mdifSqtDt6J
         D0yA6sEVPu/wyQeENrm2otztNXrIlxC47XWXfTDlZmfC4ythSDXh/Ul8sG2fEE9Pp/DC
         TDIe2lFK5MysGnRcQ8OEijbb7vyDk0fjlPfN5BzdiovANQfo/BvUCRVnoygHGFQrGWEw
         hzdFZKmEzhbLthiHj2UxvqZgZAlq6gxi30ckx0XuxO0btxyE+aqnINL1fv69hNrrb6at
         Dh1BCm+ctnIEQydRjKUn2PBFgC14+oKRIiNLmWVG2jpRroFaxyJyHPVzuAo/4aRwVsTQ
         qqnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cSGujW2Galvs7IAUQE5keZKPx92E1dkMry8LvUi3WxsMtMTPgGlIS4vm7nSQIntMtBzvuQeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbJvfomXz/xjuAAn9UGnuI9HVgunhFzpyjWkVGviO0wIBdOA6
	nXJc7bOApLbB4a12ORJEBrjkz8FiMB97JxFvVPkwWRD74X1UQ9bGKXRy
X-Gm-Gg: AeBDiesr4tvUZibLHHcY/IBi6n4dXk3cszjRFgAfHL1c/8peJMWfdOZUZTSMpHyX3B3
	1IMt0mWwftdBgC+9vt2NcoagoimWODeI1oI+89a4xc1tXhCeqfM8W7CkWApyvA5CP2M5lAgjzBQ
	TINN7bwP/jPsodQORXUEt9/8pyfTFlC3iEO//ns1d50+NxsvmRPg2+Wha2G1WqlA71QBTZ0ma7t
	OUkjVfVQFixkNpdrXX7o9gKzAZvPXxCUTFcqOX3/lx4DGswL8szV6AnPhVyKh3mAyo/QerYrVzx
	Wpf1MMrgA/yDkTLdQpnlR1+wOsGRHv9+GknnFwGvJLfHgP7CvoyxLFPVzgWcaqea1wTG7khpk+k
	YORnzcctN2yEYAoCEvkVpOqM3WGP6aUgnqT4FrSoMM2+25+o/8B5jHY9VKJ/LOqGqfIQfPXBaps
	RW64dl6cfWaCqcczDkP448Ew8EibJZ/XaeB1o5A9ckGAoaBnH7z4AE5ic=
X-Received: by 2002:a05:6a00:400e:b0:82c:9f7f:3495 with SMTP id d2e1a72fcca58-82f0c351b36mr17153382b3a.45.1776172442703;
        Tue, 14 Apr 2026 06:14:02 -0700 (PDT)
Received: from tech-Alienware-m15-R6.. ([122.171.18.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b5a79sm15269008b3a.30.2026.04.14.06.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:14:02 -0700 (PDT)
From: Sunny Patel <nueralspacetech@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	balbirs@nvidia.com,
	byungchul@sk.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matthew.brost@intel.com,
	nueralspacetech@gmail.com,
	rakie.kim@sk.com,
	stable@vger.kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com
Subject: Re: [PATCH] mm/migrate_device: fix double unlock
Date: Tue, 14 Apr 2026 18:43:53 +0530
Message-ID: <20260414131353.8543-1-nueralspacetech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2c0c00aa-7fb2-4d7b-90b3-0309c13468ce@kernel.org>
References: <2c0c00aa-7fb2-4d7b-90b3-0309c13468ce@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,sk.com,gourry.net,gmail.com,vger.kernel.org,kvack.org,intel.com,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237869-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nueralspacetech@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CD003FA5EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 20:03, David Hildenbrand (Arm) wrote:
> As raised by Matthew, the entire code block is dead code:
> https://lore.kernel.org/linux-mm/20260212014611.416695-1-dave@stgolabs.net/
> And I even Ack'ed it /facepalm
> So we should take that (cleanup) patch instead. Thanks!

+1 

Thanks for the pointer. I will drop my cleanup patch and defer
to above patch at the above link instead since it already
addresses the same dead code block and has your Ack.

Thanks,
Sunny Patel

