Return-Path: <stable+bounces-195250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA96C73BD2
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 12:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B43F4EA3C8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE332E735;
	Thu, 20 Nov 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzMtpowC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUTtYlrS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281132DEA8F
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638016; cv=none; b=SMVEe6X2NS1Cq9EbC4lhaF56u5rDHgN0P50xXQ1glegKah1V9NrbsgUlS1a+j6wOefR01/M6EILIcoRQ+QtKCCG4z2TZXEkCjsFIzYhSRpX8aO3SGLoI8o4LtjZffCh3bw7ZXLDVluJzSWDZRCjZpI5IVQvRywVHCtjFzLQStKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638016; c=relaxed/simple;
	bh=YJqucc6y3evWF4wSv56D5Hg6FOQn5YFJUMPL4VlHK4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv2Z9pO+NuyB4uftI94cXpsu2W7vwPmKF14NR2aIaWuMvxgxvx42IzpVh2sVuobvD+JbnTl/LbI9KlPQutaH+2QThpsQ1aX0OCkuekJ0uYikQBfr7axjH6bzH/IM3m7Rw7JOfcjhBSjZyfttYtNbTgbr6b/W7v+WixiAkirTFZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzMtpowC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUTtYlrS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763638014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqS+S451NRmIYeRi6IUton5nKAKTYp9P1BRktE8Qx5E=;
	b=QzMtpowC2WDUvJF0CYyHepezKPapYWfVcKk1JHa/Rg/a6AhpJ8Z/QXrFNHGOmw0gl+Cfak
	939IWwzJMh27O5mUA7XrzN9/d5yMgrI9RdPb73TPY6EFCsyZrE1E+Alt5Fdwxls95xl4BK
	ZQLYFv5Go/o8nJGgb7YDOijuJdO6xAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-7z_coBqKOH2lmxjhm3WJSA-1; Thu, 20 Nov 2025 06:26:53 -0500
X-MC-Unique: 7z_coBqKOH2lmxjhm3WJSA-1
X-Mimecast-MFC-AGG-ID: 7z_coBqKOH2lmxjhm3WJSA_1763638012
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47788165c97so5031425e9.0
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 03:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763638011; x=1764242811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqS+S451NRmIYeRi6IUton5nKAKTYp9P1BRktE8Qx5E=;
        b=aUTtYlrSM+SSWKPDdL8phWLZ8WsAnPeIaSSnIOvATgS1R+Q2is1K+lIvdk+CaCk8Mn
         xAwWsTXk9qZI1fP/qrXvmGybknlPpQZVNvCO6j7NRHJL4OFkm1/L0ct1f/9oBn81WpXC
         2s7NZ1i2mjI4CU4UDJwQJWzjvwQ9PhyP4h4pNWAd7OowLtFnEw/qWJphl61jmxR6B1Vd
         ubxPgcigmHuZjzLrPYifONHXDMzvoftwwML5tj1eCzgPE9ruwJFK3aN8sO/K4lgsa4dY
         ZystGxk16GSOOhLIDAQtqthlODDNXavifUMBYiQduO5N0y+G4rkWOVvP7EHFzmlEa47T
         0e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763638011; x=1764242811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqS+S451NRmIYeRi6IUton5nKAKTYp9P1BRktE8Qx5E=;
        b=pgAlS63RojO6qrHTnd3ZsZ2AJdaIiL6+1EdBg0r7KsrlQHiEQ/rT7ik6j1pw4FwQfY
         RkeCMubbAly1kU42mQTiDio8LXA+AdL+jnb8aRJMzo6yZlP2r1CZqi6B4TKVO4gs6kOF
         kI3ZfVbJ06TU0a8V+7VjjJish/p4OiYEGAp4lZFfzVINa1n94mNV3kOPV8bAaePEQoDL
         6iWi3ku7UgmF1w89vWp22LUq8V6YXog2q4aKykyXcR7qIRB+2vYfZqKuw3eL8KPncVSq
         a/Hj6sNp4TJVXUKW4HXw2EeFZUQBEFW2/Z3GFEjCjwaPx06uXyhsG8w/eOjuZ6APcBd1
         6Ajg==
