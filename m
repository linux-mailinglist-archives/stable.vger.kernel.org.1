Return-Path: <stable+bounces-67530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F70950B8D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE11285E7D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152E19D06C;
	Tue, 13 Aug 2024 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gK62B3vn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0D37E
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570851; cv=none; b=N440A2xrKt2W3Za4t1/oQPWCpCy998x9iFnrT/YG7H6aWx+vwMLLJYOYqCUIhTKcpHoxHcQ/alHDcYmnVn4E2sm6TLAbLVUdWBjgJJKuEjYDXjQX0CbdgaG9a1mVspygm7CpZmz76Jd4kUjQSNIaW228KGMbKujv4oCdX9RE090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570851; c=relaxed/simple;
	bh=GgufDS8O1v7BR5tsZE+aldeple21s1USye3EdwP6M/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+Y5eC3nJLXk59C3pRB0Vx8Wfxft2jZEf29B8WMF5tsy1bK+zNiDIVjpmDIKOIpw+/pjMnDQJjUKWMueps4afQQXgWlqSxfZs6l7pSP4lP3MicygdElkNqikGsBSF2y64RO63vxezm293fpMfCJiZ+J1QVn+jyXJSiUD+PylN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gK62B3vn; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e03caab48a2so105830276.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723570848; x=1724175648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgufDS8O1v7BR5tsZE+aldeple21s1USye3EdwP6M/4=;
        b=gK62B3vngZ4y9Fu5W0XHTDOk//Wb/CocmvymVil9b7NExHnjDzjs+FmNvyEIt4hmLt
         fn1tyME0VJRVb91q7RQhy3ArWth7N1qZaP4+4ZIR8WJ9wAuW5tDwuZjHXQzOmaYp1hv8
         c3n+1YaZ/TfO9cBTJb3pjZpsxrn14Uets8avY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570848; x=1724175648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgufDS8O1v7BR5tsZE+aldeple21s1USye3EdwP6M/4=;
        b=TsGHO6GtJqy1DDW9IM4KQzgUmV/uW4kDHCWQQ6z70nRmARvFeORo2RrXVh9VIBQeBJ
         ikeHoxuPJEz+jNRjovi+jZ7bbvkGD5Z0T+CJDHqlQK22hwNXTbw2bmaHWJPu074E7UlX
         wzD0tzU95CXwYSRoQxKjQYABvkfBEcGNx1955EhndL99H2KotPh0GEL7wR0JU/k9FcK+
         R/nTamF5IJi0quWcXE5KVqKnZPPhlffMy7SaY9MqXvPau8apytXy30YtuWKuwDx+N2xH
         o0jMjfKYHHhG8BsyEBUpw1IoVqiPZ1ev6cvth5FDY3F5fHl9OZGq4NnTwqBV5pC5tAs7
         kPTA==
X-Forwarded-Encrypted: i=1; AJvYcCX2SEZ7H2txPnfv7BKv7ZY3UvzSrwVhEDnOPsbRYtup4FUjYoihrvnI8HTcpjY73T/Syvc0W9PcHdJiGOd/B9TotIxoDF16
X-Gm-Message-State: AOJu0Yy56QjmhLLMyvzK+xc4JFf3ZM0XPPaNtYDg+0G7UGBCEeOWYZDf
	2wfg/V20yuJKJjBnxTphPd6FuOHBsztLXGHnZrA8vngx2GKSa2ZJj0sYDWlzqt+IHtTej10VgHr
	i3We1obTTficuR7jaPfGPXoqgOrTIKEg+WMjd
X-Google-Smtp-Source: AGHT+IE8psTnghl+RGcXVtPTE07/3VNV/5PqLY1f9KAHCym7306ApXTEvMy/9rFaV7ye+4ns11fLC2PuIxeNCBSeU40=
X-Received: by 2002:a05:6902:2e8a:b0:e0b:ddd8:cd90 with SMTP id
 3f1490d57ef6-e1140ebffd3mr3618391276.24.1723570848659; Tue, 13 Aug 2024
 10:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801175548.17185-1-zack.rusin@broadcom.com> <CAO6MGtg7MJ8fujgkA5vEk5gU9vdxV3pzO9X2jrraqHcAnOJOZA@mail.gmail.com>
In-Reply-To: <CAO6MGtg7MJ8fujgkA5vEk5gU9vdxV3pzO9X2jrraqHcAnOJOZA@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 13 Aug 2024 13:40:37 -0400
Message-ID: <CABQX2QOeWoVcJJxyQOhgO5XrsLRiUMko+Q6yUMhQbCYHY44LYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vmwgfx: Prevent unmapping active read buffers
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, martin.krastev@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 1:29=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com=
> wrote:
>
> Remove `busy_places` now that it's unused. There's also probably a
> better place to put `map_count` in the struct layout to avoid false
> sharing with `cpu_writers`. I'd repack the whole struct if we're going
> to be adding and removing fields.

Those are not related to this change. They'd be two seperate changes.
One to remove other unused members and third to relayout the struct.

z

