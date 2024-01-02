Return-Path: <stable+bounces-9218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB07E82209C
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 18:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0DE283FBF
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3FD156D4;
	Tue,  2 Jan 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EY/Y0Lsx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C4156C3
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so168a12.1
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704217969; x=1704822769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JnUuY4M9qtYjhHx0d1iAoLibQlRjERDMsDTlYJYQ8M=;
        b=EY/Y0Lsx/LX3w0tHUEzBosK5OAm+faPDVBPdgJRDIHMEj3BlGQJAgpGBIrOyomLWnG
         0ZlCE4+gsP5APRiZoJfYLQahQEm0PjptYwOGl6y6r2m693U0BdweH8eLlYY7iW43LGnU
         cPX51Vyhe5q8sJGFJao5MWGiFU4xLqXCRVLpOtdGycFPDNRISVyTauq95naM+IcCOXcB
         g2cdwR/d7DC4OsKH31A5nA6WQG14ZHOuTbQ0sHy8n5ZGBwcfllQ6CQgSQSQ0vZK+qC12
         BewYjCfnEB1EzFtHWo7AMLVSFDeaA4mckNBa97cf8q0WpaIpoxDrpFWwJn4x+yKpMhfa
         HyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704217969; x=1704822769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JnUuY4M9qtYjhHx0d1iAoLibQlRjERDMsDTlYJYQ8M=;
        b=uwscf8AendL9v4QVERPsQXcz2FuU2K7nUeQW/8idEUvABNGEl0yJpMibDe5DsVQALD
         mB2XH4Rswg4tC5l62BAVaOGwxpFRpAJLmCataLujaxDoHNovGLwDKTE/enBKpQy3tZ6F
         SCVC4qytrTyhheb1PuTFHwLPfOdblO2/WFv6N0Eu8n1UhsjyeGgA0MeQvcmXEuf21MJd
         oA7sZyDg2UgihkabFwogSZZsXiSF+n+sVcCDYSaHFVJEL3G1hTZSKDx+7po29uCq/NGL
         vaA9nfXmV8My6J/1i9/zsArZvOE3noshPJBdiStE2aBKaZBOcnMw0GBh4LB1M82rIh19
         jyAw==
X-Gm-Message-State: AOJu0Yz/G8DxaQLmbfyW6WFDsiz0T8FmnY276vzI5ii7kcgl397B64rA
	2Mh8G+6PClW+KIoiA6Lj0YK4NWmkvfyy24zbd8HXYjNyXg5o
X-Google-Smtp-Source: AGHT+IGJ8BljJDaR8vES20RJvWnVVKHpcEdOyIkDvu7Zquv42tGv2FUyRLJO1xoWnnm11TEHAcZptWjqCPHedXIlUGU=
X-Received: by 2002:a50:d705:0:b0:553:62b4:5063 with SMTP id
 t5-20020a50d705000000b0055362b45063mr1136137edi.4.1704217969561; Tue, 02 Jan
 2024 09:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121203954.173364-2-rdbabiera@google.com> <ZY7mgMkoaZDZGua4@cae.in-ulm.de>
 <ZZO+HZjR6O1eSyjv@kuha.fi.intel.com>
In-Reply-To: <ZZO+HZjR6O1eSyjv@kuha.fi.intel.com>
From: RD Babiera <rdbabiera@google.com>
Date: Tue, 2 Jan 2024 09:52:38 -0800
Message-ID: <CALzBnUG_8d-PLdhpHb4=mWUZ4oUguBqj3hBnE_HBHgdX1WoyVg@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, badhri@google.com, stable@vger.kernel.org, 
	Chris Bainbridge <chris.bainbridge@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

That sounds good to me. Christian had proposed a fix in another email thread,
so I can post the patch after testing on my end.

Thanks again Christian for the analysis and fix.

Best,
---
RD

