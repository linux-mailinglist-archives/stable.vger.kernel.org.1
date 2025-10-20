Return-Path: <stable+bounces-188270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAEBF3F5A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E4F34F0107
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045C2F7ABF;
	Mon, 20 Oct 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="b6/LvO1z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D172F3601
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000348; cv=none; b=aMMKZGQemVojc/6UM8bAP0xMvY67D7jbrcfiOV+XsO7UAo1VC22zKf/5bOD4cziHijM5dfthiZQ8T/eERY1nSHY+JlEYMVyb/uQ/eghwv388KzC2Do0CWp5lXmrGBHaBW2O4XvXL9QYEKQl1XJ9jvccCDxsK8zX1Tz0q+bsT9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000348; c=relaxed/simple;
	bh=D/FHKOF5Y7S2qddZOuD0AqYI2i0zzDzJ0vAZn86eZ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN5sc4Ne+Olt+mwyk8EK2lTfr2yZmlChi8X8WxMvhKqjsNaT19JeZhf3NrbDQM5i6OzeGW9KFbBE8a4JLJ3xmOAjoZ416Q5yV6aVbVZ5Lnl88HFeC5R8KSvEaatpxnp37KI1BgnUcWcT2XnGvCyQovE1g3071l5HbdN/+YNrhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=b6/LvO1z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782023ca359so4785960b3a.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1761000346; x=1761605146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjA+D2gABjg6fRwb90P8FJ6zI+4eBjJEl6XrYNmNfy8=;
        b=b6/LvO1zZeXkGOUqL0CUHqnkLiSSUszgacha0NTRXLmvkaXSc5Kid0ylb3OjkJDnDm
         FM2EYFfRWsR/aPQYZNY6ABsiBD1ZYcSMzPXJH/3MWWHclTlgbk6xmEddwvuQ6VWJgCHG
         fRuRls3pCl+KKIDsSRfLZktHq9nOEDV5gDsR9FVyHA/98wrdrFU4iMZQdrgfG6NL+7fy
         yuI6sUFloliJJlxbVffqaD2uZ3A2E5jpTHpO7zJWcGFNYyE+PlujeYjGXwXZrOTSxY7k
         +TOcgNgANqBXRSYH4aX2Vdy0V3aQGbj6g0pOtydORviT1xaqeTLKmz2gFRkCbDjW3Oqd
         uQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000346; x=1761605146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjA+D2gABjg6fRwb90P8FJ6zI+4eBjJEl6XrYNmNfy8=;
        b=RXSsgC98e5fJTB8aEs9ruJQ1O7wWdG7IaSMBIPpVOz27yTJALuCNHrTn1XC1rL/ZwT
         72bi7Rxd4gx/VeRlDffR+yxY32Qs5Q2+zaMO9eeyzYPOJvcwbgb8x2DPYCYLI2iOWjk0
         bdrraxoheLsoBM/qdk0BsPB7Lm3Vhr+WyoGFz8ET6PAwDahtuqFJg6VwECFfwOce5k5b
         t30M3cIv4x6oWAL+LIK7e3eLIIrF+EbR2SPCrpppg1peqFFybDNSoa+189Z/bwz27cZD
         kNy0VUCc8TiDGRe65X3KTta48I5oqEY01gg29xy2ta5XHGtxPW7MV1UHSg/ogHItn6zS
         riqg==
X-Forwarded-Encrypted: i=1; AJvYcCWTgGde9VXnuTUWX61sqCKJ+AYi93mwpk2ojRXyj+2VcSxXYJkhE4fgt7c97CvXTYvw55KwMm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOTpm2ExW1Ryc6W1chOrrYj6evgLmMmFxAYqaYiTrhfM6PL8I
	WQD1t4Oh5nr64aRB+7NSQfur/Qy1UmUfKmboodwCVMUeh5OGQMnZJ0eMHaR4wg3FNpXf
X-Gm-Gg: ASbGncsfeeWpORcVolG7fFV6zoX4yMPkqeZIzI7HMJRC1lkE1aiBPQtUFsh4o6YMJFn
	6BX3BJcse/glpyXj+N20SIXtwml8tcuXDlzyKIRknP6t/6+FkvsWu4jUWoznRPow+RHAG21Rv4T
	Jbtin7ZkA/lG6L1p5yC2IqZlv6RFMulAztSU5KTElFZHRDWq94fkobt0zqpi5y1yaZ7N4ju59CD
	6FJVqzVeebo5H7oBdUfgKDcaSJWaTS1A8bzH8oqOJWj17lDAcdYpCJQClwNvu8AXiL19/QYUvKY
	99CMiO4mvKJA3B9nIFta/CY/XPd5rGhRWZJQkG3tl6yK0QJVDDlGbLnUgqIbo5MVTXM93aTeO/Q
	gX85fvZG9+jBuoWAiRecxjsWxVfZ+GxygbZ7dW5n8tQWmMf+iK+sIqkmuWObapqA0CqlHWPrxv6
	xX+A==
X-Google-Smtp-Source: AGHT+IFMfVbHKDPJ93PraNhiZ4Nmaqe9rmEg5jcKWkWmKkIqhKzyHvYVhl0ZbDOR4Q8R+bGwGNNryw==
X-Received: by 2002:a05:6a00:21c4:b0:772:45ee:9b9e with SMTP id d2e1a72fcca58-7a220aa8c36mr15402276b3a.9.1761000345917;
        Mon, 20 Oct 2025 15:45:45 -0700 (PDT)
Received: from sultan-box ([79.127.217.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e25asm9290207b3a.56.2025.10.20.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:45:45 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:45:43 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
Message-ID: <aPa7lwfpALpbCmed@sultan-box>
References: <20251020223434.5977-1-mario.limonciello@amd.com>
 <aPa60qtBV5iCiY2I@sultan-box>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPa60qtBV5iCiY2I@sultan-box>

On Mon, Oct 20, 2025 at 03:42:26PM -0700, Sultan Alsawaf wrote:
> On Mon, Oct 20, 2025 at 05:34:34PM -0500, Mario Limonciello wrote:
> > Adjusting the idle handler for DPM0 handling forgot a return statement
> > which causes the system to not be able to enter s0i3.
> > 
> > Add the missing return statement.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
> 
> I just noticed that this link doesn't work; it seems like that email of mine
> didn't make it onto the amd-gfx list?

Ouch, looks like none of my emails today are showing up on amd-gfx. :-\

Sultan

