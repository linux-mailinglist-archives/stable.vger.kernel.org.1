Return-Path: <stable+bounces-225398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAkrDHKQtGl0qAAAu9opvQ
	(envelope-from <stable+bounces-225398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:32:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CB528A6CE
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72C6F304A0DF
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F115E386428;
	Fri, 13 Mar 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmUun2lo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F663876BB
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441065; cv=none; b=rnBy4xON4Wr47qZruPbryeglDB/aXme5We861vnAB72YBopBOCy9FxtC1GnSBTvdRUJAEQTK8vn+w7SpYjfsM1kd0Q3qrsaMcB35LisAzxR77dy7zZqYc376IiOOZTlVQHqD3hdbrkP0GSETsw+fvKHIoo/epNW2U0Fg7e+lzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441065; c=relaxed/simple;
	bh=NFLaka9RbUB7rQIXmBFP+S7DhEt0nL0qMIqQVvHtB70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5wQNxQeBj6UUZxcv3Q9FuQ5Ru7RiyH2WpNLxlJnsnS7Qf4gX4GwcbDGAV6EUVD06QnR7ZzxRvXcePH9lUrWXJVrVUIKKhdW9tMl+WSRqJx/JsGbwYZWnjVPsq3DBc2JzdcBnpiSj5q585NVTzw9s0YXUt67yQqtMWEIWwdA9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmUun2lo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c70b5594f4so282642785a.1
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773441063; x=1774045863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFLaka9RbUB7rQIXmBFP+S7DhEt0nL0qMIqQVvHtB70=;
        b=XmUun2loFwRvm5ZJcFE4mk1JyAhsKdgac0SWTjxRd1B36rPn99OCwhepQC8pAnvE+T
         oIZq9RpOIgDd+M3QCZbyxlTO6HUNFOQCHOnQ9t4emEPv0iVsmdWQcEpXr2Wl+D1j47XF
         dOxp40FbYn3DyhZcLd0YtTce/K+hRLuJvXwq5cxH1khzGWYC3EFMktCw8yVvykxEcMS6
         P0T8dNovZDTVYuQXzjXLJkpTSPZ21MrksZVo9z1Z3oLeHYTjznoAGe3fA7zcDJm603Rg
         D7lYlL/FWzte4qerIMGMUWBfkyqQ+879QWCZsIlwokX42daNt+gmJ8nb/sPziAdNGFgI
         26FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441063; x=1774045863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFLaka9RbUB7rQIXmBFP+S7DhEt0nL0qMIqQVvHtB70=;
        b=aBP3hLhuA5cB2DWMJ75c4BwplJ5j1dcHvIK4alAs9/UXTdtrEtsAbGUpy+mq7Zv3Dv
         B2inMq3jZ8DlqsO8xKqb+NbdjVW34t7fzVRTpmj+kUYoU75+SqPvXHw1YhvuT5WKgIdZ
         x82P3mg14oCFDC/KI2iwhWmmwPDowk5ic69WPpMUBsyIJYit+LcYXiKUixpfPg84F0GU
         rDRqEtSliJmEAZnbBhQjBeNzTsXn5k7oYOTh9CBrKMNwZzGSmBUjbzTGu2jjgRDSV9Dp
         nXsGWZXaqa+8jK8X4TyAphVxnGbjWq3kleySWQ+AwHEfTZpa6Rgnv6IFrkLY8vKGQSLq
         HI8A==
X-Forwarded-Encrypted: i=1; AJvYcCWaF0bzX+tDFskmGkLtyhb8wG2F+l1MAPPkUfW/04r/Yhm0jh6sColpOPkyIBC+zmJtt3rgzxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJLf/PKSi5ce0BKkbRuovo37zX4of7MZStCpfDzw5NzNJ7Uv2
	cZv3D4QppCem2kboxI6YVkhsvzM4zdy/DLBbGsps4PmP+i5BgyM5qr4A
X-Gm-Gg: ATEYQzwYAvudLelBcIiGupx2Pa92UkHtlKsv5rkpSx15d7GUBG0x9EPUbMJFGhWsVGZ
	gbF36V8dNJFjPi/KNTydFEddG7EnoM7lOzCg9UX6aRrrXoRtvog3wS7NdlSMsOolMfQXm4TN68f
	h+BUTCGZX/plm4QpT0VVHytXWhk26xRjiQ+4EP4HtNa4f6MjRvwSn9i+LTFFewe8tQZ1rWpDzwm
	Znd1oDJA/X9R01vYxQZS4NjcAfAjxDWuipkgs6xdvZoe9R+8vBWRFA+TZ9aMmy9v7Dg4XbiQL7t
	pGYAkyaBlRJbkvcuKpPF6SHBdW35gXg/yuj0OuHt6zSe4wS2mF3Eco1sFpcr2OjfBIgIaWuFZZK
	fOYR2bvMi9nKwsme4MRYT3OYQ1GGlF/XkYWalBWAslQHVkyrxbfCNgerS9/s8koOfwaMB9x4qam
	EIc01pVi+ET1tNy1bOkxaVX/SKrb9vD6RHsEOyh9vWijbqMAuA4pf8cxDnNSFyqhKWq75o7zbfU
	eke6msVkSHP65FYkBYA
X-Received: by 2002:a05:620a:4629:b0:8cd:938b:7da2 with SMTP id af79cd13be357-8cdb5ba0d7emr653069285a.35.1773441063406;
        Fri, 13 Mar 2026 15:31:03 -0700 (PDT)
Received: from localhost.localdomain ([129.170.197.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21348e2sm656282285a.35.2026.03.13.15.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:31:02 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Nathan Rebello <nathan.c.rebello@gmail.com>,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: typec: ucsi: validate connector number in ucsi_notify_common()
Date: Fri, 13 Mar 2026 18:30:49 -0400
Message-ID: <20260313223049.317-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <abPQcFxlSntTv-1t@kuha>
References: <20260312211503.1915-1-nathan.c.rebello@gmail.com> <abPQcFxlSntTv-1t@kuha>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225398-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,vger.kernel.org,dartmouth.edu];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9CB528A6CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 at 10:53:04 +0200, Heikki Krogerus wrote:
> Did you see this happening on an actual device?

No, this was found through code review while auditing how CCI data
flows through the UCSI core. The connector number from
UCSI_CCI_CONNECTOR() is a 7-bit field that gets used as an array index
without bounds checking, so a malfunctioning device could trigger an
out-of-bounds access.

Thank you,
Nathan Rebello

