Return-Path: <stable+bounces-40305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB638AB26B
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD07D1C23348
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4465212FB3B;
	Fri, 19 Apr 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZRcumW5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215512F580
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541879; cv=none; b=D3StBUJVi2+rGue7gBcOwMIGzP8pQ+QX6PA8cKhWX4HzaCT0x+i/kN62Jys6QsYweQJS4Pb/kqAyAuThCnV1Skm8tV62QHXHnDEeSlDBmVnqZw1AzCXf5xb0Sd1w2rIJUNsqrhBJ4PzJtehUV/etmPxO3+yUNGKMzvqsQDWgxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541879; c=relaxed/simple;
	bh=W5+oOr7Fr7tXiO2PHuLRIMRnoPnJ1qAKQqYNYt3GxQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtbVqQYK1HHOZmAfRUHzbCxEIHsDZUBAJE1TjEFW+KrDrh6lThz/VW2CROp5kcf45qdQ2Mb/pNE5pVg/GRpRu3tySFF2xrUY+2NYX6/v3mwR+Q+BookjGSBJtr8xXrVzc4kz+iKGgMS06NSKYAwRx5HMAQNJevXhwQ/+FJont5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZRcumW5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFBAC3277B
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZRcumW5d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713541876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5+oOr7Fr7tXiO2PHuLRIMRnoPnJ1qAKQqYNYt3GxQ0=;
	b=ZRcumW5dFLHBlkbmJwxKn0yiiSEsurNygf9KIACIyPT6OVd5tCs/SlSpA46SKDNQk0RVWq
	YztyhwUUetE5dxG/pqrP3oQSt5p5tXs5Vqasq0rOceudeJZKUnw7ko7i6dCgfW0KSsAYRY
	/Qd9Q5BmIifTW+r9QmG6lnThmqVKg7g=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0043457f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Fri, 19 Apr 2024 15:51:15 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61ae4743d36so25048367b3.2
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9wAtp1sTJWOEQ+IEaM/UsE9nD1aJk/Fx3hcQbOOBqZ9VuAs/rjXZnH1gZ2FI2TH7IxX0KrZGKShQ7QXKxgTGIlTC03ode
X-Gm-Message-State: AOJu0Yy6fXuLL1/dDHVj9LeEwRIrWKSK/wcbxFUTr5aewIj1T15FVk/i
	W0NlMZO5j2uxfM7/3NyOAlG6qPn+Rvokg3e+MSlNRalZlcQDuKUztIPvlccvt3OFVjQ5vw4X0/z
	r6qsD1h8+F98DcEtmxDWdwxt4Wg4=
X-Google-Smtp-Source: AGHT+IFkTPNRApxEDDLExR4JyjlAgOGWAWGX+Rr+kp2/2RUrAPrE4pxaapfbsqDREs1IpkHTdR83sLtuxU+6aExtGVs=
X-Received: by 2002:a25:2d21:0:b0:dc6:b812:8ab3 with SMTP id
 t33-20020a252d21000000b00dc6b8128ab3mr2570667ybt.26.1713541875200; Fri, 19
 Apr 2024 08:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024041903-pentagon-deceiver-fe1d@gregkh>
In-Reply-To: <2024041903-pentagon-deceiver-fe1d@gregkh>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 19 Apr 2024 17:51:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9rQOEFUCxB-23RxgSm0vfGTKpgg3LtPAJCGnatOTaLdyQ@mail.gmail.com>
Message-ID: <CAHmME9rQOEFUCxB-23RxgSm0vfGTKpgg3LtPAJCGnatOTaLdyQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] random: handle creditable entropy from
 atomic process context" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org
Cc: guoyong.wang@mediatek.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

5.10 doesn't have f5bda35fba615ace70a656d4700423fa6c9bebee because of
72268945b124cd61336f9b4cac538b0516399a2d and so we don't need to
backport e871abcda3b67d0820b4182ebe93435624e9c6a4 to it. So nothing to
be done here.