X-Forwarded-Encrypted: i=1; AJvYcCWdRRIc6/RwLbJh1qWbL663P45oqVjd+eMAv86FY35fNGz3xb69oz0Q2UnRUKuyXE+aUDimU+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgmd2bbbTTE7gIJOuruSxg8gFt7SURpodiccWHxEbs4RD8ziw
	8ok8j60Pdik28E6kdLas4w6eorOCzSOOL4xgLRrIp6vLFGpc8xZEYXWhKz2542ffAiLaeQygYtI
	WNbAD9qRwC+/iCLn7zH4tMxAwQ862T75AqAnR29luMN3nl6NsExw97I5dPd19biq4KQ==
X-Gm-Gg: ASbGncsViizvuYZCnGONEsQmYyOaOaJgAVBlClB3dxlSyv6CgGNPOUIp0zTZK8xvt02
	7VGkU8LDfBwzp1+ie2QrWZnSk0BlF4hGgRK3BgxtTw9VU1tTVE1hTY0M1UPm4ITaPn0CmgLuBmn
	DWz+cqcRkdvY2rzeRGWA+NH7+qoGdlDI6hkiijBEJRqsQ6xe8AXmVFTkDYtthftXJYNGQbIxXK3
	HiwqDo3MWR79h5Bs9o60qm/lPvCn3CME3VQ976+qq7Cuwjcv3asnomUrayFZgDAPR/KfANKO6M3
	sodBIaj0p/gVqauN3MDZIQpP5yvdpOZlwlJ6jgqBO0TPkZuTVPgpJYAsk4PtXYZkXpl4Nzdl6rs
	nRe2gjFH9jzpV
X-Received: by 2002:a05:600c:4f51:b0:471:9da:524c with SMTP id 5b1f17b1804b1-477babcf75emr19620945e9.12.1763638011517;
        Thu, 20 Nov 2025 03:26:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeKEOaazfM9KhQXI1DdCaf+McPmoAWzMH7ECavD7fZB8Di1CGCkdsdqX4WGC/qULZnN/Krbw==
X-Received: by 2002:a05:600c:4f51:b0:471:9da:524c with SMTP id 5b1f17b1804b1-477babcf75emr19620605e9.12.1763638011115;
        Thu, 20 Nov 2025 03:26:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm62835665e9.8.2025.11.20.03.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 03:26:50 -0800 (PST)
Message-ID: <038697aa-a11c-45ce-a270-258403cc1457@redhat.com>
Date: Thu, 20 Nov 2025 12:26:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH REPOST net v2] atm/fore200e: Fix possible data race in
 fore200e_open()
To: Gui-Dong Han <hanguidong02@gmail.com>, 3chas3@gmail.com,
 horms@kernel.org, kuba@kernel.org
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
References: <20251118033330.1844136-1-hanguidong02@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251118033330.1844136-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 4:33 AM, Gui-Dong Han wrote:
> Protect access to fore200e->available_cell_rate with rate_mtx lock to
> prevent potential data race.
> 
> In this case, since the update depends on a prior read, a data race
> could lead to a wrong fore200e.available_cell_rate value.
> 
> The field fore200e.available_cell_rate is generally protected by the lock
> fore200e.rate_mtx when accessed. In all other read and write cases, this
> field is consistently protected by the lock, except for this case and
> during initialization.
> 
> This potential bug was detected by our experimental static analysis tool,
> which analyzes locking APIs and paired functions to identify data races
> and atomicity violations.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
> * Added a description of the data race hazard in fore200e_open(), as
> suggested by Jakub Kicinski and Simon Horman.

It looks like you missed Jakub's reply on v2:

https://lore.kernel.org/netdev/20250123071201.3d38d8f6@kernel.org/

The above comment is still not sufficient: you should describe
accurately how 2 (or more) CPUs could actually race causing the
corruption, reporting the relevant call paths leading to the race.

Thanks,

Paolo


