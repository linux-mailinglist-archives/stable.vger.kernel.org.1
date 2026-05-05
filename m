Return-Path: <stable+bounces-244191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UESbAnQI+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EECD4CFFDE
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D88C030734A1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AC480DC4;
	Tue,  5 May 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsHsKd8r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E43E868E
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993393; cv=none; b=G3jiNU1Ma7qH0Xa7t43i415VAjfF+BZGh+vEsBk1WYvNii33YelBqlet367s1uWd0Dbh4NcwNFnxC20Ajd//2WEyhXFkrmF6YLxQOKcfZ1dxXhjLs84Bpwg4MSse+gHqQalq9VwLyT76i5IdDL71ZwMGLuZUPA1b7TGkx6Eseoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993393; c=relaxed/simple;
	bh=A9wpaSBbR1ublzL/Sy2zUllnDSEWVh69TzLmMcbXZ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMm6VLOafNfSIUzvzrINjuEXquvpV7avE/Z5oK+tDuK8gU/HjpocURSzHxEIOv/D2TjoGyc9U6/eOqoGLUwI4vY2lEBFYvy5NVjlRxGXdTq0BIcoIYNaptgb5yGXMD12q0hgyAA6f1fGFP0WGDx0XYP7zMxQoThUjCECiYir7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsHsKd8r; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9ea536877so22411425ad.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777993391; x=1778598191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKYwXEKBkfxrwukpDctwnP55c5ugAMD8+9dw4QCucpc=;
        b=OsHsKd8rK5oIhfHwRZbAUsyG9x1n8Qa724mT5Cj8TJHExm2iYXMRQaT5D1Z77hDyTI
         xA4cM1J85Eabfc1x8G8kOucgIS5NLfQLIfFzDZuHZmGvelW+kQzEXIZ/p7RjLRVhWVb6
         H+GoFgOgt8N/IosJ7YGaivt8IaSVi67n4at9NhoTVeDxF8jLcQFBrm0dI85pTeGD8xw8
         73jZP3RRLPr2uciV9Yuwyr6g7XVzgEEs8iLJbJRzRNnQ3/gpE1WzT3EClnD3GOt0xpY9
         e72MJQ1xsCVfrVBPtlB8w+J232SS/XyBASUgjkrQtX7pdbRZFl489eRAQQ4x954YnNvr
         lsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777993391; x=1778598191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKYwXEKBkfxrwukpDctwnP55c5ugAMD8+9dw4QCucpc=;
        b=sDOwvE6sYIDY4NWXvLip1MUwNg22iFMp9W0oeT+uUr/0SMPfVUmNXhj7kXjtMmnF4s
         xNUxget2NkRmsqla+bZplfHCIam/kQCNHqN9Ao/jai+iIQQbNvp/yo3TAs1Yz2EGOqE5
         7xRlp3hzUZ6QOv3qW8rfitTfWVpFmdHBejPGIwAFcxlPgWsBWp997E4hk1njWAZPK/iZ
         HMseN/eOrg1v2BQ+XtvWs8du/cu8/GB/S19UAf2XYdTsCOq2xlWlvmPj+hdiPG+Hvwxy
         toyvSyU2cdzfMmCHnLMnVxTccJ3DNjWjKZfpysFM5WLXheBna0usRGIhW0UqJTaQAjjW
         FJRg==
X-Forwarded-Encrypted: i=1; AFNElJ+wl8tLqd2CE+XM3J1RCfNotby+Xpy+XMjBjpQUOZwRpmPnRkh4LiR4kCbPBWS3nP0rwl2rvp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIq+aTkBhVVG/9cH+8bNxOuA+k3n9cRig1lxA0Esd58a5kT4tB
	bImimJRtXzLwssSzoorQwZtmhQsNtIc8Ps/I6Zy/MM5691tmPnO0D/FA
X-Gm-Gg: AeBDiesVv2OVPvVgrKVKU4T3ztLqyaCjXV1qy15NiaSmWXprM/M3XvWsKslz2ZgjeBw
	aVXHZ+BA+iW3Y038y06O+ZPH0Onv3YqXXafAvStUCAfZImFyf5jQanLiT8I886dd40T/aFRQgDz
	AIOfkexghBnz1rOXi9KQdPAMeD5p/+fUwOJqVkKFqxA5j57O6qNmXT0h7ZwLvR91OytEuUsHyOH
	cFntHiPKNAkUsGCUJAMyAnbCtGH5qSCya3Yr3TsYrsLUA7Qwkt3cTJGp8bK6MXtWZRE052XqYmS
	mSYGjDw+JCAB8MBJlzl71DQTFqxbR/Btu8FrH1ORXrWlMCfcm93wt149UzDpBw5UPnMqRwCSHOQ
	ftXn76dVbt7diP0BOlLKdwfBbe2iPqpH3DDKPYfEX8YTroU/Q5VtS7La9b9PdaJUoHdfXqrKQYB
	IikSsaXISzl9sVNqVqbXIa/jZSOjnorsKv7cBkVrpc8jiqzxT+nJhEWcd/O7Kw+5JrsJTMIKa+Z
	8Y=
X-Received: by 2002:a17:903:3c47:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2ba4d7aadebmr32397605ad.11.1777993389459;
        Tue, 05 May 2026 08:03:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae366c7sm143554025ad.55.2026.05.05.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:03:08 -0700 (PDT)
Date: Tue, 5 May 2026 08:03:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: atmel_mxt_ts - fix boundary check in
 mxt_prepare_cfg_mem
Message-ID: <afoFzH1RvBwUajER@google.com>
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
 <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>
X-Rspamd-Queue-Id: 6EECD4CFFDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244191-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email]

Hi Ricardo,

On Tue, May 05, 2026 at 11:08:15AM +0200, Ricardo Ribalda wrote:
> HI Dmitry
> 
> FWIW this patch looks correct to me...

Thank you for looking this over.

> 
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> But there are a couple of things that look weird.
> 
> 1) The patch line (1503) does not seem to match your tree
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/tree/drivers/input/touchscreen/atmel_mxt_ts.c#n1503

Yeah, I have an unrelated path in my queue that affects line offsets,

> 
> 2) The sscanf just before this check has two conversions (val and
> offset), but you only check for ret != 1. Should't it be ret !=2? or I
> am missing something?

"%n" format specifier does not increment number of successfully parsed
elements returned by sscanf(). It kind of makes sense although may look
surprising.

Thanks.

-- 
Dmitry

