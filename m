Return-Path: <stable+bounces-100297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A69EA7EE
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 06:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819B216757E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 05:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E922617D;
	Tue, 10 Dec 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IDAu9RDc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45F1A2550
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809033; cv=none; b=lyb5DMDP7j3OLytjwc3e9o8S4KhtoHijt98DbScPA5vfP4Fpco3upWnbP4hpOwvIdns6o9Erth1/7DPuOwljeb7Lh9a5Jv6QO5eVSKBRi962KT+rzXtrKyZ8VEjSQIkH9Kh/pCTotMHs7GwUjTcdTC3UPnLYjDDNRerX5Dphhyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809033; c=relaxed/simple;
	bh=aTjOK/wPe0ItsVsha/ExeZ/2Uz5Nj07sS4vX9Hvgl3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeCkeIUjm2iaCtTzhLxDAxpFHa3wbEpDiKAgy/yNNHfrB0XvULmq0Rpg3jHdWn9YJHOGZR+Vr6Dv4cKZainnLPghImWYCZb21KlZFtSU7+/9hUmVh9dSwc5SE2Lyrn2Ma8uhSZOYK1eIhY5LPTuEzpgt4B4/jaxBc397IOrMtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IDAu9RDc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725ed193c9eso1538059b3a.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 21:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733809031; x=1734413831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DA6LwlN+iu99STnfx1xnRTypt6Y96GDmqmaEft2Edrg=;
        b=IDAu9RDc/k0d4MUYfW3yR8v0NhjqWPTNsrHtmrJo2ecSqWuTYnsDIIeJ3r1PBf8A1z
         KsNQUnx68uMD191RFfe2BY3SXkigDi5PzzxgCSqS11eBjhzKRv2zo9qPFug8o7WA5o1H
         tZgGG1s+YHRzOtUahkhsYUkF1DKJ32Wh+D45E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733809031; x=1734413831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA6LwlN+iu99STnfx1xnRTypt6Y96GDmqmaEft2Edrg=;
        b=ak8yUGr1aEGAFggkPyyWNmiriE2UHhiQTJcE3xeREooO0GMV6NCC5iaCq4L+YGta11
         xyo7E7McQM4NCGJ2uDs7uhSCalzF1rNeoCiF0xmA6ZAwh6sf1dsqdTP93h5J3NFOfwsJ
         QxT76Ep3lzxQlqd9zml+mcfDlrahjqtRiOzuwHyJN6vgbEn7upkr79yJYBVulR4VUHkh
         N4JVihp0Q1bdf0N5sSkBQQmQt5KzPyENs0LE25i/BMcdIlBNPm4rtItEsXRGcjOgWCzO
         k3wRZpQ1Fv4zeQGutiiTpdoLcI74SCzbl7tBsuDmPM/Gc5PkLZMKiY9axke3RCXenJZL
         pl9g==
X-Forwarded-Encrypted: i=1; AJvYcCUkkXHLg57p0XAVVIvbJiPVHeki/XO8kP0mXdTUZ93KPQbuqkdBNXozJZg+RQvREv7WPBn0XR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/fCTqNnn8o9YnDC5QBSt+cm8MDSkhFAGeHALcaRt1PGhKZAU
	IlQ0ilnJFZnevXY/dyJM40ePSadnqWAsZCs70gfV87nuTUXpu1tAp9Pega/uSg==
X-Gm-Gg: ASbGncsvZCpKJr8nsRp29PmRqxO3fmi9t2qQQzQXnZrzaA1jiJxjueopXv2ceOBDeI6
	G559zR05th6oe1F5pcmp3Gio5z8n+JqA6wK00vqpIRWlPtF3uVfFIAaejnckd7MgiXkifpw4j5i
	Zbrd9AtZSeBHQEC+JBv67TQTfAE+5EpCmMhtsu2jJmoHpn4WtubVYPLg1kvqXBu0Niw+MOzE6UP
	UYye44UaVPoZ0480VPLdGvsQq9nq40/dgqeIqfKqhPVhriesb0I5SD4TQ==
X-Google-Smtp-Source: AGHT+IHsRdrbt4UaD7n1kcL4kNxd2ePBm+Z7OktgexwEA0DthXG14ae04j5UqI4+aDSqtlTTyuMbAA==
X-Received: by 2002:a05:6a00:22c6:b0:725:9edd:dc30 with SMTP id d2e1a72fcca58-7273cb1af91mr4786542b3a.12.1733809031388;
        Mon, 09 Dec 2024 21:37:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:ecc2:3f01:a798:5d0f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd40e37fdcsm4231258a12.53.2024.12.09.21.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 21:37:11 -0800 (PST)
Date: Tue, 10 Dec 2024 14:37:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	mm-commits@vger.kernel.org, stable@vger.kernel.org,
	deshengwu@tencent.com, kasong@tencent.com
Subject: Re: + zram-fix-uninitialized-zram-not-releasing-backing-device.patch
 added to mm-hotfixes-unstable branch
Message-ID: <20241210053707.GK16709@google.com>
References: <20241210015750.7D4C6C4CED1@smtp.kernel.org>
 <20241210040815.GJ16709@google.com>
 <20241209212039.69b30b998e5de7622fe10ab5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209212039.69b30b998e5de7622fe10ab5@linux-foundation.org>

On (24/12/09 21:20), Andrew Morton wrote:
> On Tue, 10 Dec 2024 13:08:15 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > I'm not sure if this and zram-refuse-to-use-zero-sized-block-device-as-backing-device.patch
> > are worth the stable tag, they don't really fix problems that people run
> > into en masse.
> 
> Me either, but they're very simple patches.

Fair enough.

