Return-Path: <stable+bounces-232797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FW/KFwszWn7aQYAu9opvQ
	(envelope-from <stable+bounces-232797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:31:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA537C2E0
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A15CC3087AC2
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B7446AF04;
	Wed,  1 Apr 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq1b0CvX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B146AED8
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053573; cv=none; b=Nk5hicHxNo4LxWMM+0KrYD9qbbvG87vtzXVNhzbhPweFhcqOVuj5MQL148LSX8chdYyoort9yc19IlPvfIzbxROmE+2ya7plnJBHr7UlNitKPx91P2ixppsdEsGVSByhZoFNZSwXiPi4lNdo3JNT0tOLpAuv9IaSjbDBujMpNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053573; c=relaxed/simple;
	bh=ITic5mu+GoI587U3EtX2iADmbMq3h3/7vmM+a4EMPN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXKSD9ZVtKOGt7k+GEEIdGWlcpb7tN460BCU39HIrzbPOljQkQXQL4l4uCkptA8kqBMHqZ1Q4I9Y4DHikTndDPveYwb8m6pvFErW/10lkQQ1OgeZ+QEgNR1JAOqCgAcWFGk6cPFANbNTTwq0YVGsW5syv0+X+f+KopFf4XtZqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq1b0CvX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad617d5b80so48173425ad.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053572; x=1775658372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hhqa35fXh8wwIiHwhMfdisdO3+HC9veB1HGkN/+YkLk=;
        b=Gq1b0CvX1FNgNe2zzBYi2nyovSFIefFvGt835nvuW2fLychXXUqSLBQVraNtBWVHdY
         vQ5nol8ihqqIT4evoEW9SzUL4dgGj5YTcfzSsGPpQ0LOcNm5mLl1K1VufEgrwWbfoHFW
         8uB10/E0q8Uw/vBeLd+M6Oz2DvIWRtf82bUjw/9e9mekudvII4TkkuC5HBvBwlXYSwcI
         un9xVAGIGWatkM2L7NhOzv7usBGgMxG0DXbrfx/YPecuVV3EVmONnt1bYe0fx0UIikmw
         12NZqockCXojfNWmJOt6WNqEHXZiwl5SujFe9jd5/A0wbj0QrKP0JhFq7nXAp+w1fqHJ
         dyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053572; x=1775658372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hhqa35fXh8wwIiHwhMfdisdO3+HC9veB1HGkN/+YkLk=;
        b=HTrvlvfjv7ob4rpX8Ja0t/JJTnIkV+3eXCj4DyvjU4zO1/90h/VryQWdexp+85o65B
         WUTtnKWDRTmiCCkXjzKdwiRJFPDfeK0TJERuJ3Kd1MFSE9slEMwbAUbsyN9W1hKHa3vb
         6rSXyV+YThJbazgJE8tqDEMArwr7brSaGNhiMjXKDspRuMr6dWDMN/I8UDe720wQ9C5T
         ziWj4rrYRO1wj9Kf223V9iG+GSPnqMr2nie3HqgOnprGNVJhS30w1LjLSo25floHG4Ei
         EbZFlDKa2AytXWk2N9Z8X/qu7TqhxcYyWi5RaBbQnaMUBjG44TLgVR4FOyXx/hKQxnJq
         NxPg==
X-Forwarded-Encrypted: i=1; AJvYcCXFy/Trk9yYyeTF/QA4k7oKWGSypJ6zNp2VoCi07wUtXXLV/6nPRL+jsMin/cWYlq+FornGhzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gVRmLSi0ZcpGct9PXRT0Lu2VG0hc2WbXM9Rb7uz3fcss0Om+
	EQO8cEhd5q9cgtTW9DcPSv0knjD3UugcX0a75gNdEnhEapnYPuFjFtJW
X-Gm-Gg: ATEYQzzy/+V3ZQBlFdcTBBf6+Bvb3TC104FQrnq6WRRJU5bd6l7NvRj+wbIcPo7anQb
	1EGU4Aryr9IaL5qVOmFJLw5cS7RQ+fqJ3vc+8kSw3UWIw+DFvCaWo+1e1O+aQBOHGs7iUbizy8Q
	utoDNGe51ir2fh+OT60+2j6qEDJnwprVh3i6nWXRV3Y40Shh6m07yk8OzlCvlfvTil7tuiKoz23
	KGV/U1Ir3nNQrH4htxBV+LSBS0/I6EXOqsPRuoxC6LBpzv6E1CWfI5OfPjE5aLwspvZa7RCg6CZ
	MNI0AgmfZdBRYTpiKiK0MCOvZl/shCt2LdFllgN/aL7y1jkxP5sBO9J2L4wrfM3gVdsbcgt7Stn
	k1NOEqr+QYD1aurBIx2/D6wvqBD2OnAZtk6A1sAjJLKICPAm4VUBZ9hPFKPGMrcrI3i8fgiTJ5m
	YVlNJs
X-Received: by 2002:a17:903:2c47:b0:2b0:6945:7dab with SMTP id d9443c01a7336-2b269cb8312mr37894575ad.46.1775053571808;
        Wed, 01 Apr 2026 07:26:11 -0700 (PDT)
Received: from hkbin-u25 ([2406:280:1003:25b6::6da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242680132sm158467045ad.32.2026.04.01.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:11 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hkbinbinbin@gmail.com,
	i@zenithal.me,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH] usbip: vhci: validate ret_submit number_of_packets
Date: Wed,  1 Apr 2026 14:26:06 +0000
Message-ID: <20260401142606.1861126-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026040100-brewing-ethics-990c@gregkh>
References: <2026040100-brewing-ethics-990c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232797-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,zenithal.me,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkbinbinbin@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AFA537C2E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your time and for pointing these out. 
I sincerely apologize for the oversight.

I cloned the repository a few days ago and discovered the bugs, 
but I must admit that I used AI tools to figure out how to patch, 
and generate the patch and description. 

I was not aware of the earlier submission
https://lore.kernel.org/r/20260329125437.517980-2-sebasjosue84@gmail.com.
Since this issue has been correctly fixed by the other author,
please ignore my submission.
I have realized my mistake, and i will correct it.
I sincerely apologize again. Really sorry for the trouble.

thanks,

ZhiTao Ou

