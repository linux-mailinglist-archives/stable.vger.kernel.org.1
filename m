Return-Path: <stable+bounces-235757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI6XGnuM2mnd3ggAu9opvQ
	(envelope-from <stable+bounces-235757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:01:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E93E12D0
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF356302F9B5
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9682ED16D;
	Sat, 11 Apr 2026 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+8GiEJO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CA9189F20
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775930485; cv=none; b=ko6Gf9E7ZmG8bzv7l+Vx2Rxeq8qawY4/7WGguBUdb379Lfovu1vF71LsQMQR8qx9c5ZZCfJ8wi/s7wIE2nGoKlsSpqEeeWpgsXkbFJH/5t5a4TvxcwU2vqD5IT6t+oy/OUVKLWvSTD+JB/F9SFQ8mZ8nKDDRHtOMgjzwz3FFQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775930485; c=relaxed/simple;
	bh=EvV02ZmvM+JA8M92n2q7fmCz94u6Aj+qLtTgXdzpdY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5byQYKJXJ7hr/JXUhnV7kpiNBT4+aUEzNQL0zUKsiBy1c/nbvCcI7c6GrWxH43GdK1+SEgY0QvoM+9axrabku8QSCY1u1ma+3fV94VvvYpq6+GAqHNd4JBzPbTElCPGS8MbiBTkvOoU7B1ds4YkxSs0v0h0Hj2evjs/7ZbuC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+8GiEJO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c741c1a656aso93813a12.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775930484; x=1776535284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9yp2kH/NJKvXgSMeVoXYBn72yJ116yN3z9leX/3Fuk=;
        b=I+8GiEJOzH21HiJa2uLpghcU2pvkX86F300fGJ6+ERqE/xdPY21fxujHUanGndmQuq
         QsDDjPa8mFi0Bj0c1ys8HCm4Z/foH2r4uo3E+v0wyoTDrodmKwQzj0gIG7EAqbEzeThC
         XyI0ix6vUGmWnFAm2HcXyfF+T8jyI1nkmp5Y5cjebxyKlkj7HRnfCgNceJ/j7Ul0R1wt
         VMz91zovCU7SbuceCYUe62PnsnTtHFV4CVGt8kO+0EXhs1ytXbstABynqXwdnItahWmy
         a5165djyiLyPU4nsbhB+73gpUH1OO38AdNWNKSGVCwRosIYE+ptVDqyAUUjC4oSSKxs5
         rTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775930484; x=1776535284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9yp2kH/NJKvXgSMeVoXYBn72yJ116yN3z9leX/3Fuk=;
        b=SG3s3ypq8O8hS+mmNyXApvOHdojFI1eOc9K8hgx80KXVkMkJ/hC+GQJOzIoGB8LYw0
         aSY1yg8wWGbuKJAKBEccvq44hD0tE0ynFD1O2QcxyM1+PzP7oZ7Pjo1f6x80fegCZQVn
         B2iSchHTy24N63laHAyeinlPn8EYH9/y3fFsh4XmKE80OQO/KwoakI91dI/BVDtyAtC2
         oIuCBocI0HZICxxouKidbwNbW2Mp+5nS0SWCGhpYZ7eKipTon/cUaX71M/6aLBNrY5PQ
         xS624vFsJtN0w4OdMftXdwgQqjUr1zo256UZM0joCLVE3KT/ZD3KWZ7kyErhcWgVIhLw
         b6rg==
X-Forwarded-Encrypted: i=1; AFNElJ/DPDhRKRSbMScAPdAIFf0ek0E0BZ7C8xPiKEra9CjGY7GoEwo06uGyXcn3ItDTrNrs6tt3lJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwnun6ZJGnf0hQYCVhV3g5IsOCbG5h+svRh/QrSf7EVG1YcoFU
	f3sPaluxCF615SogxWZtP/8yuFARCvhWd0SdgnsHwCUNHl7kvqOFtVzr
X-Gm-Gg: AeBDiesRjQcg1byjQsaBWvSYft2FqND1P6s88lHE1RBNN82YUfBESoF5ySHa2c3DHDK
	KToSWSaMDcAGCTnWIQKUnV5RSy8CumTBN3VIMI8FuxEmSHnGZ6KKalzQKB93nC6RSnueD68fSap
	zDpGiHOU/ocR7Lc6et5v52JC/DJUWOi0+gUhm4wx9IkdJE1ruAuM3M7vtlN0TLEfCiSrZLNuhrP
	xlcRpbraa55ucgu+W4CtXpUiQH3X+Yi+PkGa41k+51r6DgEiodBC0OfCAWoKsagVvKPPCLhfji0
	UfVftd36i2P2aID/76bNa0m0ASFz73dczCUoN9b+V7yvAvRIt0xW1Z4wVoFgdBVdN+mqvd7+9QQ
	kGURpdZPL3zmC+amCoTCwlnzHUf7vIX9wWrEQc78yH2sW24koLh+9JVf50tmF2uSnjO6Zt1pUpf
	g6xzgESfr+1GM1fxBGYiJraVyG8u80
X-Received: by 2002:a17:90b:1dc6:b0:35c:30a8:31a with SMTP id 98e67ed59e1d1-35e4245a4e8mr4738542a91.0.1775930483734;
        Sat, 11 Apr 2026 11:01:23 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e581537afsm925311a91.10.2026.04.11.11.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 11:01:23 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] usb: gadget: udc: max3420: validate endpoint index before array access
Date: Sat, 11 Apr 2026 14:00:12 -0400
Message-ID: <20260411180012.830193-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALFbBidSiJTD2zdczQ1_mxv8Xm9Pqspnz8LDppHp2hudkLSoxw@mail.gmail.com>
References: <CALFbBidSiJTD2zdczQ1_mxv8Xm9Pqspnz8LDppHp2hudkLSoxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235757-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD0E93E12D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

USB SETUP packets originate from an external USB host and must be
treated as untrusted input.

The endpoint index is derived from wIndex masked with
USB_ENDPOINT_NUMBER_MASK, producing values in the range 0-15. However,
udc->ep[] contains only MAX3420_MAX_EPS (4) entries.

Using this unvalidated value as an array index allows out-of-bounds
read and write access to memory beyond the ep[] array when wIndex >= 4.

Add bounds checks in max3420_getstatus() and
max3420_set_clear_feature() before using the derived index.

Cc: stable@vger.kernel.org
Reported-by: Pavitra Jha <jhapavitra98@gmail.com>
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/usb/gadget/udc/max3420_udc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 11fd61cba..070893723 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -548,7 +548,10 @@ static void max3420_getstatus(struct max3420_udc *udc)
 			goto stall;
 		break;
 	case USB_RECIP_ENDPOINT:
-		ep = &udc->ep[udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK];
+		id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (id >= MAX3420_MAX_EPS)
+			goto stall;
+		ep = &udc->ep[id];
 		if (udc->setup.wIndex & USB_DIR_IN) {
 			if (!ep->ep_usb.caps.dir_in)
 				goto stall;
@@ -596,6 +599,8 @@ static void max3420_set_clear_feature(struct max3420_udc *udc)
 			break;
 
 		id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (id >= MAX3420_MAX_EPS)
+			goto stall;
 		ep = &udc->ep[id];
 
 		spin_lock_irqsave(&ep->lock, flags);
-- 
2.53.0


