Return-Path: <stable+bounces-212787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NBoJJd8e2kQFAIAu9opvQ
	(envelope-from <stable+bounces-212787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:28:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14BB16FF
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943763010509
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE802D3ED1;
	Thu, 29 Jan 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwhn6AYz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEF2D837E
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700480; cv=none; b=GTM+yzyrlc/f2va+82uB1jhGw2hfgmXCauhge3ENGZBDxQDr18MASl2vIZgqGkA/5RvCC5+vL7IZBav/uEAgJpNi54w5LAc9oslGWkHLt5gDX2sFsHD4N5sHvZotetCnCutnaye4MlbgfOZubrCG+3sNk/8ih5+HzGEq10Sxpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700480; c=relaxed/simple;
	bh=WGcd+eGZrnT4a8vrCYCQCfONoxvosYN2DwBdqwJnV9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuH5To5ZNsw7OfzUUL+rlV6s/4KBVao9vhLcZ5STqeVgK5sIUFDSI67uXHnXJ61GqjMxqcq1O1MOgYAE0oefbKOKNr+66HIQ+fm8kDRWvN4O+MwOzOcVnRnmX0ac9aZK/bRM42lj7fs2oV1aNtJiV5MvbEnFhX8RhPJ3GptYD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwhn6AYz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso7876365ad.1
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769700478; x=1770305278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGcd+eGZrnT4a8vrCYCQCfONoxvosYN2DwBdqwJnV9o=;
        b=Wwhn6AYzYLzFeKjS12bCs8RxS2TmGnMtjlgwRZx3iHtIwKDHZgTlcB7qTtaODSxWXg
         FlduSKUebVkVJvjAk4xDzBIcKzS+AZrzGFGVjDjJ4quSQoq6hXurOtgLjfE48Yshua2w
         Erh9mbTsFhu+p7byn5J/x6Ktco9W9XwoLbruGu1i2hCqmZJ6+KMG6fZhqJLVOpGzPvex
         Jba5VHsHhMC2U7BG8kXv4kcoYTGTk39inwiLhO1CWi3ZLqyRWGGVPPYT4KJfzHPGUcKG
         Kz38QeoW/4N3/24n9IMQV5kR5iK6kUHEiEUkiaLIHaKB2WgtfADpJh1BX2YY3Uof8gf5
         CJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769700478; x=1770305278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGcd+eGZrnT4a8vrCYCQCfONoxvosYN2DwBdqwJnV9o=;
        b=j3PrPJbWI3KOrj2oU9sW1gyoqa9+8vHWf4XnjDaGKssArMthr6DkAYzYKen5wz1i+b
         2MLmWB11e7R9ZAqtwar1sHnCScKvto/qz0QnI6pDoOCvzeiCzi4rI2Fr75zjcCD0fC8g
         skUHHfQOau7JmZoA7wrBD9wbcNLMYXUneuLUjuFpsz7VL5SYGd/0ZOPcDry485f5ABMT
         cNezdIsIQJe3VVQ84D+CMbnNu2DoVImiKNcL/rqbMkd3Hsx3dScWZMotV+GzEfprWJJU
         RFJEydX/Oc8wYQkCrT0ggh/kiBhe4fXbPAxDtTzigbW5Upxmggl7XhhSg8sI98R8/E7G
         98Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXOJ66r6qth1e+w8N73N0DLUHh6ChhgdjIuhdC286WJkqVURkej39D4q1g4PCivbXuXfXtWCFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCehBE/L43IMrTK4uYrrUdwr9e4K077LgjvJOQOfHNaHox4ozJ
	crgZvVv6eamrZvMjbeYwwAMZIk9nD0qeSYxcRMdjr8KVnlN/Rc66V34pR6YkQtUt
X-Gm-Gg: AZuq6aLDmWLx0PWWX1x9LRTT5zu9dNmVdYwjNAxqU/ZRqXWVPp2P7fZXHNYMEfK1kN2
	FmYhIkTF2ZaOZrgOnJl+BaUBgEUbr4Z6aUJB3CDdghQs88vj4GNoUb9YmRtq9o1JWevXcK3J7P/
	4DNv6j3MhHv3dX5SLYUWtbVynwaYNyfLwjvMO1lLmdt5xWGPomylMxRCFPN8IsX4nQ2N8v4DUys
	7U5fov6+jZEbXl1OVxW6CjWf1ewPSQsSsGwZ1idwCbilNlzM3D64J29OTvpZy2byv62j5uNhsvA
	8Kfi8JOSgvlFeZI0pwZeeVYE7xLQupsEBWWTTdnjEOsqsVOjIXMId4MT32rElICBmiv8Vr9s14D
	uarilnruKqfHbNoxRuqpJIOs9pWWDwjyQR2zg7wEx55R3sf+tQuBwK8pN125Dk+yjx0JlEy2ONL
	Geihs4oGcyAQb6AqASCA==
X-Received: by 2002:a17:903:2ece:b0:2a0:d074:e9f4 with SMTP id d9443c01a7336-2a870def787mr86840655ad.59.1769700478049;
        Thu, 29 Jan 2026 07:27:58 -0800 (PST)
Received: from fedora ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d8eabsm54826735ad.68.2026.01.29.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:27:57 -0800 (PST)
Date: Fri, 30 Jan 2026 00:27:53 +0900
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <agruenba@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzbot+4cb0d0336db6bc6930e9@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [v2] gfs2: Fix use-after-free in gfs2_fill_super()
Message-ID: <aXt5oYSyrSTjmXMf@fedora>
References: <20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com>
 <57c723e9-d38a-47fe-9737-5b472916f3d2@web.de>
 <CAHMDPKUZgJ80k+u_e45FGSPz5N4sjBfX0AtWu3Oqr79wMSx3MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHMDPKUZgJ80k+u_e45FGSPz5N4sjBfX0AtWu3Oqr79wMSx3MA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212787-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[web.de,lists.linux.dev,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakamoryota@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,4cb0d0336db6bc6930e9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A14BB16FF
X-Rspamd-Action: no action

Hi Andreas, Hi folks,

I'm following up on this patch. It addresses a use-after-free bug reported
by syzbot.

Would you take a look at the patch and let me know if this version is
acceptable, or if you'd prefer any further changes?
Link: https://lore.kernel.org/all/20251230-fix-use-after-free-gfs2-v2-1-7b2760be547c@gmail.com/

Regards,
Ryota Sakamoto

